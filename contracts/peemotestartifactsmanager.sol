// SPDX-License-Identifier:MIT
pragma solidity >=0.6.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract PeemoTestArtifactManager is ERC1155, Ownable {

    address token;

    constructor(address _token) ERC1155("https://game.example/api/item/{id}.json") {
        token = _token;
    }

    function createArtifact(
        string memory _artifactName,
        uint _initialSupply,
        string memory _attributes
    ) public onlyOwner returns(uint8){

    }

    function _acquireArtifact(uint _artifactId, uint _amount) public {

    }

    function _getArtifactBalance(uint _artifactId) public{
        
    }
}