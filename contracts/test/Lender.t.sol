// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import {Lender} from "../src/Lender.sol";
import {TestERC20} from "../src/test/TestERC20.sol";
import {Famcnft} from "../src/Famcnft.sol";
import {IERC721Receiver} from "../src/test/IERC721Receiver.sol";
// error ERC20InvalidSender(address sender);


contract LenderTest is Test, IERC721Receiver {
    Lender public lender;
    TestERC20 public fhdToken;
    Famcnft public famcnft; // FastApeMotoClub, our ERC721

    function setUp() public {
        fhdToken = new TestERC20(987678);
        lender = new Lender(address(fhdToken));
        fhdToken.approve(address(lender), 8888);
        famcnft = new Famcnft();
        famcnft.approve(address(lender), 0);
    }

    function test_createOffer() public {
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

    function test_acceptOffer() public {
        lender.createOffer(
            address(famcnft), 0, 1, 1, 1
        );
        assertEq(lender.lastOfferId(), 1);
        lender.acceptOffer(1);
        // assertEq(lender.offers[offerId].active, false);
    }

    function test_repayLoan() public {
        lender.createOffer(
            address(famcnft), 0, 1, 1, 1
        );
        lender.acceptOffer(1);
        lender.repayLoan(1);
    }

    function test_claimNft() public {
        lender.createOffer(
            address(famcnft), 0, 1, 1, 1
        );
        lender.acceptOffer(1);
        // Immediately... should fail
        vm.expectRevert("Loan has not expired");
        lender.claimNFT(1);
        // Advance block time
    }

    function test_getOffersByNft() public {
        lender.createOffer(
            address(famcnft), 0, 3, 2, 1
        );
        lender.createOffer(
            address(famcnft), 0, 6, 5, 4
        );
        Lender.Offer[] memory offer = lender.getOffersByNft(address(famcnft), 0);
    }

    function onERC721Received(
        address operator,
        address from,
        uint256 tokenId,
        bytes calldata data
    ) external returns (bytes4) {
        operator = operator;
        from = from;
        tokenId = tokenId;
        data = data;
        return 0x150b7a02;
    }
}
