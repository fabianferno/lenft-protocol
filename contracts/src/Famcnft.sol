// This smart contract allows lenders to lend money to borrowers against their NFTs.
//
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import "openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";
// for Remix
// import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC721/ERC721.sol";

contract Famcnft is ERC721('FastApeMotoClub', 'FAMC') {
    
    uint256 private _tokenId;
    string private _name;
    string private _symbol;
    address private _owner;

    constructor () {
        _owner = msg.sender;
        _safeMint(msg.sender, _tokenId++);
    }

    function mint(address to) public {
        require(msg.sender==_owner);
        _safeMint(to, _tokenId++);
    }
}