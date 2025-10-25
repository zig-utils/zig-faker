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
    // American & International
    "Pizza",           "Burger",          "Sushi",           "Pasta",           "Tacos",
    "Salad",           "Steak",           "Chicken",         "Salmon",          "Soup",
    "Sandwich",        "Burrito",         "Curry",           "Noodles",         "Rice Bowl",
    "Ramen",           "Pho",             "Pad Thai",        "Stir Fry",        "Dumplings",
    // Italian
    "Lasagna",         "Risotto",         "Carbonara",       "Ravioli",         "Gnocchi",
    "Pesto Pasta",     "Margherita Pizza", "Calzone",        "Tiramisu",        "Minestrone",
    "Bruschetta",      "Caprese Salad",   "Osso Buco",       "Saltimbocca",     "Arancini",
    // Asian
    "Fried Rice",      "Lo Mein",         "Chow Mein",       "Spring Rolls",    "Egg Rolls",
    "Wonton Soup",     "Hot Pot",         "Bibimbap",        "Bulgogi",         "Kimchi Stew",
    "Tempura",         "Teriyaki",        "Udon",            "Yakisoba",        "Onigiri",
    "Banh Mi",         "Tom Yum",         "Laksa",           "Satay",           "Rendang",
    // Mexican & Latin
    "Enchiladas",      "Quesadilla",      "Fajitas",         "Tamales",         "Nachos",
    "Guacamole",       "Ceviche",         "Empanadas",       "Churros",         "Mole",
    "Tostadas",        "Pozole",          "Carnitas",        "Barbacoa",        "Chile Relleno",
    // Middle Eastern & Mediterranean
    "Falafel",         "Hummus",          "Shawarma",        "Kebab",           "Gyro",
    "Tabbouleh",       "Baba Ganoush",    "Moussaka",        "Dolma",           "Couscous",
    "Tagine",          "Shakshuka",       "Spanakopita",     "Baklava",         "Tzatziki",
    // Indian
    "Tikka Masala",    "Vindaloo",        "Korma",           "Biryani",         "Samosa",
    "Naan",            "Dal",             "Paneer",          "Tandoori",        "Chutney",
    // American Classics
    "Mac and Cheese",  "Meatloaf",        "BBQ Ribs",        "Fried Chicken",   "Hot Dog",
    "Chili",           "Jambalaya",       "Gumbo",           "Clam Chowder",    "Cornbread",
    "Mashed Potatoes", "Coleslaw",        "Biscuits",        "Pancakes",        "Waffles",
    // European
    "Fish and Chips",  "Shepherd's Pie",  "Bangers and Mash", "Beef Wellington", "Yorkshire Pudding",
    "Paella",          "Gazpacho",        "Schnitzel",       "Sauerbraten",     "Rouladen",
    "Quiche",          "Ratatouille",     "Bouillabaisse",   "Cassoulet",       "Fondue",
    // Breakfast
    "Eggs Benedict",   "Omelette",        "French Toast",    "Crepes",          "Granola",
    "Bagel",           "Croissant",       "Muffin",          "Scone",           "Danish",
};

const food_ingredient = [_][]const u8{
    // Basics
    "Tomato",      "Onion",       "Garlic",      "Ginger",      "Pepper",      "Salt",        "Sugar",       "Flour",
    "Butter",      "Oil",         "Milk",        "Eggs",        "Cheese",      "Cream",       "Yogurt",      "Rice",
    "Pasta",       "Bread",       "Potato",      "Carrot",      "Celery",      "Lettuce",     "Spinach",     "Basil",
    // Dairy & Proteins
    "Mozzarella",  "Parmesan",    "Cheddar",     "Feta",        "Goat Cheese", "Blue Cheese", "Ricotta",     "Brie",
    "Sour Cream",  "Buttermilk",  "Heavy Cream", "Half and Half", "Whey",      "Cottage Cheese", "Cream Cheese", "Mascarpone",
    "Chicken",     "Beef",        "Pork",        "Lamb",        "Turkey",      "Duck",        "Venison",     "Veal",
    "Salmon",      "Tuna",        "Cod",         "Halibut",     "Shrimp",      "Crab",        "Lobster",     "Scallops",
    "Bacon",       "Ham",         "Sausage",     "Salami",      "Prosciutto",  "Chorizo",     "Pastrami",    "Pepperoni",
    // Vegetables
    "Broccoli",    "Cauliflower", "Cabbage",     "Kale",        "Bok Choy",    "Brussels Sprouts", "Asparagus", "Artichoke",
    "Cucumber",    "Zucchini",    "Eggplant",    "Squash",      "Pumpkin",     "Bell Pepper", "Jalapeño",    "Habanero",
    "Mushroom",    "Corn",        "Peas",        "Green Beans", "Lima Beans",  "Edamame",     "Snow Peas",   "Chickpeas",
    "Lentils",     "Black Beans", "Kidney Beans", "Pinto Beans", "Navy Beans", "Soybeans",    "Tofu",        "Tempeh",
    "Radish",      "Turnip",      "Beet",        "Parsnip",     "Rutabaga",    "Sweet Potato", "Yam",        "Leek",
    "Scallion",    "Shallot",     "Chives",      "Fennel",      "Chard",       "Collard Greens", "Arugula",  "Watercress",
    // Grains & Starches
    "Quinoa",      "Couscous",    "Bulgur",      "Barley",      "Oats",        "Rye",         "Wheat",       "Cornmeal",
    "Polenta",     "Semolina",    "Farro",       "Millet",      "Amaranth",    "Buckwheat",   "Wild Rice",   "Brown Rice",
    "Basmati",     "Jasmine Rice", "Arborio",    "Sushi Rice",  "Noodles",     "Spaghetti",   "Fettuccine",  "Penne",
    // Seasonings & Condiments
    "Oregano",     "Thyme",       "Rosemary",    "Sage",        "Parsley",     "Cilantro",    "Dill",        "Mint",
    "Bay Leaf",    "Tarragon",    "Marjoram",    "Chervil",     "Savory",      "Lemongrass",  "Cardamom",    "Clove",
    "Nutmeg",      "Cinnamon",    "Allspice",    "Vanilla",     "Saffron",     "Turmeric",    "Cumin",       "Coriander",
    "Paprika",     "Cayenne",     "Chili Powder", "Curry Powder", "Mustard",   "Horseradish", "Wasabi",      "Sriracha",
    "Soy Sauce",   "Fish Sauce",  "Oyster Sauce", "Hoisin",     "Teriyaki",    "Vinegar",     "Balsamic",    "Wine",
    "Stock",       "Broth",       "Bouillon",    "Tomato Paste", "Tomato Sauce", "Salsa",     "Pesto",       "Tahini",
};

const food_fruit = [_][]const u8{
    // Common Fruits
    "Apple",       "Banana",      "Orange",      "Grape",       "Strawberry",  "Blueberry",   "Raspberry",   "Blackberry",
    "Mango",       "Pineapple",   "Watermelon",  "Melon",       "Peach",       "Pear",        "Plum",        "Cherry",
    "Lemon",       "Lime",        "Kiwi",        "Papaya",      "Coconut",     "Avocado",
    // Citrus
    "Grapefruit",  "Tangerine",   "Clementine",  "Mandarin",    "Blood Orange", "Pomelo",     "Yuzu",        "Kumquat",
    // Berries
    "Cranberry",   "Gooseberry",  "Elderberry",  "Boysenberry", "Mulberry",    "Acai",        "Goji Berry",  "Currant",
    // Stone Fruits
    "Apricot",     "Nectarine",   "Persimmon",   "Date",        "Fig",
    // Tropical
    "Passion Fruit", "Dragon Fruit", "Lychee",   "Rambutan",    "Starfruit",   "Guava",       "Durian",      "Jackfruit",
    "Pomegranate", "Cantaloupe",  "Honeydew",    "Plantain",
    // Other
    "Quince",      "Tamarind",    "Breadfruit",  "Soursop",     "Cherimoya",
};

const food_vegetable = [_][]const u8{
    // Root Vegetables
    "Carrot",      "Potato",      "Sweet Potato", "Beet",        "Radish",      "Turnip",      "Parsnip",     "Rutabaga",
    "Ginger",      "Turmeric",    "Horseradish",  "Jicama",      "Taro",        "Yam",         "Cassava",     "Celeriac",
    // Leafy Greens
    "Lettuce",     "Spinach",     "Kale",         "Chard",       "Collard Greens", "Arugula",  "Watercress",  "Mustard Greens",
    "Bok Choy",    "Endive",      "Radicchio",    "Romaine",     "Iceberg",     "Butterhead",  "Mizuna",      "Escarole",
    // Cruciferous
    "Broccoli",    "Cauliflower", "Cabbage",      "Brussels Sprouts", "Kohlrabi", "Romanesco",
    // Alliums
    "Onion",       "Garlic",      "Shallot",      "Leek",        "Scallion",    "Chives",
    // Squashes & Gourds
    "Zucchini",    "Cucumber",    "Pumpkin",      "Squash",      "Eggplant",    "Butternut Squash", "Acorn Squash", "Spaghetti Squash",
    // Peppers
    "Bell Pepper", "Jalapeño",    "Habanero",     "Poblano",     "Serrano",     "Cayenne",     "Anaheim",     "Thai Chili",
    // Others
    "Tomato",      "Corn",        "Peas",         "Green Beans", "Asparagus",   "Celery",      "Artichoke",   "Okra",
    "Mushroom",    "Fennel",      "Rhubarb",      "Bamboo Shoots", "Water Chestnuts",
};

const food_meat = [_][]const u8{
    // Beef & Red Meat
    "Beef",        "Steak",       "Brisket",     "Ribeye",      "Sirloin",     "Tenderloin",  "Chuck",       "Round",
    "Ground Beef", "Veal",        "Lamb",        "Mutton",      "Venison",     "Bison",       "Goat",
    // Poultry
    "Chicken",     "Turkey",      "Duck",        "Goose",       "Quail",       "Pheasant",    "Cornish Hen", "Chicken Breast",
    "Chicken Thigh", "Drumstick", "Wings",       "Ground Turkey",
    // Pork
    "Pork",        "Bacon",       "Ham",         "Pork Chop",   "Pork Loin",   "Pork Belly",  "Ribs",        "Pulled Pork",
    "Sausage",     "Bratwurst",   "Chorizo",     "Salami",      "Pepperoni",   "Prosciutto",  "Pancetta",    "Canadian Bacon",
    // Seafood
    "Salmon",      "Tuna",        "Cod",         "Halibut",     "Mahi Mahi",   "Trout",       "Bass",        "Tilapia",
    "Swordfish",   "Mackerel",    "Sardines",    "Anchovies",   "Herring",     "Catfish",     "Snapper",     "Flounder",
    "Shrimp",      "Crab",        "Lobster",     "Scallops",    "Clams",       "Mussels",     "Oysters",     "Squid",
    "Octopus",     "Calamari",    "Prawns",      "Crayfish",
};

const food_spice = [_][]const u8{
    // Basic Spices
    "Salt",        "Black Pepper", "White Pepper", "Paprika",     "Cumin",       "Coriander",   "Turmeric",    "Cinnamon",
    "Nutmeg",      "Ginger",       "Garlic Powder", "Onion Powder", "Cayenne",    "Chili Powder", "Red Pepper Flakes",
    // Herbs
    "Basil",       "Oregano",      "Thyme",        "Rosemary",    "Sage",        "Parsley",     "Cilantro",    "Dill",
    "Mint",        "Tarragon",     "Marjoram",     "Chervil",     "Bay Leaf",    "Fennel Seed", "Celery Seed",
    // International Spices
    "Cardamom",    "Saffron",      "Star Anise",   "Cloves",      "Allspice",    "Mace",        "Fenugreek",   "Asafoetida",
    "Sumac",       "Za'atar",      "Ras el Hanout", "Garam Masala", "Curry Powder", "Chinese Five Spice", "Harissa",
    "Berbere",     "Adobo",        "Cajun Seasoning", "Jerk Seasoning", "Old Bay",
    // Seeds & Other
    "Mustard Seed", "Poppy Seed",  "Sesame Seed",  "Caraway",     "Anise",       "Vanilla",     "Lemongrass",  "Ginseng",
};

const animal_dog = [_][]const u8{
    "Labrador Retriever", "German Shepherd", "Golden Retriever", "French Bulldog", "Bulldog",
    "Beagle",         "Poodle",          "Rottweiler",       "Yorkshire Terrier", "Boxer",
    "Dachshund",      "Siberian Husky",  "Great Dane",       "Doberman",       "Shih Tzu",
    "Boston Terrier", "Pomeranian",      "Corgi",            "Chihuahua",      "Pit Bull",
    "Border Collie",  "Australian Shepherd", "Cavalier King Charles", "Miniature Schnauzer", "Shiba Inu",
    "Cocker Spaniel", "Maltese",         "English Springer Spaniel", "Bernese Mountain Dog", "Pug",
    "Mastiff",        "Basset Hound",    "Newfoundland",     "Saint Bernard",  "Akita",
    "Bloodhound",     "Weimaraner",      "Vizsla",           "Rhodesian Ridgeback", "Dalmatian",
    "Jack Russell Terrier", "Bichon Frise", "Havanese",      "Samoyed",        "Alaskan Malamute",
    "Afghan Hound",   "Irish Setter",    "Bull Terrier",     "Chow Chow",      "Scottish Terrier",
};

const animal_cat = [_][]const u8{
    "Persian",        "Maine Coon",     "Siamese",        "Ragdoll",        "Bengal",
    "Sphynx",         "British Shorthair", "Abyssinian",  "Birman",         "Oriental Shorthair",
    "Scottish Fold",  "Devon Rex",      "Norwegian Forest", "Russian Blue", "Manx",
    "American Shorthair", "Exotic Shorthair", "Burmese",  "Tonkinese",      "Himalayan",
    "Turkish Angora", "Siberian",       "Savannah",       "Chartreux",      "Cornish Rex",
    "Balinese",       "Ragamuffin",     "Somali",         "Turkish Van",    "Ocicat",
};

const animal_bird = [_][]const u8{
    "Sparrow",      "Robin",        "Eagle",        "Hawk",         "Owl",
    "Parrot",       "Canary",       "Finch",        "Pigeon",       "Crow",
    "Raven",        "Hummingbird",  "Woodpecker",   "Cardinal",     "Blue Jay",
    "Falcon",       "Osprey",       "Vulture",      "Pelican",      "Albatross",
    "Penguin",      "Flamingo",     "Swan",         "Duck",         "Goose",
    "Peacock",      "Toucan",       "Cockatoo",     "Macaw",        "Parakeet",
    "Cockatiel",    "Budgerigar",   "Lovebird",     "Seagull",      "Tern",
    "Crane",        "Stork",        "Heron",        "Egret",        "Kingfisher",
};

const animal_fish = [_][]const u8{
    "Goldfish",     "Koi",          "Betta",        "Guppy",        "Angelfish",
    "Tetra",        "Molly",        "Swordtail",    "Platy",        "Catfish",
    "Cichlid",      "Oscar",        "Discus",       "Barb",         "Danio",
    "Clownfish",    "Tang",         "Damselfish",   "Wrasse",       "Goby",
    "Blenny",       "Rainbowfish",  "Rasbora",      "Loach",        "Gourami",
    "Pufferfish",   "Lionfish",     "Grouper",      "Snapper",      "Barracuda",
};

const animal_horse = [_][]const u8{
    "Arabian",          "Thoroughbred",     "Quarter Horse",    "Mustang",          "Appaloosa",
    "Morgan",           "Paint",            "Palomino",         "Clydesdale",       "Percheron",
    "Belgian",          "Shire",            "Friesian",         "Andalusian",       "Lipizzaner",
    "Tennessee Walking", "Standardbred",    "Shetland Pony",    "Welsh Pony",       "Haflinger",
    "Icelandic Horse",  "Gypsy Vanner",     "Akhal-Teke",       "Marwari",          "Connemara",
};

const animal_farm = [_][]const u8{
    "Cow",          "Pig",          "Sheep",        "Goat",         "Chicken",
    "Duck",         "Goose",        "Turkey",       "Horse",        "Donkey",
    "Mule",         "Llama",        "Alpaca",       "Rabbit",       "Guinea Pig",
    "Rooster",      "Hen",          "Lamb",         "Calf",         "Piglet",
    "Foal",         "Kid",          "Chick",        "Duckling",     "Gosling",
};

const animal_insect = [_][]const u8{
    "Ant",          "Bee",          "Wasp",         "Butterfly",    "Moth",
    "Dragonfly",    "Damselfly",    "Grasshopper",  "Cricket",      "Katydid",
    "Beetle",       "Ladybug",      "Firefly",      "Cockroach",    "Termite",
    "Fly",          "Mosquito",     "Gnat",         "Horsefly",     "Housefly",
    "Flea",         "Tick",         "Louse",        "Mantis",       "Walking Stick",
    "Cicada",       "Aphid",        "Scale Insect", "Mealworm",     "Silkworm",
};

const animal_wild = [_][]const u8{
    "Lion",         "Tiger",        "Bear",         "Wolf",         "Fox",
    "Elephant",     "Rhinoceros",   "Hippopotamus", "Giraffe",      "Zebra",
    "Deer",         "Moose",        "Elk",          "Caribou",      "Antelope",
    "Buffalo",      "Bison",        "Gazelle",      "Wildebeest",   "Gnu",
    "Leopard",      "Cheetah",      "Jaguar",       "Panther",      "Cougar",
    "Lynx",         "Bobcat",       "Coyote",       "Hyena",        "Jackal",
    "Monkey",       "Gorilla",      "Chimpanzee",   "Orangutan",    "Baboon",
    "Lemur",        "Gibbon",       "Sloth",        "Armadillo",    "Anteater",
    "Porcupine",    "Hedgehog",     "Beaver",       "Otter",        "Seal",
    "Walrus",       "Sea Lion",     "Dolphin",      "Whale",        "Shark",
    "Crocodile",    "Alligator",    "Lizard",       "Iguana",       "Gecko",
    "Snake",        "Python",       "Cobra",        "Rattlesnake",  "Viper",
    "Frog",         "Toad",         "Salamander",   "Newt",         "Kangaroo",
    "Koala",        "Platypus",     "Wombat",       "Tasmanian Devil", "Opossum",
    "Raccoon",      "Skunk",        "Badger",       "Meerkat",      "Prairie Dog",
};

// Realistic name frequency weights (higher = more common)
// Based on actual name popularity data - top names are much more common
const first_name_male_weights = [_]f64{
    // Top 10 names - very common (3.0-2.0)
    3.0, 2.9, 2.8, 2.7, 2.6, 2.5, 2.4, 2.3, 2.2, 2.1,
    // Names 11-30 - common (2.0-1.2)
    2.0, 1.9, 1.8, 1.7, 1.6, 1.5, 1.4, 1.3, 1.2, 1.1,
    1.0, 0.9, 0.8, 0.7, 0.6, 0.5, 0.4, 0.3, 0.2, 0.1,
    // Names 31-60 - less common (1.0-0.5)
    0.9, 0.8, 0.7, 0.6, 0.5, 0.4, 0.3, 0.2, 0.1, 0.09,
    0.8, 0.7, 0.6, 0.5, 0.4, 0.3, 0.2, 0.1, 0.09, 0.08,
    // Names 51-80 - uncommon (0.5-0.1)
    0.7, 0.6, 0.5, 0.4, 0.3, 0.2, 0.1, 0.09, 0.08, 0.07,
    0.6, 0.5, 0.4, 0.3, 0.2, 0.1, 0.09, 0.08, 0.07, 0.06,
    // Remaining names - rare (0.1)
    0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1,
    0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1,
};

const first_name_female_weights = [_]f64{
    // Top 10 names - very common
    3.0, 2.9, 2.8, 2.7, 2.6, 2.5, 2.4, 2.3, 2.2, 2.1,
    // Names 11-30 - common
    2.0, 1.9, 1.8, 1.7, 1.6, 1.5, 1.4, 1.3, 1.2, 1.1,
    1.0, 0.9, 0.8, 0.7, 0.6, 0.5, 0.4, 0.3, 0.2, 0.1,
    // Names 31-60 - less common
    0.9, 0.8, 0.7, 0.6, 0.5, 0.4, 0.3, 0.2, 0.1, 0.09,
    0.8, 0.7, 0.6, 0.5, 0.4, 0.3, 0.2, 0.1, 0.09, 0.08,
    // Names 51-80 - uncommon
    0.7, 0.6, 0.5, 0.4, 0.3, 0.2, 0.1, 0.09, 0.08, 0.07,
    0.6, 0.5, 0.4, 0.3, 0.2, 0.1, 0.09, 0.08, 0.07, 0.06,
    // Remaining names - rare
    0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1,
    0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1,
};

const last_name_weights = [_]f64{
    // Top 10 surnames - very common (Smith, Johnson, etc.)
    4.0, 3.5, 3.0, 2.8, 2.6, 2.4, 2.2, 2.0, 1.9, 1.8,
    // Names 11-30 - common
    1.7, 1.6, 1.5, 1.4, 1.3, 1.2, 1.1, 1.0, 0.9, 0.8,
    0.7, 0.6, 0.5, 0.4, 0.3, 0.2, 0.1, 0.09, 0.08, 0.07,
    // Names 31-60 - less common
    0.6, 0.5, 0.4, 0.3, 0.2, 0.1, 0.09, 0.08, 0.07, 0.06,
    0.5, 0.4, 0.3, 0.2, 0.1, 0.09, 0.08, 0.07, 0.06, 0.05,
    // Names 51-80 - uncommon
    0.4, 0.3, 0.2, 0.1, 0.09, 0.08, 0.07, 0.06, 0.05, 0.04,
    0.3, 0.2, 0.1, 0.09, 0.08, 0.07, 0.06, 0.05, 0.04, 0.03,
    // Remaining names - rare
    0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1,
    0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1,
};

// Country distribution weights (based on world population)
const country_weights = [_]f64{
    // Major countries by population
    10.0,  // United States
    18.5,  // China
    17.5,  // India
    3.4,   // Indonesia
    2.7,   // Brazil
    2.1,   // Pakistan
    2.0,   // Nigeria
    1.7,   // Bangladesh
    1.6,   // Russia
    1.3,   // Mexico
    1.3,   // Japan
    1.1,   // Philippines
    1.0,   // Egypt
    1.0,   // Vietnam
    0.9,   // Germany
    0.9,   // Iran
    0.8,   // Turkey
    0.7,   // Thailand
    0.7,   // United Kingdom
    0.7,   // France
    0.7,   // Italy
    0.6,   // South Africa
    0.6,   // South Korea
    0.6,   // Spain
    0.5,   // Canada
    0.5,   // Australia
    0.3,   // Netherlands
    0.2,   // Sweden
    0.2,   // Norway
    0.2,   // Denmark
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
        .first_name_male_weights = &first_name_male_weights,
        .first_name_female_weights = &first_name_female_weights,
        .last_name_weights = &last_name_weights,
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
        .country_weights = &country_weights,
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
        .horse = &animal_horse,
        .farm = &animal_farm,
        .insect = &animal_insect,
        .wild = &animal_wild,
    },
};
