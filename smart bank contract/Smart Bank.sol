//----------------------------------
// Smart Bank contract
//
// Symbol : VAR
// Name : VAR Token
// Total Supply : 10000000
// Decimals : 14
//-----------------------------------
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
interface IERC20 {
    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external  view returns (uint256);
    function transfer(address to, uint256 amount) external returns (bool);
    function allowance(address TokenOwner,  address spender) external view returns (uint256);
    function approve(address spender, uint256 amount) external returns (bool);
    function transferFrom(address from, address to, uint256 amount) external returns (bool);
    function swapTokenForEther(uint256 TokenAmount) external view returns (uint256);
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
}
contract ERC20 is IERC20{
    string public name;
    bytes32 public symbol;
    uint256 public decimals;
    uint256 private initialsupply;
    uint256 public totalSupply;
    address private owner;
    mapping (address =>uint)  balances;
    mapping (address =>mapping(address => uint)) allowed;
    constructor()  {
        name = "VAR Token";
        symbol ="VAR";
        decimals = 14;
        totalSupply = 100000000* 10** uint256(decimals);
        initialsupply = totalSupply;
        owner =msg.sender;
        balances[msg.sender] = totalSupply;
        emit Transfer(address(0), msg.sender, totalSupply);
    } 
    function totalsupply() public view returns (uint256){
        return totalSupply;
    }
    function balanceOf(address account) public view returns (uint256) {
        return balances[account];
    }
    function allowance(address TokenOwner, address spender) public view returns (uint256) {
        return allowed[TokenOwner][spender];
    }
    function transfer(address to, uint256 amount) public returns (bool) {
        require(to != address(0));
        balances[msg.sender]-= amount;
        balances[to]+= amount;
        emit Transfer(msg.sender, to, amount);
        return true;
    }
    function approve(address spender, uint256 amount) public returns (bool) {
        allowed[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }
    function transferFrom(address from, address to, uint256 amount) public returns (bool) {
        allowed[from][msg.sender]-= amount;
        balances[from] -= amount;
        balances[to] += amount;
        emit Transfer(from, to, amount);
        return true;
    }
    function mint(uint256 amount) public{
        balances[msg.sender] += amount;
        totalSupply += amount;
        emit Transfer(address(0), msg.sender, amount);
    }
    function burn(uint256 amount) public {
        balances[msg.sender] -= amount;
        totalSupply -= amount;
        emit Transfer(msg.sender, address(0), amount);
    }
    function swapTokenForEther(uint256 TokenAmount) public view returns (uint256) {
        require(balanceOf(msg.sender) >= TokenAmount, "Insufficient token balance");
        return TokenAmount;
    }
}
