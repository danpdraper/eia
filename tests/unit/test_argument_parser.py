import pytest

import eia.algorithms as algorithms
import eia.argument_parser as argument_parser
import eia.environment as environment
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
            '/path/to/output/directory',
            '--legislation_directory_path',
            'test_legislation_directory_path',
            '--debug',
            '--do_not_preserve_provision_delimiters',
        ]
        expected_namespace = {
            # The equality holds in each of the following three cases because
            # the objects are singletons.
            'algorithm': algorithms.JACCARD_INDEX,
            'scope': scopes.FULL_TEXT,
            'language': languages.ENGLISH,
            'output_directory_path': '/path/to/output/directory',
            'legislation_directory_path': 'test_legislation_directory_path',
            'debug': True,
            'preserve_provision_delimiters': False,
        }
        actual_namespace = vars(self.argument_parser.parse(arguments))
        assert expected_namespace == actual_namespace

    def test_parse_raises_system_exit_when_unsupported_algorithm_argument_provided(self):
        arguments = [
            'unsupported_algorithm',
            'full_text',
            'english',
            '/path/to/output/directory',
            '--legislation_directory_path',
            'test_legislation_directory_path',
            '--debug',
            '--do_not_preserve_provision_delimiters',
        ]
        with pytest.raises(SystemExit):
            self.argument_parser.parse(arguments)

    def test_parse_raises_system_exit_when_unsupported_scope_argument_provided(self):
        arguments = [
            'jaccard_index',
            'unsupported_scope',
            'english',
            '/path/to/output/directory',
            '--legislation_directory_path',
            'test_legislation_directory_path',
            '--debug',
            '--do_not_preserve_provision_delimiters',
        ]
        with pytest.raises(SystemExit):
            self.argument_parser.parse(arguments)

    def test_parse_raises_system_exit_when_unsupported_language_argument_provided(self):
        arguments = [
            'jaccard_index',
            'full_text',
            'unsupported_language',
            '/path/to/output/directory',
            '--legislation_directory_path',
            'test_legislation_directory_path',
            '--debug',
            '--do_not_preserve_provision_delimiters',
        ]
        with pytest.raises(SystemExit):
            self.argument_parser.parse(arguments)

    def test_parse_does_not_raise_system_exit_when_optional_arguments_not_provided(self):
        arguments = ['jaccard_index', 'full_text', 'english', '/path/to/output/directory']
        self.argument_parser.parse(arguments)

    def test_parse_assigns_false_to_debug_parameter_when_debug_argument_not_provided(self):
        arguments = ['jaccard_index', 'full_text', 'english', '/path/to/output/directory']
        assert self.argument_parser.parse(arguments).debug is False

    def test_parse_assigns_true_to_preserve_provision_delimiters_parameter_when_argument_not_provided(self):
        arguments = ['jaccard_index', 'full_text', 'english', '/path/to/output/directory']
        assert self.argument_parser.parse(arguments).preserve_provision_delimiters is True

    def test_parse_assigns_path_in_package_to_legislation_directory_path_parameter_when_argument_not_provided(self):
        arguments = ['jaccard_index', 'full_text', 'english', '/path/to/output/directory']
        expected_legislation_directory_path = environment.LEGISLATION_DIRECTORY_PATH
        actual_legislation_directory_path = \
            self.argument_parser.parse(arguments).legislation_directory_path
        assert expected_legislation_directory_path == actual_legislation_directory_path
