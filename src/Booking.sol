// contracts/Booking.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract Booking {
    struct Experience {
        address payable host;
        string description;
        uint256 price;
        bool isAvailable;
    }

    struct BookingDetail {
        address payable user;
        uint256 experienceId;
        uint256 amount;
        bool isComplete;
    }

    mapping(uint256 => Experience) public experiences;
    mapping(uint256 => BookingDetail) public bookings;
    uint256 public experienceCounter;
    uint256 public bookingCounter;

    event ExperienceListed(uint256 experienceId, address host, uint256 price);
    event BookingConfirmed(uint256 bookingId, address user, uint256 experienceId);
    event PaymentReleased(uint256 bookingId, address host, uint256 amount);

    function listExperience(string memory description, uint256 price) external {
        experienceCounter++;
        experiences[experienceCounter] = Experience(payable(msg.sender), description, price, true);
        emit ExperienceListed(experienceCounter, msg.sender, price);
    }

    function bookExperience(uint256 experienceId) external payable {
        Experience storage experience = experiences[experienceId];
        require(experience.isAvailable, "Experience is not available");
        require(msg.value == experience.price, "Incorrect payment amount");

        bookingCounter++;
        bookings[bookingCounter] = BookingDetail(payable(msg.sender), experienceId, msg.value, false);
        emit BookingConfirmed(bookingCounter, msg.sender, experienceId);
    }

    function completeBooking(uint256 bookingId) external {
        BookingDetail storage booking = bookings[bookingId];
        Experience storage experience = experiences[booking.experienceId];
        
        require(msg.sender == booking.user, "Only the user can complete booking");
        require(!booking.isComplete, "Booking already complete");

        booking.isComplete = true;
        experience.host.transfer(booking.amount);
        emit PaymentReleased(bookingId, experience.host, booking.amount);
    }
}
