from brownie import interface, config, network
import scripts.functions as func

def main():
    get_weth()

def get_weth():
    account = func.get_account()
    contract = interface.IWeth(config["networks"][network.show_active()]["weth_token"])
    txn = contract.deposit({"from": account, "value": 0.1 * (10 ** 18)})
    #txn = contract.withdraw(0.1 * (10 ** 18), {"from": account})
    print("Deposited! You can have 0.1 WETH")
    #print("Youve withdrawn your ETH back")
    txn.wait(1)
    return txn