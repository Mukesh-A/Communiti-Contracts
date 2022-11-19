// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./ERC721.sol";
//in wwe.json i have used pinata to store data in IPFS pinata gives free 1gb storage 
//use of pinata is . when u upload smthing direcctly in ipfs if that file is not accessed in while time they get deleted , so what pinata does is it try to pin this data in ipfs so that it stay for more time 

contract WWE is ERC721 {
    string public name;

    string public symbol;

    uint256 public tokenCount;
    mapping(uint256 => string) private _tokenURIs;

    constructor(string memory _name, string memory _symbol) {
        name = _name;
        symbol = _symbol;
    }

    //retuns token URI
    // that is basically https url :consist of all the info regarding metadata
    function tokenURI(uint256 _tokenId) public view returns (string memory) {
        //see erc721 coontract of _owner which is retuning the address
        require(_owners[_tokenId] != address(0), "Token doesnot exist");
        return  _tokenURIs[_tokenId];
    }

    //create a new NFT inside our collection
    function mint(string memory _tokenURI) public{
        tokenCount +=1;
        _balances[msg.sender] +=1;
        _owners[tokenCount] = msg.sender;
        _tokenURIs[tokenCount] = _tokenURI;

        emit Transfer(address(0), msg.sender, tokenCount);
    }

//we have added override because we r trying to overrise the funtion which is inherited
    function supportsInterface(bytes4 interfaceId) public pure override returns(bool){
        //saying that our contract is supported by this two interfaces
        // y two id becuase one is for meta data id and another is for ERC721 id
        return interfaceId == 0x5b5e139f  || interfaceId == 0x80ac58cd;
    }
}
