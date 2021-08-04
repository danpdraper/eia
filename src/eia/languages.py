SUPPORTED_LANGUAGES = ['english']


class Language(object):
    def __init__(self, language):
        if language.lower() not in SUPPORTED_LANGUAGES:
            raise ValueError("Language {} is not supported.".format(language))
        self.language = language

    def __str__(self):
        return self.language.lower()


ENGLISH = Language('english')


LANGUAGES = {
    'english': ENGLISH,
}
