# `selfdestruct` deletes the contract from the blockchain. It takes a single input, an address to send all of Ether stored in the contract.

# pragma version ^0.4.0

@external
@payable
def __default__():
    pass

@external
def kill():
    selfdestruct(msg.sender)