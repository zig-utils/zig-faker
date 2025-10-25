const std = @import("std");
const Random = @import("../random.zig").Random;

pub const Commerce = struct {
    random: *Random,
    allocator: std.mem.Allocator,

    pub fn init(allocator: std.mem.Allocator, random: *Random) Commerce {
        return Commerce{
            .random = random,
            .allocator = allocator,
        };
    }

    const products = [_][]const u8{
        "Chair",      "Table",      "Lamp",       "Sofa",       "Bed",        "Desk",
        "Monitor",    "Keyboard",   "Mouse",      "Phone",      "Tablet",     "Laptop",
        "Camera",     "Speaker",    "Headphones", "Watch",      "Shoes",      "Shirt",
        "Pants",      "Jacket",     "Hat",        "Bag",        "Wallet",     "Sunglasses",
        "Book",       "Notebook",   "Pen",        "Pencil",     "Backpack",   "Bottle",
        "Cup",        "Plate",      "Bowl",       "Fork",       "Knife",      "Spoon",
        "Towel",      "Pillow",     "Blanket",    "Rug",        "Curtain",    "Mirror",
        "Clock",      "Frame",      "Vase",       "Plant",      "Candle",     "Soap",
    };

    const adjectives = [_][]const u8{
        "Small",      "Ergonomic",  "Rustic",     "Intelligent", "Gorgeous",   "Incredible",
        "Fantastic",  "Practical",  "Sleek",      "Awesome",    "Enormous",   "Mediocre",
        "Synergistic", "Heavy Duty", "Lightweight", "Aerodynamic", "Handcrafted", "Recycled",
        "Refined",    "Tasty",      "Unbranded",  "Generic",    "Licensed",   "Luxurious",
        "Premium",    "Standard",   "Professional", "Industrial", "Commercial", "Residential",
    };

    const materials = [_][]const u8{
        "Steel",      "Wooden",     "Concrete",   "Plastic",    "Cotton",     "Granite",
        "Rubber",     "Metal",      "Soft",       "Fresh",      "Frozen",     "Leather",
        "Silk",       "Glass",      "Ceramic",    "Bronze",     "Copper",     "Aluminum",
        "Iron",       "Gold",       "Silver",     "Titanium",   "Carbon",     "Bamboo",
    };

    const departments = [_][]const u8{
        "Books",         "Movies",        "Music",         "Games",         "Electronics",
        "Computers",     "Home",          "Garden",        "Tools",         "Grocery",
        "Health",        "Beauty",        "Toys",          "Kids",          "Baby",
        "Clothing",      "Shoes",         "Jewelry",       "Sports",        "Outdoors",
        "Automotive",    "Industrial",    "Office",        "Pet Supplies",  "Handmade",
    };

    const colors = [_][]const u8{
        "Red",     "Blue",    "Green",   "Yellow",  "Orange",  "Purple",  "Pink",
        "Brown",   "Black",   "White",   "Gray",    "Silver",  "Gold",    "Beige",
        "Navy",    "Teal",    "Maroon",  "Olive",   "Lime",    "Cyan",    "Magenta",
    };

    /// Generate a random product name
    pub fn product(self: *Commerce) []const u8 {
        return self.random.arrayElement([]const u8, &products);
    }

    /// Generate a product adjective
    pub fn productAdjective(self: *Commerce) []const u8 {
        return self.random.arrayElement([]const u8, &adjectives);
    }

    /// Generate a product material
    pub fn productMaterial(self: *Commerce) []const u8 {
        return self.random.arrayElement([]const u8, &materials);
    }

    /// Generate a department name
    pub fn department(self: *Commerce) []const u8 {
        return self.random.arrayElement([]const u8, &departments);
    }

    /// Generate a product color
    pub fn color(self: *Commerce) []const u8 {
        return self.random.arrayElement([]const u8, &colors);
    }

    /// Generate a full product name (adjective + material + product)
    pub fn productName(self: *Commerce) ![]u8 {
        const adj = self.productAdjective();
        const mat = self.productMaterial();
        const prod = self.product();
        return std.fmt.allocPrint(self.allocator, "{s} {s} {s}", .{ adj, mat, prod });
    }

    /// Generate a product price
    pub fn price(self: *Commerce, min: f64, max: f64) f64 {
        const value = self.random.float(min, max);
        return @round(value * 100.0) / 100.0;
    }

    /// Generate a product SKU
    pub fn sku(self: *Commerce) ![]u8 {
        return self.random.replaceSymbols(self.allocator, "???-####-????");
    }
};
