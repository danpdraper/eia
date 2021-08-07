NEWLINE_CHARACTER = '\n'


def read(file_path):
    with open(file_path, 'r') as file_object:
        return file_object.read()


def line_generator(file_path):
    with open(file_path, 'r') as file_object:
        for line in file_object:
            yield line.rstrip(NEWLINE_CHARACTER)


def write(file_path, line_generator):
    with open(file_path, 'w') as file_object:
        for line in line_generator:
            file_object.write("{}{}".format(line, NEWLINE_CHARACTER))