import matplotlib.pyplot as pyplot
import numpy


def heatmap(
        data, row_labels, column_labels, title, colour_bar_label,
        output_file_path):
    figure, axes = pyplot.subplots()
    axes_image = axes.imshow(data)

    colour_bar = axes.figure.colorbar(axes_image, ax=axes)
    colour_bar.ax.set_ylabel(colour_bar_label, rotation=-90, va='bottom')

    axes.set_xticks(numpy.arange(len(column_labels)))
    axes.set_xticklabels(column_labels)
    axes.set_yticks(numpy.arange(len(row_labels)))
    axes.set_yticklabels(row_labels)

    pyplot.setp(
        axes.get_xticklabels(), rotation=90, ha='right', rotation_mode='anchor')

    axes.set_title(title)

    pyplot.savefig(output_file_path)


def similarity_heatmap(labels_and_rows, algorithm, scope, output_file_path):
    labels, rows = zip(*labels_and_rows)
    title = "{} {}".format(scope, algorithm.to_string())
    heatmap(rows, labels, labels, title, 'Similarity', output_file_path)
