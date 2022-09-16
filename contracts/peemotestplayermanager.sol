//SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract PeemoTestRewardManager is Ownable {
    address token;
    address stake_manager;
    address unclaimed_peem_holder;

    //User mappings
    mapping(uint=>address) playeridtoaddress;
    mapping(uint=>string) playeridtousername;
    mapping(uint=>string) playeridtoemail;
    mapping(uint=>uint8) playeridtoverifiedstatus;
    mapping(uint=>uint) playeridtounclaimedpeem;

    constructor(address _token){
        token = _token;
    }

    function addPlayer(string memory _email, string memory _username) public onlyOwner {
        
    }

    /**verifyPlayer transfers all unclaimed peem of a player from the unclaimed peem address to the player's verified address */
    function verifyPlayer(uint _playerId, address _playerAddress) public onlyOwner {

    }

    function isVerified(uint _playerId) public view returns(uint8){
        return playeridtoverifiedstatus[_playerId];
    }
}