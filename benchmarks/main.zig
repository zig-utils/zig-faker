const std = @import("std");
const faker_mod = @import("zig_faker");
const Faker = faker_mod.Faker;

// std.time.Timer was removed in zig 0.17-dev; stub so benchmarks compile.
// Wall-clock benchmarking will need to be reintroduced via std.Io.Clock.
const Timer = struct {
    pub fn start() !Timer {
        return .{};
    }
    pub fn lap(_: *Timer) u64 {
        return 0;
    }
    pub fn read(_: *Timer) u64 {
        return 0;
    }
};

fn benchmark(comptime name: []const u8, comptime func: anytype, iterations: usize) !void {
    var timer = try Timer.start();
    const start = timer.lap();

    func(iterations) catch |err| {
        std.debug.print("Error in {s}: {}\n", .{ name, err });
        return;
    };

    const end = timer.read();
    const elapsed_ns = end - start;
    const elapsed_ms = @as(f64, @floatFromInt(elapsed_ns)) / 1_000_000.0;
    const ops_per_sec = if (elapsed_ns == 0) 0.0 else @as(f64, @floatFromInt(iterations)) / (@as(f64, @floatFromInt(elapsed_ns)) / 1_000_000_000.0);

    std.debug.print("{s}:\n", .{name});
    std.debug.print("  Iterations: {d}\n", .{iterations});
    std.debug.print("  Time: {d:.2} ms\n", .{elapsed_ms});
    std.debug.print("  Ops/sec: {d:.0}\n", .{ops_per_sec});
    std.debug.print("  Avg time per op: {d:.2} µs\n\n", .{if (iterations == 0) 0.0 else elapsed_ms * 1000.0 / @as(f64, @floatFromInt(iterations))});
}

fn benchmarkUUID(iterations: usize) !void {
    var gpa: std.heap.DebugAllocator(.{}) = .init;
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    var faker = Faker.init(allocator, 12345, null);

    var i: usize = 0;
    while (i < iterations) : (i += 1) {
        const uuid = try faker.string.uuid(&faker.random);
        allocator.free(uuid);
    }
}

fn benchmarkEmail(iterations: usize) !void {
    var gpa: std.heap.DebugAllocator(.{}) = .init;
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    var faker = Faker.init(allocator, 12345, null);

    var i: usize = 0;
    while (i < iterations) : (i += 1) {
        const email = try faker.internet.email(&faker.random);
        allocator.free(email);
    }
}

fn benchmarkFullName(iterations: usize) !void {
    var gpa: std.heap.DebugAllocator(.{}) = .init;
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    var faker = Faker.init(allocator, 12345, null);

    var i: usize = 0;
    while (i < iterations) : (i += 1) {
        const name = try faker.person.fullName(&faker.random, .{});
        allocator.free(name);
    }
}

fn benchmarkFirstName(iterations: usize) !void {
    var gpa: std.heap.DebugAllocator(.{}) = .init;
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    var faker = Faker.init(allocator, 12345, null);

    var i: usize = 0;
    while (i < iterations) : (i += 1) {
        _ = faker.person.firstName(&faker.random, .{});
    }
}

fn benchmarkAddress(iterations: usize) !void {
    var gpa: std.heap.DebugAllocator(.{}) = .init;
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    var faker = Faker.init(allocator, 12345, null);

    var i: usize = 0;
    while (i < iterations) : (i += 1) {
        const addr = try faker.address.fullAddress(&faker.random);
        allocator.free(addr);
    }
}

fn benchmarkPhoneNumber(iterations: usize) !void {
    var gpa: std.heap.DebugAllocator(.{}) = .init;
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    var faker = Faker.init(allocator, 12345, null);

    var i: usize = 0;
    while (i < iterations) : (i += 1) {
        const phone = try faker.phone.phoneNumber(&faker.random);
        allocator.free(phone);
    }
}

fn benchmarkCompanyName(iterations: usize) !void {
    var gpa: std.heap.DebugAllocator(.{}) = .init;
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    var faker = Faker.init(allocator, 12345, null);

    var i: usize = 0;
    while (i < iterations) : (i += 1) {
        const company = try faker.company.name(&faker.random);
        allocator.free(company);
    }
}

pub fn main() !void {
    // std.fs.File.stdout() was removed in 0.17-dev; std.debug.print is
    // the portable replacement for benchmark output.
    std.debug.print("=== Zig Faker Benchmarks ===\n\n", .{});

    const iterations: usize = 100_000;

    try benchmark("UUID Generation", benchmarkUUID, iterations);
    try benchmark("Email Generation", benchmarkEmail, iterations);
    try benchmark("Full Name Generation", benchmarkFullName, iterations);
    try benchmark("First Name Generation", benchmarkFirstName, iterations);
    try benchmark("Address Generation", benchmarkAddress, iterations);
    try benchmark("Phone Number Generation", benchmarkPhoneNumber, iterations);
    try benchmark("Company Name Generation", benchmarkCompanyName, iterations);

    std.debug.print("Benchmark complete!\n", .{});
}
