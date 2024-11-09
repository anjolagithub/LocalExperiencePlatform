// contracts/Review.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract Review {
    struct UserReview {
        address user;
        uint256 experienceId;
        string reviewText;
    }

    mapping(uint256 => UserReview[]) public reviews;

    event ReviewAdded(address user, uint256 experienceId, string reviewText);

    function addReview(uint256 experienceId, string memory reviewText) external {
        reviews[experienceId].push(UserReview(msg.sender, experienceId, reviewText));
        emit ReviewAdded(msg.sender, experienceId, reviewText);
    }
}
