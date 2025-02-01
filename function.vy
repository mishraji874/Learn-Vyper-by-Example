# pragma version ^0.4.0

@external
@pure
def multiply(x: uint256, y: uint256) -> uint256:
    return x * y

@external
@pure
def divide(x: uint256, y: uint256) -> uint256:
    return x // y

# a function that does nothing
@external
def doesNothing():
    # pass is useful when you want to compile the contract now,
    # write the code later
    pass

# function can return multiple outputs
@external
@pure
def multiOut() -> (uint256, bool):
    return (1, True)

@external
@pure
def addAndSub(x: uint256, y: uint256) -> (uint256, uint256):
    return (x + y, x - y)