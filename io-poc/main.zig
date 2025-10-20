const std = @import("std");

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();
    const stdin = std.io.getStdIn().reader();

    try stdout.print("=== Zig Stats Program ===\n", .{});

    // --- 1. Ask for user name ---
    try stdout.print("Enter your name: ", .{});
    var name_buffer: [256]u8 = undefined;
    const name_line_opt = try stdin.readUntilDelimiterOrEof(&name_buffer, '\n');
    const name_line = name_line_opt orelse return;
    const name = name_line[0 .. name_line.len - 1]; // remove newline
    try stdout.print("Hello, {s}! Let's calculate some statistics.\n\n", .{name});

    // --- 2. Ask how many numbers to input ---
    try stdout.print("How many numbers will you enter? ", .{});
    var count_buffer: [16]u8 = undefined;
    const count_line_opt = try stdin.readUntilDelimiterOrEof(&count_buffer, '\n');
    const count_line = count_line_opt orelse return;
    const count_str = count_line[0 .. count_line.len - 1];
    const count = try std.fmt.parseInt(u8, count_str, 10);

    if (count > 256) {
        try stdout.print("Too many numbers, max is 256.\n", .{});
        return;
    }

    // --- 3. Read numbers into an array ---
    var numbers: [256]f64 = undefined;
    var i: usize = 0;
    while (i < @intCast(usize, count)) {
        try stdout.print("Enter number {d}: ", .{i + 1});
        var num_buffer: [32]u8 = undefined;
        const num_line_opt = try stdin.readUntilDelimiterOrEof(&num_buffer, '\n');
        const num_line = num_line_opt orelse return;
        const num_str = num_line[0 .. num_line.len - 1];

        const num = try std.fmt.parseFloat(f64, num_str);
        numbers[i] = num;

        i += 1; // increment manually
    }

    // --- 4. Compute statistics ---
    var sum: f64 = 0;
    var min: f64 = numbers[0];
    var max: f64 = numbers[0];

    i = 0;
    while (i < @intCast(usize, count)) {
        const n = numbers[i];
        sum += n;
        if (n < min) min = n;
        if (n > max) max = n;

        i += 1;
    }

    const avg = sum / f64(count);

    // --- 5. Print nicely formatted table ---
    try stdout.print("\n--- Numbers Entered ---\n", .{});
    try stdout.print("| Index | Value    |\n", .{});
    try stdout.print("|-------|----------|\n", .{});

    i = 0;
    while (i < @intCast(usize, count)) {
        try stdout.print("| {d}     | {f}\n", .{ i + 1, numbers[i] });
        i += 1;
    }

    try stdout.print("\nStatistics:\n", .{});
    try stdout.print("Sum: {f}\n", .{sum});
    try stdout.print("Average: {f}\n", .{avg});
    try stdout.print("Min: {f}\n", .{min});
    try stdout.print("Max: {f}\n", .{max});

    try stdout.print("\nThanks, {s}, for using Zig Stats Program!\n", .{name});
}
