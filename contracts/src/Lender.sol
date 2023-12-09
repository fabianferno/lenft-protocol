// This smart contract allows lenders to lend money to borrowers against their NFTs.
//
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import "openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";
import "openzeppelin-contracts/contracts/token/ERC721/IERC721.sol";

contract Lender {

    struct Offer {
        address nftContract;
        uint256 tokenId;
        address lender;
        address borrower;
        uint256 interestRate; // Should be in basis points. 1% = 100
        uint256 duration;     // In seconds
        uint256 amount;       // In FHD
        uint256 startTime;    // Unix timestamp in seconds
        uint256 endTime;      // Unix timestamp in seconds
        bool active;
    }

    // The token the loans have to be in Fathom Dollar (FHD)
    // https://charts.fathom.fi/#/token/0x49d3f7543335cf38fa10889ccff10207e22110b5
    // mainnet: 0x49d3f7543335cf38fa10889ccff10207e22110b5
    // testnet: 0xDf29cB40Cb92a1b8E8337F542E3846E185DefF96
    address public token = 0xDf29cB40Cb92a1b8E8337F542E3846E185DefF96;

    uint256 public lastOfferId;

    mapping(uint256 => Offer) public offers;
    mapping(address => mapping (uint256 => Offer[])) public offersByNft;

    constructor(address _token) {
        token = _token;
    }

    function createOffer(
        address _nftContract,
        uint256 _tokenId,
        uint256 _interestRate,
        uint256 _duration,
        uint256 _amount
    ) public returns (uint256) {
        require(_interestRate > 0, "Interest rate must be greater than 0");
        require(_duration > 0, "Duration must be greater than 0");
        require(_amount > 0, "Amount must be greater than 0");
        // Add: require that the NFT is listed

        require(_amount <= IERC20(token).balanceOf(msg.sender), "Insufficient balance");
        IERC20(token).transferFrom(msg.sender, address(this), _amount);

        lastOfferId = lastOfferId + 1;
        uint256 offerId = lastOfferId;

        offers[offerId] = Offer({
            nftContract: _nftContract,
            tokenId: _tokenId,
            lender: msg.sender,
            borrower: address(0),
            interestRate: _interestRate,
            duration: _duration,
            amount: _amount,
            startTime: 0,
            endTime: 0,
            active: true
        });
        offersByNft[_nftContract][_tokenId].push(offers[offerId]);
        return offerId;
    }

    function listNft(address _nftContract, uint256 _tokenId) public {
        require(IERC721(_nftContract).ownerOf(_tokenId) == msg.sender, "You do not own this NFT");
        IERC721(_nftContract).approve(address(this), _tokenId);
        IERC721(_nftContract).transferFrom(msg.sender, address(this), _tokenId);
    }

    function acceptOffer(uint256 _offerId) public {
        require(offers[_offerId].active == true, "Offer does not exist");
        require(offers[_offerId].borrower == address(0), "Offer already accepted");
        address _nftContract = offers[_offerId].nftContract;
        uint256 _tokenId = offers[_offerId].tokenId;

        require(IERC721(_nftContract).ownerOf(_tokenId) == msg.sender, "You do not own this NFT");

        offers[_offerId].borrower = msg.sender;
        offers[_offerId].startTime = block.timestamp;
        offers[_offerId].endTime = block.timestamp + offers[_offerId].duration;

        IERC721(_nftContract).transferFrom(msg.sender, address(this), _tokenId);
        IERC20(token).transfer(msg.sender, offers[_offerId].amount);
    }

    function repayLoan(uint256 _offerId) public {
        require(offers[_offerId].active == true, "Offer does not exist");
        require(offers[_offerId].borrower == msg.sender, "You did not accept this offer");
        require(offers[_offerId].endTime > block.timestamp, "Loan has expired");

        // Calculate interest based on how much time has passed
        // Block timestamps are in seconds.
        // Interest is per loan, not per annum. Early repayment means a lineraly proportional
        // reduction in total interest to be paid.
        uint256 plannedDuration = offers[_offerId].duration;
        uint256 principal = offers[_offerId].amount;
        uint256 interestRate = offers[_offerId].interestRate;
        uint256 interestPerSecond = principal * interestRate / plannedDuration;
        uint256 actualDuration = endTime - startTime;
        uint256 interest = actualDuration * interestPerSecond / uint256(10000);

        require(IERC20(token).balanceOf(msg.sender) >= offers[_offerId].amount + interest, "Insufficient balance");
        IERC20(token).transferFrom(msg.sender, offers[_offerId].lender, offers[_offerId].amount + interest);

        address nft = offers[_offerId].nftContract;
        uint256 tokenId = offers[_offerId].tokenId;
        IERC721(nft).transferFrom(address(this), msg.sender, tokenId);

        offers[_offerId].active = false;
    }

    function claimNFT(uint256 _offerId) public {
        require(offers[_offerId].active == true, "Offer does not exist");
        require(offers[_offerId].lender == msg.sender, "You did not create this offer");
        require(offers[_offerId].endTime < block.timestamp, "Loan has not expired");

        address nft = offers[_offerId].nftContract;
        uint256 tokenId = offers[_offerId].tokenId;
        IERC721(nft).transferFrom(address(this), msg.sender, tokenId);

        offers[_offerId].active = false;
    }

    function cancelOffer(uint256 _offerId) public {
        require(offers[_offerId].active == true, "Offer does not exist");
        require(offers[_offerId].lender == msg.sender, "You did not create this offer");

        IERC20(token).transferFrom(address(this), msg.sender, offers[_offerId].amount);

        offers[_offerId].active = false;
    }

    function getOffer(uint256 _offerId) public view returns (Offer memory) {
        return offers[_offerId];
    }

    function getOffersByNft(address _nftContract, uint256 _tokenId) public view returns (Offer[] memory) {
        return offersByNft[_nftContract][_tokenId];
    }

    function getInterest(uint256 _offerId, uint256 startTime, uint256 endTime) public view returns (uint256) {
        uint256 plannedDuration = offers[_offerId].duration;
        uint256 principal = offers[_offerId].amount;
        uint256 interestRate = offers[_offerId].interestRate;
        uint256 interestPerSecond = principal * interestRate / plannedDuration;
        uint256 actualDuration = endTime - startTime;
        uint256 interest = actualDuration * interestPerSecond;
        return interest / uint256(10000);
    }
}
