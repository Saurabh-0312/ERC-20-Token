// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;
import {Test} from "forge-std/Test.sol";
import {DeployOurToken} from "../script/Deploy.s.sol";
import {OurToken} from "../src/OurToken.sol";

contract OurTokenTest is Test {
    OurToken public ourToken;

    DeployOurToken public deployer;

    address Saurabh = makeAddr("Saurabh");
    address Singh = makeAddr("Singh");

    uint256 public constant Starting_Balance = 1000;

    function setUp() public {
        deployer = new DeployOurToken();
        ourToken = deployer.run();

        vm.prank(msg.sender);
        ourToken.transfer(Saurabh, Starting_Balance);
    }

    function testSaurabhBalance() public {
        assertEq(Starting_Balance, ourToken.balanceOf(Saurabh));
    }

    function testAllowance() public {
        uint256 initialAllownace = 1000;

        vm.prank(Saurabh);
        ourToken.approve(Singh, initialAllownace);

        uint256 transferAmount = 500;

        vm.prank(Singh);
        ourToken.transferFrom(Saurabh, Singh, transferAmount);

        assertEq(ourToken.balanceOf(Singh), transferAmount);
        assertEq(
            ourToken.balanceOf(Saurabh),
            Starting_Balance - transferAmount
        );
    }
}
