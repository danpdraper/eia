import eia.languages as languages
import eia.text_file_language_filterer as text_file_language_filterer


class TestTextFileLanguageFilterer(object):
    def setup(self):
        self.language = languages.ENGLISH
        self.text_file_language_filterer = \
            text_file_language_filterer.TextFileLanguageFilterer(self.language)

    def test_filter_only_returns_files_whose_language_matches_that_supplied_to_the_constructor(self):
        file_paths = [
            '/path/to/state_a_english.txt',
            '/path/to/state_b_french.txt',
            '/path/to/state_c_spanish.txt',
            '/path/to/state_d_russian.txt',
            # Misspelled language in file name
            '/path/to/state_e_engish.txt',
            '/path/to/state_f_english.txt',
        ]
        expected_file_paths = [
            '/path/to/state_a_english.txt',
            '/path/to/state_f_english.txt',
        ]
        assert expected_file_paths == \
            self.text_file_language_filterer.filter(file_paths)
