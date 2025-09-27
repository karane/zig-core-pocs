const std = @import("std");

// Function example
fn add(a: i32, b: i32) i32 {
    return a + b;
}

pub fn main() void {
    // Constants
    const pi: f64 = 3.14159;
    std.debug.print("Constant pi = {}\n", .{pi});

    // Variables that never change → use const
    const x: i32 = 10;
    const y: i32 = 20;
    std.debug.print("x = {}, y = {}\n", .{x, y});

    const sum = x + y;
    std.debug.print("x + y = {}\n", .{sum});
    std.debug.print("Add function: add(x, y) = {}\n", .{add(x, y)});

    const arr: [5]i32 = .{1, 2, 3, 4, 5};
    std.debug.print("Array elements: {s}", .{" "}); // placeholder for string separator
    for (arr) |val| {
        std.debug.print("{} ", .{val});
    }
    std.debug.print("\n", .{});

    // Loops
    std.debug.print("Loop from 0 to 4:\n", .{});
    for (0..5) |i| {
        std.debug.print("i = {}\n", .{i});
    }

    // Conditional
    if (x < y) {
        std.debug.print("x is less than y\n", .{});
    } else {
        std.debug.print("x is greater than or equal to y\n", .{});
    }

    // Boolean
    const flag: bool = true;
    if (flag) {
        std.debug.print("Flag is true\n", .{});
    }

    // Strings
    const name: []const u8 = "Zig";
    std.debug.print("Hello, {s}!\n", .{name});
}
