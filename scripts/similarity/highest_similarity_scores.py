#!/usr/bin/env python3

import eia.application as application
import eia.argument_parsers as argument_parsers


if __name__ == '__main__':
    arguments = argument_parsers.HighestSimilarityScoreArgumentParser().parse()
    row_labels_and_column_labels_and_elements = \
        application.extract_highest_similarity_scores(
            arguments.similarity_matrix_file_path, arguments.number_of_scores,
            arguments.debug)
    for labels_and_elements in row_labels_and_column_labels_and_elements:
        print("{}\t{}\t{:.3f}".format(*labels_and_elements))
