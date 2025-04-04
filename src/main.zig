const std = @import("std");
const writer = std.io.getStdOut().writer();

const http = @import("http.zig");

pub fn main() !void {
    const alloc = std.heap.page_allocator;
    var arena = std.heap.ArenaAllocator.init(alloc);
    const allocator = arena.allocator();

    defer arena.deinit();

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
