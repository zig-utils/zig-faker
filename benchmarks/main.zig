const std = @import("std");
const faker_mod = @import("zig-faker");
const Faker = faker_mod.Faker;

fn benchmark(comptime name: []const u8, comptime func: anytype, iterations: usize) !void {
    const stdout = std.io.getStdOut().writer();

    var timer = try std.time.Timer.start();
    const start = timer.lap();

    func(iterations) catch |err| {
        try stdout.print("Error in {s}: {}\n", .{ name, err });
        return;
    };

    const end = timer.read();
    const elapsed_ns = end - start;
    const elapsed_ms = @as(f64, @floatFromInt(elapsed_ns)) / 1_000_000.0;
    const ops_per_sec = @as(f64, @floatFromInt(iterations)) / (@as(f64, @floatFromInt(elapsed_ns)) / 1_000_000_000.0);

    try stdout.print("{s}:\n", .{name});
    try stdout.print("  Iterations: {d}\n", .{iterations});
    try stdout.print("  Time: {d:.2} ms\n", .{elapsed_ms});
    try stdout.print("  Ops/sec: {d:.0}\n", .{ops_per_sec});
    try stdout.print("  Avg time per op: {d:.2} µs\n\n", .{elapsed_ms * 1000.0 / @as(f64, @floatFromInt(iterations))});
}

fn benchmarkUUID(iterations: usize) !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    var faker = Faker.init(allocator, 12345, null);

    var i: usize = 0;
    while (i < iterations) : (i += 1) {
        const uuid = try faker.string.uuid();
        allocator.free(uuid);
    }
}

fn benchmarkEmail(iterations: usize) !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    var faker = Faker.init(allocator, 12345, null);

    var i: usize = 0;
    while (i < iterations) : (i += 1) {
        const email = try faker.internet.email();
        allocator.free(email);
    }
}

fn benchmarkFullName(iterations: usize) !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    var faker = Faker.init(allocator, 12345, null);

    var i: usize = 0;
    while (i < iterations) : (i += 1) {
        const name = try faker.person.fullName(.{});
        allocator.free(name);
    }
}

fn benchmarkFirstName(iterations: usize) !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    var faker = Faker.init(allocator, 12345, null);

    var i: usize = 0;
    while (i < iterations) : (i += 1) {
        _ = faker.person.firstName(.{});
    }
}

fn benchmarkAddress(iterations: usize) !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    var faker = Faker.init(allocator, 12345, null);

    var i: usize = 0;
    while (i < iterations) : (i += 1) {
        const addr = try faker.address.fullAddress();
        allocator.free(addr);
    }
}

fn benchmarkPhoneNumber(iterations: usize) !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    var faker = Faker.init(allocator, 12345, null);

    var i: usize = 0;
    while (i < iterations) : (i += 1) {
        const phone = try faker.phone.phoneNumber();
        allocator.free(phone);
    }
}

fn benchmarkCompanyName(iterations: usize) !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    var faker = Faker.init(allocator, 12345, null);

    var i: usize = 0;
    while (i < iterations) : (i += 1) {
        const company = try faker.company.name();
        allocator.free(company);
    }
}

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();

    try stdout.print("=== Zig Faker Benchmarks ===\n\n", .{});

    const iterations: usize = 100_000;

    try benchmark("UUID Generation", benchmarkUUID, iterations);
    try benchmark("Email Generation", benchmarkEmail, iterations);
    try benchmark("Full Name Generation", benchmarkFullName, iterations);
    try benchmark("First Name Generation", benchmarkFirstName, iterations);
    try benchmark("Address Generation", benchmarkAddress, iterations);
    try benchmark("Phone Number Generation", benchmarkPhoneNumber, iterations);
    try benchmark("Company Name Generation", benchmarkCompanyName, iterations);

    try stdout.print("Benchmark complete!\n", .{});
}
