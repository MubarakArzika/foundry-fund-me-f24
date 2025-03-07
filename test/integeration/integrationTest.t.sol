// // SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Test, console} from "forge-std/Test.sol";
import {DeployFundMe} from "../../script/DeployFundMe.s.sol";
import {FundMe} from "../../src/FundMe.sol";
import {FundFundMe, WithdrawFundMe} from "../../script/Interactions.s.sol";

contract InteractionTest is Test {
  FundMe fundMe;
  
  address USER = makeAddr("usr");
  uint256 constant SEND_VALUE = 0.1 ether;
  uint256 constant STARTING_BALANCE = 10 ether;
  uint256 constant GAS_PRICE = 1;


  function setUp() external {
    DeployFundMe deploy = new DeployFundMe();
    fundMe = deploy.run();
     vm.deal(USER, STARTING_BALANCE);
  }


  function testUserCanFundInteractions() public {
    vm.prank(USER);
    vm.deal(USER, 1e18);
    FundFundMe fundFundMe = new FundFundMe();
    fundFundMe.fundFundMe(address(fundMe));

    WithdrawFundMe withdrawFundMe = new WithdrawFundMe();
    withdrawFundMe.withdrawFundMe(address(fundMe));
    assert(address(fundMe).balance == 0);
  }
} 
