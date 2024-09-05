// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Test, console} from "forge-std/Test.sol";
import {FundMe} from "../../src/FundMe.sol";
import {DeployFundMe} from "../../script/DeployFundMe.s.sol";
import {FundFundMe, WithdrawFundMe} from "../../script/Interactions.s.sol";

contract FundMeIntegrationTest is Test {
    FundMe fundMe;

    address USER = makeAddr("user");
    uint256 constant SEND_VALUE = 0.1 ether;
    uint256 constant INITIAL_BALANCE = 10 ether;
    uint256 constant GAS_PRICE = 1;

    function setUp() external {
        DeployFundMe deployFundMe = new DeployFundMe();
        fundMe = deployFundMe.run();
        vm.deal(USER, INITIAL_BALANCE);
    }

    function testUserCanFundAndOwnerWithdraw() public {
        // uint256 beforeUserBalance = address(USER).balance;
        // uint256 beforeOwnerBalance = address(fundMe.getOwner()).balance;

        FundFundMe fundFundMe = new FundFundMe();
        fundFundMe.fundFuneMe(address(fundMe));

        // uint256 amountFunded = fundMe.getAddressToAmountFunded(USER);
        // assertEq(amountFunded, SEND_VALUE);

        WithdrawFundMe withdrawFundMe = new WithdrawFundMe();
        withdrawFundMe.withdrawFuneMe(address(fundMe));
        assertEq(address(fundMe).balance, 0);
    }   

}