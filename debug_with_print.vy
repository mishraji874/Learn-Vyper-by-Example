# Use the built-in function print to debug smart contracts.

# pragma version ^0.4.0

@external
def test_print():
    x: uint256 = 123
    # set hardhat_compat = True when testing with hardhat
    print("print something here", x, hardhat_compat=True)