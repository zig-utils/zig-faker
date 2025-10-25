// Portuguese (Brazil) locale
const locale = @import("../locale.zig");
const pt_base = @import("pt.zig").pt;

// Brazilian cities
const city_br = [_][]const u8{
    "São Paulo", "Rio de Janeiro", "Brasília", "Salvador", "Fortaleza",
    "Belo Horizonte", "Manaus", "Curitiba", "Recife", "Goiânia",
    "Belém", "Porto Alegre", "Guarulhos", "Campinas", "São Luís",
    "São Gonçalo", "Maceió", "Duque de Caxias", "Natal", "Teresina",
    "Campo Grande", "Nova Iguaçu", "São Bernardo do Campo", "João Pessoa", "Santo André",
};

// Brazilian states
const state_br = [_][]const u8{
    "Acre", "Alagoas", "Amapá", "Amazonas", "Bahia",
    "Ceará", "Distrito Federal", "Espírito Santo", "Goiás", "Maranhão",
    "Mato Grosso", "Mato Grosso do Sul", "Minas Gerais", "Pará", "Paraíba",
    "Paraná", "Pernambuco", "Piauí", "Rio de Janeiro", "Rio Grande do Norte",
    "Rio Grande do Sul", "Rondônia", "Roraima", "Santa Catarina", "São Paulo",
    "Sergipe", "Tocantins",
};

const state_abbr_br = [_][]const u8{
    "AC", "AL", "AP", "AM", "BA", "CE", "DF", "ES", "GO", "MA",
    "MT", "MS", "MG", "PA", "PB", "PR", "PE", "PI", "RJ", "RN",
    "RS", "RO", "RR", "SC", "SP", "SE", "TO",
};

pub const pt_BR: locale.LocaleDefinition = .{
    .title = "Português (Brasil)",
    .person = pt_base.person,
    .address = locale.AddressLocale{
        .street_name = &[_][]const u8{
            "Rua Augusta", "Avenida Paulista", "Rua das Flores", "Alameda Santos",
            "Rua do Comércio", "Avenida Brasil", "Rua Principal", "Praça da Sé",
        },
        .city = &city_br,
        .state = &state_br,
        .state_abbr = &state_abbr_br,
        .country = &[_][]const u8{"Brasil"},
        .postal_code_format = &[_][]const u8{"#####-###"},
        .building_number = pt_base.address.building_number,
        .direction = pt_base.address.direction,
        .country_weights = null,
        .state_weights = null,
    },
    .company = pt_base.company,
    .internet = locale.InternetLocale{
        .domain_suffix = &[_][]const u8{ ".br", ".com.br", ".net.br", ".org.br", ".gov.br" },
        .domain_word = &[_][]const u8{ "tech", "web", "net", "online", "digital" },
        .free_email = &[_][]const u8{
            "gmail.com", "hotmail.com", "yahoo.com.br", "outlook.com",
            "uol.com.br", "bol.com.br", "terra.com.br", "globo.com",
        },
    },
    .phone = locale.PhoneLocale{
        .format = &[_][]const u8{
            "+55 (##) ####-####",   // Landline
            "+55 (##) #####-####",  // Mobile
            "(##) ####-####",
            "(##) #####-####",
        },
    },
    .food = pt_base.food,
    .animal = pt_base.animal,
};
