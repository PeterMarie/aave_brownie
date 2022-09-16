//SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract PeemoTestStakeManager is Ownable {
    address token;
    uint minimum_stake;
    mapping(uint => uint) playeridtoamountstaked;

    constructor(address _token){
        token = _token;
    }

    function stakeToken(uint _playerId, address _playerAddress, uint _amount) public payable {
        require(_amount > minimum_stake, "You must stake at least 1 PEEM!");
        IERC20(token).transferFrom(_playerAddress, address(this), _amount);
        playeridtoamountstaked[_playerId] += _amount;
    }

    function withdrawStake(uint _playerId, address _playerAddress, uint _amount) public returns (uint) {
        uint player_stake = playeridtoamountstaked[_playerId];
        require(player_stake > _amount, "Insufficient Stake to Withdraw");
        uint stake_to_remain = player_stake - _amount;
        require(stake_to_remain > 1, "You must have at least 1 PEEM staked to remain a player");
        IERC20(token).transferFrom(address(this), _playerAddress, _amount);
        return stake_to_remain;
    }

    function getPlayerStake(uint _playerId) public view returns (uint){
        uint stake = playeridtoamountstaked[_playerId];
        return stake;
    }

}