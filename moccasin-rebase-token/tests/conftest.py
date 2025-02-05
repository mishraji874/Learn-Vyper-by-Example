import pytest
from script.deploy import deploy
from boa import env

@pytest.fixture(scope="module")
def accounts():
    return [env.generate_address() for _ in range(10)]

@pytest.fixture(scope="module")
def token(accounts):
    env.eoa = accounts[0]  # Set deployer account
    return deploy()