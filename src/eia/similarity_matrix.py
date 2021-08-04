def generator(labels, values):
    if len(labels) != len(values):
        raise ValueError("The number of rows in values must equal the number of "
            "elements in labels. labels: {}. values: {}.".format(labels, values))
    if len(values) != len(values[0]):
        raise ValueError("The number of rows and the number of columns in "
            "values must be equal. values: {}".format(values))
    for row in zip(labels, values):
        yield [row[0]] + row[1]
