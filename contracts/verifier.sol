// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

contract Verifier {
    // Returns the address that signed a given string message
    function verifyString(string memory message, uint8 v, bytes32 r, bytes32 s) public pure returns (address signer) {
        // The message header; we will fill in the length next
        string memory header = "\x19Ethereum Signed Message:\n000000";

        // Calculate the length of the message
        uint256 length = bytes(message).length;

        // Maximum length we support
        require(length <= 999999, "Message length exceeds maximum supported length");

        // Convert message length to string and update header
        uint256 offset = 57;
        while (length != 0) {
            header[offset] = bytes1(uint8(48 + length % 10));
            length /= 10;
            offset--;
        }

           Perform the elliptic curve recover operation
        bytes32 check = keccak256(abi.encodePacked(header, message));
        return ecrecover(check, v, r, s);
    }
}
