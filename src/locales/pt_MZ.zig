// Portuguese (pt_MZ) locale
const locale = @import("../locale.zig");
const pt_base = @import("pt.zig").pt;

pub const pt_MZ: locale.LocaleDefinition = .{
    .title = "Português (pt_MZ)",
    .person = pt_base.person,
    .address = pt_base.address,
    .company = pt_base.company,
    .internet = pt_base.internet,
    .phone = pt_base.phone,
    .food = pt_base.food,
    .animal = pt_base.animal,
};
