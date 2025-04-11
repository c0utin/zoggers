const std = @import("std");
const eth = @import("ethereum.zig");
const http = @import("http.zig");

// Rollup resul
const Result = union {
    accept: []const u8,
    reject: []const u8,
};

const Metadata = struct {
    inputIndex: i32,
    msgSender: eth.Address,
    blockNumber: i64,
    blockTimestamp: i64,
};

const AdvaceInput = struct {
    metadata: Metadata,
    payload: []const u8,
};

const InspectInput = struct {
    payload: []const u8,
};

const Request = struct {
    destination: ?eth.Address,
    payload: []const u8,

    pub fn send_voucher(req: *Request) !i32 {
        req = std.fmt.bytesToHex(req, .lower);
        //res = http.post(url: []const u8, headers: []const std.http.Header, body: []const u8, client: *std.http.Client, allocator: std.mem.Allocator)
    }
};

// TODO: fn send_notice
// TODO: fn send_report

// TODO: Define INSPECT & ADVANCE handler
