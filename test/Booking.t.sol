// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "forge-std/Test.sol";
import "../src/Booking.sol";

contract BookingTest is Test {
    Booking booking;

    function setUp() public {
        booking = new Booking();
    }

    function testListExperience() public {
        booking.listExperience("Snorkeling", 1 ether);
        (address host, string memory description, uint256 price, bool isAvailable) = booking.experiences(1);
        assertEq(description, "Snorkeling");
        assertEq(price, 1 ether);
        assertTrue(isAvailable);
    }

    function testBookExperience() public {
        booking.listExperience("Snorkeling", 1 ether);
        vm.prank(address(0x1));
        booking.bookExperience{value: 1 ether}(1);
        (address user, uint256 experienceId, uint256 amount, bool isComplete) = booking.bookings(1);
        assertEq(user, address(0x1));
        assertEq(amount, 1 ether);
        assertFalse(isComplete);
    }
}
