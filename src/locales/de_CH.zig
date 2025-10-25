// German (Switzerland) locale
const locale = @import("../locale.zig");
const de_base = @import("de.zig").de;

pub const de_CH: locale.LocaleDefinition = .{
    .title = "Deutsch (Schweiz)",
    .person = de_base.person,
    .address = de_base.address,
    .company = de_base.company,
    .internet = locale.InternetLocale{
        .domain_suffix = &[_][]const u8{ ".ch", ".com", ".net", ".org" },
        .domain_word = &[_][]const u8{ "tech", "web", "net", "online", "digital" },
        .free_email = &[_][]const u8{ "gmail.com", "bluewin.ch", "gmx.ch", "hotmail.ch" },
    },
    .phone = locale.PhoneLocale{
        .format = &[_][]const u8{ "+41 ## ### ## ##", "0## ### ## ##" },
    },
    .food = de_base.food,
    .animal = de_base.animal,
};
