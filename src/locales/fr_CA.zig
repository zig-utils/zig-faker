// French (fr_CA) locale  
const locale = @import("../locale.zig");
const fr_base = @import("fr.zig").fr;

pub const fr_CA: locale.LocaleDefinition = .{
    .title = "Français (fr_CA)",
    .person = fr_base.person,
    .address = fr_base.address,
    .company = fr_base.company,
    .internet = fr_base.internet,
    .phone = fr_base.phone,
    .food = fr_base.food,
    .animal = fr_base.animal,
};
