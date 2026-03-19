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
    _ = b.addModule("zig_faker", .{
        .root_source_file = b.path("src/faker.zig"),
    });

    // Example executable
    const example_module = b.createModule(.{
        .root_source_file = b.path("examples/basic.zig"),
        .target = target,
        .optimize = optimize,
    });
    example_module.addImport("zig_faker", root_module);

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
    benchmark_module.addImport("zig_faker", root_module);

    const benchmark = b.addExecutable(.{
        .name = "benchmark",
        .root_module = benchmark_module,
    });
    b.installArtifact(benchmark);

    const run_benchmark = b.addRunArtifact(benchmark);
    const benchmark_step = b.step("benchmark", "Run benchmarks");
    benchmark_step.dependOn(&run_benchmark.step);

    // Comprehensive demo
    const demo_module = b.createModule(.{
        .root_source_file = b.path("examples/comprehensive_demo.zig"),
        .target = target,
        .optimize = optimize,
    });
    demo_module.addImport("faker", root_module);

    const demo = b.addExecutable(.{
        .name = "comprehensive_demo",
        .root_module = demo_module,
    });
    b.installArtifact(demo);

    const run_demo = b.addRunArtifact(demo);
    const demo_step = b.step("demo", "Run comprehensive demo");
    demo_step.dependOn(&run_demo.step);

    // CLI executable - "faker"
    const cli_module = b.createModule(.{
        .root_source_file = b.path("src/cli.zig"),
        .target = target,
        .optimize = optimize,
    });
    cli_module.addImport("faker.zig", root_module);

    const cli = b.addExecutable(.{
        .name = "faker",
        .root_module = cli_module,
    });
    b.installArtifact(cli);

    const run_cli = b.addRunArtifact(cli);
    if (b.args) |args| {
        run_cli.addArgs(args);
    }
    const cli_step = b.step("cli", "Run the faker CLI");
    cli_step.dependOn(&run_cli.step);

    // Install step specifically for CLI
    const install_cli_step = b.step("install-cli", "Install the faker CLI binary");
    install_cli_step.dependOn(&b.addInstallArtifact(cli, .{}).step);
}
