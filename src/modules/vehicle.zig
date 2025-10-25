const std = @import("std");
const Random = @import("../random.zig").Random;

pub const Vehicle = struct {
    allocator: std.mem.Allocator,

    pub fn init(allocator: std.mem.Allocator) Vehicle {
        return Vehicle{
            .allocator = allocator,
        };
    }

    /// Car manufacturers
    const manufacturers = [_][]const u8{
        "Toyota",     "Honda",      "Ford",       "Chevrolet",  "Nissan",     "BMW",
        "Mercedes",   "Audi",       "Volkswagen", "Hyundai",    "Kia",        "Mazda",
        "Subaru",     "Lexus",      "Porsche",    "Ferrari",    "Lamborghini", "Tesla",
        "Volvo",      "Jaguar",     "Land Rover", "Jeep",       "Ram",        "GMC",
        "Cadillac",   "Dodge",      "Chrysler",   "Buick",      "Acura",      "Infiniti",
        "Genesis",    "Mitsubishi", "Suzuki",     "Fiat",       "Alfa Romeo", "Maserati",
        "Bentley",    "Rolls-Royce", "Aston Martin", "McLaren",  "Bugatti",    "Pagani",
    };

    const car_models = [_][]const u8{
        "Camry",     "Accord",     "Civic",      "Corolla",    "Mustang",    "F-150",
        "Silverado", "RAV4",       "CR-V",       "Highlander", "Pilot",      "Explorer",
        "Tahoe",     "Suburban",   "Escape",     "Rogue",      "Altima",     "Sentra",
        "Maxima",    "Pathfinder", "3 Series",   "5 Series",   "X3",         "X5",
        "C-Class",   "E-Class",    "GLC",        "GLE",        "A4",         "Q5",
        "Q7",        "Golf",       "Jetta",      "Tiguan",     "Elantra",    "Sonata",
        "Tucson",    "Santa Fe",   "Forte",      "Sportage",   "Sorento",    "CX-5",
        "CX-9",      "MX-5",       "Outback",    "Forester",   "Legacy",     "WRX",
    };

    const vehicle_types = [_][]const u8{
        "Sedan",     "SUV",        "Truck",      "Coupe",      "Hatchback",
        "Wagon",     "Van",        "Minivan",    "Convertible", "Roadster",
        "Sports Car", "Supercar",  "Hypercar",   "Crossover",  "Off-road",
        "Pickup",    "Electric",   "Hybrid",     "Compact",    "Midsize",
    };

    const fuel_types = [_][]const u8{
        "Gasoline", "Diesel", "Electric", "Hybrid", "Plug-in Hybrid",
        "Hydrogen", "E85",    "CNG",      "LPG",    "Biodiesel",
    };

    const bicycle_types = [_][]const u8{
        "Road Bike",     "Mountain Bike", "Hybrid Bike",   "Cruiser",       "BMX",
        "Electric Bike", "Folding Bike",  "Gravel Bike",   "Touring Bike",  "Cyclocross",
        "Fat Bike",      "Track Bike",    "Tandem",        "Recumbent",     "Cargo Bike",
    };

    /// Generate a random car manufacturer
    pub fn manufacturer(self: *Vehicle, random: *Random) []const u8 {
        _ = self;
        return random.arrayElement([]const u8, &manufacturers);
    }

    /// Generate a random car model
    pub fn model(self: *Vehicle, random: *Random) []const u8 {
        _ = self;
        return random.arrayElement([]const u8, &car_models);
    }

    /// Generate a random vehicle type
    pub fn type_(self: *Vehicle, random: *Random) []const u8 {
        _ = self;
        return random.arrayElement([]const u8, &vehicle_types);
    }

    /// Generate a random fuel type
    pub fn fuel(self: *Vehicle, random: *Random) []const u8 {
        _ = self;
        return random.arrayElement([]const u8, &fuel_types);
    }

    /// Generate a random bicycle type
    pub fn bicycle(self: *Vehicle, random: *Random) []const u8 {
        _ = self;
        return random.arrayElement([]const u8, &bicycle_types);
    }

    /// Generate a VIN (Vehicle Identification Number)
    pub fn vin(self: *Vehicle, random: *Random) ![]u8 {
        const chars = "ABCDEFGHJKLMNPRSTUVWXYZ0123456789"; // Excludes I, O, Q
        var result = try self.allocator.alloc(u8, 17);

        for (0..17) |i| {
            const idx = random.int(0, @as(i64, @intCast(chars.len - 1)));
            result[i] = chars[@intCast(idx)];
        }

        return result;
    }

    /// Generate a license plate number
    pub fn licensePlate(self: *Vehicle, random: *Random) ![]u8 {
        const formats = [_][]const u8{
            "???-####",
            "###-???",
            "??#-###",
            "###-##??",
        };

        const format = random.arrayElement([]const u8, &formats);
        return random.replaceSymbols(self.allocator, format);
    }

    /// Generate a full vehicle name (manufacturer + model)
    pub fn vehicle(self: *Vehicle, random: *Random) ![]u8 {
        const make = self.manufacturer(random);
        const model_name = self.model(random);
        return std.fmt.allocPrint(self.allocator, "{s} {s}", .{ make, model_name });
    }

    /// Generate a vehicle color
    pub fn color(self: *Vehicle, random: *Random) []const u8 {
        _ = self;
        const colors = [_][]const u8{
            "White",  "Black",  "Gray",   "Silver", "Red",    "Blue",
            "Green",  "Yellow", "Orange", "Brown",  "Purple", "Gold",
            "Beige",  "Tan",    "Navy",   "Maroon", "Teal",   "Pink",
        };
        return random.arrayElement([]const u8, &colors);
    }
};
