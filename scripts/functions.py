from re import S
from unittest import mock
from brownie import accounts, network, config, Contract
from web3 import Web3

DECIMALS = 8
STARTING_VALUE = 200000000000
FORKED_LOCAL_ENVIRONMENTS = ["mainnet-fork-dev"]
LOCAL_BLOCKCHAIN_ENVIRONMENTS = ["development", "ganache-local"]

contract_to_mock = {
    
}

def get_account(index=None, id=None):
    if(index):
        return accounts[index]
    if(id):
        return accounts.load(id)
    if((network.show_active() in LOCAL_BLOCKCHAIN_ENVIRONMENTS) or (network.show_active() in FORKED_LOCAL_ENVIRONMENTS)):
        return accounts[0]
    
    #default account
    return accounts.add(config["wallets"]["from_key"])

def get_verify():
    return config["networks"][network.show_active()].get("verify")

def get_contract(contract_name):
    contract_type = contract_to_mock[contract_name]
    if(network.show_active() in LOCAL_BLOCKCHAIN_ENVIRONMENTS):
        #print(f"Contract {contract_type} has been run {len(contract_type)} times")
        if(len(contract_type) <= 0):
            print(f"Deploying {contract_name} Mock contract...")
            deploy_mocks(contract_name)
            return contract_type[-1]
        return contract_type[-1]
    else:
        contract_address = config["networks"][network.show_active()][contract_name]
        contract = Contract.from_abi(contract_type._name, contract_address, contract_type.abi)
        return contract

def deploy_mocks(contract_name):
    account = get_account()
    contract_type = contract_to_mock[contract_name]
    match contract_name:
        case _:
            pass
    print(f'{contract_name} Mock Deployed!')