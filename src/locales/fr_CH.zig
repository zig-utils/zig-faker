// French (fr_CH) locale  
const locale = @import("../locale.zig");
const fr_base = @import("fr.zig").fr;

pub const fr_CH: locale.LocaleDefinition = .{
    .title = "Français (fr_CH)",
    .person = fr_base.person,
    .address = fr_base.address,
    .company = fr_base.company,
    .internet = fr_base.internet,
    .phone = fr_base.phone,
    .food = fr_base.food,
    .animal = fr_base.animal,
};
