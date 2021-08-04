SUPPORTED_SCOPES = ['full_text']


class Scope(object):
    def __init__(self, scope):
        if scope.lower() not in SUPPORTED_SCOPES:
            raise ValueError("Scope {} is not supported.".format(scope))
        self.scope = scope

    def __str__(self):
        return self.scope.lower()


FULL_TEXT = Scope('full_text')


SCOPES = {
    'full_text': FULL_TEXT,
}
