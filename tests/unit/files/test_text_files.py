import os

import eia.files.text_files as text_files
import eia.languages as languages
import eia.scopes as scopes
import eia.tests.utilities as utilities


def create_test_directory():
    test_directory_path = os.path.join(os.path.sep, 'tmp', 'test_text_files')
    utilities.silently_delete_directory_tree(test_directory_path)
    os.makedirs(test_directory_path)
    return test_directory_path


def test_discover_returns_paths_to_all_text_files_in_directory():
    test_directory_path = create_test_directory()
    first_file_path = os.path.join(test_directory_path, 'first_file.txt')
    # Misspelled extension
    second_file_path = os.path.join(test_directory_path, 'second_file.tx')
    # File with non-text extension
    third_file_path = os.path.join(test_directory_path, 'third_file.py')
    # File without extension
    fourth_file_path = os.path.join(test_directory_path, 'fourth_file')
    fifth_file_path = os.path.join(test_directory_path, 'fifth_file.txt')

    expected_file_paths = sorted([first_file_path, fifth_file_path])

    try:
        open(first_file_path, 'w').close()
        open(second_file_path, 'w').close()
        open(third_file_path, 'w').close()
        open(fourth_file_path, 'w').close()
        open(fifth_file_path, 'w').close()
        actual_file_paths = sorted(text_files.discover(test_directory_path))
    finally:
        utilities.silently_delete_directory_tree(test_directory_path)

    assert expected_file_paths == actual_file_paths


def test_discover_returns_paths_to_text_files_in_nested_directories():
    test_directory_path = create_test_directory()
    nested_directory = os.path.join(test_directory_path, 'nested')
    nested_nested_directory = os.path.join(
        test_directory_path, 'nested', 'nested_again')
    os.makedirs(nested_nested_directory)

    first_file_path = os.path.join(test_directory_path, 'first_file.txt')
    second_file_path = os.path.join(nested_directory, 'second_file.txt')
    third_file_path = os.path.join(nested_nested_directory, 'third_file.txt')
    # File without extension
    fourth_file_path = os.path.join(nested_nested_directory, 'fourth_file')

    expected_file_paths = sorted([first_file_path, second_file_path, third_file_path])

    try:
        open(first_file_path, 'w').close()
        open(second_file_path, 'w').close()
        open(third_file_path, 'w').close()
        open(fourth_file_path, 'w').close()
        actual_file_paths = sorted(text_files.discover(test_directory_path))
    finally:
        utilities.silently_delete_directory_tree(test_directory_path)

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


def populate_input_text_generator_test_files(test_directory_path):
    state_a_file_path = os.path.join(test_directory_path, 'state_a_english.txt')
    state_b_file_path = os.path.join(test_directory_path, 'state_b_french.txt')
    state_c_file_path = os.path.join(test_directory_path, 'state_c_spanish.txt')
    state_d_file_path = os.path.join(test_directory_path, 'state_d_english.txt')

    with open(state_a_file_path, 'w') as file_object:
        file_object.write('Title I - General Provisions\n')
        file_object.write('(1) I enjoy spending time outdoors.\n')
        file_object.write('(2) I prefer to do so when the weather is nice.\n')
        file_object.write('(3) That said, walking in the rain is not so bad either.\n')

    with open(state_b_file_path, 'w') as file_object:
        file_object.write('Titre I - Dispositions générales\n')
        file_object.write("(1) J'aime passer du temps dehors.\n")
        file_object.write('(2) Je préfère le faire quand il fait beau.\n')
        file_object.write("(3) Cela dit, marcher sous la pluie n'est pas si mal non plus.\n")

    with open(state_c_file_path, 'w') as file_object:
        file_object.write('Título I - Disposiciones generales\n')
        file_object.write('(1) Disfruto pasar tiempo al aire libre.\n')
        file_object.write('(2) Prefiero hacerlo cuando hace buen tiempo.\n')
        file_object.write('(3) Dicho esto, caminar bajo la lluvia tampoco es tan malo.\n')

    with open(state_d_file_path, 'w') as file_object:
        file_object.write('Title I - General Provisions\n')
        file_object.write('(1) I do not enjoy spending time outdoors.\n')
        file_object.write('(2) I would much rather sit inside and play video games.\n')
        file_object.write('(3) Who wants to walk when you can drive?\n')


def test_input_text_generator_yields_full_text_of_files_written_in_specified_language_when_scope_is_full_text():
    test_directory_path = create_test_directory()

    input_text_generator = text_files.input_text_generator(
        scopes.FULL_TEXT, languages.ENGLISH, test_directory_path)

    expected_labels_and_text = [
        ('State A', (
            'Title I - General Provisions\n'
            '(1) I enjoy spending time outdoors.\n'
            '(2) I prefer to do so when the weather is nice.\n'
            '(3) That said, walking in the rain is not so bad either.\n'
        )),
        ('State D', (
            'Title I - General Provisions\n'
            '(1) I do not enjoy spending time outdoors.\n'
            '(2) I would much rather sit inside and play video games.\n'
            '(3) Who wants to walk when you can drive?\n'
        )),
    ]

    try:
        populate_input_text_generator_test_files(test_directory_path)
        actual_labels_and_text = [label_and_text for label_and_text in input_text_generator]
    finally:
        utilities.silently_delete_directory_tree(test_directory_path)

    assert expected_labels_and_text == actual_labels_and_text
