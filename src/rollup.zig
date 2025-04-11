const std = @import("std");
const eth = @import("ethereum.zig");

const Metadata = struct {
    inputIndex: i32,
    msgSender: eth.Address,
    blockNumber: i64,
    blockTimestamp: i64,
};
