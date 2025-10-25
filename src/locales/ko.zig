// Korean (한국어) locale - Minimal version
const locale = @import("../locale.zig");
const en = @import("en.zig").en;

pub const ko: locale.LocaleDefinition = .{
    .title = "한국어",
    .person = locale.PersonLocale{
        .first_name_male = &[_][]const u8{ "민준", "서준", "예준", "도윤", "시우", "주원", "하준", "지호", "준서", "건우" },
        .first_name_female = &[_][]const u8{ "서연", "민서", "서현", "지우", "하은", "윤서", "지유", "채원", "지민", "수아" },
        .first_name_neutral = &[_][]const u8{},
        .last_name = &[_][]const u8{ "김", "이", "박", "최", "정", "강", "조", "윤", "장", "임", "한", "오", "서", "신", "권" },
        .prefix = &[_][]const u8{ "씨", "님", "박사", "교수", "선생님" },
        .suffix = &[_][]const u8{},
        .job_title = en.person.job_title,
        .gender = &[_][]const u8{ "남성", "여성", "기타" },
        .first_name_male_weights = null,
        .first_name_female_weights = null,
        .last_name_weights = null,
    },
    .address = locale.AddressLocale{
        .street_name = &[_][]const u8{ "강남대로", "테헤란로", "종로", "을지로", "세종대로" },
        .city = &[_][]const u8{ "서울", "부산", "인천", "대구", "대전", "광주", "수원", "울산", "창원", "고양" },
        .state = &[_][]const u8{ "서울특별시", "부산광역시", "대구광역시", "인천광역시", "광주광역시", "대전광역시", "울산광역시", "세종특별자치시", "경기도", "강원도" },
        .state_abbr = &[_][]const u8{ "서울", "부산", "대구", "인천", "광주", "대전", "울산", "세종", "경기", "강원" },
        .country = &[_][]const u8{ "대한민국", "미국", "중국", "일본", "영국" },
        .postal_code_format = &[_][]const u8{ "#####" },
        .building_number = &[_][]const u8{ "#", "##", "###" },
        .direction = &[_][]const u8{ "북", "남", "동", "서" },
        .country_weights = null,
        .state_weights = null,
    },
    .company = en.company,
    .internet = locale.InternetLocale{
        .domain_suffix = &[_][]const u8{ ".kr", ".co.kr", ".com", ".net" },
        .domain_word = &[_][]const u8{ "tech", "web", "net", "online", "digital" },
        .free_email = &[_][]const u8{ "naver.com", "gmail.com", "daum.net", "hanmail.net" },
    },
    .phone = locale.PhoneLocale{
        .format = &[_][]const u8{ "+82 ##-####-####", "###-####-####" },
    },
    .food = en.food,
    .animal = en.animal,
};
