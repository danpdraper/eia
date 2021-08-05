import logging

import pytest


LOGGER = logging.getLogger(__name__)


@pytest.fixture(scope='module', autouse=True)
def log_module_name(request):
    LOGGER.info("Executing tests in module {}".format(request.module.__name__))


@pytest.fixture(scope='function', autouse=True)
def log_test_name(request):
    LOGGER.info("Executing {}".format(request.function.__name__))
