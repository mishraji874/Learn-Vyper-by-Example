"""
Events write logs to the blockchain, commonly used by application to monitor blockchain state and as a cheaper alternative to store data on the blockchain without using state variables.

Events can be efficiently searched by indexing their arguments. Up to 3 parameters can be indexed.
"""

# pragma version ^0.4.0

# up to 3 index
event Transfer:
    # enables quick search of all Transfer events where sender is a certain address
    sender: indexed(address)
    # enables quick search of all Transfer events where receiver is a certain address
    receiver: indexed(address)
    amount: uint256

@external
def transfer(receiver: address, amount: uint256):
    # some code...
    log Transfer(msg.sender, receiver, amount)

@external
def mint(amount: uint256):
    # some code...
    log Transfer(empty(address), msg.sender, amount)

@external
def burn(amount: uint256):
    # some code...
    log Transfer(msg.sender, empty(address), amount)