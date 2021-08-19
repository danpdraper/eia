import argparse

import eia.algorithms as algorithms
import eia.environment as environment
import eia.languages as languages
import eia.scopes as scopes


class AlgorithmAction(argparse.Action):
    def __call__(self, parser, namespace, values, option_string=None):
        setattr(namespace, self.dest, algorithms.ALGORITHMS[values])


class ScopeAction(argparse.Action):
    def __call__(self, parser, namespace, values, option_string=None):
        setattr(namespace, self.dest, scopes.SCOPES[values])


class LanguageAction(argparse.Action):
    def __call__(self, parser, namespace, values, option_string=None):
        setattr(namespace, self.dest, languages.LANGUAGES[values])


class CalculateSimilarityArgumentParser(object):
    def __init__(self):
        self.argument_parser = argparse.ArgumentParser()
        self.argument_parser.add_argument(
            'algorithm', action=AlgorithmAction,
            choices=['jaccard_index', 'term_frequency'])
        self.argument_parser.add_argument(
            'scope', action=ScopeAction, choices=['full_text', 'provision'])
        self.argument_parser.add_argument(
            'language', action=LanguageAction, choices=['english', 'french'])
        self.argument_parser.add_argument('output_directory_path')
        self.argument_parser.add_argument(
            '--legislation_directory_path',
            default=environment.LEGISLATION_DIRECTORY_PATH)
        self.argument_parser.add_argument('--debug', action='store_true')
        self.argument_parser.add_argument(
            '--do_not_preserve_provision_delimiters',
            dest='preserve_provision_delimiters', action='store_false')
        self.argument_parser.add_argument(
            '--states_to_include_file_path',
            default=environment.STATES_TO_INCLUDE_DEFAULT_FILE_PATH)

    def parse(self, arguments=None):
        if arguments is None:
            return self.argument_parser.parse_args()
        return self.argument_parser.parse_args(arguments)


class HighestSimilarityScoreArgumentParser(object):
    def __init__(self):
        self.argument_parser = argparse.ArgumentParser()
        self.argument_parser.add_argument('similarity_matrix_file_path')
        self.argument_parser.add_argument('number_of_scores', type=int)
        self.argument_parser.add_argument(
            '--include_provision_contents_in_output', action='store_true')
        self.argument_parser.add_argument(
            '--legislation_directory_path',
            default=environment.LEGISLATION_DIRECTORY_PATH)
        self.argument_parser.add_argument('--debug', action='store_true')

    def parse(self, arguments=None):
        if arguments is None:
            return self.argument_parser.parse_args()
        return self.argument_parser.parse_args(arguments)
