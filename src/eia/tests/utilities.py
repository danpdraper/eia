import logging
import os
import shutil


LOGGER = logging.getLogger(__name__)


EPSILON = 0.0005


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


def silently_delete_directory_tree(directory_path):
    shutil.rmtree(directory_path, ignore_errors=True)


def create_test_directory(directory_name):
    test_directory_path = os.path.join(os.path.sep, 'tmp', directory_name)
    silently_delete_directory_tree(test_directory_path)
    os.makedirs(test_directory_path)
    LOGGER.info("Created directory {}".format(test_directory_path))
    return test_directory_path


def populate_test_directory(test_directory_path, file_content_by_relative_path):
    for relative_path, file_content in file_content_by_relative_path.items():
        if os.path.sep in relative_path:
            file_directory_path = os.path.join(
                test_directory_path, os.path.split(relative_path)[0])
            if not os.path.isdir(file_directory_path):
                os.makedirs(file_directory_path)
                LOGGER.info("Created directory {}".format(file_directory_path))
        file_path = os.path.join(test_directory_path, relative_path)
        LOGGER.info("Writing the following to {}: {}".format(file_path, file_content))
        with open(file_path, 'w') as file_object:
            file_object.write(file_content)
        LOGGER.info(
            "Wrote the following to {}: {}".format(file_path, file_content))


def delete_test_directory(test_directory_path):
    silently_delete_directory_tree(test_directory_path)
    LOGGER.info("Deleted directory {}".format(test_directory_path))


def populate_actual_similarity_matrix_and_labels(
        output_directory_path, algorithm, scope, actual_similarity_matrix_labels,
        actual_similarity_matrix):
    output_file_path = os.path.join(
        output_directory_path, algorithm, "{}.csv".format(scope))
    with open(output_file_path, 'r') as file_object:
        for line in file_object:
            if line.startswith('language'):
                continue
            line_components = line.rstrip('\n').split(',')
            actual_similarity_matrix_labels.append(line_components[0])
            actual_similarity_matrix.append(
                list(map(lambda line_component: float(line_component), line_components[1:])))


def compare_expected_and_actual_similarity_matrix_labels(
        expected_similarity_matrix_labels, actual_similarity_matrix_labels):
    assert sorted(expected_similarity_matrix_labels) == sorted(actual_similarity_matrix_labels)


def compare_expected_and_actual_similarity_matrices(
        expected_similarity_matrix, actual_similarity_matrix, expected_labels,
        actual_labels):
    assert len(expected_similarity_matrix) == len(actual_similarity_matrix)
    for expected_row_index, row_label in enumerate(expected_labels):
        expected_row = expected_similarity_matrix[expected_row_index]
        actual_row_index = actual_labels.index(row_label)
        actual_row = actual_similarity_matrix[actual_row_index]
        assert len(expected_row) == len(actual_row)
        for expected_column_index, column_label in enumerate(expected_labels):
            expected_element = expected_row[expected_column_index]
            actual_column_index = actual_labels.index(column_label)
            actual_element = actual_row[actual_column_index]
            LOGGER.info(
                "Comparing matrix elements at expected row index {}, expected "
                "column index {}, actual row index {} and actual column "
                "index {}. Expected element value: {}, actual element value: "
                "{}".format(
                    expected_row_index, expected_column_index, actual_row_index,
                    actual_column_index, expected_element, actual_element))
            assert round(abs(expected_element - actual_element), 4) <= EPSILON


def plot_file_path(output_directory_path, algorithm, scope):
    return os.path.join(
        output_directory_path, algorithm, "{}.png".format(scope))


def assert_plot_file_exists(output_directory_path, algorithm, scope):
    assert os.path.exists(
        plot_file_path(output_directory_path, algorithm, scope)) is True


def assert_plot_file_does_not_exist(output_directory_path, algorithm, scope):
    assert os.path.exists(
        plot_file_path(output_directory_path, algorithm, scope)) is False
