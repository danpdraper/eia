import eia.files.text_files as text_files


def row_generator(algorithm, scope, language, text_file_directory_path):
    for row_label, row_text in text_files.input_text_generator(
            scope, language, text_file_directory_path):
        row = []
        for _, column_text in text_files.input_text_generator(
                scope, language, text_file_directory_path):
            row.append(algorithm.apply(row_text, column_text))
        yield row_label, row
