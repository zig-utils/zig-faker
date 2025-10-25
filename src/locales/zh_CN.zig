// Chinese (China - Simplified) locale
const locale = @import("../locale.zig");
const zh_base = @import("zh.zig").zh;

pub const zh_CN: locale.LocaleDefinition = .{
    .title = "中文 (中国)",
    .person = zh_base.person,
    .address = locale.AddressLocale{
        .street_name = &[_][]const u8{"中山路", "人民路", "解放路", "建设路", "和平路", "长江路", "黄河路"},
        .city = &[_][]const u8{"北京", "上海", "广州", "深圳", "成都", "杭州", "重庆", "西安", "武汉", "南京"},
        .state = &[_][]const u8{"北京市", "上海市", "广东省", "浙江省", "江苏省", "四川省"},
        .state_abbr = &[_][]const u8{"京", "沪", "粤", "浙", "苏", "川"},
        .country = &[_][]const u8{"中国"},
        .postal_code_format = &[_][]const u8{"######"},
        .building_number = &[_][]const u8{"#号", "##号"},
        .direction = &[_][]const u8{"东", "南", "西", "北"},
        .country_weights = null,
        .state_weights = null,
    },
    .company = zh_base.company,
    .internet = locale.InternetLocale{
        .domain_suffix = &[_][]const u8{ ".cn", ".com.cn", ".net.cn", ".com" },
        .domain_word = &[_][]const u8{ "tech", "web", "net", "online", "digital" },
        .free_email = &[_][]const u8{ "qq.com", "163.com", "126.com", "gmail.com", "sina.com" },
    },
    .phone = locale.PhoneLocale{
        .format = &[_][]const u8{ "+86 ### #### ####", "### #### ####" },
    },
    .food = zh_base.food,
    .animal = zh_base.animal,
};
