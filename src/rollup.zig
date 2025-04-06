const std = @import("std");
const zabi = @import("zabi");
const utils = zabi.utils.utils;

// types

// TODO: use zabi Addres type
pub const Address = [20]u8;
const Allocator = std.mem.Allocator;

// valid hex by EIP-55 ETH
pub fn hex_to_address(hex: []const u8) !Address {
    if (!utils.isAddress(hex)) {
        return error.InvalidAddress;
    }
    const addresBytes = try utils.addressToBytes(hex);
    return addresBytes;
}

pub const AddressBook = struct {
    CartesiAppFactory: Address,
    AppAddressRelay: Address,
    ERC1155BatchPortal: Address,
    ERC1155SinglePortal: Address,
    ERC20Portal: Address,
    ERC721Portal: Address,
    EtherPortal: Address,
    InputBox: Address,

    pub fn init() !AddressBook {
        return AddressBook{
            .CartesiAppFactory = try hex_to_address("0x7122cd1221C20892234186facfE8615e6743Ab02"),
            .AppAddressRelay = try hex_to_address("0xF5DE34d6BbC0446E2a45719E718efEbaaE179daE"),
            .ERC1155BatchPortal = try hex_to_address("0xedB53860A6B52bbb7561Ad596416ee9965B055Aa"),
            .ERC1155SinglePortal = try hex_to_address("0x7CFB0193Ca87eB6e48056885E026552c3A941FC4"),
            .ERC20Portal = try hex_to_address("0x9C21AEb2093C32DDbC53eEF24B873BDCd1aDa1DB"),
            .ERC721Portal = try hex_to_address("0x237F8DD094C0e47f4236f12b4Fa01d6Dae89fb87"),
            .EtherPortal = try hex_to_address("0xFfdbe43d4c855BF7e0f105c400A50857f53AB044"),
            .InputBox = try hex_to_address("0x59b22D57D4f067708AB0c00552767405926dc768"),
        };
    }
};
