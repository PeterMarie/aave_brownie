from brownie import PeemoTester, PeemoTestRewardManager
import scripts.functions as func
from web3 import Web3

player_id = 1

def deploy_peem():
    if(len(PeemoTester) <= 0):
        initial_supply = Web3.toWei(10000000000, 'ether')
        account = func.get_account()
        contract = PeemoTester.deploy(initial_supply, {'from': account})
    else:
        contract = PeemoTester[-1]
    return contract

def deploy_staking_contract():
    peem_contract = deploy_peem()
    if(len(PeemoTestRewardManager) <= 0):
        token_address = peem_contract.address
        account = func.get_account()
        contract = PeemoTestRewardManager.deploy(token_address, {'from': account})
    else:
        contract = PeemoTestRewardManager[-1]
    return contract

def get_peem():
    account = func.get_account()
    contract = deploy_peem()
    receiving_account = func.get_account(index=1)
    amount = int(input("Enter amount to Receive/n"))
    txn = contract.transfer(receiving_account, amount, {"from": account})
    txn.wait(1)
    return amount

def stake_peem():
    account = func.get_account(index=1)
    peem_available = get_peem()
    amount_to_stake = int(input("Enter amount to Stake/n"))
    contract = deploy_staking_contract()
    peem_contract = deploy_peem()
    txn = peem_contract.increaseAllowance(contract.address, amount_to_stake, {"from":account})
    txn.wait(1)
    txn1 = contract.stakeToken(amount_to_stake, {"from": account})
    txn1.wait(1)
    print(contract.getStake({"from": account}))


def withdraw_staked_peem():
    pass

def get_staked_peem():
    contract = deploy_staking_contract()
    staked_peem = contract.getPlayerStake(player_id)

def main():
    stake_peem()