#!/usr/bin/env python3

import eia.application as application
import eia.argument_parser as argument_parser


if __name__ == '__main__':
    arguments = argument_parser.ArgumentParser().parse()
    application.run(
        arguments.algorithm, arguments.scope, arguments.language,
        arguments.legislation_directory_path, arguments.output_file_path,
        arguments.debug)
