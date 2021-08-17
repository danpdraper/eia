import logging
import sys

import matplotlib.pyplot as pyplot
import matplotlib.ticker as ticker
import numpy
import numpy.ma as ma

import eia.files.csv_files as csv_files
import eia.scopes as scopes
import eia.transformations as transformations


COMMA_AND_SPACE = ', '


LOGGER = logging.getLogger(__name__)


def trim_data_for_full_text(data, row_labels, column_labels):
    trimmed_data = data[1:]
    for row in trimmed_data:
        row.pop(len(row) - 1)

    trimmed_row_labels = row_labels[1:]
    trimmed_column_labels = column_labels[:-1]

    for row_index in range(len(trimmed_row_labels)):
        for column_index in range(len(trimmed_column_labels)):
            if column_index > row_index:
                trimmed_data[row_index][column_index] = -1

    masked_trimmed_data = ma.masked_values(trimmed_data, -1)

    return masked_trimmed_data, trimmed_row_labels, trimmed_column_labels


def trim_data_for_provisions(data, row_labels, column_labels):
    first_state_in_row_labels = csv_files.state_and_provision_number_from_label(
        row_labels[0])[0]
    first_state_row_labels = list(filter(
        lambda label: csv_files.state_and_provision_number_from_label(label)[0] == first_state_in_row_labels,
        row_labels))
    last_state_in_column_labels = csv_files.state_and_provision_number_from_label(
        column_labels[-1])[0]
    last_state_column_labels = list(filter(
        lambda label: csv_files.state_and_provision_number_from_label(label)[0] == last_state_in_column_labels,
        column_labels))

    LOGGER.debug("First state row labels: {}".format(first_state_row_labels))
    LOGGER.debug("Last state column labels: {}".format(last_state_column_labels))

    trimmed_data = []
    row_label_lower_bound_index = sys.maxsize
    row_label_upper_bound_index = -1
    column_label_lower_bound_index = sys.maxsize
    column_label_upper_bound_index = -1

    for row_index in range(len(first_state_row_labels), len(row_labels)):
        trimmed_row = []
        row_state, row_provision_number = \
            csv_files.state_and_provision_number_from_label(
                row_labels[row_index])
        for column_index in range(0, len(column_labels) - len(last_state_column_labels)):
            column_state, column_provision_number = \
                csv_files.state_and_provision_number_from_label(
                    column_labels[column_index])
            # The first expression in the following predicate will evaluate to
            # True when column_state is equal to row_state (e.g. column_state =
            # A, row_state = A) or when column_state would follow row_state if
            # the two were sorted in ascending alphabetical order (e.g.
            # column_state = B, row_state = A).
            if column_state >= row_state and \
                    row_index >= row_label_lower_bound_index:
                LOGGER.debug(
                    "Adding -1 to trimmed data at row {} {} and column {} {} "
                    "for later masking.".format(
                        row_state, row_provision_number, column_state,
                        column_provision_number))
                trimmed_row.append(-1)
            else:
                trimmed_row.append(data[row_index][column_index])
                if row_index < row_label_lower_bound_index:
                    row_label_lower_bound_index = row_index
                if row_index > row_label_upper_bound_index:
                    row_label_upper_bound_index = row_index
                if column_index < column_label_lower_bound_index:
                    column_label_lower_bound_index = column_index
                if column_index > column_label_upper_bound_index:
                    column_label_upper_bound_index = column_index
        LOGGER.debug(
            "Trimmed row {} {} contains {} elements.".format(
                row_state, row_provision_number, len(trimmed_row)))
        if trimmed_row:
            trimmed_data.append(trimmed_row)

    LOGGER.debug("Row label lower bound index: {}".format(
        row_label_lower_bound_index))
    LOGGER.debug("Row label upper bound index: {}".format(
        row_label_upper_bound_index))
    LOGGER.debug("Column label lower bound index: {}".format(
        column_label_lower_bound_index))
    LOGGER.debug("Column label upper bound index: {}".format(
        column_label_upper_bound_index))

    masked_trimmed_data = ma.masked_values(trimmed_data, -1)
    trimmed_row_labels = \
        row_labels[row_label_lower_bound_index:row_label_upper_bound_index + 1]
    trimmed_column_labels = \
        column_labels[column_label_lower_bound_index:column_label_upper_bound_index + 1]

    LOGGER.debug("Trimmed data: {}".format(trimmed_data))
    LOGGER.debug("Masked trimmed data {}".format(masked_trimmed_data))
    LOGGER.debug("Trimmed row labels: {}".format(trimmed_row_labels))
    LOGGER.debug("Trimmed column labels: {}".format(trimmed_column_labels))

    return masked_trimmed_data, trimmed_row_labels, trimmed_column_labels


def configure_colour_bar(colour_bar, colour_bar_label):
    colour_bar.ax.set_ylabel(colour_bar_label, rotation=-90, va='bottom')
    colour_bar.ax.spines[:].set_visible(False)
    colour_bar.ax.tick_params(axis='y', which='major', length=0)


def configure_axes(axes, row_labels, column_labels):
    axes.set_xticks(numpy.arange(len(column_labels)))
    axes.set_xticklabels(column_labels, fontsize=8)
    axes.set_yticks(numpy.arange(len(row_labels)))
    axes.set_yticklabels(row_labels, fontsize=8)
    axes.tick_params(axis='both', which='both', length=0)
    axes.grid(which='minor', color='w', linestyle='-', linewidth=3)


def heatmap(data, row_labels, column_labels, title, colour_bar_label):
    figure, axes = pyplot.subplots()

    axes_image = axes.imshow(data, cmap='Reds', vmin=0, vmax=1)

    configure_colour_bar(
        axes.figure.colorbar(axes_image, ax=axes), colour_bar_label)

    configure_axes(axes, row_labels, column_labels)

    axes.spines[:].set_visible(False)

    axes.set_title(title, pad=20)

    return axes


def configure_axes_for_full_text(axes, row_labels, column_labels):
    axes.set_xticks(numpy.arange(len(column_labels) + 1) - 0.5, minor=True)
    axes.set_yticks(numpy.arange(len(row_labels) + 1) - 0.5, minor=True)
    pyplot.setp(axes.get_xticklabels(), rotation=45, ha='right')


def add_data_labels(data, axes):
    value_formatter = ticker.StrMethodFormatter('{x:0.2f}')
    for row_index in range(len(data)):
        for column_index in range(len(data[row_index])):
            element_value = data[row_index, column_index]
            if element_value is ma.masked:
                continue
            axes.text(
                column_index, row_index,
                value_formatter(element_value, None),
                horizontalalignment='center', verticalalignment='center',
                color='white' if element_value > 0.5 else 'black')


def similarity_heatmap_for_full_text(
        data, row_labels, column_labels, title, colour_bar_label):
    trimmed_masked_data, trimmed_row_labels, trimmed_column_labels = \
        trim_data_for_full_text(data, row_labels, column_labels)
    axes = heatmap(
        trimmed_masked_data, trimmed_row_labels, trimmed_column_labels, title,
        colour_bar_label)
    configure_axes_for_full_text(axes, trimmed_row_labels, trimmed_column_labels)
    add_data_labels(trimmed_masked_data, axes)


def provision_numbers_from_labels(labels):
    return list(map(
        lambda label: csv_files.state_and_provision_number_from_label(label)[1],
        labels))


def unique_states_from_labels(labels):
    unique_states = []
    for label in labels:
        state = csv_files.state_and_provision_number_from_label(label)[0]
        if state not in unique_states:
            unique_states.append(state)
    return unique_states


def configure_axes_for_provisions(
        axes, row_labels, column_labels, x_axis_label, y_axis_label):
    x_axis_tick_count = int(len(column_labels) / 10)
    x_axis_tick_count = 1 if x_axis_tick_count < 1 else x_axis_tick_count
    LOGGER.debug("x-axis tick count: {}".format(x_axis_tick_count))
    axes.xaxis.set_major_locator(ticker.MaxNLocator(x_axis_tick_count))
    y_axis_tick_count = int(len(row_labels) / 5)
    y_axis_tick_count = 1 if y_axis_tick_count < 1 else y_axis_tick_count
    LOGGER.debug("y-axis tick count: {}".format(y_axis_tick_count))
    axes.yaxis.set_major_locator(ticker.MaxNLocator(y_axis_tick_count))
    axes.set_xlabel(x_axis_label)
    axes.set_ylabel(y_axis_label)


def similarity_heatmap_for_provisions(
        data, row_labels, column_labels, title, colour_bar_label):
    trimmed_data, trimmed_row_labels, trimmed_column_labels = \
        trim_data_for_provisions(data, row_labels, column_labels)
    axes = heatmap(
        trimmed_data, provision_numbers_from_labels(trimmed_row_labels),
        provision_numbers_from_labels(trimmed_column_labels), title,
        colour_bar_label)
    configure_axes_for_provisions(
        axes, trimmed_row_labels, trimmed_column_labels,
        COMMA_AND_SPACE.join(unique_states_from_labels(trimmed_column_labels)),
        COMMA_AND_SPACE.join(unique_states_from_labels(trimmed_row_labels)[::-1]))


HEATMAP_BY_SCOPE = {
    scopes.FULL_TEXT: similarity_heatmap_for_full_text,
    scopes.PROVISION: similarity_heatmap_for_provisions,
}


def similarity_heatmap(
        labels_and_rows, algorithm, scope, preserve_provision_delimiters,
        output_file_path):
    labels, rows = zip(*labels_and_rows)
    title = "{} {} With{} Provision Delimiters".format(
        transformations.snake_case_string_to_capitalized(algorithm.to_string()),
        transformations.snake_case_string_to_capitalized(str(scope)),
        '' if preserve_provision_delimiters else 'out')
    HEATMAP_BY_SCOPE[scope](rows, labels, labels, title, 'Similarity')
    LOGGER.info('Generated similarity heatmap')
    pyplot.savefig(output_file_path, bbox_inches='tight')
    LOGGER.info("Wrote similarity heatmap to {}".format(output_file_path))
