// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract CommunitiToken {
    string public name;
    string public symbol;
    uint8 public decimal;
    uint256 public totalSupply;

    mapping(address => uint256) public balances;
event Transfer(address indexed _from, address indexed _to, uint256 _value);
    //Commuinit , CMT, 18(that is standard, eth is 18 digit decimal 1Eth = 1*10**18) , we can even manipulate.
    //In USDC if we see they have 6 Decimal.

    //if u sending smone 100 token then that have to be multiply with 18,
    //if we r using USDC then with 6
    constructor(
        string memory _name,
        string memory _symbol,
        uint8 _decimal,
        uint256 _initalSupply //max supply
    ) {
        name = _name;
        symbol = _symbol;
        decimal = _decimal;
        totalSupply = _initalSupply;
        balances[msg.sender] = _initalSupply; // total supply is going to be hold by one address that is me
    }

    function balanceOf(address _owner) public view returns (uint256 balance) {
        return balances[_owner];
    }

    function transfer(address _to, uint256 _value)
        public
        returns (bool success)
    {
        require(balances[msg.sender] >= _value, "token balance is low");
        balances[msg.sender] -= _value;
        balances[_to] += _value;
        emit transfer(msg.sender, _to, _value);
        return true;
    }
}
