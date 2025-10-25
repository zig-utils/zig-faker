const std = @import("std");
const Random = @import("../random.zig").Random;

pub const Finance = struct {
    random: *Random,
    allocator: std.mem.Allocator,

    pub fn init(allocator: std.mem.Allocator, random: *Random) Finance {
        return Finance{
            .random = random,
            .allocator = allocator,
        };
    }

    const account_types = [_][]const u8{
        "Checking",    "Savings",     "Money Market", "Certificate of Deposit",
        "Retirement",  "Investment",  "Credit Card",  "Loan",
    };

    const transaction_types = [_][]const u8{
        "Deposit",    "Withdrawal",  "Transfer",    "Payment",
        "Purchase",   "Refund",      "Fee",         "Interest",
        "Dividend",   "Charge",
    };

    const currency_codes = [_][]const u8{
        "USD", "EUR", "GBP", "JPY", "CHF", "CAD", "AUD", "NZD",
        "CNY", "INR", "BRL", "MXN", "ZAR", "RUB", "KRW", "SGD",
    };

    const currency_names = [_][]const u8{
        "US Dollar",         "Euro",             "British Pound",    "Japanese Yen",
        "Swiss Franc",       "Canadian Dollar",  "Australian Dollar", "New Zealand Dollar",
        "Chinese Yuan",      "Indian Rupee",     "Brazilian Real",   "Mexican Peso",
        "South African Rand", "Russian Ruble",   "South Korean Won", "Singapore Dollar",
    };

    const crypto_currencies = [_][]const u8{
        "Bitcoin", "Ethereum", "Tether", "BNB",     "USD Coin", "XRP",
        "Cardano", "Dogecoin", "Polygon", "Solana", "Polkadot", "Litecoin",
    };

    /// Generate a random account number
    pub fn accountNumber(self: *Finance) ![]u8 {
        return self.random.replaceSymbols(self.allocator, "########");
    }

    /// Generate a random routing number
    pub fn routingNumber(self: *Finance) ![]u8 {
        return self.random.replaceSymbols(self.allocator, "#########");
    }

    /// Generate a credit card number (Luhn algorithm valid)
    pub fn creditCardNumber(self: *Finance) ![]u8 {
        // Generate 15 random digits
        var digits: [16]u8 = undefined;
        for (0..15) |i| {
            digits[i] = @intCast(self.random.int(0, 9));
        }

        // Calculate Luhn checksum
        var sum: u32 = 0;
        var i: usize = 14;
        var alternate = true;
        while (true) : ({
            if (i == 0) break;
            i -= 1;
        }) {
            var digit = digits[i];
            if (alternate) {
                digit *= 2;
                if (digit > 9) digit -= 9;
            }
            sum += digit;
            alternate = !alternate;
        }

        digits[15] = @intCast((10 - (sum % 10)) % 10);

        // Format as string
        return std.fmt.allocPrint(
            self.allocator,
            "{d}{d}{d}{d}-{d}{d}{d}{d}-{d}{d}{d}{d}-{d}{d}{d}{d}",
            .{
                digits[0],  digits[1],  digits[2],  digits[3],
                digits[4],  digits[5],  digits[6],  digits[7],
                digits[8],  digits[9],  digits[10], digits[11],
                digits[12], digits[13], digits[14], digits[15],
            },
        );
    }

    /// Generate a CVV code
    pub fn cvv(self: *Finance) ![]u8 {
        return self.random.replaceSymbols(self.allocator, "###");
    }

    /// Generate an IBAN
    pub fn iban(self: *Finance) ![]u8 {
        const country_codes = [_][]const u8{ "DE", "GB", "FR", "IT", "ES", "NL", "BE", "AT" };
        const country = self.random.arrayElement([]const u8, &country_codes);
        const check_digits = try self.random.replaceSymbols(self.allocator, "##");
        defer self.allocator.free(check_digits);
        const account = try self.random.replaceSymbols(self.allocator, "####################");
        defer self.allocator.free(account);

        return std.fmt.allocPrint(self.allocator, "{s}{s}{s}", .{ country, check_digits, account });
    }

    /// Generate a BIC/SWIFT code
    pub fn bic(self: *Finance) ![]u8 {
        const bank = try self.random.replaceSymbols(self.allocator, "????");
        defer self.allocator.free(bank);
        const country = try self.random.replaceSymbols(self.allocator, "??");
        defer self.allocator.free(country);
        const location = try self.random.replaceSymbols(self.allocator, "??");
        defer self.allocator.free(location);

        return std.fmt.allocPrint(self.allocator, "{s}{s}{s}", .{ bank, country, location });
    }

    /// Generate a random amount
    pub fn amount(self: *Finance, min: f64, max: f64) f64 {
        const value = self.random.float(min, max);
        return @round(value * 100.0) / 100.0;
    }

    /// Generate a random account type
    pub fn accountType(self: *Finance) []const u8 {
        return self.random.arrayElement([]const u8, &account_types);
    }

    /// Generate a random transaction type
    pub fn transactionType(self: *Finance) []const u8 {
        return self.random.arrayElement([]const u8, &transaction_types);
    }

    /// Generate a currency code
    pub fn currencyCode(self: *Finance) []const u8 {
        return self.random.arrayElement([]const u8, &currency_codes);
    }

    /// Generate a currency name
    pub fn currencyName(self: *Finance) []const u8 {
        return self.random.arrayElement([]const u8, &currency_names);
    }

    /// Generate a cryptocurrency name
    pub fn cryptocurrency(self: *Finance) []const u8 {
        return self.random.arrayElement([]const u8, &crypto_currencies);
    }

    /// Generate a Bitcoin address
    pub fn bitcoinAddress(self: *Finance) ![]u8 {
        const prefix = if (self.random.boolean(0.5)) "1" else "3";
        const addr = try self.random.replaceSymbols(self.allocator, "????????????????????????????????");
        defer self.allocator.free(addr);
        return std.fmt.allocPrint(self.allocator, "{s}{s}", .{ prefix, addr });
    }

    /// Generate an Ethereum address
    pub fn ethereumAddress(self: *Finance) ![]u8 {
        const addr = try self.random.hex(self.allocator, 40);
        defer self.allocator.free(addr);
        return std.fmt.allocPrint(self.allocator, "0x{s}", .{addr});
    }
};
