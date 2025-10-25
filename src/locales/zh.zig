// Chinese (中文) locale - Minimal version  
const locale = @import("../locale.zig");
const en = @import("en.zig").en;

pub const zh: locale.LocaleDefinition = .{
    .title = "中文",
    .person = locale.PersonLocale{
        .first_name_male = &[_][]const u8{ "伟", "杰", "强", "磊", "鹏", "超", "军", "刚", "浩", "明" },
        .first_name_female = &[_][]const u8{ "芳", "娜", "秀英", "敏", "静", "丽", "艳", "莉", "红", "玲" },
        .first_name_neutral = &[_][]const u8{},
        .last_name = &[_][]const u8{ "王", "李", "张", "刘", "陈", "杨", "黄", "赵", "周", "吴", "徐", "孙", "朱", "马", "胡", "郭", "林", "何", "高", "梁" },
        .prefix = &[_][]const u8{ "先生", "女士", "博士", "教授", "老师" },
        .suffix = &[_][]const u8{},
        .job_title = en.person.job_title,
        .gender = &[_][]const u8{ "男", "女", "其他" },
        .first_name_male_weights = null,
        .first_name_female_weights = null,
        .last_name_weights = null,
    },
    .address = locale.AddressLocale{
        .street_name = &[_][]const u8{ "中山路", "人民路", "解放路", "建设路", "和平路" },
        .city = &[_][]const u8{ "北京", "上海", "广州", "深圳", "成都", "杭州", "重庆", "西安", "苏州", "武汉", "南京", "天津", "郑州", "长沙", "东莞" },
        .state = &[_][]const u8{ "北京市", "上海市", "广东省", "浙江省", "江苏省", "四川省", "湖北省", "陕西省", "湖南省", "河南省" },
        .state_abbr = &[_][]const u8{ "京", "沪", "粤", "浙", "苏", "川", "鄂", "陕", "湘", "豫" },
        .country = &[_][]const u8{ "中国", "美国", "日本", "韩国", "英国" },
        .postal_code_format = &[_][]const u8{ "######" },
        .building_number = &[_][]const u8{ "#号", "##号", "###号" },
        .direction = &[_][]const u8{ "东", "南", "西", "北" },
        .country_weights = null,
        .state_weights = null,
    },
    .company = en.company,
    .internet = locale.InternetLocale{
        .domain_suffix = &[_][]const u8{ ".cn", ".com.cn", ".net.cn", ".com" },
        .domain_word = &[_][]const u8{ "tech", "web", "net", "online", "digital" },
        .free_email = &[_][]const u8{ "qq.com", "163.com", "126.com", "gmail.com", "sina.com" },
    },
    .phone = locale.PhoneLocale{
        .format = &[_][]const u8{ "+86 ### #### ####", "### #### ####" },
    },
    .food = en.food,
    .animal = en.animal,
};
