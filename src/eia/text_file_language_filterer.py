import re


class TextFileLanguageFilterer(object):
    def __init__(self, language):
        self.language = language
        self.file_name_suffix_regex = re.compile(r"{}\.txt".format(self.language))

    def filter(self, file_paths):
        return list(filter(
            lambda file_path : self.file_name_suffix_regex.search(file_path),
            file_paths))
