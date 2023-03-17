//SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract PeemoTestPlayerManager is Ownable {
    address token;
    address stake_manager;
    address unclaimed_peem_holder;
    uint player_count;

    //User mappings
    struct Players {
        uint player_id;
        string hashed_password;
        string username;
        string email;
        uint8 verifiedstatus;
        uint unclaimedpeem;
    }
    mapping(uint=>Players) playeridtodetails;
    mapping(string=>uint) playeremailtoid;

    mapping(uint=>address) playeridtoaddress;
    mapping(uint=>string) playeridtousername;
    mapping(uint=>string) playeridtoemail;
    mapping(uint=>uint8) playeridtoverifiedstatus;
    mapping(uint=>uint) playeridtounclaimedpeem;
    enum VERIFIED_STATUS {
        NONE,
        EMAIL_VERIFIED,
        ADDRESS_VERIFIED
    }

    constructor(address _token, address _unclaimed_peem_holder){
        token = _token;
        unclaimed_peem_holder = _unclaimed_peem_holder;
    }

    function addPlayer(string memory _email, string memory _username) public onlyOwner {
        VERIFIED_STATUS verified_status;
        verified_status = VERIFIED_STATUS.NONE;
        uint new_player_id = player_count;
        Players memory new_player = Players(new_player_id, 'password', _username, _email, uint8(verified_status), 0);
        playeridtodetails[new_player_id] = new_player;
        player_count = player_count + 1;
    }

    /**verifyPlayer transfers all unclaimed peem of a player from the unclaimed peem address to the player's verified address */
    function verifyPlayerAddress(uint _playerId, address _playerAddress) public onlyOwner {

    }

    function verifyPlayer(uint _playerId) public {

    }

    function isVerified(uint _playerId) public view returns(uint8){
        return playeridtodetails[_playerId].verifiedstatus;
    }

    function getPlayerId(string calldata _email) public view returns(uint){
        return playeremailtoid[_email];
    }

    function getPlayerUsername(uint _playerId) public view returns(string memory){
        return playeridtodetails[_playerId].username;
    }
}

contract Tester{
    
    uint userCount;
    string[] _techstack;
    CatDetails[] _cats;

    struct People {
        string name;
        uint height_in_cm;
        bytes gender;
        string[] tech_stack;
        CatDetails[] my_cats;
    }
    struct CatDetails {
        string name;
        uint age;
        string color;
    }

    mapping (uint=>People) user_id_to_details;

    function setUser() public {
        uint userId = userCount++;
        string[] storage my_techstack = _techstack;
        my_techstack.push("Python");
        my_techstack.push("JavaScript");
        my_techstack.push("Solidity");
        CatDetails[] storage cats = _cats;
        CatDetails memory firstcat = CatDetails("Snuffles", 3, 'yellow');
        cats.push(firstcat);
        People memory yours_truly = People("Peter M. Ogwara", 155, "m", my_techstack, cats);
        user_id_to_details[userId] = yours_truly;
    }

    function getCat() public view returns(string memory){
        return user_id_to_details[1].my_cats[1].name;
    }
}