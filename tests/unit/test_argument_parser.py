import pytest

import eia.algorithms as algorithms
import eia.argument_parser as argument_parser
import eia.languages as languages
import eia.scopes as scopes


class TestArgumentParser(object):
    def setup(self):
        self.argument_parser = argument_parser.ArgumentParser()

    def test_parse_extracts_expected_arguments(self):
        arguments = [
            'jaccard_index',
            'full_text',
            'english',
            '--legislation_directory_path',
            'test_legislation_directory_path',
            '--output_file_path',
            'test_output_file_path',
            '--debug',
        ]
        expected_namespace = {
            # The equality holds in each of the following three cases because
            # the objects are singletons.
            'algorithm': algorithms.JACCARD_INDEX,
            'scope': scopes.FULL_TEXT,
            'language': languages.ENGLISH,
            'legislation_directory_path': 'test_legislation_directory_path',
            'output_file_path': 'test_output_file_path',
            'debug': True,
        }
        actual_namespace = vars(self.argument_parser.parse(arguments))
        assert expected_namespace == actual_namespace

    def test_parse_raises_system_exit_when_unsupported_algorithm_argument_provided(self):
        arguments = [
            'unsupported_algorithm',
            'full_text',
            'english',
            '--legislation_directory_path',
            'test_legislation_directory_path',
            '--output_file_path',
            'test_output_file_path',
            '--debug',
        ]
        with pytest.raises(SystemExit):
            self.argument_parser.parse(arguments)

    def test_parse_raises_system_exit_when_unsupported_scope_argument_provided(self):
        arguments = [
            'jaccard_index',
            'unsupported_scope',
            'english',
            '--legislation_directory_path',
            'test_legislation_directory_path',
            '--output_file_path',
            'test_output_file_path',
            '--debug',
        ]
        with pytest.raises(SystemExit):
            self.argument_parser.parse(arguments)

    def test_parse_raises_system_exit_when_unsupported_language_argument_provided(self):
        arguments = [
            'jaccard_index',
            'full_text',
            'unsupported_language',
            '--legislation_directory_path',
            'test_legislation_directory_path',
            '--output_file_path',
            'test_output_file_path',
            '--debug',
        ]
        with pytest.raises(SystemExit):
            self.argument_parser.parse(arguments)

    def test_parse_does_not_raise_system_exit_when_optional_arguments_not_provided(self):
        arguments = ['jaccard_index', 'full_text', 'english']
        self.argument_parser.parse(arguments)

    def test_parse_assigns_false_to_debug_parameter_when_debug_argument_not_provided(self):
        arguments = ['jaccard_index', 'full_text', 'english']
        assert self.argument_parser.parse(arguments).debug is False
