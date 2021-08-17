import os

import pytest

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


def test_filter_file_paths_by_state_only_returns_files_whose_state_is_one_of_those_provided():
    file_paths = [
        '/path/to/state_a_english.txt',
        '/path/to/state_b_french.txt',
        '/path/to/state_c_spanish.txt',
        '/path/to/state_d_russian.txt',
        '/path/to/state_e_arabic.txt',
        '/path/to/state_f_portuguese.txt',
    ]
    states = ['state_a', 'state_c', 'state_e']
    expected_file_paths = [
        '/path/to/state_a_english.txt',
        '/path/to/state_c_spanish.txt',
        '/path/to/state_e_arabic.txt',
    ]
    assert expected_file_paths == text_files.filter_file_paths_by_state(file_paths, states)


def test_find_provision_contents_finds_contents_of_provided_provision_in_file_concerning_provided_state_and_language():
    test_directory_path = utilities.create_test_directory('test_text_files')

    file_content_by_relative_path = {
        'state_a_english.txt': (
            '(1) First provision in State A English.\n'
            '(2) Second provision in State A English.\n'
        ),
        os.path.join('nested', 'state_a_french.txt'): (
            '(1) First provision in State A French.\n'
            '(2) Second provision in State A French.\n'
        ),
        'state_b_english.txt': (
            '(1) First provision in State B English.\n'
            '(2) Second provision in State B English.\n'
        ),
        os.path.join('nested', 'state_b_french.txt'): (
            '(1) First provision in State B French.\n'
            '(2) Second provision in State B French.\n'
        ),
        'state_c_english.txt': (
            '(1) First provision in State C English.\n'
            '(2) Second provision in State C English.\n'
        ),
        os.path.join('nested', 'state_c_french.txt'): (
            '(1) First provision in State C French.\n'
            '(2) Second provision in State C French.\n'
        ),
    }

    first_expected_provision = 'Second provision in State B English.'
    second_expected_provision = 'First provision in State C French.'

    try:
        utilities.populate_test_directory(
            test_directory_path, file_content_by_relative_path)
        # State B English provision 2
        first_actual_provision = text_files.find_provision_contents(
            test_directory_path, 'english', 'State B', 2)
        # State C French provision 1
        second_actual_provision = text_files.find_provision_contents(
            test_directory_path, 'french', 'State C', 1)
    finally:
        utilities.delete_test_directory(test_directory_path)

    assert first_expected_provision == first_actual_provision
    assert second_expected_provision == second_actual_provision


def test_find_provision_contents_raises_runtime_error_when_more_or_less_than_one_file_concerning_state_and_language():
    test_directory_path = utilities.create_test_directory('test_text_files')

    file_content_by_relative_path = {
        'state_a_english.txt': (
            '(1) First provision in State A English.\n'
            '(2) Second provision in State A English.\n'
        ),
        os.path.join('nested', 'state_a_english.txt'): (
            '(1) First provision in State A English.\n'
            '(2) Second provision in State A English.\n'
        ),
    }

    try:
        utilities.populate_test_directory(
            test_directory_path, file_content_by_relative_path)
        # No file concerning state and language
        with pytest.raises(RuntimeError):
            text_files.find_provision_contents(
                test_directory_path, 'french', 'State A', 1)
        # Two files concerning state and language
        with pytest.raises(RuntimeError):
            text_files.find_provision_contents(
                test_directory_path, 'english', 'State A', 1)
    finally:
        utilities.delete_test_directory(test_directory_path)


def test_find_provision_contents_raises_runtime_error_when_provided_provision_not_found_in_file():
    test_directory_path = utilities.create_test_directory('test_text_files')

    file_content_by_relative_path = {
        'state_a_english.txt': (
            '(1) First provision in State A English.\n'
            '(2) Second provision in State A English.\n'
        ),
    }

    try:
        utilities.populate_test_directory(
            test_directory_path, file_content_by_relative_path)
        with pytest.raises(RuntimeError):
            text_files.find_provision_contents(
                test_directory_path, 'english', 'State A', 3)
    finally:
        utilities.delete_test_directory(test_directory_path)


def test_is_not_comment_returns_true_when_line_does_not_start_with_hashmark():
    # Letter
    assert text_files.is_not_comment('A') is True
    assert text_files.is_not_comment('a') is True
    # Number
    assert text_files.is_not_comment('0') is True
    assert text_files.is_not_comment('00') is True
    # Punctuation
    assert text_files.is_not_comment('.') is True
    assert text_files.is_not_comment(',') is True
    assert text_files.is_not_comment('?') is True
    assert text_files.is_not_comment(';') is True
    assert text_files.is_not_comment(':') is True
    assert text_files.is_not_comment('"') is True
    assert text_files.is_not_comment("'") is True
    # Dashes and underscores
    assert text_files.is_not_comment('-') is True
    assert text_files.is_not_comment('_') is True
    # Back slashes and forward slashes
    assert text_files.is_not_comment('\\') is True
    assert text_files.is_not_comment('/') is True
    assert text_files.is_not_comment('//') is True
    assert text_files.is_not_comment('/*') is True
    assert text_files.is_not_comment('*/') is True
    # Parentheses and brackets
    assert text_files.is_not_comment('[') is True
    assert text_files.is_not_comment(']') is True
    assert text_files.is_not_comment('(') is True
    assert text_files.is_not_comment(')') is True


def test_is_not_comment_returns_false_when_line_starts_with_hashmark():
    assert text_files.is_not_comment('#') is False


def populate_test_directory_for_input_text_generator_test(test_directory_path):
    file_content_by_relative_path = {
        'state_a_english.txt': (
            'Title I - General Provisions\n'
            '(1) I enjoy spending time outdoors: [a] when the weather is nice and [b] I am in a good mood.\n'
            '(2) That said, walking in the rain is not so bad either.\n'
        ),
        'state_b_french.txt': (
            'Titre I - Dispositions générales\n'
            "(1) J'aime passer du temps à l'extérieur: [a] quand il fait beau et [b] je suis de bonne humeur.\n"
            "(2) Cela dit, marcher sous la pluie n'est pas si mal non plus.\n"
        ),
        'state_c_spanish.txt': (
            'Título I - Disposiciones generales\n'
            '(1) Disfruto pasar tiempo al aire libre: [a] cuando hace buen tiempo y [b] estoy de buen humor.\n'
            '(2) Dicho esto, caminar bajo la lluvia tampoco es tan malo.\n'
        ),
        'state_d_english.txt': (
            'Title I - General Provisions\n'
            '(1) I do not enjoy spending time outdoors because: '
            '[1] the sun hurts my skin and [2] I would rather play video games.\n'
            '(2) Also, who wants to walk when you can drive?\n'
        ),
    }
    utilities.populate_test_directory(
        test_directory_path, file_content_by_relative_path)


def test_input_text_generator_yields_full_text_of_files_written_in_specified_language_when_scope_is_full_text():
    test_directory_path = utilities.create_test_directory('test_text_files')

    expected_labels_and_text = [
        ('State A', (
            'title i general provisions '
            '(1) i enjoy spending time outdoors [a] when the weather is nice and [b] i am in a good mood '
            '(2) that said walking in the rain is not so bad either'
        )),
        ('State D', (
            'title i general provisions '
            '(1) i do not enjoy spending time outdoors because '
            '[1] the sun hurts my skin and [2] i would rather play video games '
            '(2) also who wants to walk when you can drive'
        )),
    ]

    try:
        populate_test_directory_for_input_text_generator_test(test_directory_path)
        actual_labels_and_text = [
            label_and_text for label_and_text in text_files.input_text_generator(
                scopes.FULL_TEXT, languages.ENGLISH, test_directory_path, True)
        ]
    finally:
        utilities.delete_test_directory(test_directory_path)

    assert expected_labels_and_text == actual_labels_and_text


def test_input_text_generator_removes_provision_delimiters_from_full_text_when_preserve_provision_delimiters_is_false():
    test_directory_path = utilities.create_test_directory('test_text_files')

    expected_labels_and_text = [
        ('State A', (
            'title i general provisions '
            'i enjoy spending time outdoors when the weather is nice and i am in a good mood '
            'that said walking in the rain is not so bad either'
        )),
        ('State D', (
            'title i general provisions '
            'i do not enjoy spending time outdoors because '
            'the sun hurts my skin and i would rather play video games '
            'also who wants to walk when you can drive'
        )),
    ]

    try:
        populate_test_directory_for_input_text_generator_test(test_directory_path)
        actual_labels_and_text = [
            label_and_text for label_and_text in text_files.input_text_generator(
                scopes.FULL_TEXT, languages.ENGLISH, test_directory_path, False)
        ]
    finally:
        utilities.delete_test_directory(test_directory_path)

    assert expected_labels_and_text == actual_labels_and_text


def test_input_text_generator_full_text_excludes_states_not_in_states_to_include_when_states_to_include_not_empty():
    test_directory_path = utilities.create_test_directory('test_text_files')

    expected_labels_and_text = [
        ('State D', (
            'title i general provisions '
            'i do not enjoy spending time outdoors because '
            'the sun hurts my skin and i would rather play video games '
            'also who wants to walk when you can drive'
        )),
    ]

    states_to_include = ['state_d']

    try:
        populate_test_directory_for_input_text_generator_test(test_directory_path)
        actual_labels_and_text = [
            label_and_text for label_and_text in text_files.input_text_generator(
                scopes.FULL_TEXT, languages.ENGLISH, test_directory_path, False,
                states_to_include)
        ]
    finally:
        utilities.delete_test_directory(test_directory_path)

    assert expected_labels_and_text == actual_labels_and_text


def test_input_text_generator_yields_provisions_of_files_written_in_specified_language_when_scope_is_provision():
    test_directory_path = utilities.create_test_directory('test_text_files')

    expected_labels_and_text = [
        ('State A 1', (
            'i enjoy spending time outdoors [a] when the weather is nice and '
            '[b] i am in a good mood'
        )),
        ('State A 2', 'that said walking in the rain is not so bad either'),
        ('State D 1', (
            'i do not enjoy spending time outdoors because [1] the sun hurts '
            'my skin and [2] i would rather play video games'
        )),
        ('State D 2', 'also who wants to walk when you can drive'),
    ]

    try:
        populate_test_directory_for_input_text_generator_test(test_directory_path)
        actual_labels_and_text = [
            label_and_text for label_and_text in text_files.input_text_generator(
                scopes.PROVISION, languages.ENGLISH, test_directory_path, True)
        ]
    finally:
        utilities.delete_test_directory(test_directory_path)

    assert expected_labels_and_text == actual_labels_and_text


def test_input_text_generator_removes_delimiters_from_provisions_when_preserve_provision_delimiters_is_false():
    test_directory_path = utilities.create_test_directory('test_text_files')

    expected_labels_and_text = [
        ('State A 1', 'i enjoy spending time outdoors when the weather is nice and i am in a good mood'),
        ('State A 2', 'that said walking in the rain is not so bad either'),
        ('State D 1', (
            'i do not enjoy spending time outdoors because the sun hurts my '
            'skin and i would rather play video games'
        )),
        ('State D 2', 'also who wants to walk when you can drive'),
    ]

    try:
        populate_test_directory_for_input_text_generator_test(test_directory_path)
        actual_labels_and_text = [
            label_and_text for label_and_text in text_files.input_text_generator(
                scopes.PROVISION, languages.ENGLISH, test_directory_path, False)
        ]
    finally:
        utilities.delete_test_directory(test_directory_path)

    assert expected_labels_and_text == actual_labels_and_text


def test_input_text_generator_provisions_excludes_states_not_in_states_to_include_when_states_to_include_not_empty():
    test_directory_path = utilities.create_test_directory('test_text_files')

    expected_labels_and_text = [
        ('State D 1', (
            'i do not enjoy spending time outdoors because the sun hurts my '
            'skin and i would rather play video games'
        )),
        ('State D 2', 'also who wants to walk when you can drive'),
    ]

    states_to_include = ['state_d']

    try:
        populate_test_directory_for_input_text_generator_test(test_directory_path)
        actual_labels_and_text = [
            label_and_text for label_and_text in text_files.input_text_generator(
                scopes.PROVISION, languages.ENGLISH, test_directory_path, False,
                states_to_include)
        ]
    finally:
        utilities.delete_test_directory(test_directory_path)

    assert expected_labels_and_text == actual_labels_and_text
