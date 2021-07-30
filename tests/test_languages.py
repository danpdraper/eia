import pytest

import eia.languages as languages


class TestLanguage(object):
    def test_init_raises_exception_when_supplied_unsupported_language(self):
        # Lowercase
        language = 'fakeguage'
        with pytest.raises(ValueError):
            languages.Language(language)
        # Capitalized
        language = 'Fakeguage'
        with pytest.raises(ValueError):
            languages.Language(language)
        # Uppercase
        language = 'FAKEGUAGE'
        with pytest.raises(ValueError):
            languages.Language(language)

    def test_init_does_not_raise_exception_when_supplied_supported_language(self):
        # Lowercase
        language = 'english'
        languages.Language(language)
        # Capitalized
        language = 'English'
        languages.Language(language)
        # Uppercase
        language = 'ENGLISH'
        languages.Language(language)

    def test_str_returns_lowercase_language_name(self):
        language = languages.Language('ENGLISH')
        assert 'english' == str(language)
