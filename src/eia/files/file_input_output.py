class FileReader(object):
    def __init__(self, file_path):
        self.file_path = file_path
        self.line_generator = None
        self.line_index = -1 

    def _line_generator(self):
        with open(self.file_path, 'r') as file_object:
            for line in file_object:
                yield line

    def read_next_line(self):
        if self.line_generator == None:
            self.line_generator = self._line_generator()
        line = None
        while line == None:
            try:
                line = next(self.line_generator).rstrip('\n')
                self.line_index += 1
            except StopIteration:
                self.line_generator = self._line_generator()
                self.line_index = -1
        return self.line_index, line

    def read_text_unbroken(self):
        with open(self.file_path, 'r') as file_object:
            return file_object.read()


def write(file_path, line_generator):
    with open(file_path, 'w') as file_object:
        for line in line_generator:
            file_object.write("{}\n".format(line))
