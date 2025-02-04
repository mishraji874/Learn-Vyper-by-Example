from boa.test import strategy
from hypothesis import given
import pytest
from boa import env

RAY = 10 ** 27

def test_initial_state(token):
    assert token.pie() == 0
    assert token.t() == 0

def test_mint(token, accounts):
    amount = 1000 * RAY
    token.mint(accounts[0], amount)
    assert token.pie() == amount
    assert token.balance_of(accounts[0]) == amount

def test_burn(token, accounts):
    initial_amount = 1000 * RAY
    token.mint(accounts[0], initial_amount)
    
    burn_amount = 500 * RAY
    token.burn(burn_amount)
    
    assert token.pie() == initial_amount - burn_amount
    assert token.balance_of(accounts[0]) == initial_amount - burn_amount

def test_transfer(token, accounts):
    amount = 1000 * RAY
    sender = accounts[0]
    recipient = accounts[1]
    
    token.mint(sender, amount)
    token.transfer(recipient, amount // 2)
    
    assert token.balance_of(sender) == amount // 2
    assert token.balance_of(recipient) == amount // 2

def test_poke(token, accounts):
    amount = 1000 * RAY
    token.mint(accounts[0], amount)
    
    initial_balance = token.balance_of(accounts[0])
    env.time_travel(3600)  # advance 1 hour
    token.poke()
    
    assert token.balance_of(accounts[0]) != initial_balance

def test_unauthorized_mint(token, accounts):
    amount = 1000 * RAY
    with env.prank(accounts[1]):
        with pytest.raises(Exception):
            token.mint(accounts[1], amount)

@given(amount=strategy('uint256', max_value=1000 * RAY))
def test_property_mint_burn(token, accounts, amount):
    token.mint(accounts[0], amount)
    token.burn(amount)
    assert token.pie() == 0

def test_rely_deny(token, accounts):
    user = accounts[1]
    
    token.rely(user)
    assert token.wards(user) == 1
    
    token.deny(user)
    assert token.wards(user) == 0

def test_multiple_transfers(token, accounts):
    initial_amount = 1000 * RAY
    sender = accounts[0]
    user1 = accounts[1]
    user2 = accounts[2]
    
    token.mint(sender, initial_amount)
    token.transfer(user1, initial_amount // 2)
    
    with env.prank(user1):
        token.transfer(user2, initial_amount // 4)
    
    assert token.balance_of(sender) == initial_amount // 2
    assert token.balance_of(user1) == initial_amount // 4
    assert token.balance_of(user2) == initial_amount // 4