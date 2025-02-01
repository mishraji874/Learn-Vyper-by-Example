# Private state variables -> cannot be accessed from outside the contract
# Public state variables -> can be read by anyone, including users and other contracts

# pragma version ^0.4.0

# public state variables
owner: public(address)

# private state variables
foo: uint256
bar: public(bool)

@deploy
def __init__():
    self.owner = msg.sender
    self.foo = 123
    self.bar = True