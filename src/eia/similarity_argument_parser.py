import argparse


class SimilarityArgumentParser(object):
    def __init__(self):
        self.argument_parser = argparse.ArgumentParser()
        self.argument_parser.add_argument('algorithm', choices=['jaccard'])
        self.argument_parser.add_argument('legislation_language')
        self.argument_parser.add_argument('--legislation_directory_path')
        self.argument_parser.add_argument('--output_file_path')

    def parse(self):
        return self.argument_parser.parse_args()
