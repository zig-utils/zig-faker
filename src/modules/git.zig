const std = @import("std");
const Random = @import("../random.zig").Random;

pub const Git = struct {
    random: *Random,
    allocator: std.mem.Allocator,

    pub fn init(allocator: std.mem.Allocator, random: *Random) Git {
        return Git{
            .random = random,
            .allocator = allocator,
        };
    }

    const commit_message_prefixes = [_][]const u8{
        "feat",    "fix",     "docs",    "style",   "refactor",
        "perf",    "test",    "chore",   "build",   "ci",
        "revert",  "merge",   "update",  "add",     "remove",
    };

    const commit_messages = [_][]const u8{
        "initial commit",
        "add new feature",
        "fix bug in authentication",
        "update dependencies",
        "improve performance",
        "refactor code structure",
        "add unit tests",
        "fix typo in documentation",
        "update README",
        "remove deprecated code",
        "merge branch into main",
        "add configuration file",
        "fix security vulnerability",
        "optimize database queries",
        "implement user feedback",
        "add error handling",
        "update API endpoints",
        "fix responsive design",
        "add logging functionality",
        "improve code readability",
    };

    const branch_names = [_][]const u8{
        "main",      "master",    "develop",   "feature",   "hotfix",
        "release",   "bugfix",    "staging",   "production", "test",
    };

    /// Generate a random branch name
    pub fn branch(self: *Git) []const u8 {
        return self.random.arrayElement([]const u8, &branch_names);
    }

    /// Generate a commit SHA (40 hex characters)
    pub fn commitSha(self: *Git) ![]u8 {
        return self.random.hex(self.allocator, 40);
    }

    /// Generate a short commit SHA (7 hex characters)
    pub fn commitShortSha(self: *Git) ![]u8 {
        return self.random.hex(self.allocator, 7);
    }

    /// Generate a commit message
    pub fn commitMessage(self: *Git) []const u8 {
        return self.random.arrayElement([]const u8, &commit_messages);
    }

    /// Generate a conventional commit message (type: description)
    pub fn conventionalCommit(self: *Git) ![]u8 {
        const prefix = self.random.arrayElement([]const u8, &commit_message_prefixes);
        const message = self.commitMessage();
        return std.fmt.allocPrint(self.allocator, "{s}: {s}", .{ prefix, message });
    }

    /// Generate a feature branch name
    pub fn featureBranch(self: *Git) ![]u8 {
        const features = [_][]const u8{
            "login",      "signup",     "dashboard",  "profile",    "settings",
            "payment",    "checkout",   "cart",       "search",     "filter",
            "notification", "messaging", "upload",     "download",   "export",
        };

        const feature = self.random.arrayElement([]const u8, &features);
        const number = self.random.int(1, 999);
        return std.fmt.allocPrint(self.allocator, "feature/{s}-{d}", .{ feature, number });
    }

    /// Generate a bugfix branch name
    pub fn bugfixBranch(self: *Git) ![]u8 {
        const bugs = [_][]const u8{
            "crash",      "memory-leak", "timeout",   "null-pointer", "overflow",
            "deadlock",   "race-condition", "syntax-error", "logic-error", "ui-glitch",
        };

        const bug = self.random.arrayElement([]const u8, &bugs);
        const number = self.random.int(1, 999);
        return std.fmt.allocPrint(self.allocator, "bugfix/{s}-{d}", .{ bug, number });
    }
};
