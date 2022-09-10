from re import S
from unittest import mock
from brownie import accounts, network, config
from web3 import Web3

DECIMALS = 8
STARTING_VALUE = 200000000000
FORKED_LOCAL_ENVIRONMENTS = ["mainnet-fork-dev"]
LOCAL_BLOCKCHAIN_ENVIRONMENTS = ["development", "ganache-local"]

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
