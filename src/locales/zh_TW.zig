// Chinese (zh_TW) locale
const locale = @import("../locale.zig");
const zh_base = @import("zh.zig").zh;

pub const zh_TW: locale.LocaleDefinition = .{
    .title = "中文 (zh_TW)",
    .person = zh_base.person,
    .address = zh_base.address,
    .company = zh_base.company,
    .internet = zh_base.internet,
    .phone = zh_base.phone,
    .food = zh_base.food,
    .animal = zh_base.animal,
};
