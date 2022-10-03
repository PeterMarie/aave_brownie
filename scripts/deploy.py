#!C:/Users/TheresaOgwara/AppData/Local/Programs/Python/Python310/python

from audioop import add
from brownie import PeemoTester, PeemoTestStakeManager, PeemoTestPlayerManager
import scripts.functions as func
from web3 import Web3

player_account = 0

account = func.get_account()
unclaimed_peem_address = func.get_account(index=2)

def deploy_peem():
    if(len(PeemoTester) <= 0):
        initial_supply = Web3.toWei(10000000000, 'ether')
        contract = PeemoTester.deploy(initial_supply, {'from': account})
    else:
        contract = PeemoTester[-1]
    return contract

def deploy_staking_contract():
    peem_contract = deploy_peem()
    if(len(PeemoTestStakeManager) <= 0):
        token_address = peem_contract.address
        contract = PeemoTestStakeManager.deploy(token_address, {'from': account})
    else:
        contract = PeemoTestStakeManager[-1]
    return contract

def deploy_player_contract():
    peem_contract = deploy_peem()
    if(len(PeemoTestPlayerManager) <= 0):
        token_address = peem_contract.address
        contract = PeemoTestPlayerManager.deploy(token_address, unclaimed_peem_address, {'from': account})
    else:
        contract = PeemoTestPlayerManager[-1]
    return contract

def get_player_details():
    playercontract = deploy_player_contract()
    player_id = playercontract.getPlayerId('peterogwara@gmail.com', {'from': account})
    verified_status = playercontract.isVerified(player_id, {"from": account})
    username = playercontract.getPlayerUsername(player_id, {"from": account})
    if(verified_status == 0):
        player_account = unclaimed_peem_address
    else:
        player_account = playercontract.getplayerAddress(player_id, {"from": account})
    return [verified_status, player_account, username]

def get_peem():
    contract = deploy_peem()
    amount = int(input("Enter amount to Receive/n"))
    txn = contract.transfer(player_account, amount, {"from": account})
    txn.wait(1)
    return amount

def stake_peem():
    peem_available = get_peem()
    amount_to_stake = int(input("Enter amount to Stake/n"))
    contract = deploy_staking_contract()
    peem_contract = deploy_peem()
    txn = peem_contract.increaseAllowance(contract.address, amount_to_stake, {"from":player_account})
    txn.wait(1)
    txn1 = contract.stakeToken(player_id, amount_to_stake, {"from": account})
    txn1.wait(1)
    print(contract.getStake(player_id, {"from": account}))


def withdraw_staked_peem():
    pass

def get_staked_peem():
    contract = deploy_staking_contract()
    staked_peem = contract.getPlayerStake(player_id)

def add_player():
    contract = deploy_player_contract()
    txn = contract.addPlayer('peterogwara@gmail.com', 'PeterMarie', {'from': account})
    txn.wait(1)
    print('Player Added')

def main():
    add_player()
    player_details = get_player_details()
    print(player_details)