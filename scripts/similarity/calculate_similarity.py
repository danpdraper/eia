#!/usr/bin/env python3

import eia.application as application
import eia.similarity_argument_parser as similarity_argument_parser


if __name__ == '__main__':
    arguments = similarity_argument_parser.SimilarityArgumentParser().parse()
    application.run(arguments.algorithm, arguments.legislation_language,
        arguments.legislation_directory_path, arguments.output_file_path)
