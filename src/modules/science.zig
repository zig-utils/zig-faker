const std = @import("std");
const Random = @import("../random.zig").Random;

pub const Science = struct {
    allocator: std.mem.Allocator,

    pub fn init(allocator: std.mem.Allocator) Science {
        return Science{
            .allocator = allocator,
        };
    }

    const elements = [_][]const u8{
        "Hydrogen",   "Helium",     "Lithium",    "Beryllium",  "Boron",      "Carbon",
        "Nitrogen",   "Oxygen",     "Fluorine",   "Neon",       "Sodium",     "Magnesium",
        "Aluminum",   "Silicon",    "Phosphorus", "Sulfur",     "Chlorine",   "Argon",
        "Potassium",  "Calcium",    "Scandium",   "Titanium",   "Vanadium",   "Chromium",
        "Manganese",  "Iron",       "Cobalt",     "Nickel",     "Copper",     "Zinc",
        "Gallium",    "Germanium",  "Arsenic",    "Selenium",   "Bromine",    "Krypton",
        "Rubidium",   "Strontium",  "Yttrium",    "Zirconium",  "Niobium",    "Molybdenum",
        "Technetium", "Ruthenium",  "Rhodium",    "Palladium",  "Silver",     "Cadmium",
        "Indium",     "Tin",        "Antimony",   "Tellurium",  "Iodine",     "Xenon",
        "Gold",       "Mercury",    "Lead",       "Uranium",    "Plutonium",  "Radium",
    };

    const element_symbols = [_][]const u8{
        "H",  "He", "Li", "Be", "B",  "C",  "N",  "O",  "F",  "Ne",
        "Na", "Mg", "Al", "Si", "P",  "S",  "Cl", "Ar", "K",  "Ca",
        "Sc", "Ti", "V",  "Cr", "Mn", "Fe", "Co", "Ni", "Cu", "Zn",
        "Ga", "Ge", "As", "Se", "Br", "Kr", "Rb", "Sr", "Y",  "Zr",
        "Nb", "Mo", "Tc", "Ru", "Rh", "Pd", "Ag", "Cd", "In", "Sn",
        "Sb", "Te", "I",  "Xe", "Au", "Hg", "Pb", "U",  "Pu", "Ra",
    };

    const units = [_][]const u8{
        // Length
        "meter",      "kilometer",  "centimeter", "millimeter", "micrometer", "nanometer",
        "inch",       "foot",       "yard",       "mile",
        // Mass
        "gram",       "kilogram",   "milligram",  "microgram",  "ton",
        "ounce",      "pound",
        // Time
        "second",     "minute",     "hour",       "day",        "week",       "month",       "year",
        "millisecond", "microsecond", "nanosecond",
        // Temperature
        "Kelvin",     "Celsius",    "Fahrenheit",
        // Energy
        "Joule",      "calorie",    "kilocalorie", "electron volt",
        // Force
        "Newton",     "pound-force",
        // Pressure
        "Pascal",     "bar",        "atmosphere", "psi",
        // Volume
        "liter",      "milliliter", "gallon",     "quart",      "pint",       "cup",
    };

    const fields = [_][]const u8{
        "Physics",       "Chemistry",     "Biology",       "Astronomy",     "Geology",
        "Mathematics",   "Computer Science", "Engineering", "Medicine",     "Psychology",
        "Ecology",       "Genetics",      "Microbiology",  "Zoology",       "Botany",
        "Neuroscience",  "Biochemistry",  "Molecular Biology", "Quantum Mechanics", "Thermodynamics",
        "Electromagnetism", "Optics",     "Acoustics",     "Cosmology",     "Astrophysics",
    };

    const constants = [_][]const u8{
        "Speed of Light",        "Planck's Constant",    "Gravitational Constant",
        "Avogadro's Number",     "Boltzmann Constant",   "Gas Constant",
        "Elementary Charge",     "Electron Mass",        "Proton Mass",
        "Neutron Mass",          "Pi",                   "Euler's Number",
        "Golden Ratio",          "Vacuum Permittivity",  "Vacuum Permeability",
    };

    /// Generate a random chemical element name
    pub fn element(self: *Science, random: *Random) []const u8 {
        _ = self;
        return random.arrayElement([]const u8, &elements);
    }

    /// Generate a random chemical element symbol
    pub fn elementSymbol(self: *Science, random: *Random) []const u8 {
        _ = self;
        return random.arrayElement([]const u8, &element_symbols);
    }

    /// Generate a random unit of measurement
    pub fn unit(self: *Science, random: *Random) []const u8 {
        _ = self;
        return random.arrayElement([]const u8, &units);
    }

    /// Generate a random scientific field
    pub fn field(self: *Science, random: *Random) []const u8 {
        _ = self;
        return random.arrayElement([]const u8, &fields);
    }

    /// Generate a random scientific constant name
    pub fn constant(self: *Science, random: *Random) []const u8 {
        _ = self;
        return random.arrayElement([]const u8, &constants);
    }

    /// Generate a random chemical formula
    pub fn chemicalFormula(self: *Science, random: *Random) ![]u8 {
        const patterns = [_][]const u8{
            "{E}",       "{E}2",      "{E}3",      "{E}{E}",    "{E}2{E}",
            "{E}{E}2",   "{E}2{E}3",  "{E}3{E}2",  "{E}{E}3",   "{E}({E}2)3",
        };

        const pattern = random.arrayElement([]const u8, &patterns);
        var result = try self.allocator.dupe(u8, pattern);

        // Replace {E} with element symbols
        while (std.mem.indexOf(u8, result, "{E}")) |idx| {
            const symbol = self.elementSymbol(random);
            const new_result = try std.fmt.allocPrint(
                self.allocator,
                "{s}{s}{s}",
                .{ result[0..idx], symbol, result[idx + 3 ..] },
            );
            self.allocator.free(result);
            result = new_result;
        }

        return result;
    }
};
