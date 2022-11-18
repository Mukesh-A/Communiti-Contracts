// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract NFTCollection {

    mapping(address => uint256) internal _balances
    mapping(uint256 => address  ) internal _owners;
    mapping(address =>mapping(address=>bool)  ) private _operatorApprovals;
    mapping(uint256 =>address) private _tokenApprovals;

    function balanceOf(address _owner) public view returns (uint256) {
        // https://stackoverflow.com/questions/48219716/what-is-address0-in-solidity
        require(_owner != address(0),"Address is invalid")
        return _balances[_owner]
    }
    // if we have a collection then their might be multiple nft each one will have diffrent id
    //so here we r fetching the token id and returing the address of the owner
        function ownerOf(uint256 _tokenId) public view returns (address){
            address owner = _owners[_tokenId];
            require(owner != address(0), "token iD is not valid");
            require owner;
        }

        //its is like having a joint account
        // example
        // if their is a collection id {
        //     1,2,3,,4,5,6,
        // }
        // if 1,2,3 belong to 0x1
        // to this i am adding another account 0x2 i.e 0x1 => 0x2 now both account has the accecible to {1,2,3} id's
        function setApprovalForAll(address _operator, bool _approved) external{
            _operatorApprovals[msg.sender][_operator] = _approved;
            emit ApprovalForAll(msg.sender,_operator,_approved);
        }
        function isApprovedForAll(address _owner, address _operator) public view returns (bool){
            return _operatorApprovals[owner][_operator];
        }
        //like in setApprove all if u dont want to approve all the nft then just approve sign NFT so approve funtion is used
        function approve(address _approved, uint256 _tokenId) external payable{
            address owner = ownerOf(_tokenId);
            require(msg.sender == owner || isApprovedForAll, msg.sender, "MSG.SENDER is not owner or operator");
            _tokenApprovals[_tokenId] = _approved;
            emit Approval(owner,_approved,_tokenId);
        }

        funtion getApproved(uint256 _tokenId) external view returns (address);
        {
            require(_owner[_tokenId] != address(0), "Token id is invalid")
        }
}
