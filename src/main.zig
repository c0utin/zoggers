const std = @import("std");
const writer = std.io.getStdOut().writer();

const http = @import("http.zig");
const rollup = @import("address.zig");

pub fn main() !void {

    // init http client context
    // TODO

    const alloc = std.heap.page_allocator;
    var arena = std.heap.ArenaAllocator.init(alloc);
    const allocator = arena.allocator();
    defer arena.deinit();

    const AddressBook = try rollup.AddressBook.init(allocator);
    try writer.print("EtherPortal: {any}\n", .{AddressBook.EtherPortal});

    // Send request example
    var client = std.http.Client{
        .allocator = allocator,
    };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "X-Custom-Header", .value = "application" },
    };

    const response = try http.get("https://www.example.com", headers, &client, allocator);
    try writer.print("Response:\n{s}\n", .{response});
}
