"""
Both pure and view functions are read only function, they cannot write anything to the blockchain.

pure functions do not read any state or global variables

view functions can read state variables, global variables and call internal functions.
"""

# pragma version ^0.4.0

num: public(uint256)

# pure functions does not read any state or global variables
@external
@pure
def pureFunc(x: uint256) -> uint256:
    return x

# view functions might read state or global state, or call an internal function
@external
@view
def viewFunc(x: uint256) -> bool:
    return x > self.num

@external
@pure
def sum(x: uint256, y: uint256, z: uint256) -> uint256:
    return x + y + z

@external
@view
def addNum(x: uint256) -> uint256:
    return x + self.num