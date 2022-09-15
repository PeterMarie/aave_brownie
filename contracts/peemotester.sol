//SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
//import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract PeemoTester is ERC20, Ownable {

    constructor(uint _initialSupply) ERC20("PeemoTester", "PMT"){
        _mint(msg.sender, _initialSupply);
    }

    function decimals() public pure override returns (uint8) {
        return 0;
    }

}