// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.0;

contract LongsToken {
    event Transfer(address indexed from, address indexed to, uint tokens);
    event Approval(
        address indexed tokenOwner,
        address indexed spender,
        uint tokens
    );

    string public constant name = "LONGS TOKEN";
    string public constant symbol = "LNG";
    uint8 public constant decimals = 18;
    uint256 totalSupply_;

    mapping(address => uint256) balances;

    mapping(address => mapping(address => uint256)) allowed;

    constructor(uint256 total) {
        totalSupply_ = total;
        balances[msg.sender] = totalSupply_;
    }

    function totalSupply() public view returns (uint256) {
        return totalSupply_;
    }

    function balanceOf(address account) public view returns (uint) {
        return balances[account];
    }

    function transfer(address to, uint amount) public returns (bool) {
        require(amount <= balances[msg.sender]);
        balances[msg.sender] -= amount;
        balances[to] += amount;
        emit Transfer(msg.sender, to, amount);
        return true;
    }

    function approve(address spender, uint amount) public returns (bool) {
        allowed[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }

    function allowance(address owner, address spender)
        public
        view
        returns (uint)
    {
        return allowed[owner][spender];
    }

    function transferFrom(
        address from,
        address to,
        uint amount
    ) public returns (bool) {
        require(amount <= balances[from]);
        require(amount <= allowed[from][msg.sender]);

        balances[from] -= amount;
        allowed[from][msg.sender] -= amount;
        balances[to] += amount;
        emit Transfer(from, to, amount);
        return true;
    }
}
