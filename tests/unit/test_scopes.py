import pytest

import eia.scopes as scopes


class TestScopes(object):
    def test_init_raises_value_error_when_supplied_unsupported_scope(self):
        # Lowercase
        scope = 'fakescope'
        with pytest.raises(ValueError):
            scopes.Scope(scope)
        # Capitalized
        scope = 'Fakescope'
        with pytest.raises(ValueError):
            scopes.Scope(scope)
        # Uppercase
        scope = 'FAKESCOPE'
        with pytest.raises(ValueError):
            scopes.Scope(scope)

    def test_init_does_not_raise_exception_when_supplied_supported_scope(self):
        # Lowercase
        scope = 'full_text'
        scopes.Scope(scope)
        # Capitalized
        scope = 'Full_Text'
        scopes.Scope(scope)
        # Uppercase
        scope = 'FULL_TEXT'
        scopes.Scope(scope)

    def test_str_returns_lowercase_scope_name(self):
        scope = scopes.Scope('FULL_TEXT')
        assert 'full_text' == str(scope)
