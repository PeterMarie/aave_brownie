//SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

interface PeemoTestStakeManager {
    function stakeToken(uint _playerId, uint _amount) external payable;

    function withdrawStake(uint _playerId, uint _amount) external returns (uint);

    function getPlayerStake(uint _playerId) external view returns (uint);
}

contract PeemoTestRewardManager {
    address token;
    address stake_manager;
    mapping(address => uint) addresstoamountstaked;

    constructor(address _token, address _stake_manager){
        token = _token;
        stake_manager = _stake_manager;
    }

}