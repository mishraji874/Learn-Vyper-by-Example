from src import RebaseToken
from moccasin.boa_tools import VyperContract
# from boa.contracts.vyper.vyper_contract import VyperContract

def deploy() -> VyperContract:
    # Deploy the rebase token contract
    rebase_token: VyperContract = RebaseToken.deploy()
    
    # get deployer address
    deployer = rebase_token.boa.env.msg.sender
    
    # authorize deployer
    rebase_token.rely(deployer)
    
    # print initial state
    print("Contract deployed to: ", rebase_token.address)
    print("Total supply: ", rebase_token.pie())
    print("Current timestamp: ", rebase_token.t())
    
    return rebase_token

def moccasin_main() -> VyperContract:
    return deploy()
