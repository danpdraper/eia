#!/usr/bin/env python3

import eia.application as application
import eia.argument_parsers as argument_parsers


if __name__ == '__main__':
    arguments = argument_parsers.HighestSimilarityScoreArgumentParser().parse()
    provision_pairs = application.extract_highest_similarity_scores(
        arguments.similarity_matrix_file_path, arguments.number_of_scores,
        arguments.include_provision_contents_in_output,
        arguments.legislation_directory_path, arguments.debug)
    for provision_pair in provision_pairs:
        print("{}\t{}\t{:.3f}".format(*provision_pair[:3]))
        if len(provision_pair) > 3:
            print("\n{}: {}".format(provision_pair[0], provision_pair[3]))
            print("\n{}: {}".format(provision_pair[1], provision_pair[4]))
            print("\n----------\n")
