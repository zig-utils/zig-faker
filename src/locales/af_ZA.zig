// Afrikaans (South Africa) locale
const locale = @import("../locale.zig");
const af_base = @import("af.zig").af;

pub const af_ZA: locale.LocaleDefinition = .{
    .title = "Afrikaans (Suid-Afrika)",
    .person = af_base.person,
    .address = af_base.address,
    .company = af_base.company,
    .internet = af_base.internet,
    .phone = af_base.phone,
    .food = af_base.food,
    .animal = af_base.animal,
};
