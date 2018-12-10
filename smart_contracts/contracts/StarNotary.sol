pragma solidity ^0.4.23;

import "./ERC721Token.sol";

// Requirement 1: StarNotary contract must extend ERC721Token 
contract StarNotary is ERC721Token { 

    // Requirement 2: Add metadata to the star token
    struct Star {
        string name;
        string starStory;
        string ra;
        string dec;
        string mag;
    }
    
    mapping(bytes32 => bool) public starsRegistry;
    mapping(uint256 => Star) public tokenIdToStarInfo;
    mapping(uint256 => uint256) public starsForSale;


    function createStar(string _name, string _story, string _Dec, string _Mag, string _Cent, uint256 _tokenId) public { 
        Star memory newStar = Star(_name, _story, _Cent, _Dec, _Mag);

        // Requirement 3: Uniqueness of the Star check
        require(!this.checkIfStarIsUnique(_Dec, _Mag, _Cent), "The star is not unique, won't be added to network!!");
        bytes32 starHash = keccak256(abi.encodePacked(_Dec, _Mag, _Cent));
        starsRegistry[starHash] = true;

        tokenIdToStarInfo[_tokenId] = newStar;

        ERC721Token.mint(_tokenId);
    }


    function checkIfStarIsUnique(string _Dec, string _Mag, string _Cent) public view  returns (bool) {
        bytes32 starHash = keccak256(abi.encodePacked(_Dec, _Mag, _Cent));
        return starsRegistry[starHash];
    }

    function putStarUpForSale(uint256 _tokenId, uint256 _price) public {

        // `require` owner in the token is equal to `msg.sender`
        require(this.ownerOf(_tokenId) == msg.sender, "Requirement Missing: Sender must be the owner of the token!!");
        starsForSale[_tokenId] = _price;
    }

    function buyStar(uint256 _tokenId) public payable { 
        require(starsForSale[_tokenId] > 0, "Star is not for Sale");

        uint256 starCost = starsForSale[_tokenId];
        address starOwner = this.ownerOf(_tokenId);

        require(msg.value >= starCost, "Your quoted amount is less than Star Cost");

        clearPreviousStarState(_tokenId);
        transferFromHelper(starOwner, msg.sender, _tokenId);

        if(msg.value > starCost) { 
            msg.sender.transfer(msg.value - starCost);
        }

        starOwner.transfer(starCost);
    }

    function clearPreviousStarState(uint256 _tokenId) private {
        //clear approvals 
        tokenToApproved[_tokenId] = address(0);

        //clear being on sale 
        starsForSale[_tokenId] = 0;
    }
}