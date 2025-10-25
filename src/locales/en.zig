const locale = @import("../locale.zig");
const LocaleDefinition = locale.LocaleDefinition;
const PersonLocale = locale.PersonLocale;
const AddressLocale = locale.AddressLocale;
const CompanyLocale = locale.CompanyLocale;
const InternetLocale = locale.InternetLocale;
const PhoneLocale = locale.PhoneLocale;
const FoodLocale = locale.FoodLocale;
const AnimalLocale = locale.AnimalLocale;

const first_name_male = [_][]const u8{
    "James",     "John",      "Robert",   "Michael",  "William",   "David",     "Richard",  "Joseph",
    "Thomas",    "Charles",   "Christopher", "Daniel", "Matthew",  "Anthony",   "Mark",     "Donald",
    "Steven",    "Paul",      "Andrew",   "Joshua",   "Kenneth",   "Kevin",     "Brian",    "George",
    "Edward",    "Ronald",    "Timothy",  "Jason",    "Jeffrey",   "Ryan",      "Jacob",    "Gary",
    "Nicholas",  "Eric",      "Jonathan", "Stephen",  "Larry",     "Justin",    "Scott",    "Brandon",
    "Benjamin",  "Samuel",    "Raymond",  "Gregory",  "Frank",     "Alexander", "Patrick",  "Jack",
    "Dennis",    "Jerry",     "Tyler",    "Aaron",    "Jose",      "Adam",      "Henry",    "Nathan",
    "Douglas",   "Zachary",   "Peter",    "Kyle",     "Walter",    "Ethan",     "Jeremy",   "Harold",
    "Keith",     "Christian", "Roger",    "Noah",     "Gerald",    "Carl",      "Terry",    "Sean",
    "Austin",    "Arthur",    "Lawrence", "Jesse",    "Dylan",     "Bryan",     "Joe",      "Jordan",
    "Billy",     "Bruce",     "Albert",   "Willie",   "Gabriel",   "Logan",     "Alan",     "Juan",
    "Wayne",     "Roy",       "Ralph",    "Randy",    "Eugene",    "Vincent",   "Russell",  "Elijah",
    "Louis",     "Bobby",     "Philip",   "Johnny",   "Bradley",   "Mason",
};

const first_name_female = [_][]const u8{
    "Mary",      "Patricia",  "Jennifer", "Linda",    "Elizabeth", "Barbara",   "Susan",    "Jessica",
    "Sarah",     "Karen",     "Nancy",    "Lisa",     "Betty",     "Margaret",  "Sandra",   "Ashley",
    "Kimberly",  "Emily",     "Donna",    "Michelle", "Dorothy",   "Carol",     "Amanda",   "Melissa",
    "Deborah",   "Stephanie", "Rebecca",  "Sharon",   "Laura",     "Cynthia",   "Kathleen", "Amy",
    "Angela",    "Shirley",   "Anna",     "Brenda",   "Pamela",    "Emma",      "Nicole",   "Helen",
    "Samantha",  "Katherine", "Christine", "Debra",   "Rachel",    "Carolyn",   "Janet",    "Catherine",
    "Maria",     "Heather",   "Diane",    "Ruth",     "Julie",     "Olivia",    "Joyce",    "Virginia",
    "Victoria",  "Kelly",     "Lauren",   "Christina", "Joan",     "Evelyn",    "Judith",   "Megan",
    "Andrea",    "Cheryl",    "Hannah",   "Jacqueline", "Martha",  "Gloria",    "Teresa",   "Ann",
    "Sara",      "Madison",   "Frances",  "Kathryn",  "Janice",    "Jean",      "Abigail",  "Alice",
    "Judy",      "Sophia",    "Grace",    "Denise",   "Amber",     "Doris",     "Marilyn",  "Danielle",
    "Beverly",   "Isabella",  "Theresa",  "Diana",    "Natalie",   "Brittany",  "Charlotte", "Marie",
    "Kayla",     "Alexis",    "Lori",     "Emma",     "Ava",       "Mia",
};

const first_name_neutral = [_][]const u8{
    "Alex",   "Jordan", "Taylor", "Casey",  "Riley",  "Morgan", "Cameron", "Avery",
    "Quinn",  "Parker", "Peyton", "River",  "Sage",   "Skyler", "Charlie", "Dakota",
    "Rowan",  "Phoenix", "Blake", "Reese",  "Finley", "Hayden", "Emerson", "Oakley",
    "Elliott", "Sawyer", "Jamie",  "Dylan",  "Adrian", "Jesse",  "Kendall", "Sydney",
};

const last_name = [_][]const u8{
    "Smith",     "Johnson",   "Williams", "Brown",    "Jones",     "Garcia",    "Miller",   "Davis",
    "Rodriguez", "Martinez",  "Hernandez", "Lopez",   "Gonzalez",  "Wilson",    "Anderson", "Thomas",
    "Taylor",    "Moore",     "Jackson",  "Martin",   "Lee",       "Perez",     "Thompson", "White",
    "Harris",    "Sanchez",   "Clark",    "Ramirez",  "Lewis",     "Robinson",  "Walker",   "Young",
    "Allen",     "King",      "Wright",   "Scott",    "Torres",    "Nguyen",    "Hill",     "Flores",
    "Green",     "Adams",     "Nelson",   "Baker",    "Hall",      "Rivera",    "Campbell", "Mitchell",
    "Carter",    "Roberts",   "Gomez",    "Phillips", "Evans",     "Turner",    "Diaz",     "Parker",
    "Cruz",      "Edwards",   "Collins",  "Reyes",    "Stewart",   "Morris",    "Morales",  "Murphy",
    "Cook",      "Rogers",    "Gutierrez", "Ortiz",   "Morgan",    "Cooper",    "Peterson", "Bailey",
    "Reed",      "Kelly",     "Howard",   "Ramos",    "Kim",       "Cox",       "Ward",     "Richardson",
    "Watson",    "Brooks",    "Chavez",   "Wood",     "James",     "Bennett",   "Gray",     "Mendoza",
    "Ruiz",      "Hughes",    "Price",    "Alvarez",  "Castillo",  "Sanders",   "Patel",    "Myers",
    "Long",      "Ross",      "Foster",   "Jimenez",
};

const prefix = [_][]const u8{ "Mr.", "Mrs.", "Ms.", "Miss", "Dr.", "Prof." };

const suffix = [_][]const u8{ "Jr.", "Sr.", "II", "III", "IV", "V", "PhD", "MD", "DDS", "Esq." };

const gender = [_][]const u8{ "Male", "Female", "Non-binary", "Agender", "Genderfluid", "Bigender" };

const job_title = [_][]const u8{
    "Software Engineer",        "Product Manager",     "Data Scientist",    "UX Designer",
    "Marketing Manager",        "Sales Representative", "Accountant",       "HR Manager",
    "Project Manager",          "Business Analyst",    "DevOps Engineer",  "QA Engineer",
    "System Administrator",     "Database Administrator", "Network Engineer", "Security Analyst",
    "Frontend Developer",       "Backend Developer",   "Full Stack Developer", "Mobile Developer",
    "Content Writer",           "Graphic Designer",    "Customer Support", "Operations Manager",
    "Financial Analyst",        "Consultant",          "Research Scientist", "Teacher",
    "Nurse",                    "Doctor",              "Lawyer",           "Architect",
    "Civil Engineer",           "Mechanical Engineer", "Electrical Engineer", "Chef",
    "Photographer",             "Video Editor",        "Social Media Manager", "SEO Specialist",
};

const street_name = [_][]const u8{
    "Main Street",    "Oak Avenue",     "Maple Drive",   "Park Lane",    "Washington Street",
    "Lake Road",      "Hill Street",    "Church Road",   "Elm Street",   "Pine Avenue",
    "Cedar Lane",     "River Road",     "Sunset Boulevard", "First Avenue", "Second Street",
    "Third Street",   "Lincoln Avenue", "Madison Street", "Jefferson Road", "Adams Street",
    "Highland Avenue", "Spring Street", "Grove Avenue",  "Forest Drive", "Valley Road",
    "Hillside Drive", "Meadow Lane",   "Brook Street",   "Ridge Road",   "Summit Avenue",
};

const city = [_][]const u8{
    "New York",      "Los Angeles",  "Chicago",      "Houston",      "Phoenix",
    "Philadelphia",  "San Antonio",  "San Diego",    "Dallas",       "San Jose",
    "Austin",        "Jacksonville", "Fort Worth",   "Columbus",     "Charlotte",
    "San Francisco", "Indianapolis", "Seattle",      "Denver",       "Washington",
    "Boston",        "Nashville",    "Baltimore",    "Portland",     "Las Vegas",
    "Detroit",       "Memphis",      "Louisville",   "Milwaukee",    "Albuquerque",
    "Tucson",        "Fresno",       "Sacramento",   "Kansas City",  "Atlanta",
    "Miami",         "Oakland",      "Minneapolis",  "Cleveland",    "Tampa",
};

const state = [_][]const u8{
    "Alabama",       "Alaska",        "Arizona",      "Arkansas",     "California",
    "Colorado",      "Connecticut",   "Delaware",     "Florida",      "Georgia",
    "Hawaii",        "Idaho",         "Illinois",     "Indiana",      "Iowa",
    "Kansas",        "Kentucky",      "Louisiana",    "Maine",        "Maryland",
    "Massachusetts", "Michigan",      "Minnesota",    "Mississippi",  "Missouri",
    "Montana",       "Nebraska",      "Nevada",       "New Hampshire", "New Jersey",
    "New Mexico",    "New York",      "North Carolina", "North Dakota", "Ohio",
    "Oklahoma",      "Oregon",        "Pennsylvania", "Rhode Island", "South Carolina",
    "South Dakota",  "Tennessee",     "Texas",        "Utah",         "Vermont",
    "Virginia",      "Washington",    "West Virginia", "Wisconsin",   "Wyoming",
};

const state_abbr = [_][]const u8{
    "AL", "AK", "AZ", "AR", "CA", "CO", "CT", "DE", "FL", "GA",
    "HI", "ID", "IL", "IN", "IA", "KS", "KY", "LA", "ME", "MD",
    "MA", "MI", "MN", "MS", "MO", "MT", "NE", "NV", "NH", "NJ",
    "NM", "NY", "NC", "ND", "OH", "OK", "OR", "PA", "RI", "SC",
    "SD", "TN", "TX", "UT", "VT", "VA", "WA", "WV", "WI", "WY",
};

const country = [_][]const u8{
    "United States", "Canada",       "Mexico",       "United Kingdom", "France",
    "Germany",       "Italy",        "Spain",        "Australia",    "Brazil",
    "Argentina",     "Japan",        "China",        "India",        "Russia",
    "South Korea",   "Netherlands",  "Belgium",      "Switzerland",  "Sweden",
    "Norway",        "Denmark",      "Finland",      "Poland",       "Austria",
    "Ireland",       "Portugal",     "Greece",       "Turkey",       "Egypt",
};

const postal_code_format = [_][]const u8{ "#####", "#####-####" };

const building_number = [_][]const u8{ "###", "####", "#####" };

const direction = [_][]const u8{ "North", "South", "East", "West", "Northeast", "Northwest", "Southeast", "Southwest" };

const company_name = [_][]const u8{
    "Tech",      "Digital",   "Global",   "Smart",    "Advanced",  "Innovative", "Creative",  "Dynamic",
    "Strategic", "Elite",     "Prime",    "Premier",  "Superior",  "Optimal",    "Paramount", "Pinnacle",
    "Alpha",     "Beta",      "Gamma",    "Delta",    "Omega",     "Summit",     "Apex",      "Nexus",
    "Fusion",    "Quantum",   "Cyber",    "Cloud",    "Data",      "Info",       "Soft",      "Net",
    "Web",       "Mobile",    "Wireless", "Telecom",  "Media",     "Vision",     "Future",    "Next",
};

const company_suffix = [_][]const u8{
    "Inc",         "LLC",        "Ltd",        "Corp",       "Corporation",
    "Company",     "Group",      "Industries", "Systems",    "Solutions",
    "Technologies", "Services",  "Enterprises", "Partners",  "Associates",
};

const industry = [_][]const u8{
    "Technology",      "Finance",        "Healthcare",    "Education",     "Manufacturing",
    "Retail",          "Hospitality",    "Transportation", "Construction",  "Real Estate",
    "Entertainment",   "Media",          "Telecommunications", "Energy",   "Agriculture",
    "Pharmaceuticals", "Biotechnology",  "Automotive",    "Aerospace",     "Defense",
    "Consulting",      "Marketing",      "Advertising",   "Insurance",     "Banking",
};

const buzzwords = [_][]const u8{
    "synergy",       "leverage",      "paradigm",     "disruptive",   "innovative",
    "scalable",      "optimize",      "streamline",   "revolutionize", "transform",
    "integrate",     "facilitate",    "empower",      "enhance",      "maximize",
    "strategic",     "tactical",      "holistic",     "proactive",    "robust",
    "seamless",      "cutting-edge",  "state-of-the-art", "best-in-class", "world-class",
    "next-generation", "mission-critical", "value-added", "turnkey",   "enterprise",
};

const descriptor = [_][]const u8{
    "innovative",  "leading",     "premium",     "professional", "reliable",
    "efficient",   "comprehensive", "flexible",  "powerful",     "advanced",
    "cutting-edge", "state-of-the-art", "world-class", "industry-leading", "award-winning",
    "trusted",     "proven",      "certified",   "licensed",     "insured",
};

const domain_suffix = [_][]const u8{ "com", "net", "org", "io", "co", "dev", "app", "tech", "info", "biz" };

const domain_word = [_][]const u8{
    "tech",   "digital", "global", "smart",  "web",    "net",    "cloud",  "data",
    "info",   "soft",    "cyber",  "media",  "online", "virtual", "mobile", "social",
    "connect", "link",   "hub",    "zone",   "spot",   "place",  "world",  "universe",
};

const free_email = [_][]const u8{
    "gmail.com",    "yahoo.com",    "hotmail.com",  "outlook.com",
    "icloud.com",   "mail.com",     "protonmail.com", "aol.com",
};

const phone_format = [_][]const u8{
    "###-###-####",
    "(###) ###-####",
    "1-###-###-####",
    "###.###.####",
};

const food_dish = [_][]const u8{
    "Pizza",      "Burger",     "Sushi",      "Pasta",      "Tacos",
    "Salad",      "Steak",      "Chicken",    "Salmon",     "Soup",
    "Sandwich",   "Burrito",    "Curry",      "Noodles",    "Rice Bowl",
    "Ramen",      "Pho",        "Pad Thai",   "Stir Fry",   "Dumplings",
};

const food_ingredient = [_][]const u8{
    "Tomato",  "Onion",   "Garlic",  "Ginger",  "Pepper",  "Salt",    "Sugar",   "Flour",
    "Butter",  "Oil",     "Milk",    "Eggs",    "Cheese",  "Cream",   "Yogurt",  "Rice",
    "Pasta",   "Bread",   "Potato",  "Carrot",  "Celery",  "Lettuce", "Spinach", "Basil",
};

const food_fruit = [_][]const u8{
    "Apple",   "Banana",  "Orange",  "Grape",   "Strawberry", "Blueberry", "Raspberry", "Blackberry",
    "Mango",   "Pineapple", "Watermelon", "Melon", "Peach", "Pear",   "Plum",    "Cherry",
    "Lemon",   "Lime",    "Kiwi",    "Papaya",  "Coconut",  "Avocado",
};

const food_vegetable = [_][]const u8{
    "Carrot",  "Broccoli", "Cauliflower", "Cabbage", "Lettuce", "Spinach", "Kale",    "Tomato",
    "Cucumber", "Pepper",  "Onion",    "Garlic",  "Potato",  "Sweet Potato", "Corn", "Peas",
    "Beans",   "Celery",  "Asparagus", "Zucchini", "Eggplant", "Mushroom",
};

const food_meat = [_][]const u8{
    "Beef",    "Chicken", "Pork",    "Lamb",    "Turkey",  "Duck",    "Fish",    "Salmon",
    "Tuna",    "Shrimp",  "Crab",    "Lobster", "Bacon",   "Sausage", "Ham",     "Steak",
};

const food_spice = [_][]const u8{
    "Pepper",  "Salt",    "Paprika", "Cumin",   "Coriander", "Turmeric", "Cinnamon", "Nutmeg",
    "Ginger",  "Garlic",  "Oregano", "Basil",   "Thyme",   "Rosemary", "Sage",    "Parsley",
    "Dill",    "Mint",    "Chili",   "Curry",   "Saffron", "Cardamom",
};

const animal_dog = [_][]const u8{
    "Labrador",    "German Shepherd", "Golden Retriever", "Bulldog",   "Beagle",
    "Poodle",      "Rottweiler",   "Yorkshire Terrier", "Boxer",     "Dachshund",
    "Siberian Husky", "Great Dane", "Doberman",      "Shih Tzu",  "Boston Terrier",
    "Pomeranian",  "Corgi",        "Chihuahua",     "Pit Bull",  "Border Collie",
};

const animal_cat = [_][]const u8{
    "Persian",   "Maine Coon", "Siamese",   "Ragdoll",   "Bengal",
    "Sphynx",    "British Shorthair", "Abyssinian", "Birman", "Oriental Shorthair",
    "Scottish Fold", "Devon Rex", "Norwegian Forest", "Russian Blue", "Manx",
};

const animal_bird = [_][]const u8{
    "Sparrow",   "Robin",     "Eagle",     "Hawk",      "Owl",
    "Parrot",    "Canary",    "Finch",     "Pigeon",    "Crow",
    "Raven",     "Hummingbird", "Woodpecker", "Cardinal", "Blue Jay",
};

const animal_fish = [_][]const u8{
    "Goldfish",  "Koi",       "Betta",     "Guppy",     "Angelfish",
    "Tetra",     "Molly",     "Swordtail", "Platy",     "Catfish",
    "Cichlid",   "Oscar",     "Discus",    "Barb",      "Danio",
};

pub const en: LocaleDefinition = .{
    .title = "English",
    .person = PersonLocale{
        .first_name_male = &first_name_male,
        .first_name_female = &first_name_female,
        .first_name_neutral = &first_name_neutral,
        .last_name = &last_name,
        .prefix = &prefix,
        .suffix = &suffix,
        .gender = &gender,
        .job_title = &job_title,
    },
    .address = AddressLocale{
        .street_name = &street_name,
        .city = &city,
        .state = &state,
        .state_abbr = &state_abbr,
        .country = &country,
        .postal_code_format = &postal_code_format,
        .building_number = &building_number,
        .direction = &direction,
    },
    .company = CompanyLocale{
        .name = &company_name,
        .suffix = &company_suffix,
        .industry = &industry,
        .buzzwords = &buzzwords,
        .descriptor = &descriptor,
    },
    .internet = InternetLocale{
        .domain_suffix = &domain_suffix,
        .domain_word = &domain_word,
        .free_email = &free_email,
    },
    .phone = PhoneLocale{
        .format = &phone_format,
    },
    .food = FoodLocale{
        .dish = &food_dish,
        .ingredient = &food_ingredient,
        .fruit = &food_fruit,
        .vegetable = &food_vegetable,
        .meat = &food_meat,
        .spice = &food_spice,
    },
    .animal = AnimalLocale{
        .dog = &animal_dog,
        .cat = &animal_cat,
        .bird = &animal_bird,
        .fish = &animal_fish,
    },
};
