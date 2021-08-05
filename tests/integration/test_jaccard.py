import logging
import os
import subprocess

import eia.environment as environment
import eia.tests.utilities as utilities


LOGGER = logging.getLogger(__name__)


STATE_A_LEGISLATION_TEXT = (
    "TITLE I - GENERAL PRINCIPLES"
    "\n\n"
    "(1) All citizens have the right to live in a healthy environment and to "
    "the benefits of the rational use of the country's natural resources, "
    "hence the obligations to participate in its defense and sustainable use, "
    "respectively."
    "\n\n"
    "(2) It is due to respect for the principles of the well-being of the "
    "entire population, the protection, preservation and conservation of the "
    "environment and the rational use of natural resources, whose values "
    "cannot be underestimated in relation to merely utilitarian interests."
    "\n\n"
    "(3) It is the responsibility of the State to implement a National "
    "Environmental Management Program to achieve the objectives set out above, "
    "creating the necessary structures and specialized bodies for this purpose "
    "and having legislation published to make it feasible."
)


STATE_B_LEGISLATION_TEXT = (
    "TITLE I - GENERAL PROVISIONS"
    "\n\n"
    "(1) This law establishes the general legal framework for environmental "
    "management in State B."
    "\n\n"
    "(2) The environment constitutes a common heritage of the nation in State "
    "B. It is an integral part of the universal heritage. Its protection and "
    "the rational management of the resources it offers to human life are of "
    "general interest. These target in particular the geosphere, hydrosphere, "
    "atmosphere, their tangible and intangible content, as well as the social "
    "and cultural aspects they include."
    "\n\n"
    "(3) The President of State B defines the national environmental policy. "
    "Its implementation is the responsibility of the Government, which applies "
    "it, together with the decentralized territorial communities, grassroots "
    "communities and environmental defense associations. To this end, the "
    "Government develops national strategies, plans or programs aimed at "
    "ensuring the conservation and sustainable use of environmental resources."
)


STATE_C_LEGISLATION_TEXT = (
    "TITLE I - FUNDAMENTAL PRINCIPLES"
    "\n\n"
    "(1) The purpose of this law is to establish the essential principles "
    "according to which the environment is sustainably managed and protected "
    "against forms of degradation, in order to safeguard and enhance natural "
    "resources and improve the living conditions of the population."
    "\n\n"
    "(2) Every citizen, individually or within the framework of traditional "
    "local institutions or associations, is responsible, in collaboration with "
    "the decentralized territorial collectivities and the State, to work, to "
    "prevent and to fight against all kinds of pollution or environmental "
    "degradation in compliance with laws and regulations."
    "\n\n"
    "(3) The administration sets up the bodies necessary for the "
    "implementation of this law. It brings together the organizations "
    "concerned for better coordination of action to protect and enhance the "
    "environment."
)


def test_jaccard_similarity_full_text():
    test_directory_path = utilities.create_test_directory('jaccard_similarity_full_text')

    file_content_by_relative_path = {
        os.path.join('legislation', 'state_a_english.txt'): STATE_A_LEGISLATION_TEXT,
        os.path.join('legislation', 'state_b_english.txt'): STATE_B_LEGISLATION_TEXT,
        os.path.join('legislation', 'state_c_english.txt'): STATE_C_LEGISLATION_TEXT,
    }

    script_file_path = os.path.join(
        environment.ENVIRONMENT_ROOT_PATH, 'scripts', 'similarity',
        'calculate_similarity.py')
    output_file_path = os.path.join(test_directory_path, 'similarity.txt')

    actual_similarity_matrix_labels = []
    actual_similarity_matrix = []

    try:
        utilities.populate_test_directory(
            test_directory_path, file_content_by_relative_path)
        subprocess.run(
            [
                script_file_path,
                'jaccard_index',
                'full_text',
                'english',
                '--legislation_directory_path',
                test_directory_path,
                '--output_file_path',
                output_file_path,
            ],
            check=True)
        with open(output_file_path, 'r') as file_object:
            for line in file_object:
                line_components = line.rstrip('\n').split(',')
                actual_similarity_matrix_labels.append(line_components[0])
                actual_similarity_matrix.append(
                    list(map(lambda line_component: float(line_component), line_components[1:])))
    finally:
        utilities.delete_test_directory(test_directory_path)

    expected_similarity_matrix_labels = ['State A', 'State B', 'State C']
    expected_similarity_matrix = [
        [1.0, 0.149, 0.135],
        [0.149, 1.0, 0.160],
        [0.135, 0.160, 1.0],
    ]

    assert expected_similarity_matrix_labels == actual_similarity_matrix_labels

    assert len(expected_similarity_matrix) == len(actual_similarity_matrix)
    epsilon = 0.0005
    for row_index in range(len(expected_similarity_matrix)):
        expected_row = expected_similarity_matrix[row_index]
        actual_row = actual_similarity_matrix[row_index]
        assert len(expected_row) == len(actual_row)
        for column_index in range(len(expected_row)):
            assert abs(expected_row[column_index] - actual_row[column_index]) < epsilon
