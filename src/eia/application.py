import os

import eia.file_path_converter as file_path_converter
import eia.file_reader as file_reader


def compare_legislation(
        text_file_discoverer, text_file_language_filterer,
        similarity_calculator):
    legislation_file_paths = text_file_language_filterer.filter(
        text_file_discoverer.discover())
    legislation_texts = [
        file_reader.FileReader(file_path).read_text_unbroken() for file_path in legislation_file_paths
    ]
    labels = [
        file_path_converter.to_state_name_capitalized(file_path) for file_path in legislation_file_paths
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
