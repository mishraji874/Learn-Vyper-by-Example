"""
Immutable variables are like constants except value are assigned when the contract is deployed.

When to use immutable variables?
- You have a variable that needs to be set when the contract is deployed, for example like setting contract owner to msg.sender
and this variable will never change after deployment

Why declare variables as immutable?
Like constants, immutable variables save run time gas
"""

# pragma version ^0.4.0

OWNER: public(immutable(address))
MY_IMMUTABLE: public(immutable(uint256))

@deploy
def __init__(val: uint256):
    OWNER = msg.sender
    MY_IMMUTABLE = val

@external
@view
def get_my_immutable() -> uint256:
    return MY_IMMUTABLE