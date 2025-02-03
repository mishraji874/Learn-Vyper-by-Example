# When contract A delegates call to contract B, B's code will be executed inside contract A. This will update state variables and Ether balance inside contract A and not B.

# Delegate call is commonly used to create an upgradable contract.

# Here is the contract that we will delegate call to.

# pragma version ^0.4.0

# state variables must be declared in the same order
# as contract making the call
x: public(uint256)
y: public(uint256)

@external
def update_x(x: uint256):
    # when this function is called with delegate call
    # this will update self.x inside the calling contract
    self.x = x + 1

@external
def update_y(y: uint256):
    self.y = y * y