// English (en_HK) locale
const locale = @import("../locale.zig");
const en_base = @import("en.zig").en;

pub const en_HK: locale.LocaleDefinition = .{
    .title = "English (en_HK)",
    .person = en_base.person,
    .address = en_base.address,
    .company = en_base.company,
    .internet = en_base.internet,
    .phone = en_base.phone,
    .food = en_base.food,
    .animal = en_base.animal,
};
