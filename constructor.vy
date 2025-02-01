# __init__ is a special function that is executed only once when the contract is deployed

# pragma version ^0.4.0

owner: public(address)
name: public(String[10])
createdAt: public(uint256)
expiresAt: public(uint256)

@deploy
def __init__(name: String[10], duration: uint256):
    # set owner to the caller
    self.owner = msg.sender

    # set name from input
    self.name = name
    self.createdAt = block.timestamp
    self.expiresAt = block.timestamp + duration