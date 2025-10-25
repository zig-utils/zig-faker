// French (Luxembourg) locale
const locale = @import("../locale.zig");
const fr_base = @import("fr.zig").fr;

pub const fr_LU: locale.LocaleDefinition = .{
    .title = "Français (Luxembourg)",
    .person = fr_base.person,
    .address = fr_base.address,
    .company = fr_base.company,
    .internet = locale.InternetLocale{
        .domain_suffix = &[_][]const u8{ ".lu", ".com", ".net" },
        .domain_word = &[_][]const u8{ "tech", "web", "net", "online", "digital" },
        .free_email = &[_][]const u8{ "gmail.com", "hotmail.lu", "yahoo.com" },
    },
    .phone = locale.PhoneLocale{
        .format = &[_][]const u8{ "+352 ### ### ###" },
    },
    .food = fr_base.food,
    .animal = fr_base.animal,
};
