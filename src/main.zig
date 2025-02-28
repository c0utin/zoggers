const std = @import("std");
const writer = std.io.getStdOut().writer();

const types = @import("types.zig");

// TODO: Create wallet type like go-ethereum-common
const AddressBook = struct {
    CartesiAppFactory: [20]u8,
    AppAddressRelay: [20]u8,
    ERC1155BatchPortal: [20]u8,
    ERC1155SinglePortal: [20]u8,
    ERC20Portal: [20]u8,
    ERC721Portal: [20]u8,
    EtherPortal: [20]u8,
    InputBox: [20]u8,
};

const RunOpts = struct { AddressBook: AddressBook, RollupUrl: []u8 };

fn get_low_level(
    url: []const u8,
    headers: []const std.http.Header,
    client: *std.http.Client,
    allocator: std.mem.Allocator,
) ![]u8 {
    var buf: [4096]u8 = undefined;
    var readBuff: [4096]u8 = undefined;
    const uri = try std.Uri.parse(url);
    var req = try client.open(.GET, uri, .{
        .server_header_buffer = &buf,
        .extra_headers = headers,
    });
    defer req.deinit();
    try req.send();
    try req.finish();

    const start = std.time.milliTimestamp();
    try req.wait();
    const stop = std.time.milliTimestamp();

    const size = try req.read(&readBuff);

    try writer.print("\n{s} {d} status={d}\n{s}\n", .{ url, stop - start, req.response.status, readBuff[0..size] });
    const out = try allocator.alloc(u8, size);
    std.mem.copyForwards(u8, out, readBuff[0..size]);
    return out;
}

// TODO: Initi client for listening Cartesi-machine
pub fn main() !void {
    const alloc = std.heap.page_allocator;
    var arena = std.heap.ArenaAllocator.init(alloc);
    const allocator = arena.allocator();

    defer arena.deinit();

    var client = std.http.Client{
        .allocator = allocator,
    };

    const headers = &[_]std.http.Header{
        .{ .name = "X-Custom-Header", .value = "application" },
    };

    const response = try get_low_level("https://www.example.com", headers, &client, allocator);
    try writer.print("Response:\n{s}\n", .{response});

    allocator.free(response);

}
