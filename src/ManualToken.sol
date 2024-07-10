// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

contract ManualToken {
    mapping(address => uint) private s_balances;

    function name() public pure returns (string memory) {
        return "Manual Toker";
    }

    // string public name = "Manual Token";

    function decimals() public pure returns (uint8) {
        return 18;
    }

    function totalSupply() public pure returns (uint256) {
        return 100 ether;
    }

    function balanceof(address _owner) public view returns (uint256 balance) {
        return s_balances[_owner];
    }

    function transfer(address _to, uint256 _amount) public {
        uint256 previousBalance = balanceof(msg.sender) + balanceof(_to);
        s_balances[msg.sender] -= _amount;
        s_balances[_to] += _amount;
        require(balanceof(msg.sender) + balanceof(_to) == previousBalance);
    }
}
