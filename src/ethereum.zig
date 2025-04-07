const std = @import("std");

const Allocator = std.mem.Allocator;
const Keccak256 = std.crypto.hash.sha3.Keccak256;

// ethereum types
pub const Address = [20]u8;

/// Valid if given a string is a valid hex to eth-eip55
pub fn checksum_eip55(
    allocator: Allocator,
    address: []const u8,
) (Allocator.Error || error{ Overflow, InvalidCharacter })![]u8 {
    var buf: [40]u8 = undefined;
    const lower = std.ascii.lowerString(&buf, if (std.mem.startsWith(u8, address, "0x")) address[2..] else address);

    var hashed: [Keccak256.digest_length]u8 = undefined;
    Keccak256.hash(lower, &hashed, .{});
    const hex = std.fmt.bytesToHex(hashed, .lower);

    const checksum = try allocator.alloc(u8, 42);
    for (checksum[2..], 0..) |*c, i| {
        const char = lower[i];

        if (try std.fmt.charToDigit(hex[i], 16) > 7) {
            c.* = std.ascii.toUpper(char);
        } else {
            c.* = char;
        }
    }

    @memcpy(checksum[0..2], "0x");

    return checksum;
}

/// Checks if the given address is a valid ethereum address.
pub fn is_address(addr: []const u8) bool {
    if (!std.mem.startsWith(u8, addr, "0x"))
        return false;

    const address = addr[2..];

    if (address.len != 40)
        return false;

    var buf: [40]u8 = undefined;
    const lower = std.ascii.lowerString(&buf, address);

    var hashed: [Keccak256.digest_length]u8 = undefined;
    Keccak256.hash(lower, &hashed, .{});
    const hex = std.fmt.bytesToHex(hashed, .lower);

    var checksum: [42]u8 = undefined;
    for (checksum[2..], 0..) |*c, i| {
        const char = lower[i];

        const char_digit = std.fmt.charToDigit(hex[i], 16) catch return false;
        if (char_digit > 7) {
            c.* = std.ascii.toUpper(char);
        } else {
            c.* = char;
        }
    }

    @memcpy(checksum[0..2], "0x");

    return std.mem.eql(u8, addr, checksum[0..]);
}

/// Convert address to its representing bytes
pub fn address_to_bytes(
    address: []const u8,
) error{ InvalidAddress, NoSpaceLeft, InvalidLength, InvalidCharacter }!Address {
    const addr = if (std.mem.startsWith(u8, address, "0x")) address[2..] else address;

    if (addr.len != 40)
        return error.InvalidAddress;

    var addr_bytes: Address = undefined;
    _ = try std.fmt.hexToBytes(&addr_bytes, addr);

    return addr_bytes;
}
