import logging
import os
import subprocess

import eia.environment as environment
import eia.tests.utilities as utilities


LOGGER = logging.getLogger(__name__)


STATE_A_LEGISLATION_TEXT = '''TITLE I - GENERAL PRINCIPLES

(1) All citizens have the right to live in a healthy environment and to the benefits of the rational use of the country's natural resources, hence the obligations to participate in its defense and sustainable use, respectively.

(2) It is due to respect for the principles of the well-being of the entire population, the protection, preservation and conservation of the environment and the rational use of natural resources, whose values cannot be underestimated in relation to merely utilitarian interests.

(3) It is the responsibility of the State to implement a National Environmental Management Program to achieve the objectives set out above, creating the necessary structures and specialized bodies for this purpose and having legislation published to make it feasible.'''


STATE_B_LEGISLATION_TEXT = '''TITLE I - GENERAL PROVISIONS

(1) This law establishes the general legal framework for environmental management in State B.

(2) The environment constitutes a common heritage of the nation in State B. It is an integral part of the universal heritage. Its protection and the rational management of the resources it offers to human life are of general interest. These target in particular the geosphere, hydrosphere, atmosphere, their tangible and intangible content, as well as the social and cultural aspects they include.

(3) The President of State B defines the national environmental policy. Its implementation is the responsibility of the Government, which applies it, together with the decentralized territorial communities, grassroots communities and environmental defense associations. To this end, the Government develops national strategies, plans or programs aimed at ensuring the conservation and sustainable use of environmental resources.'''


STATE_C_LEGISLATION_TEXT = '''TITLE I - FUNDAMENTAL PRINCIPLES

(1) The purpose of this law is to establish the essential principles according to which the environment is sustainably managed and protected against forms of degradation, in order to safeguard and enhance natural resources and improve the living conditions of the population.

(2) Every citizen, individually or within the framework of traditional local institutions or associations, is responsible, in collaboration with the decentralized territorial collectivities and the State, to work, to prevent and to fight against all kinds of pollution or environmental degradation in compliance with laws and regulations.

(3) The administration sets up the bodies necessary for the implementation of this law. It brings together the organizations concerned for better coordination of action to protect and enhance the environment.'''


def test_jaccard_similarity_full_text():
    test_directory_path = os.path.join(
        os.path.sep, 'tmp', 'jaccard_similarity_full_text')
    legislation_directory_path = os.path.join(test_directory_path, 'legislation')
    utilities.silently_delete_directory_tree(test_directory_path)
    os.makedirs(legislation_directory_path)
    LOGGER.info("Created directory {}".format(test_directory_path))

    state_a_legislation_file_path = os.path.join(
        legislation_directory_path, 'state_a_english.txt')
    with open(state_a_legislation_file_path, 'w') as file_object:
        file_object.write(STATE_A_LEGISLATION_TEXT)
    LOGGER.info("Wrote State A legislation text to {}".format(
        state_a_legislation_file_path))

    state_b_legislation_file_path = os.path.join(
        legislation_directory_path, 'state_b_english.txt')
    with open(state_b_legislation_file_path, 'w') as file_object:
        file_object.write(STATE_B_LEGISLATION_TEXT)
    LOGGER.info("Wrote State B legislation text to {}".format(
        state_b_legislation_file_path))

    state_c_legislation_file_path = os.path.join(
        legislation_directory_path, 'state_c_english.txt')
    with open(state_c_legislation_file_path, 'w') as file_object:
        file_object.write(STATE_C_LEGISLATION_TEXT)
    LOGGER.info("Wrote State C legislation text to {}".format(
        state_c_legislation_file_path))

    script_file_path = os.path.join(
        environment.ENVIRONMENT_ROOT_PATH, 'scripts', 'similarity',
        'calculate_similarity.py')

    similarity_output_file_path = os.path.join(
        test_directory_path, 'similarity.txt')
    actual_similarity_matrix_labels = []
    actual_similarity_matrix = []

    try:
        subprocess.run(
            [
                script_file_path,
                'jaccard',
                'english',
                '--legislation_directory',
                legislation_directory_path,
                '--output_file_path',
                similarity_output_file_path,
            ],
            check=True)
        with open(similarity_output_file_path, 'r') as file_object:
            for line in file_object:
                line_components = line.rstrip('\n').split(',')
                actual_similarity_matrix_labels.append(line_components[0])
                actual_similarity_matrix.append(
                    list(map(lambda line_component: int(line_component),
                        line_components[1:])))
    finally:
        utilities.silently_delete_directory_tree(test_directory_path)
        LOGGER.info("Deleted directory {}".format(test_directory_path))

    expected_similarity_matrix_labels = ['State A', 'State B', 'State C']
    expected_similarity_matrix = [
        [1, 1, 1],
        [1, 1, 1],
        [1, 1, 1],
    ]

    assert expected_similarity_matrix_labels == actual_similarity_matrix_labels
    assert expected_similarity_matrix == actual_similarity_matrix
