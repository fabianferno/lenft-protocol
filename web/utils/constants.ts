const NFT_CONTRACT_ADDRESS: any = "0x82De0603E7bB4986B8d5cF81c4620093B1D8F571";
const FHD_CONTRACT_ADDRESS: any = "0xDf29cB40Cb92a1b8E8337F542E3846E185DefF96";
const LENDER_CONTRACT_ADDRESS: any =
  "0x028830eeb2d0D8f6AB9a0059cED637dd7e18580e";

const LENDER: any = {
  contract: LENDER_CONTRACT_ADDRESS,
  abi: [
    {
      type: "constructor",
      inputs: [{ name: "_token", type: "address", internalType: "address" }],
      stateMutability: "nonpayable",
    },
    {
      type: "function",
      name: "acceptOffer",
      inputs: [{ name: "_offerId", type: "uint256", internalType: "uint256" }],
      outputs: [],
      stateMutability: "nonpayable",
    },
    {
      type: "function",
      name: "cancelOffer",
      inputs: [{ name: "_offerId", type: "uint256", internalType: "uint256" }],
      outputs: [],
      stateMutability: "nonpayable",
    },
    {
      type: "function",
      name: "claimNFT",
      inputs: [{ name: "_offerId", type: "uint256", internalType: "uint256" }],
      outputs: [],
      stateMutability: "nonpayable",
    },
    {
      type: "function",
      name: "createOffer",
      inputs: [
        { name: "_nftContract", type: "address", internalType: "address" },
        { name: "_tokenId", type: "uint256", internalType: "uint256" },
        { name: "_interestRate", type: "uint256", internalType: "uint256" },
        { name: "_duration", type: "uint256", internalType: "uint256" },
        { name: "_amount", type: "uint256", internalType: "uint256" },
      ],
      outputs: [{ name: "", type: "uint256", internalType: "uint256" }],
      stateMutability: "nonpayable",
    },
    {
      type: "function",
      name: "getInterest",
      inputs: [
        { name: "_offerId", type: "uint256", internalType: "uint256" },
        { name: "startTime", type: "uint256", internalType: "uint256" },
        { name: "endTime", type: "uint256", internalType: "uint256" },
      ],
      outputs: [{ name: "", type: "uint256", internalType: "uint256" }],
      stateMutability: "view",
    },
    {
      type: "function",
      name: "getListedNfts",
      inputs: [],
      outputs: [
        {
          name: "",
          type: "tuple[]",
          internalType: "struct Lender.NFT[]",
          components: [
            { name: "nftContract", type: "address", internalType: "address" },
            { name: "tokenId", type: "uint256", internalType: "uint256" },
            { name: "listed", type: "bool", internalType: "bool" },
          ],
        },
      ],
      stateMutability: "view",
    },
    {
      type: "function",
      name: "getOffer",
      inputs: [{ name: "_offerId", type: "uint256", internalType: "uint256" }],
      outputs: [
        {
          name: "",
          type: "tuple",
          internalType: "struct Lender.Offer",
          components: [
            { name: "nftContract", type: "address", internalType: "address" },
            { name: "tokenId", type: "uint256", internalType: "uint256" },
            { name: "lender", type: "address", internalType: "address" },
            { name: "borrower", type: "address", internalType: "address" },
            { name: "interestRate", type: "uint256", internalType: "uint256" },
            { name: "duration", type: "uint256", internalType: "uint256" },
            { name: "amount", type: "uint256", internalType: "uint256" },
            { name: "startTime", type: "uint256", internalType: "uint256" },
            { name: "endTime", type: "uint256", internalType: "uint256" },
            { name: "active", type: "bool", internalType: "bool" },
          ],
        },
      ],
      stateMutability: "view",
    },
    {
      type: "function",
      name: "getOffersByNft",
      inputs: [
        { name: "_nftContract", type: "address", internalType: "address" },
        { name: "_tokenId", type: "uint256", internalType: "uint256" },
      ],
      outputs: [
        {
          name: "",
          type: "tuple[]",
          internalType: "struct Lender.Offer[]",
          components: [
            { name: "nftContract", type: "address", internalType: "address" },
            { name: "tokenId", type: "uint256", internalType: "uint256" },
            { name: "lender", type: "address", internalType: "address" },
            { name: "borrower", type: "address", internalType: "address" },
            { name: "interestRate", type: "uint256", internalType: "uint256" },
            { name: "duration", type: "uint256", internalType: "uint256" },
            { name: "amount", type: "uint256", internalType: "uint256" },
            { name: "startTime", type: "uint256", internalType: "uint256" },
            { name: "endTime", type: "uint256", internalType: "uint256" },
            { name: "active", type: "bool", internalType: "bool" },
          ],
        },
      ],
      stateMutability: "view",
    },
    {
      type: "function",
      name: "lastOfferId",
      inputs: [],
      outputs: [{ name: "", type: "uint256", internalType: "uint256" }],
      stateMutability: "view",
    },
    {
      type: "function",
      name: "listNft",
      inputs: [
        { name: "_nftContract", type: "address", internalType: "address" },
        { name: "_tokenId", type: "uint256", internalType: "uint256" },
      ],
      outputs: [],
      stateMutability: "nonpayable",
    },
    {
      type: "function",
      name: "listedNfts",
      inputs: [{ name: "", type: "uint256", internalType: "uint256" }],
      outputs: [
        { name: "nftContract", type: "address", internalType: "address" },
        { name: "tokenId", type: "uint256", internalType: "uint256" },
        { name: "listed", type: "bool", internalType: "bool" },
      ],
      stateMutability: "view",
    },
    {
      type: "function",
      name: "offers",
      inputs: [{ name: "", type: "uint256", internalType: "uint256" }],
      outputs: [
        { name: "nftContract", type: "address", internalType: "address" },
        { name: "tokenId", type: "uint256", internalType: "uint256" },
        { name: "lender", type: "address", internalType: "address" },
        { name: "borrower", type: "address", internalType: "address" },
        { name: "interestRate", type: "uint256", internalType: "uint256" },
        { name: "duration", type: "uint256", internalType: "uint256" },
        { name: "amount", type: "uint256", internalType: "uint256" },
        { name: "startTime", type: "uint256", internalType: "uint256" },
        { name: "endTime", type: "uint256", internalType: "uint256" },
        { name: "active", type: "bool", internalType: "bool" },
      ],
      stateMutability: "view",
    },
    {
      type: "function",
      name: "offersByNft",
      inputs: [
        { name: "", type: "address", internalType: "address" },
        { name: "", type: "uint256", internalType: "uint256" },
        { name: "", type: "uint256", internalType: "uint256" },
      ],
      outputs: [
        { name: "nftContract", type: "address", internalType: "address" },
        { name: "tokenId", type: "uint256", internalType: "uint256" },
        { name: "lender", type: "address", internalType: "address" },
        { name: "borrower", type: "address", internalType: "address" },
        { name: "interestRate", type: "uint256", internalType: "uint256" },
        { name: "duration", type: "uint256", internalType: "uint256" },
        { name: "amount", type: "uint256", internalType: "uint256" },
        { name: "startTime", type: "uint256", internalType: "uint256" },
        { name: "endTime", type: "uint256", internalType: "uint256" },
        { name: "active", type: "bool", internalType: "bool" },
      ],
      stateMutability: "view",
    },
    {
      type: "function",
      name: "repayLoan",
      inputs: [{ name: "_offerId", type: "uint256", internalType: "uint256" }],
      outputs: [],
      stateMutability: "nonpayable",
    },
    {
      type: "function",
      name: "token",
      inputs: [],
      outputs: [{ name: "", type: "address", internalType: "address" }],
      stateMutability: "view",
    },
  ],
};

const FHD: any = {
  contract: FHD_CONTRACT_ADDRESS,
  abi: [
    {
      type: "function",
      name: "allowance",
      inputs: [
        { name: "owner", type: "address", internalType: "address" },
        { name: "spender", type: "address", internalType: "address" },
      ],
      outputs: [{ name: "", type: "uint256", internalType: "uint256" }],
      stateMutability: "view",
    },
    {
      type: "function",
      name: "approve",
      inputs: [
        { name: "spender", type: "address", internalType: "address" },
        { name: "value", type: "uint256", internalType: "uint256" },
      ],
      outputs: [{ name: "", type: "bool", internalType: "bool" }],
      stateMutability: "nonpayable",
    },
    {
      type: "function",
      name: "balanceOf",
      inputs: [{ name: "account", type: "address", internalType: "address" }],
      outputs: [{ name: "", type: "uint256", internalType: "uint256" }],
      stateMutability: "view",
    },
    {
      type: "function",
      name: "totalSupply",
      inputs: [],
      outputs: [{ name: "", type: "uint256", internalType: "uint256" }],
      stateMutability: "view",
    },
    {
      type: "function",
      name: "transfer",
      inputs: [
        { name: "to", type: "address", internalType: "address" },
        { name: "value", type: "uint256", internalType: "uint256" },
      ],
      outputs: [{ name: "", type: "bool", internalType: "bool" }],
      stateMutability: "nonpayable",
    },
    {
      type: "function",
      name: "transferFrom",
      inputs: [
        { name: "from", type: "address", internalType: "address" },
        { name: "to", type: "address", internalType: "address" },
        { name: "value", type: "uint256", internalType: "uint256" },
      ],
      outputs: [{ name: "", type: "bool", internalType: "bool" }],
      stateMutability: "nonpayable",
    },
    {
      type: "event",
      name: "Approval",
      inputs: [
        {
          name: "owner",
          type: "address",
          indexed: true,
          internalType: "address",
        },
        {
          name: "spender",
          type: "address",
          indexed: true,
          internalType: "address",
        },
        {
          name: "value",
          type: "uint256",
          indexed: false,
          internalType: "uint256",
        },
      ],
      anonymous: false,
    },
    {
      type: "event",
      name: "Transfer",
      inputs: [
        {
          name: "from",
          type: "address",
          indexed: true,
          internalType: "address",
        },
        { name: "to", type: "address", indexed: true, internalType: "address" },
        {
          name: "value",
          type: "uint256",
          indexed: false,
          internalType: "uint256",
        },
      ],
      anonymous: false,
    },
  ],
};

const NFT: any = {
  contract: NFT_CONTRACT_ADDRESS,
  abi: [
    { type: "constructor", inputs: [], stateMutability: "nonpayable" },
    {
      type: "function",
      name: "approve",
      inputs: [
        { name: "to", type: "address", internalType: "address" },
        { name: "tokenId", type: "uint256", internalType: "uint256" },
      ],
      outputs: [],
      stateMutability: "nonpayable",
    },
    {
      type: "function",
      name: "balanceOf",
      inputs: [{ name: "owner", type: "address", internalType: "address" }],
      outputs: [{ name: "", type: "uint256", internalType: "uint256" }],
      stateMutability: "view",
    },
    {
      type: "function",
      name: "getApproved",
      inputs: [{ name: "tokenId", type: "uint256", internalType: "uint256" }],
      outputs: [{ name: "", type: "address", internalType: "address" }],
      stateMutability: "view",
    },
    {
      type: "function",
      name: "isApprovedForAll",
      inputs: [
        { name: "owner", type: "address", internalType: "address" },
        { name: "operator", type: "address", internalType: "address" },
      ],
      outputs: [{ name: "", type: "bool", internalType: "bool" }],
      stateMutability: "view",
    },
    {
      type: "function",
      name: "mint",
      inputs: [{ name: "to", type: "address", internalType: "address" }],
      outputs: [],
      stateMutability: "nonpayable",
    },
    {
      type: "function",
      name: "name",
      inputs: [],
      outputs: [{ name: "", type: "string", internalType: "string" }],
      stateMutability: "view",
    },
    {
      type: "function",
      name: "ownerOf",
      inputs: [{ name: "tokenId", type: "uint256", internalType: "uint256" }],
      outputs: [{ name: "", type: "address", internalType: "address" }],
      stateMutability: "view",
    },
    {
      type: "function",
      name: "safeTransferFrom",
      inputs: [
        { name: "from", type: "address", internalType: "address" },
        { name: "to", type: "address", internalType: "address" },
        { name: "tokenId", type: "uint256", internalType: "uint256" },
      ],
      outputs: [],
      stateMutability: "nonpayable",
    },
    {
      type: "function",
      name: "safeTransferFrom",
      inputs: [
        { name: "from", type: "address", internalType: "address" },
        { name: "to", type: "address", internalType: "address" },
        { name: "tokenId", type: "uint256", internalType: "uint256" },
        { name: "data", type: "bytes", internalType: "bytes" },
      ],
      outputs: [],
      stateMutability: "nonpayable",
    },
    {
      type: "function",
      name: "setApprovalForAll",
      inputs: [
        { name: "operator", type: "address", internalType: "address" },
        { name: "approved", type: "bool", internalType: "bool" },
      ],
      outputs: [],
      stateMutability: "nonpayable",
    },
    {
      type: "function",
      name: "supportsInterface",
      inputs: [{ name: "interfaceId", type: "bytes4", internalType: "bytes4" }],
      outputs: [{ name: "", type: "bool", internalType: "bool" }],
      stateMutability: "view",
    },
    {
      type: "function",
      name: "symbol",
      inputs: [],
      outputs: [{ name: "", type: "string", internalType: "string" }],
      stateMutability: "view",
    },
    {
      type: "function",
      name: "tokenURI",
      inputs: [{ name: "tokenId", type: "uint256", internalType: "uint256" }],
      outputs: [{ name: "", type: "string", internalType: "string" }],
      stateMutability: "view",
    },
    {
      type: "function",
      name: "transferFrom",
      inputs: [
        { name: "from", type: "address", internalType: "address" },
        { name: "to", type: "address", internalType: "address" },
        { name: "tokenId", type: "uint256", internalType: "uint256" },
      ],
      outputs: [],
      stateMutability: "nonpayable",
    },
    {
      type: "event",
      name: "Approval",
      inputs: [
        {
          name: "owner",
          type: "address",
          indexed: true,
          internalType: "address",
        },
        {
          name: "approved",
          type: "address",
          indexed: true,
          internalType: "address",
        },
        {
          name: "tokenId",
          type: "uint256",
          indexed: true,
          internalType: "uint256",
        },
      ],
      anonymous: false,
    },
    {
      type: "event",
      name: "ApprovalForAll",
      inputs: [
        {
          name: "owner",
          type: "address",
          indexed: true,
          internalType: "address",
        },
        {
          name: "operator",
          type: "address",
          indexed: true,
          internalType: "address",
        },
        {
          name: "approved",
          type: "bool",
          indexed: false,
          internalType: "bool",
        },
      ],
      anonymous: false,
    },
    {
      type: "event",
      name: "Transfer",
      inputs: [
        {
          name: "from",
          type: "address",
          indexed: true,
          internalType: "address",
        },
        { name: "to", type: "address", indexed: true, internalType: "address" },
        {
          name: "tokenId",
          type: "uint256",
          indexed: true,
          internalType: "uint256",
        },
      ],
      anonymous: false,
    },
    {
      type: "error",
      name: "ERC721IncorrectOwner",
      inputs: [
        { name: "sender", type: "address", internalType: "address" },
        { name: "tokenId", type: "uint256", internalType: "uint256" },
        { name: "owner", type: "address", internalType: "address" },
      ],
    },
    {
      type: "error",
      name: "ERC721InsufficientApproval",
      inputs: [
        { name: "operator", type: "address", internalType: "address" },
        { name: "tokenId", type: "uint256", internalType: "uint256" },
      ],
    },
    {
      type: "error",
      name: "ERC721InvalidApprover",
      inputs: [{ name: "approver", type: "address", internalType: "address" }],
    },
    {
      type: "error",
      name: "ERC721InvalidOperator",
      inputs: [{ name: "operator", type: "address", internalType: "address" }],
    },
    {
      type: "error",
      name: "ERC721InvalidOwner",
      inputs: [{ name: "owner", type: "address", internalType: "address" }],
    },
    {
      type: "error",
      name: "ERC721InvalidReceiver",
      inputs: [{ name: "receiver", type: "address", internalType: "address" }],
    },
    {
      type: "error",
      name: "ERC721InvalidSender",
      inputs: [{ name: "sender", type: "address", internalType: "address" }],
    },
    {
      type: "error",
      name: "ERC721NonexistentToken",
      inputs: [{ name: "tokenId", type: "uint256", internalType: "uint256" }],
    },
  ],
};

export { LENDER, FHD, NFT };
