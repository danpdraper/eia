import pytest

import eia.algorithms as algorithms
import eia.argument_parser as argument_parser
import eia.environment as environment
import eia.languages as languages
import eia.scopes as scopes


class TestArgumentParser(object):
    def setup(self):
        self.matrix_and_plot_function = lambda args: ('matrix_and_plot', vars(args))
        self.highest_provision_group_scores_function = lambda args: ('highest_scores', vars(args))
        self.parser = argument_parser.ArgumentParser(
            self.matrix_and_plot_function,
            self.highest_provision_group_scores_function)

    def test_parse_matrix_and_plot_extracts_expected_arguments(self):
        arguments = [
            '--legislation_directory_path',
            '/path/to/legislation/directory',
            '--debug',
            'matrix_and_plot',
            'jaccard_index',
            'full_text',
            'english',
            '/path/to/output/directory',
            '--do_not_preserve_provision_delimiters',
            '--states_to_include_file_path',
            '/path/to/states/to/include/file',
            '--matrix_only',
        ]
        expected_namespace = {
            # The equality holds in each of the following three cases because
            # the objects are singletons.
            'algorithm': algorithms.JACCARD_INDEX,
            'scope': scopes.FULL_TEXT,
            'language': languages.ENGLISH,
            'output_directory_path': '/path/to/output/directory',
            'legislation_directory_path': '/path/to/legislation/directory',
            'debug': True,
            'preserve_provision_delimiters': False,
            'states_to_include_file_path': '/path/to/states/to/include/file',
            'matrix_only': True,
            'func': self.matrix_and_plot_function,
        }
        actual_namespace = vars(self.parser.parse(arguments))
        assert expected_namespace == actual_namespace

    def test_parse_matrix_and_plot_assigns_appropriate_function_to_argument_namespace(self):
        arguments = [
            '--legislation_directory_path',
            '/path/to/legislation/directory',
            '--debug',
            'matrix_and_plot',
            'jaccard_index',
            'full_text',
            'english',
            '/path/to/output/directory',
            '--do_not_preserve_provision_delimiters',
            '--states_to_include_file_path',
            '/path/to/states/to/include/file',
            '--matrix_only',
        ]
        expected_function_output = 'matrix_and_plot', {
            # The equality holds in each of the following three cases because
            # the objects are singletons.
            'algorithm': algorithms.JACCARD_INDEX,
            'scope': scopes.FULL_TEXT,
            'language': languages.ENGLISH,
            'output_directory_path': '/path/to/output/directory',
            'legislation_directory_path': '/path/to/legislation/directory',
            'debug': True,
            'preserve_provision_delimiters': False,
            'states_to_include_file_path': '/path/to/states/to/include/file',
            'matrix_only': True,
            'func': self.matrix_and_plot_function,
        }
        parsed_arguments = self.parser.parse(arguments)
        actual_function_output = parsed_arguments.func(parsed_arguments)
        assert expected_function_output == actual_function_output

    def test_parse_matrix_and_plot_raises_system_exit_when_unsupported_algorithm_argument_provided(self):
        arguments = [
            '--legislation_directory_path',
            '/path/to/legislation/directory',
            '--debug',
            'matrix_and_plot',
            'unsupported_algorithm',
            'full_text',
            'english',
            '/path/to/output/directory',
            '--do_not_preserve_provision_delimiters',
            '--states_to_include_file_path',
            '/path/to/states/to/include/file',
        ]
        with pytest.raises(SystemExit):
            self.parser.parse(arguments)

    def test_parse_matrix_and_plot_raises_system_exit_when_unsupported_scope_argument_provided(self):
        arguments = [
            '--legislation_directory_path',
            '/path/to/legislation/directory',
            '--debug',
            'matrix_and_plot',
            'jaccard_index',
            'unsupported_scope',
            'english',
            '/path/to/output/directory',
            '--do_not_preserve_provision_delimiters',
            '--states_to_include_file_path',
            '/path/to/states/to/include/file',
        ]
        with pytest.raises(SystemExit):
            self.parser.parse(arguments)

    def test_parse_matrix_and_plot_raises_system_exit_when_unsupported_language_argument_provided(self):
        arguments = [
            '--legislation_directory_path',
            '/path/to/legislation/directory',
            '--debug',
            'matrix_and_plot',
            'jaccard_index',
            'full_text',
            'unsupported_language',
            '/path/to/output/directory',
            '--do_not_preserve_provision_delimiters',
            '--states_to_include_file_path',
            '/path/to/states/to/include/file',
        ]
        with pytest.raises(SystemExit):
            self.parser.parse(arguments)

    def test_parse_matrix_and_plot_does_not_raise_system_exit_when_optional_arguments_not_provided(self):
        arguments = [
            'matrix_and_plot',
            'jaccard_index',
            'full_text',
            'english',
            '/path/to/output/directory',
        ]
        self.parser.parse(arguments)

    def test_parse_matrix_and_plot_assigns_false_to_debug_parameter_when_debug_argument_not_provided(self):
        arguments = [
            'matrix_and_plot',
            'jaccard_index',
            'full_text',
            'english',
            '/path/to/output/directory',
        ]
        assert self.parser.parse(arguments).debug is False

    def test_parse_matrix_and_plot_assigns_true_to_preserve_provision_delimiters_when_argument_not_provided(self):
        arguments = [
            'matrix_and_plot',
            'jaccard_index',
            'full_text',
            'english',
            '/path/to/output/directory',
        ]
        assert self.parser.parse(arguments).preserve_provision_delimiters is True

    def test_parse_matrix_and_plot_assigns_package_path_to_legislation_directory_path_when_argument_not_provided(self):
        arguments = [
            'matrix_and_plot',
            'jaccard_index',
            'full_text',
            'english',
            '/path/to/output/directory',
        ]
        expected_legislation_directory_path = environment.LEGISLATION_DIRECTORY_PATH
        actual_legislation_directory_path = \
            self.parser.parse(arguments).legislation_directory_path
        assert expected_legislation_directory_path == actual_legislation_directory_path

    def test_parse_matrix_and_plot_assigns_package_path_to_states_to_include_file_path_when_argument_not_provided(self):
        arguments = [
            'matrix_and_plot',
            'jaccard_index',
            'full_text',
            'english',
            '/path/to/output/directory',
        ]
        expected_states_to_include_file_path = environment.STATES_TO_INCLUDE_DEFAULT_FILE_PATH
        actual_states_to_include_file_path = \
            self.parser.parse(arguments).states_to_include_file_path
        assert expected_states_to_include_file_path == actual_states_to_include_file_path

    def test_parse_matrix_and_plot_assigns_false_to_matrix_only_when_argument_not_provided(self):
        arguments = [
            'matrix_and_plot',
            'jaccard_index',
            'full_text',
            'english',
            '/path/to/output/directory',
        ]
        assert self.parser.parse(arguments).matrix_only is False

    def test_parse_highest_scores_extracts_expected_arguments(self):
        arguments = [
            '--legislation_directory_path',
            '/path/to/legislation/directory',
            '--debug',
            'highest_provision_group_scores',
            '/path/to/similarity/matrix',
            '5',
            '--include_provision_contents_in_output',
            '--score_threshold',
            '0.5',
            '--reduce_redundancy_in_output',
            '--deduplicate_transitive_similarity',
            '--enactment_years_file_path',
            '/path/to/enactment/years',
        ]
        expected_namespace = {
            'matrix_file_path': '/path/to/similarity/matrix',
            'number_of_scores': 5,
            'include_provision_contents_in_output': True,
            'legislation_directory_path': '/path/to/legislation/directory',
            'debug': True,
            'score_threshold': 0.5,
            'reduce_redundancy_in_output': True,
            'deduplicate_transitive_similarity': True,
            'enactment_years_file_path': '/path/to/enactment/years',
            'func': self.highest_provision_group_scores_function,
        }
        actual_namespace = vars(self.parser.parse(arguments))
        assert expected_namespace == actual_namespace

    def test_parse_highest_scores_assigns_appropriate_function_to_argument_namespace(self):
        arguments = [
            '--legislation_directory_path',
            '/path/to/legislation/directory',
            '--debug',
            'highest_provision_group_scores',
            '/path/to/similarity/matrix',
            '5',
            '--include_provision_contents_in_output',
            '--score_threshold',
            '0.5',
            '--reduce_redundancy_in_output',
            '--deduplicate_transitive_similarity',
            '--enactment_years_file_path',
            '/path/to/enactment/years',
        ]
        expected_function_output = 'highest_scores', {
            'matrix_file_path': '/path/to/similarity/matrix',
            'number_of_scores': 5,
            'include_provision_contents_in_output': True,
            'legislation_directory_path': '/path/to/legislation/directory',
            'debug': True,
            'score_threshold': 0.5,
            'reduce_redundancy_in_output': True,
            'deduplicate_transitive_similarity': True,
            'enactment_years_file_path': '/path/to/enactment/years',
            'func': self.highest_provision_group_scores_function,
        }
        parsed_arguments = self.parser.parse(arguments)
        actual_function_output = parsed_arguments.func(parsed_arguments)
        assert expected_function_output == actual_function_output

    def test_parse_highest_scores_assigns_false_to_include_provision_contents_in_output_when_no_argument(self):
        arguments = ['highest_provision_group_scores', '/path/to/similarity/matrix', '5']
        assert self.parser.parse(arguments).include_provision_contents_in_output is False

    def test_parse_highest_scores_assigns_false_to_debug_parameter_when_debug_argument_not_provided(self):
        arguments = ['highest_provision_group_scores', '/path/to/similarity/matrix', '5']
        assert self.parser.parse(arguments).debug is False

    def test_parse_highest_scores_assigns_package_path_to_legislation_directory_path_when_argument_not_provided(self):
        arguments = ['highest_provision_group_scores', '/path/to/similarity/matrix', '5']
        expected_legislation_directory_path = environment.LEGISLATION_DIRECTORY_PATH
        actual_legislation_directory_path = \
            self.parser.parse(arguments).legislation_directory_path
        assert expected_legislation_directory_path == actual_legislation_directory_path

    def test_parse_highest_scores_assigns_false_to_reduce_redunancy_in_output_when_argument_not_provided(self):
        arguments = ['highest_provision_group_scores', '/path/to/similarity/matrix', '5']
        assert self.parser.parse(arguments).reduce_redundancy_in_output is False

    def test_parse_highest_scores_assigns_false_to_deduplicate_transitive_similarity_when_argument_not_provided(self):
        arguments = ['highest_provision_group_scores', '/path/to/similarity/matrix', '5']
        assert self.parser.parse(arguments).deduplicate_transitive_similarity is False

    def test_parse_highest_scores_assigns_package_path_to_enactment_years_file_path_when_argument_not_provided(self):
        arguments = ['highest_provision_group_scores', '/path/to/similarity/matrix', '5']
        expected_enactment_years_file_path = environment.ENACTMENT_YEARS_DEFAULT_FILE_PATH
        actual_enactment_years_file_path = \
            self.parser.parse(arguments).enactment_years_file_path
        assert expected_enactment_years_file_path == actual_enactment_years_file_path
