const std = @import("std");

fn add(a: i32, b: i32) i32 {
    return a + b;
}

fn divide(a: i32, b: i32) !i32 {
    if (b == 0) return error.DivisionByZero;

    // For signed ints, must choose the kind of division:
    // @divTrunc → truncates toward zero (typical C-style division)
    // @divFloor → rounds toward negative infinity
    // @divExact → requires exact divisibility
    return @divTrunc(a, b);
}

const Point = struct {
    x: i32,
    y: i32,

    pub fn move(self: *Point, dx: i32, dy: i32) void {
        self.x += dx;
        self.y += dy;
    }
};

test "basic arithmetic" {
    const result = add(2, 3);
    try std.testing.expect(result == 5);
}

test "expectEqual example" {
    const a = add(10, 5);
    try std.testing.expectEqual(@as(i32, 15), a);
}

test "division works" {
    const res = try divide(10, 2);
    try std.testing.expectEqual(@as(i32, 5), res);
}

test "division by zero returns error" {
    const result = divide(10, 0);
    try std.testing.expectError(error.DivisionByZero, result);
}

test "struct and mutation" {
    var p = Point{ .x = 1, .y = 2 };
    p.move(3, 4);
    try std.testing.expectEqual(@as(i32, 4), p.x);
    try std.testing.expectEqual(@as(i32, 6), p.y);
}
