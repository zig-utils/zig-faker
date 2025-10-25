const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    // Create the root module for the library
    const root_module = b.createModule(.{
        .root_source_file = b.path("src/faker.zig"),
        .target = target,
        .optimize = optimize,
    });

    // Module for external use
    _ = b.addModule("zig-faker", .{
        .root_source_file = b.path("src/faker.zig"),
    });

    // Example executable
    const example_module = b.createModule(.{
        .root_source_file = b.path("examples/basic.zig"),
        .target = target,
        .optimize = optimize,
    });
    example_module.addImport("zig-faker", root_module);

    const example = b.addExecutable(.{
        .name = "example",
        .root_module = example_module,
    });
    b.installArtifact(example);

    const run_example = b.addRunArtifact(example);
    const example_step = b.step("example", "Run the example");
    example_step.dependOn(&run_example.step);

    // Tests
    const test_module = b.createModule(.{
        .root_source_file = b.path("src/faker.zig"),
        .target = target,
        .optimize = optimize,
    });

    const tests = b.addTest(.{
        .root_module = test_module,
    });

    const run_tests = b.addRunArtifact(tests);
    const test_step = b.step("test", "Run unit tests");
    test_step.dependOn(&run_tests.step);

    // Benchmark
    const benchmark_module = b.createModule(.{
        .root_source_file = b.path("benchmarks/main.zig"),
        .target = target,
        .optimize = .ReleaseFast,
    });
    benchmark_module.addImport("zig-faker", root_module);

    const benchmark = b.addExecutable(.{
        .name = "benchmark",
        .root_module = benchmark_module,
    });
    b.installArtifact(benchmark);

    const run_benchmark = b.addRunArtifact(benchmark);
    const benchmark_step = b.step("benchmark", "Run benchmarks");
    benchmark_step.dependOn(&run_benchmark.step);
}
