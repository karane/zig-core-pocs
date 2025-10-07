const std = @import("std");

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();

    // Immutable string (string literal)
    const hello: []const u8 = "Hello, Zig!";
    try stdout.print("Immutable: {s}\n", .{hello});

    // Mutable string
    // Allocate a buffer (stack-allocated here with fixed size)
    var buffer: [20]u8 = undefined;

    // Copy string literal into the buffer
    const msg = "Mutable";
    @memcpy(buffer[0..msg.len], msg);

    // Create a mutable slice pointing to the copied data
    var mutable_str: []u8 = buffer[0..msg.len];
    try stdout.print("Mutable before: {s}\n", .{mutable_str});

    // Modify in-place
    mutable_str[0] = 'X'; // change 'M' → 'X'
    mutable_str[mutable_str.len - 1] = '!'; // change 'e' → '!'

    try stdout.print("Mutable after:  {s}\n", .{mutable_str});

    // Append to a mutable buffer
    const index: usize = mutable_str.len;
    const extra = " String";
    @memcpy(buffer[index .. index + extra.len], extra);

    // Extend slice
    mutable_str = buffer[0 .. index + extra.len];
    try stdout.print("After append:  {s}\n", .{mutable_str});
}
