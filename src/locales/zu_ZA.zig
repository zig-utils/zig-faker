// Zulu (South Africa) locale
const locale = @import("../locale.zig");
const zu_base = @import("zu.zig").zu;

pub const zu_ZA: locale.LocaleDefinition = .{
    .title = "isiZulu (Ningizimu Afrika)",
    .person = zu_base.person,
    .address = zu_base.address,
    .company = zu_base.company,
    .internet = zu_base.internet,
    .phone = zu_base.phone,
    .food = zu_base.food,
    .animal = zu_base.animal,
};
