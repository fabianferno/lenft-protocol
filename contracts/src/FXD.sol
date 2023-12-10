// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import "openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";
// for Remix
// import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC721/ERC721.sol";

contract FXD is ERC20('Fathom Dollar', 'FXD') {
    
    address private _owner;

    constructor () {
        _owner = msg.sender;
        _mint(0x0cfecb5D359E6C59ABd1d2Aa794F52C15055f451, 999999); // F
        _mint(0x0cfecb5D359E6C59ABd1d2Aa794F52C15055f451, 999999); // S
    }

    function mint(address to) public {
        require(msg.sender==_owner);
        _mint(to, 1000);
    }
}