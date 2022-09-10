
from brownie import network, config
import scripts.functions as func
from scripts.get_weth import get_weth

def main():
    account = func.get_account()
    erc20_address = config["networks"][network.show_active()]["weth_token"]
    if (network.show_active() in func.FORKED_LOCAL_ENVIRONMENTS):
        get_weth()

