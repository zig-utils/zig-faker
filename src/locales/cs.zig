// cs locale - Minimal stub
const locale = @import("../locale.zig");
const en = @import("en.zig").en;

pub const cs: locale.LocaleDefinition = .{
    .title = "cs",
    .person = en.person,
    .address = en.address,
    .company = en.company,
    .internet = en.internet,
    .phone = en.phone,
    .food = en.food,
    .animal = en.animal,
};
