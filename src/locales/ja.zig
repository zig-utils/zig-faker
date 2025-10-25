// Japanese (日本語) locale - Minimal version
const locale = @import("../locale.zig");
const en = @import("en.zig").en;

pub const ja: locale.LocaleDefinition = .{
    .title = "日本語",
    .person = locale.PersonLocale{
        .first_name_male = &[_][]const u8{ "太郎", "健", "誠", "翔", "大輔", "拓也", "健太", "隆", "直樹", "裕太" },
        .first_name_female = &[_][]const u8{ "さくら", "美咲", "陽菜", "結衣", "葵", "愛", "彩花", "七海", "莉子", "美月" },
        .first_name_neutral = &[_][]const u8{},
        .last_name = &[_][]const u8{ "佐藤", "鈴木", "高橋", "田中", "渡辺", "伊藤", "山本", "中村", "小林", "加藤", "吉田", "山田", "佐々木", "山口", "松本" },
        .prefix = &[_][]const u8{ "さん", "様", "氏", "先生", "博士" },
        .suffix = &[_][]const u8{},
        .job_title = en.person.job_title,
        .gender = &[_][]const u8{ "男性", "女性", "その他" },
        .first_name_male_weights = null,
        .first_name_female_weights = null,
        .last_name_weights = null,
    },
    .address = locale.AddressLocale{
        .street_name = &[_][]const u8{ "中央通り", "駅前通り", "本町", "栄町", "幸町" },
        .city = &[_][]const u8{ "東京", "横浜", "大阪", "名古屋", "札幌", "福岡", "神戸", "京都", "広島", "仙台" },
        .state = &[_][]const u8{ "北海道", "東京都", "大阪府", "京都府", "神奈川県", "愛知県", "福岡県", "埼玉県", "千葉県", "兵庫県" },
        .state_abbr = &[_][]const u8{ "北海道", "東京", "大阪", "京都", "神奈川", "愛知", "福岡", "埼玉", "千葉", "兵庫" },
        .country = &[_][]const u8{ "日本", "アメリカ", "中国", "韓国", "イギリス" },
        .postal_code_format = &[_][]const u8{ "###-####" },
        .building_number = &[_][]const u8{ "#", "#-#", "##-##" },
        .direction = &[_][]const u8{ "北", "南", "東", "西" },
        .country_weights = null,
        .state_weights = null,
    },
    .company = en.company,
    .internet = locale.InternetLocale{
        .domain_suffix = &[_][]const u8{ ".jp", ".co.jp", ".ne.jp", ".com" },
        .domain_word = &[_][]const u8{ "tech", "web", "net", "online", "digital" },
        .free_email = &[_][]const u8{ "gmail.com", "yahoo.co.jp", "hotmail.com", "outlook.jp" },
    },
    .phone = locale.PhoneLocale{
        .format = &[_][]const u8{ "+81 ##-####-####", "##-####-####", "###-###-####" },
    },
    .food = en.food,
    .animal = en.animal,
};
