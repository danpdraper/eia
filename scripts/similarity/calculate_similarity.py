#!/usr/bin/env python3

import eia.application as application
import eia.argument_parsers as argument_parsers


if __name__ == '__main__':
    arguments = argument_parsers.CalculateSimilarityArgumentParser().parse()
    application.calculate_similarity(
        arguments.algorithm, arguments.scope, arguments.language,
        arguments.output_directory_path, arguments.legislation_directory_path,
        arguments.debug, arguments.preserve_provision_delimiters,
        arguments.states_to_include_file_path)
