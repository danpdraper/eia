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


class ArgumentParser(object):
    def __init__(
            self, matrix_and_plot_function,
            highest_provision_group_scores_function):
        # Top-level parser
        self.argument_parser = argparse.ArgumentParser()
        self.argument_parser.add_argument('--debug', action='store_true')
        self.argument_parser.add_argument(
            '--legislation_directory_path',
            default=environment.LEGISLATION_DIRECTORY_PATH)
        subparsers = self.argument_parser.add_subparsers()

        # Parser for 'matrix_and_plot' command
        matrix_and_plot_parser = subparsers.add_parser('matrix_and_plot')
        matrix_and_plot_parser.add_argument(
            'algorithm', action=AlgorithmAction,
            choices=['jaccard_index', 'term_frequency', 'bigram_frequency'])
        matrix_and_plot_parser.add_argument(
            'scope', action=ScopeAction, choices=['full_text', 'provision'])
        matrix_and_plot_parser.add_argument(
            'language', action=LanguageAction, choices=['english', 'french'])
        matrix_and_plot_parser.add_argument('output_directory_path')
        matrix_and_plot_parser.add_argument(
            '--do_not_preserve_provision_delimiters',
            dest='preserve_provision_delimiters', action='store_false')
        matrix_and_plot_parser.add_argument('--states_to_include_file_path')
        matrix_and_plot_parser.add_argument('--matrix_only', action='store_true')
        matrix_and_plot_parser.set_defaults(func=matrix_and_plot_function)

        # Parser for 'highest_provision_group_scores'
        highest_scores_parser = subparsers.add_parser(
            'highest_provision_group_scores')
        highest_scores_parser.add_argument('matrix_file_path')
        highest_scores_parser.add_argument('number_of_scores', type=int)
        highest_scores_parser.add_argument(
            '--include_provision_contents_in_output', action='store_true')
        highest_scores_parser.add_argument(
            '--score_threshold',
            help='Score threshold in number of standard deviations above mean',
            type=float)
        highest_scores_parser.add_argument(
            '--reduce_redundancy_in_output', action='store_true')
        highest_scores_parser.add_argument(
            '--deduplicate_transitive_similarity', action='store_true')
        highest_scores_parser.add_argument(
            '--enactment_years_file_path',
            default=environment.ENACTMENT_YEARS_DEFAULT_FILE_PATH)
        highest_scores_parser.set_defaults(func=highest_provision_group_scores_function)

    def parse(self, arguments=None):
        if arguments is None:
            return self.argument_parser.parse_args()
        return self.argument_parser.parse_args(arguments)
