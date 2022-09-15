//SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract PeemoTestRewardManager {
    address token;
    uint minimum_stake;
    mapping(address => uint) addresstoamountstaked;

    constructor(address _token){
        token = _token;
    }

    function stakeToken(uint _amount) public payable {
        require(_amount > minimum_stake, "You must stake at least 1 PEEM!");
        IERC20(token).transferFrom(msg.sender, address(this), _amount);
        addresstoamountstaked[msg.sender] += _amount;
    }

    function withdrawStake(uint _amount) public returns (uint) {
        uint player_stake = addresstoamountstaked[msg.sender];
        require(player_stake > _amount, "Insufficient Stake to Withdraw");
        uint stake_to_remain = player_stake - _amount;
        require(stake_to_remain > 1, "You must have at least 1 PEEM staked to remain a player");
        IERC20(token).transferFrom(address(this), msg.sender, _amount);
        return stake_to_remain;
    }

    function getStake() public view returns (uint){
        uint stake = getPlayerStake(msg.sender);
        return stake;
    }

    function getPlayerStake(address _player) public view returns (uint){
        uint stake = addresstoamountstaked[_player];
        return stake;
    }
}