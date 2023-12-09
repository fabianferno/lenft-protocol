// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import {Lender} from "../src/Lender.sol";
import {TestERC20} from "../src/test/TestERC20.sol";
import {Famcnft} from "../src/Famcnft.sol";
import {IERC721Receiver} from "../src/test/IERC721Receiver.sol";
// Need to mock the ERC20 for the tests


contract LenderTest is Test, IERC721Receiver {
    Lender public lender;
    TestERC20 public fhdToken;
    Famcnft public famcnft;

    function setUp() public {
        fhdToken = new TestERC20(987678);
        lender = new Lender(address(fhdToken));
        fhdToken.approve(address(lender), 8888);
        famcnft = new Famcnft();
    }

    function test_createOffer() public {
        // address _nftContract,
        // uint256 _tokenId,
        // uint256 _interestRate,
        // uint256 _duration,
        // uint256 _amount
        assertEq(lender.lastOfferId(), 0);
        lender.createOffer(
            address(famcnft),
            0, 
            1, 
            1, 
            1
        );
        assertEq(lender.lastOfferId(), 1);
        // assertEq(lender.offers[0].nftContract, Famcnft);
    }

    function test_acceptOffer(uint256 offerId) public {
        lender.createOffer(
            address(famcnft),
            0,
            1, 
            1, 
            1
        );
        assertEq(lender.lastOfferId(), 1);
        lender.acceptOffer(1);
        // assertEq(lender.offers[offerId].active, false);
    }

    function onERC721Received(
        address operator,
        address from,
        uint256 tokenId,
        bytes calldata data
    ) external returns (bytes4) {
        return 0x150b7a02; // IERC721Receiver.onERC721Received.selector
    }
}
