// Chinese (Taiwan - Traditional) locale
const locale = @import("../locale.zig");
const zh_base = @import("zh.zig").zh;

pub const zh_TW: locale.LocaleDefinition = .{
    .title = "中文 (台灣)",
    .person = zh_base.person,
    .address = locale.AddressLocale{
        .street_name = &[_][]const u8{"中山路", "民權路", "信義路", "仁愛路", "和平路"},
        .city = &[_][]const u8{"台北", "高雄", "台中", "台南", "新北", "桃園", "基隆", "新竹"},
        .state = &[_][]const u8{"台北市", "新北市", "桃園市", "台中市", "台南市", "高雄市"},
        .state_abbr = &[_][]const u8{"北", "新北", "桃", "中", "南", "高"},
        .country = &[_][]const u8{"台灣"},
        .postal_code_format = &[_][]const u8{"#####"},
        .building_number = &[_][]const u8{"#號", "##號"},
        .direction = &[_][]const u8{"東", "南", "西", "北"},
        .country_weights = null,
        .state_weights = null,
    },
    .company = zh_base.company,
    .internet = locale.InternetLocale{
        .domain_suffix = &[_][]const u8{ ".tw", ".com.tw", ".net.tw", ".com" },
        .domain_word = &[_][]const u8{ "tech", "web", "net", "online", "digital" },
        .free_email = &[_][]const u8{ "gmail.com", "yahoo.com.tw", "pchome.com.tw", "hotmail.com" },
    },
    .phone = locale.PhoneLocale{
        .format = &[_][]const u8{ "+886 # #### ####", "0# #### ####" },
    },
    .food = zh_base.food,
    .animal = zh_base.animal,
};
