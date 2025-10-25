// Portuguese (Português) locale
const locale = @import("../locale.zig");
const en = @import("en.zig").en;

const first_name_male = [_][]const u8{
    "Alexandre", "André", "António", "Bruno", "Carlos",
    "Daniel", "Diogo", "Duarte", "Eduardo", "Fernando",
    "Francisco", "Gabriel", "Gonçalo", "Guilherme", "Gustavo",
    "Henrique", "Hugo", "João", "Jorge", "José",
    "Leonardo", "Lucas", "Luís", "Manuel", "Marco",
    "Martim", "Mateus", "Miguel", "Nuno", "Paulo",
    "Pedro", "Rafael", "Raul", "Ricardo", "Rodrigo",
    "Rui", "Santiago", "Sérgio", "Tiago", "Tomás",
    "Vicente", "Vítor", "Afonso", "Bernardo", "Dinis",
};

const first_name_female = [_][]const u8{
    "Ana", "Andreia", "Beatriz", "Bruna", "Camila",
    "Carolina", "Catarina", "Clara", "Daniela", "Diana",
    "Eva", "Filipa", "Francisca", "Gabriela", "Inês",
    "Joana", "Juliana", "Lara", "Laura", "Leonor",
    "Letícia", "Lúcia", "Luísa", "Margarida", "Maria",
    "Mariana", "Marta", "Matilde", "Melissa", "Mónica",
    "Patrícia", "Paula", "Raquel", "Rita", "Sara",
    "Sofia", "Susana", "Teresa", "Valentina", "Vera",
    "Vitória", "Alice", "Amélia", "Carlota", "Helena",
};

const last_name = [_][]const u8{
    "Silva", "Santos", "Ferreira", "Pereira", "Oliveira",
    "Costa", "Rodrigues", "Martins", "Jesus", "Sousa",
    "Fernandes", "Gonçalves", "Gomes", "Lopes", "Marques",
    "Alves", "Almeida", "Ribeiro", "Pinto", "Carvalho",
    "Teixeira", "Moreira", "Correia", "Mendes", "Nunes",
    "Soares", "Vieira", "Monteiro", "Cardoso", "Rocha",
    "Neves", "Coelho", "Cruz", "Cunha", "Pires",
    "Ramos", "Reis", "Simões", "Antunes", "Melo",
    "Fonseca", "Baptista", "Machado", "Henriques", "Valente",
    "Freitas", "Morais", "Barros", "Tavares", "Faria",
};

const prefix = [_][]const u8{
    "Sr.", "Sra.", "Dr.", "Dra.", "Prof.",
    "Eng.", "Arq.", "Me.", "D.", "Dom",
};

const suffix = [_][]const u8{
    "Jr.", "Filho", "Neto", "Sobrinho", "II", "III",
};

const job_title = [_][]const u8{
    "Gerente", "Diretor", "Coordenador", "Supervisor", "Assistente",
    "Desenvolvedor", "Engenheiro", "Arquiteto", "Designer", "Analista",
    "Contador", "Advogado", "Médico", "Professor", "Consultor",
    "Vendedor", "Administrador", "Técnico", "Especialista", "Chefe",
};

const street_name = [_][]const u8{
    "Rua Principal", "Avenida Central", "Rua da Liberdade", "Praça da República",
    "Avenida da Independência", "Rua do Comércio", "Alameda Santos", "Rua Augusta",
    "Avenida Paulista", "Rua das Flores", "Praça do Comércio", "Rua Garrett",
    "Avenida da Liberdade", "Rua de Santa Catarina", "Praça da Sé", "Largo do Rato",
};

const city = [_][]const u8{
    "Lisboa", "Porto", "Coimbra", "Braga", "Funchal",
    "Aveiro", "Faro", "Évora", "Viseu", "Guimarães",
    "São Paulo", "Rio de Janeiro", "Brasília", "Salvador", "Fortaleza",
    "Belo Horizonte", "Manaus", "Curitiba", "Recife", "Goiânia",
    "Belém", "Porto Alegre", "Guarulhos", "Campinas", "São Luís",
    "São Gonçalo", "Maceió", "Duque de Caxias", "Natal", "Teresina",
    "Campo Grande", "Nova Iguaçu", "São Bernardo do Campo", "João Pessoa", "Santo André",
    "Osasco", "Jaboatão dos Guararapes", "Ribeirão Preto", "Uberlândia", "Sorocaba",
};

const state = [_][]const u8{
    "Aveiro", "Beja", "Braga", "Bragança", "Castelo Branco",
    "Coimbra", "Évora", "Faro", "Guarda", "Leiria",
    "Lisboa", "Portalegre", "Porto", "Santarém", "Setúbal",
    "Viana do Castelo", "Vila Real", "Viseu", "Açores", "Madeira",
    "Acre", "Alagoas", "Amapá", "Amazonas", "Bahia",
    "Ceará", "Distrito Federal", "Espírito Santo", "Goiás", "Maranhão",
    "Mato Grosso", "Mato Grosso do Sul", "Minas Gerais", "Pará", "Paraíba",
    "Paraná", "Pernambuco", "Piauí", "Rio de Janeiro", "Rio Grande do Norte",
};

const state_abbr = [_][]const u8{
    "AVE", "BEJ", "BRA", "BRG", "CB", "COI", "EVO", "FAR", "GUA", "LEI",
    "LIS", "POR", "PTO", "SAN", "SET", "VDC", "VIR", "VIS", "AÇO", "MAD",
    "AC", "AL", "AP", "AM", "BA", "CE", "DF", "ES", "GO", "MA",
    "MT", "MS", "MG", "PA", "PB", "PR", "PE", "PI", "RJ", "RN",
};

const country = [_][]const u8{
    "Portugal", "Brasil", "Angola", "Moçambique", "Cabo Verde",
    "Guiné-Bissau", "São Tomé e Príncipe", "Timor-Leste", "Macau", "Goa",
    "Espanha", "França", "Alemanha", "Itália", "Reino Unido",
};

const postal_code_format = [_][]const u8{
    "####-###",   // Portugal
    "#####-###",  // Brazil
};

const company_name = [_][]const u8{
    "Soluções", "Tecnologia", "Serviços", "Sistemas", "Inovação",
    "Desenvolvimento", "Consultoria", "Comercial", "Industrial", "Grupo",
};

const company_suffix = [_][]const u8{
    "Lda.", "S.A.", "Unipessoal", "e Filhos", "Irmãos",
    "Grupo", "Internacional", "Portugal", "Brasil",
};

const industry = [_][]const u8{
    "Tecnologia", "Comércio", "Serviços", "Manufatura", "Construção",
    "Alimentação", "Transporte", "Educação", "Saúde", "Finanças",
    "Turismo", "Agricultura", "Energia", "Telecomunicações", "Automóvel",
};

const domain_suffix = [_][]const u8{
    ".pt", ".br", ".com", ".net", ".org",
    ".com.pt", ".com.br", ".gov.pt", ".gov.br",
};

const phone_format = [_][]const u8{
    "+351 ### ### ###",    // Portugal
    "+55 (##) ####-####",  // Brazil landline
    "+55 (##) #####-####", // Brazil mobile
    "### ### ###",
    "(##) ####-####",
};

pub const pt: locale.LocaleDefinition = .{
    .title = "Português",
    .person = locale.PersonLocale{
        .first_name_male = &first_name_male,
        .first_name_female = &first_name_female,
        .first_name_neutral = &[_][]const u8{},
        .last_name = &last_name,
        .prefix = &prefix,
        .suffix = &suffix,
        .job_title = &job_title,
        .gender = &[_][]const u8{ "Masculino", "Feminino", "Não-binário" },
        .first_name_male_weights = null,
        .first_name_female_weights = null,
        .last_name_weights = null,
    },
    .address = locale.AddressLocale{
        .street_name = &street_name,
        .city = &city,
        .state = &state,
        .state_abbr = &state_abbr,
        .country = &country,
        .postal_code_format = &postal_code_format,
        .building_number = &[_][]const u8{ "#", "##", "###", "####" },
        .direction = &[_][]const u8{ "Norte", "Sul", "Este", "Oeste" },
        .country_weights = null,
        .state_weights = null,
    },
    .company = locale.CompanyLocale{
        .name = &company_name,
        .suffix = &company_suffix,
        .industry = &industry,
        .buzzwords = &[_][]const u8{
            "inovador", "eficiente", "sustentável", "digital", "inteligente",
        },
        .descriptor = &[_][]const u8{
            "inovador", "líder", "premium", "profissional", "confiável",
        },
    },
    .internet = locale.InternetLocale{
        .domain_suffix = &domain_suffix,
        .domain_word = &[_][]const u8{ "tech", "web", "net", "online", "digital" },
        .free_email = &[_][]const u8{
            "gmail.com", "hotmail.com", "yahoo.com.br", "outlook.com", "sapo.pt",
            "live.com", "uol.com.br", "bol.com.br", "terra.com.br",
        },
    },
    .phone = locale.PhoneLocale{
        .format = &phone_format,
    },
    .food = en.food,
    .animal = en.animal,
};
