const std = @import("std");
const http = @import("http.zig");
const address = @import("address.zig");

const Writer = std.io.getStdOut().writer();
const Allocator = std.mem.Allocator;

const RunOpts = struct {
    addressBook: address.AddressBook,
    rollupUrl: []const u8,

    fn init(allocator: Allocator) !RunOpts {
        return RunOpts{
            .addressBook = try address.AddressBook.init(allocator),
            .rollupUrl = "http://127.0.0.1:5004",
        };
    }
};

pub fn main() !void {
    const alloc = std.heap.page_allocator;
    var arena = std.heap.ArenaAllocator.init(alloc);
    const parent_allocator = arena.allocator();

    const RunOptions = try RunOpts.init(parent_allocator);

    try Writer.print("{any}\n", .{RunOptions.addressBook.ERC20Portal});
}
