# Constants are variables that cannot change

# pragma version ^0.4.0

MY_CONSTANT: public(constant(uint256)) = 123
MIN: public(constant(uint256)) = 1
MAX: public(constant(uint256)) = 10
ADDR: public(constant(address)) = 0xAb5801a7D398351b8bE11C439e05C5B3259aeC9B

@external
@pure
def deprecated_constants() -> (address, uint256, bytes32):
    # 0.3 deprecated constants
    # return (ZERO_ADDRESS, MY_UINT256, EMPTY_BYTES32)
    # 0.4
    return (empty(address), max_value(uint256), empty(bytes32))

@external
@pure
def getMyConstants() -> (uint256, uint256, address):
    return (MIN, MAX, ADDR)