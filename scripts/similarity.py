#!/usr/bin/env python3

import eia.application as application
import eia.argument_parser as argument_parser


if __name__ == '__main__':
    parser = argument_parser.ArgumentParser(
        application.matrix_and_plot, application.highest_provision_group_scores,
        application.graph)
    arguments = parser.parse()
    arguments.func(arguments)
