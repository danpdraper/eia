import argparse

import eia.algorithms as algorithms
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
    def __init__(self):
        self.argument_parser = argparse.ArgumentParser()
        self.argument_parser.add_argument(
            'algorithm', action=AlgorithmAction, choices=['jaccard_index'])
        self.argument_parser.add_argument(
            'scope', action=ScopeAction, choices=['full_text'])
        self.argument_parser.add_argument(
            'language', action=LanguageAction, choices=['english'])
        self.argument_parser.add_argument('--legislation_directory_path')
        self.argument_parser.add_argument('--output_file_path')

    def parse(self, arguments=None):
        if arguments == None:
            return self.argument_parser.parse_args()
        return self.argument_parser.parse_args(arguments)
