// German (Austria) locale
const locale = @import("../locale.zig");
const de_base = @import("de.zig").de;

pub const de_AT: locale.LocaleDefinition = .{
    .title = "Deutsch (Österreich)",
    .person = de_base.person,
    .address = de_base.address,
    .company = de_base.company,
    .internet = locale.InternetLocale{
        .domain_suffix = &[_][]const u8{ ".at", ".com", ".net", ".org" },
        .domain_word = &[_][]const u8{ "tech", "web", "net", "online", "digital" },
        .free_email = &[_][]const u8{ "gmail.com", "gmx.at", "aon.at", "chello.at" },
    },
    .phone = locale.PhoneLocale{
        .format = &[_][]const u8{ "+43 ### ######", "0### ######" },
    },
    .food = de_base.food,
    .animal = de_base.animal,
};
