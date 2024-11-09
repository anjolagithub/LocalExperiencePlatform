// script/deploy.s.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "forge-std/Script.sol";
import "../src/Booking.sol";
import "../src/Reward.sol";
import "../src/Review.sol";

contract Deploy is Script {
    function run() external {
        vm.startBroadcast();

        Booking booking = new Booking();
        RewardToken rewardToken = new RewardToken();
        Review review = new Review();

        vm.stopBroadcast();
    }
}
