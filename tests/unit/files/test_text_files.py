import os

import eia.files.text_files as text_files
import eia.languages as languages
import eia.scopes as scopes
import eia.tests.utilities as utilities


def test_discover_returns_paths_to_all_text_files_in_directory():
    test_directory_path = utilities.create_test_directory('test_text_files')

    file_content_by_relative_path = {
        'first_file.txt': '',
        # Misspelled extension
        'second_file.tx': '',
        # File with non-text extension
        'third_file.py': '',
        # File without extension
        'fourth_file.py': '',
        'fifth_file.txt': '',
    }

    expected_file_paths = sorted(
        [
            os.path.join(test_directory_path, 'first_file.txt'),
            os.path.join(test_directory_path, 'fifth_file.txt'),
        ])

    try:
        utilities.populate_test_directory(
            test_directory_path, file_content_by_relative_path)
        actual_file_paths = sorted(text_files.discover(test_directory_path))
    finally:
        utilities.delete_test_directory(test_directory_path)

    assert expected_file_paths == actual_file_paths


def test_discover_returns_paths_to_text_files_in_nested_directories():
    test_directory_path = utilities.create_test_directory('test_text_files')

    file_content_by_relative_path = {
        'first_file.txt': '',
        os.path.join('nested', 'second_file.txt'): '',
        os.path.join('nested', 'nested_again', 'third_file.txt'): '',
        # File without extension
        os.path.join('nested', 'nested_again', 'fourth_file'): '',
    }

    expected_file_paths = sorted(
        [
            os.path.join(test_directory_path, 'first_file.txt'),
            os.path.join(test_directory_path, 'nested', 'second_file.txt'),
            os.path.join(test_directory_path, 'nested', 'nested_again', 'third_file.txt'),
        ])

    try:
        utilities.populate_test_directory(
            test_directory_path, file_content_by_relative_path)
        actual_file_paths = sorted(text_files.discover(test_directory_path))
    finally:
        utilities.delete_test_directory(test_directory_path)

    assert expected_file_paths == actual_file_paths


def test_filter_file_paths_by_language_only_returns_files_whose_language_matches_that_provided():
    file_paths = [
        '/path/to/state_a_english.txt',
        '/path/to/state_b_french.txt',
        '/path/to/state_c_spanish.txt',
        '/path/to/state_d_russian.txt',
        # Misspelled language in file name
        '/path/to/state_e_engish.txt',
        '/path/to/state_f_english.txt',
    ]
    expected_file_paths = [
        '/path/to/state_a_english.txt',
        '/path/to/state_f_english.txt',
    ]
    assert expected_file_paths == \
        text_files.filter_file_paths_by_language(file_paths, languages.ENGLISH)


def test_input_text_generator_yields_full_text_of_files_written_in_specified_language_when_scope_is_full_text():
    test_directory_path = utilities.create_test_directory('test_text_files')

    file_content_by_relative_path = {
        'state_a_english.txt': (
            'Title I - General Provisions\n'
            '(1) I enjoy spending time outdoors.\n'
            '(2) I prefer to do so when the weather is nice.\n'
            '(3) That said, walking in the rain is not so bad either.\n'
        ),
        'state_b_french.txt': (
            'Titre I - Dispositions générales\n'
            "(1) J'aime passer du temps dehors.\n"
            '(2) Je préfère le faire quand il fait beau.\n'
            "(3) Cela dit, marcher sous la pluie n'est pas si mal non plus.\n"
        ),
        'state_c_spanish.txt': (
            'Título I - Disposiciones generales\n'
            '(1) Disfruto pasar tiempo al aire libre.\n'
            '(2) Prefiero hacerlo cuando hace buen tiempo.\n'
            '(3) Dicho esto, caminar bajo la lluvia tampoco es tan malo.\n'
        ),
        'state_d_english.txt': (
            'Title I - General Provisions\n'
            '(1) I do not enjoy spending time outdoors.\n'
            '(2) I would much rather sit inside and play video games.\n'
            '(3) Who wants to walk when you can drive?\n'
        ),
    }

    expected_labels_and_text = [
        ('State A', (
            'title i general provisions '
            '(1) i enjoy spending time outdoors '
            '(2) i prefer to do so when the weather is nice '
            '(3) that said walking in the rain is not so bad either'
        )),
        ('State D', (
            'title i general provisions '
            '(1) i do not enjoy spending time outdoors '
            '(2) i would much rather sit inside and play video games '
            '(3) who wants to walk when you can drive'
        )),
    ]

    try:
        utilities.populate_test_directory(
            test_directory_path, file_content_by_relative_path)
        actual_labels_and_text = [
            label_and_text for label_and_text in text_files.input_text_generator(
                scopes.FULL_TEXT, languages.ENGLISH, test_directory_path)
        ]
    finally:
        utilities.delete_test_directory(test_directory_path)

    assert expected_labels_and_text == actual_labels_and_text


def test_input_text_generator_yields_provisions_of_files_written_in_specified_language_when_scope_is_provision():
    test_directory_path = utilities.create_test_directory('test_text_files')

    file_content_by_relative_path = {
        'state_a_english.txt': (
            'Title I - General Provisions\n'
            '(1) I enjoy spending time outdoors.\n'
            '(2) I prefer to do so when the weather is nice.\n'
            '(3) That said, walking in the rain is not so bad either.\n'
        ),
        'state_b_french.txt': (
            'Titre I - Dispositions générales\n'
            "(1) J'aime passer du temps dehors.\n"
            '(2) Je préfère le faire quand il fait beau.\n'
            "(3) Cela dit, marcher sous la pluie n'est pas si mal non plus.\n"
        ),
        'state_c_spanish.txt': (
            'Título I - Disposiciones generales\n'
            '(1) Disfruto pasar tiempo al aire libre.\n'
            '(2) Prefiero hacerlo cuando hace buen tiempo.\n'
            '(3) Dicho esto, caminar bajo la lluvia tampoco es tan malo.\n'
        ),
        'state_d_english.txt': (
            'Title I - General Provisions\n'
            '(1) I do not enjoy spending time outdoors.\n'
            '(2) I would much rather sit inside and play video games.\n'
            '(3) Who wants to walk when you can drive?\n'
        ),
    }

    expected_labels_and_text = [
        ('State A 1', 'i enjoy spending time outdoors'),
        ('State A 2', 'i prefer to do so when the weather is nice'),
        ('State A 3', 'that said walking in the rain is not so bad either'),
        ('State D 1', 'i do not enjoy spending time outdoors'),
        ('State D 2', 'i would much rather sit inside and play video games'),
        ('State D 3', 'who wants to walk when you can drive'),
    ]

    try:
        utilities.populate_test_directory(
            test_directory_path, file_content_by_relative_path)
        actual_labels_and_text = [
            label_and_text for label_and_text in text_files.input_text_generator(
                scopes.PROVISION, languages.ENGLISH, test_directory_path)
        ]
    finally:
        utilities.delete_test_directory(test_directory_path)

    assert expected_labels_and_text == actual_labels_and_text