# A contract can have a default function, executed when a function that does not exist is called. This is the same function as the fallback function in Solidity.

# This function is named __default__ and it is commonly used to receive Ether.

# pragma version ^0.4.0

event Payment:
    sender: indexed(address)
    amount: uint256

@external
@payable
def __default__():
    log Payment(msg.sender, msg.value)