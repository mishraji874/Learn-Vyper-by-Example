# Vyper has a handy way to secure your contract from re-entrancy.

# A re-entrancy lock can be created on a function with `@nonreentrant`.

# pragma version ^0.4.0

@external
@nonreentrant
def func():
    raw_call(msg.sender, b"", value=0)