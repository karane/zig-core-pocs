const std = @import("std");

// --- Example 1: Basic Optionals ---
fn basicOptionals() !void {
    const stdout = std.io.getStdOut().writer();

    var maybeNumber: ?i32 = 42;

    if (maybeNumber) |num| {
        try stdout.print("The number is {d}\n", .{num});
    } else {
        try stdout.print("No number provided.\n", .{});
    }

    maybeNumber = null;

    const value = maybeNumber orelse 0;
    try stdout.print("The number or default is {d}\n", .{value});

    const names: [3]?[]const u8 = [_]?[]const u8{ "Alice", null, "Charlie" };

    for (names, 0..) |name_opt, i| {
        const name = name_opt orelse "Unknown";
        try stdout.print("Name {d}: {s}\n", .{ i, name });
    }
}

// --- Example 2: Optional return from a function ---
fn findIndex(arr: []const i32, target: i32) ?usize {
    for (arr, 0..) |value, index| {
        if (value == target) return index;
    }
    return null;
}

fn optionalFunctionExample() !void {
    const stdout = std.io.getStdOut().writer();
    const numbers = &[_]i32{ 10, 20, 30, 40 };

    const index1 = findIndex(numbers, 30);
    if (index1) |i| {
        try stdout.print("Found 30 at index {d}\n", .{i});
    } else {
        try stdout.print("30 not found\n", .{});
    }

    // fallback to numbers.len if not found
    const index2: usize = findIndex(numbers, 50) orelse numbers.len;
    try stdout.print("Index of 50 (or default) = {d}\n", .{index2});
}

// --- Example 3: Optional + Error union ---
const Error = error{InvalidInput};

fn getValue(arr: []const i32, index: i32) !?i32 {
    if (index < 0) return Error.InvalidInput;

    const idx: usize = @intCast(index);
    if (idx >= arr.len) return null;

    return arr[idx];
}

fn errorOptionalExample() !void {
    const stdout = std.io.getStdOut().writer();
    const numbers = &[_]i32{ 10, 20, 30, 40 };

    // Example 1: valid index
    const val1 = try getValue(numbers, 2) orelse -1;
    try stdout.print("Value at index 2: {d}\n", .{val1});

    // Example 2: out-of-bounds index
    const val2 = try getValue(numbers, 10) orelse -1;
    try stdout.print("Value at index 10 (or default): {d}\n", .{val2});

    // Example 3: invalid index -> error
    const result = getValue(numbers, -5) catch |err| {
        if (err == Error.InvalidInput) {
            try stdout.print("Invalid index provided\n", .{});
        } else {
            try stdout.print("Other error occurred\n", .{});
        }
        return;
    };

    // result is now ?i32
    const val3 = result orelse -1;
    try stdout.print("Value at index -5 (or default): {d}\n", .{val3});

    const names: [3]?[]const u8 = [_]?[]const u8{ "Alice", null, "Charlie" };
    for (names, 0..) |name_opt, i| {
        const name = name_opt orelse "Unknown";
        try stdout.print("Name {d}: {s}\n", .{ i, name });
    }
}

// --- Main function ---
pub fn main() !void {
    try basicOptionals();
    try optionalFunctionExample();
    try errorOptionalExample();
}
