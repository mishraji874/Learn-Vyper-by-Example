# There are two ways to send Ether from a contract, `send` and `raw_call`. Here we introduce the simpler function to use, send.

# pragma version ^0.4.0

# receive ether into this contract
@external
@payable
def __default__():
    pass

@external
def send_eth(to: address, amount: uint256):
    # when ether is sent to a contract it will call
    # __default__ inside the receiving contract
    # forwards 2300 gas
    send(to, amount)

@external
def send_all(to: address):
    send(to, self.balance)