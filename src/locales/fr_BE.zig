// French (fr_BE) locale  
const locale = @import("../locale.zig");
const fr_base = @import("fr.zig").fr;

pub const fr_BE: locale.LocaleDefinition = .{
    .title = "Français (fr_BE)",
    .person = fr_base.person,
    .address = fr_base.address,
    .company = fr_base.company,
    .internet = fr_base.internet,
    .phone = fr_base.phone,
    .food = fr_base.food,
    .animal = fr_base.animal,
};
