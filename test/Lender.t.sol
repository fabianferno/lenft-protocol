// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import {Lender} from "../src/Lender.sol";
import {TestERC20} from "../src/test/TestERC20.sol";
// Need to mock the ERC20 for the tests


contract LenderTest is Test {
    Lender public lender;
    address public Famcnft;
    TestERC20 public fhdToken;

    function setUp() public {
        fhdToken = new TestERC20(987678);
        lender = new Lender(address(fhdToken));
        fhdToken.approve(address(lender), 8888);
        Famcnft = 0xf8036c4B6da44c33102E724cC8eF5E70d3125D2f;
    }

    function test_createOffer() public {
        // address _nftContract,
        // uint256 _tokenId,
        // uint256 _interestRate,
        // uint256 _duration,
        // uint256 _amount
        assertEq(lender.lastOfferId(), 0);
        lender.createOffer(
            Famcnft,
            0, 
            1, 
            1, 
            1
        );
        assertEq(lender.lastOfferId(), 1);
        assertEq(lender.offers[0].nftContract, Famcnft);
    }

    // function test_acceptOffer(uint256 offerId) public {
    //     lender.acceptOffer(offerId);
    //     assertEq(lender.offers[offerId].active, false);
    // }
}
