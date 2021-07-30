import os


class TextFileDiscoverer(object):
    def __init__(self, text_file_directory_path):
        self.text_file_directory_path = text_file_directory_path

    def discover(self):
        text_file_paths = []
        for root_directory_path, directory_names, file_names in \
                os.walk(self.text_file_directory_path):
            for file_name in file_names:
                if file_name.endswith('.txt'):
                    text_file_paths.append(
                        os.path.join(root_directory_path, file_name))
        return text_file_paths
