import eia.conversion as conversion
import eia.files.file_input_output as file_input_output
import eia.files.text_files as text_files
import eia.similarity_matrix as similarity_matrix


def run(algorithm, scope, language, legislation_directory_path, output_file_path):
    file_input_output.write(
        output_file_path, map(
            lambda value: conversion.label_and_row_tuple_to_comma_separated_string(value),
            similarity_matrix.row_generator(
                algorithm, scope, language, legislation_directory_path)))


def compare_legislation(language, legislation_directory_path, similarity_calculator):
    legislation_file_paths = text_files.filter_file_paths_by_language(
        text_files.discover(legislation_directory_path), language)
    legislation_texts = [
        file_input_output.FileReader(file_path).read_text_unbroken() for file_path in legislation_file_paths
    ]
    labels = [
        conversion.file_path_to_state_name_capitalized(file_path) for file_path in legislation_file_paths
    ]
    similarity_matrix = []
    for row_index in range(len(legislation_texts)):
        similarity_matrix_row = []
        for column_index in range(len(legislation_texts)):
            similarity_matrix_row.append(
                similarity_calculator.calculate(
                    legislation_texts[row_index],
                    legislation_texts[column_index]))
        similarity_matrix.append(similarity_matrix_row)
    return labels, similarity_matrix
