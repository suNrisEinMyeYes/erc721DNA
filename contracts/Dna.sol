//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
contract Dna is ERC721, Ownable{


    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    string public baseTokenURI;


    mapping(uint256 => bytes32) itemToDna;
    constructor() ERC721("asd", "s") {
        
    }

    function awardItem(address _to) public onlyOwner returns(uint256){
      
        _tokenIds.increment();
        _mint(_to, _tokenIds.current());
        randomDna(_tokenIds.current());

        return _tokenIds.current();
    }

    function _baseURI() internal view virtual override returns (string memory) {
        return baseTokenURI;
    }

    function getBaseUri() public view returns(string memory){
        return baseTokenURI;
    }

    function setBaseTokenURI(string memory _baseTokenURI) public {
        baseTokenURI = _baseTokenURI;
    }

    function randomDna(uint256 _id) private {
        itemToDna[_id] = keccak256(abi.encodePacked(block.timestamp, block.difficulty, _id));
    }

    function mergeDna(uint256 _id1, uint256 _id2) public{
        require(ownerOf(_id1) == msg.sender, "not an owner");
        require(ownerOf(_id2) == msg.sender, "not an owner");
        _burn(_id1);
        _burn(_id2);
        itemToDna[_id1] = 0;
        itemToDna[_id2] = 0;
        _tokenIds.increment();
        _mint(msg.sender, _tokenIds.current());

        itemToDna[_tokenIds.current()] = keccak256(abi.encodePacked(_id1, _id2));
    }
    
}
