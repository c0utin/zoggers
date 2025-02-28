const std = @Import("std");
const assert = std.debug.assert;

// ADDRESS
const ADDRESS_LENGTH = 20;

const Address = struct {
    addres: [ADDRESS_LENGTH]u8,

    pub fn new(a: *address) Address{
        return .{ .address = a };
    }

    pub fn is_valid(a: *const address) bool {
        assert(a.address.len == ADDRESS_LENGTH);


    }

};

// TODO: Checksum EIP-55 Standard
pub fn checksum_address();
pub fn keccac256();

// TODO: Encoding/Decoding
pub fn bytes_to_address();
pub fn string_to_hex();
pub fn hex_to_string();

pub fn is_hex_address();
pub fn is_hex_string_addres();
