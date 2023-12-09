// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import {Lender} from "../src/Lender.sol";
import {TestERC20} from "../src/test/TestERC20.sol";
import {Famcnft} from "../src/Famcnft.sol";
import {IERC721Receiver} from "../src/test/IERC721Receiver.sol";


contract LenderTest is Test, IERC721Receiver {
    Lender public lender;
    TestERC20 public fhdToken;
    Famcnft public famcnft; // FastApeMotoClub, our ERC721
    event InterestCalculation(uint256 offerId, uint256 startTime, uint256 endTime, uint256 interest);

    function setUp() public {
        fhdToken = new TestERC20(100000);
        lender = new Lender(address(fhdToken));
        fhdToken.approve(address(lender), 100000); // Manually in Metamask if not running via forge!
        famcnft = new Famcnft();
        famcnft.setApprovalForAll(address(lender), true);       // Manually in Metamask if not running via forge!
    }

    function test_listNft() public {
        Lender.NFT[] memory listedNfts = lender.getListedNfts();
        assertEq(listedNfts.length, 0);
        lender.listNft(address(famcnft), 0);
        listedNfts = lender.getListedNfts();
        assertEq(listedNfts.length, 1);
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
        assertEq(offer.length, 2);
    }

    function test_getInterest() public {
        lender.createOffer(
            address(famcnft), 
            0, 
            3000,     // In BPS. 30% interest
            86400,    // duration in seconds
            10000     // amount of FHD in
        );
        // We need to accept it for it to become a loan
        lender.acceptOffer(1);
        uint256 startTime = 0;
        uint256 endTime = startTime + 44000; // 1 day in seconds (86400)
        uint256 interest = lender.getInterest(1, startTime, endTime);
        // This console logsLender.Offer memory off = lender.getOffer(1); // console logs the structure
        emit InterestCalculation(1, startTime, endTime, interest);
    }

    function test_tokenURI() public {
        string memory uri = famcnft.tokenURI(0);
        // console2.log("URI: %s", uri);
    }

    function onERC721Received(
        address operator,
        address from,
        uint256 tokenId,
        bytes calldata data
    ) external pure returns (bytes4) {
        operator = operator;
        from = from;
        tokenId = tokenId;
        data = data;
        return 0x150b7a02;
    }
}
