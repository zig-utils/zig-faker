// Portuguese (pt_PT) locale
const locale = @import("../locale.zig");
const pt_base = @import("pt.zig").pt;

pub const pt_PT: locale.LocaleDefinition = .{
    .title = "Português (pt_PT)",
    .person = pt_base.person,
    .address = pt_base.address,
    .company = pt_base.company,
    .internet = pt_base.internet,
    .phone = pt_base.phone,
    .food = pt_base.food,
    .animal = pt_base.animal,
};
