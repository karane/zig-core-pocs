const std = @import("std");

pub const Shape = union(enum) {
    Circle: f64,
    Rectangle: struct { width: f64, height: f64 },
    Triangle: struct { base: f64, height: f64 },
};

pub fn main() void {
    // Example 1: Matching numbers
    const num: i32 = 2;
    switch (num) {
        1 => std.debug.print("Number is one\n", .{}),
        2 => std.debug.print("Number is two\n", .{}),
        else => std.debug.print("Number is something else\n", .{}),
    }

    // Example 2: Matching strings
    const s = "hello";
    if (std.mem.eql(u8, s, "hi")) {
        std.debug.print("Got hi\n", .{});
    } else if (std.mem.eql(u8, s, "hello")) {
        std.debug.print("Got hello\n", .{});
    } else {
        std.debug.print("Unknown string\n", .{});
    }

    // Example 3: Matching on type info
    const val = 42;
    const info = @typeInfo(@TypeOf(val));
    switch (info) {
        .int => std.debug.print("val is an integer: {}\n", .{val}),
        .float => std.debug.print("val is a float: {}\n", .{val}),
        else => std.debug.print("val is some other type\n", .{}),
    }

    // Example 4: Tagged union with pattern matching
    const shapes = [_]Shape{
        Shape{ .Circle = 5.0 },
        Shape{ .Rectangle = .{ .width = 3.0, .height = 4.0 } },
        Shape{ .Triangle = .{ .base = 6.0, .height = 2.5 } },
    };

    for (shapes) |shape| {
        switch (shape) {
            .Circle => |radius| std.debug.print("Circle with radius = {}\n", .{radius}),
            .Rectangle => |rect| std.debug.print("Rectangle width = {}, height = {}\n", .{ rect.width, rect.height }),
            .Triangle => |tri| std.debug.print("Triangle base = {}, height = {}\n", .{ tri.base, tri.height }),
        }
    }
}
