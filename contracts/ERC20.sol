// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract CommunitiToken {
    string public name;
    string public symbol;
    uint8 public decimal;
    uint256 public totalSupply;

    //mapping for balance
    mapping(address => uint256) public balances;
    //mapping for allowence
    //{
    //     0x1:{
    //         0x2:10,
    //         0x3:30
    //     }
    // }
    mapping(address => mapping(address => uint256)) public allowed;

    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(
        address indexed _owner,
        address indexed _spender,
        uint256 _value
    );

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

    //0x1 =>5 --
    //0x2 => 10 ++

    function transfer(address _to, uint256 _value)
        public
        returns (bool success)
    {
        require(balances[msg.sender] >= _value, "token balance is low");
        balances[msg.sender] -= _value;
        balances[_to] += _value;
        emit Transfer(msg.sender, _to, _value);
        return true;
    }

    // trying to tranfer the amount from another account which we have seen in approve and allowence function
    function transferFrom(
        address _from,
        address _to,
        uint256 _value
    ) public returns (bool success) {
        uint256 _allowance = allowed[_from][msg.sender];
        require(_allowance >= _value, "Allowance to low");
        require(balances[_from] >= _value, "Balance to low");
        allowed[_from][msg.sender] -= _value;
        balances[_from] -= _value;
        balances[_to] += _value;
        emit Transfer(_from, _to, _value);
        return true;
    }

    //Approve function mean thta spend _value of token behalf of owner
    // 0x1 : 50 token [owner]
    // 0x2 : spender who can spend the token behalf of owner
    function approve(address _spender, uint256 _value)
        public
        returns (bool success)
    {
        allowed[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }

    function allowance(address _owner, address _spender)
        public
        view
        returns (uint256 remaining)
    {
        //returns remainig allowence it have
        return allowed[_owner][_spender];
    }
}
