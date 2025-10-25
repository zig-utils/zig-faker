const std = @import("std");
const Random = @import("../random.zig").Random;

pub const Database = struct {
    random: *Random,
    allocator: std.mem.Allocator,

    pub fn init(allocator: std.mem.Allocator, random: *Random) Database {
        return Database{
            .random = random,
            .allocator = allocator,
        };
    }

    const column_names = [_][]const u8{
        "id",        "name",      "email",     "password",  "username",  "first_name",
        "last_name", "phone",     "address",   "city",      "state",     "zip",
        "country",   "created_at", "updated_at", "deleted_at", "status",  "type",
        "description", "title",   "content",   "author",    "user_id",   "post_id",
        "comment",   "rating",    "price",     "quantity",  "total",     "tax",
    };

    const table_names = [_][]const u8{
        "users",      "posts",      "comments",   "products",   "orders",     "customers",
        "invoices",   "payments",   "categories", "tags",       "articles",   "pages",
        "sessions",   "tokens",     "settings",   "logs",       "notifications", "messages",
        "files",      "images",     "videos",     "documents",  "transactions", "accounts",
    };

    const engines = [_][]const u8{
        "MySQL",      "PostgreSQL", "SQLite",     "MongoDB",    "Redis",
        "MariaDB",    "Oracle",     "SQL Server", "Cassandra",  "DynamoDB",
        "CouchDB",    "Neo4j",      "InfluxDB",   "Elasticsearch", "Firebase",
    };

    const sql_types = [_][]const u8{
        "INT",        "VARCHAR",    "TEXT",       "DATE",       "DATETIME",
        "TIMESTAMP",  "BOOLEAN",    "FLOAT",      "DOUBLE",     "DECIMAL",
        "CHAR",       "BINARY",     "BLOB",       "JSON",       "ENUM",
        "BIGINT",     "SMALLINT",   "TINYINT",    "MEDIUMINT",  "UUID",
    };

    const collations = [_][]const u8{
        "utf8_general_ci",    "utf8_unicode_ci",    "utf8mb4_general_ci",
        "utf8mb4_unicode_ci", "latin1_swedish_ci",  "ascii_general_ci",
        "binary",             "utf8_bin",           "utf8mb4_bin",
    };

    /// Generate a random column name
    pub fn column(self: *Database) []const u8 {
        return self.random.arrayElement([]const u8, &column_names);
    }

    /// Generate a random table name
    pub fn table(self: *Database) []const u8 {
        return self.random.arrayElement([]const u8, &table_names);
    }

    /// Generate a random database engine name
    pub fn engine(self: *Database) []const u8 {
        return self.random.arrayElement([]const u8, &engines);
    }

    /// Generate a random SQL data type
    pub fn type_(self: *Database) []const u8 {
        return self.random.arrayElement([]const u8, &sql_types);
    }

    /// Generate a random collation
    pub fn collation(self: *Database) []const u8 {
        return self.random.arrayElement([]const u8, &collations);
    }

    /// Generate a MongoDB ObjectId
    pub fn mongodbObjectId(self: *Database) ![]u8 {
        return self.random.hex(self.allocator, 24);
    }
};
