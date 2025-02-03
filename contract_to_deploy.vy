# Vyper contracts can deploy new contracts using the function `create_minimal_proxy_to`.

# `create_minimal_proxy_to` is also known as "minimal proxy contract". How it works, we won't explain it here.

# Here we will focus on how to use it to deploy new contracts.

# How to use `create_minimal_proxy_to`
# Deploy `contract_to_deploy`. This is the "master copy." All deployed contracts will execute code from this master copy.
# Call `deploy()` passing the address of the master copy and any other arguments needed to setup the new contract

# pragma version ^0.4.0

owner: public(address)

# create_minimal_proxy_to
# 1. Deploy master copy
# 2. Call create_minimal_proxy_to

# Master copy contract M (Test.vy)
#                      |
#                      V
# Factory -- create_minimal_proxy_to --> contract A (Test.vy)

# user -> A -- delegate call --> M

# __init__ is not called when deployed from create_minimal_proxy_to
@deploy
def __init__():
  self.owner = msg.sender

# call once after create_minimal_proxy_to
@external
def set_owner(owner: address):
  assert self.owner == empty(address), "owner != zero address"
  self.owner = owner

# DANGER: never have selfdestruct in original contract used by create_minimal_proxy_to
# This function has been deprecated from version 0.3.8 onwards. The underlying
# opcode will eventually undergo breaking changes, and its use is not recommended.
@external
def kill():
  selfdestruct(msg.sender)
