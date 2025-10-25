const std = @import("std");
const Random = @import("../random.zig").Random;

pub const Word = struct {
    allocator: std.mem.Allocator,

    pub fn init(allocator: std.mem.Allocator) Word {
        return Word{
            .allocator = allocator,
        };
    }

    const adjectives_list = [_][]const u8{
        // Basic descriptions
        "beautiful", "ugly",      "pretty",    "handsome",  "attractive", "plain",     "gorgeous",  "stunning",
        "happy",     "sad",       "joyful",    "miserable", "cheerful",  "gloomy",    "delighted", "depressed",
        "large",     "small",     "big",       "tiny",      "huge",      "enormous",  "gigantic",  "miniature",
        "tall",      "short",     "high",      "low",       "wide",      "narrow",    "broad",     "slim",
        // Speed & Movement
        "fast",      "slow",      "quick",     "rapid",     "swift",     "sluggish",  "speedy",    "gradual",
        "sudden",    "immediate", "instant",   "delayed",   "prompt",    "hasty",     "leisurely", "brisk",
        // Light & Color
        "bright",    "dark",      "light",     "dim",       "brilliant", "shadowy",   "radiant",   "murky",
        "colorful",  "dull",      "vivid",     "pale",      "vibrant",   "faded",     "luminous",  "gloomy",
        // Texture & Feel
        "smooth",    "rough",     "soft",      "hard",      "silky",     "coarse",    "tender",    "rigid",
        "slippery",  "sticky",    "wet",       "dry",       "moist",     "arid",      "damp",      "parched",
        "fluffy",    "crisp",     "creamy",    "crunchy",   "gooey",     "brittle",   "elastic",   "stiff",
        // Temperature
        "hot",       "cold",      "warm",      "cool",      "freezing",  "boiling",   "tepid",     "scorching",
        "chilly",    "mild",      "tropical",  "arctic",    "sweltering", "frigid",   "balmy",     "icy",
        // Quality & Condition
        "good",      "bad",       "excellent", "poor",      "superior",  "inferior",  "fine",      "terrible",
        "perfect",   "flawed",    "pristine",  "damaged",   "intact",    "broken",    "whole",     "partial",
        "fresh",     "stale",     "new",       "old",       "modern",    "ancient",   "recent",    "outdated",
        "clean",     "dirty",     "pure",      "polluted",  "spotless",  "filthy",    "tidy",      "messy",
        // Strength & Power
        "strong",    "weak",      "powerful",  "feeble",    "mighty",    "frail",     "sturdy",    "delicate",
        "robust",    "fragile",   "tough",     "gentle",    "firm",      "soft",      "solid",     "flimsy",
        // Intelligence & Mental
        "smart",     "stupid",    "intelligent", "dumb",    "clever",    "foolish",   "wise",      "silly",
        "brilliant", "ignorant",  "sharp",     "dull",      "astute",    "naive",     "shrewd",    "gullible",
        // Personality & Character
        "kind",      "cruel",     "nice",      "mean",      "friendly",  "hostile",   "polite",    "rude",
        "generous",  "selfish",   "humble",    "arrogant",  "modest",    "boastful",  "sincere",   "fake",
        "honest",    "dishonest", "loyal",     "disloyal",  "faithful",  "unfaithful", "reliable", "unreliable",
        "patient",   "impatient", "calm",      "anxious",   "peaceful",  "agitated",  "relaxed",   "tense",
        "brave",     "cowardly",  "bold",      "timid",     "fearless",  "afraid",    "daring",    "cautious",
        "confident", "insecure",  "proud",     "ashamed",   "determined", "hesitant", "ambitious", "lazy",
        // Age & Time
        "young",     "old",       "youthful",  "elderly",   "new",       "ancient",   "fresh",     "aged",
        "modern",    "vintage",   "current",   "obsolete",  "recent",    "historic",  "contemporary", "antique",
        // Size & Amount
        "full",      "empty",     "complete",  "incomplete", "whole",    "partial",   "total",     "fractional",
        "abundant",  "scarce",    "plentiful", "rare",      "ample",     "limited",   "copious",   "sparse",
        "thick",     "thin",      "dense",     "sparse",    "heavy",     "light",     "weighty",   "slight",
        // Importance & Value
        "important", "trivial",   "significant", "minor",   "crucial",   "irrelevant", "vital",    "petty",
        "valuable",  "worthless", "precious",  "cheap",     "expensive", "affordable", "costly",   "economical",
        "essential", "optional",  "necessary", "unnecessary", "required", "voluntary", "mandatory", "discretionary",
        // Difficulty & Complexity
        "easy",      "difficult", "simple",    "complex",   "hard",      "effortless", "challenging", "straightforward",
        "clear",     "confusing", "obvious",   "obscure",   "plain",     "intricate", "basic",     "advanced",
        // Sound
        "loud",      "quiet",     "noisy",     "silent",    "deafening", "hushed",    "thunderous", "muted",
        "shrill",    "melodious", "harsh",     "soothing",  "piercing",  "gentle",    "raucous",   "peaceful",
        // Taste & Smell
        "sweet",     "bitter",    "sour",      "salty",     "spicy",     "bland",     "savory",    "tangy",
        "delicious", "disgusting", "tasty",    "awful",     "yummy",     "nasty",     "flavorful", "tasteless",
        "fragrant",  "smelly",    "aromatic",  "pungent",   "fresh",     "stale",     "pleasant",  "foul",
        // Shape & Form
        "round",     "square",    "circular",  "rectangular", "oval",    "triangular", "curved",   "straight",
        "flat",      "bumpy",     "even",      "uneven",    "level",     "slanted",   "smooth",    "jagged",
        // Distance & Space
        "near",      "far",       "close",     "distant",   "remote",    "adjacent",  "neighboring", "faraway",
        "deep",      "shallow",   "profound",  "superficial", "wide",    "narrow",    "spacious",  "cramped",
        // Truth & Reality
        "true",      "false",     "real",      "fake",      "genuine",   "counterfeit", "authentic", "artificial",
        "actual",    "imaginary", "factual",   "fictional", "concrete",  "abstract",  "literal",   "figurative",
        // Emotion & Feeling
        "excited",   "bored",     "interested", "indifferent", "enthusiastic", "apathetic", "eager", "reluctant",
        "hopeful",   "hopeless",  "optimistic", "pessimistic", "content", "dissatisfied", "satisfied", "frustrated",
        "angry",     "peaceful",  "furious",   "serene",    "irritated", "tranquil",  "enraged",   "placid",
        // Social & Relations
        "popular",   "unpopular", "famous",    "unknown",   "social",    "antisocial", "outgoing", "shy",
        "public",    "private",   "open",      "secretive", "transparent", "mysterious", "obvious", "hidden",
        // Activity & Energy
        "active",    "passive",   "energetic", "lethargic", "dynamic",   "static",    "lively",    "lifeless",
        "busy",      "idle",      "productive", "unproductive", "efficient", "wasteful", "vigorous", "sluggish",
        // Comparison & Relation
        "similar",   "different", "same",      "opposite",  "alike",     "unlike",    "equal",     "unequal",
        "better",    "worse",     "superior",  "inferior",  "greater",   "lesser",    "higher",    "lower",
        // Safety & Danger
        "safe",      "dangerous", "secure",    "risky",     "protected", "vulnerable", "harmless", "harmful",
        "cautious",  "reckless",  "careful",   "careless",  "prudent",   "foolhardy", "guarded",   "exposed",
        // Health & Wellness
        "healthy",   "sick",      "fit",       "unfit",     "well",      "ill",       "robust",    "weak",
        "vigorous",  "feeble",    "sound",     "diseased",  "wholesome", "unhealthy", "vital",     "ailing",
        // Weather & Nature
        "sunny",     "cloudy",    "rainy",     "snowy",     "windy",     "calm",      "stormy",    "clear",
        "humid",     "dry",       "foggy",     "misty",     "breezy",    "still",     "temperate", "extreme",
        // Miscellaneous
        "ordinary",  "extraordinary", "normal", "abnormal",  "typical",   "unusual",   "common",    "rare",
        "general",   "specific",  "broad",     "narrow",    "vague",     "precise",   "rough",     "exact",
        "wild",      "tame",      "domestic",  "feral",     "civilized", "primitive", "refined",   "crude",
        "formal",    "informal",  "official",  "unofficial", "proper",   "improper",  "correct",   "incorrect",
        "positive",  "negative",  "constructive", "destructive", "helpful", "harmful",  "beneficial", "detrimental",
    };

    const adverbs_list = [_][]const u8{
        // Manner (how something is done)
        "quickly",     "slowly",      "carefully",   "carelessly",  "happily",     "sadly",       "joyfully",    "miserably",
        "quietly",     "loudly",      "gently",      "roughly",     "smoothly",    "awkwardly",   "gracefully",  "clumsily",
        "easily",      "hardly",      "softly",      "harshly",     "kindly",      "cruelly",     "politely",    "rudely",
        "bravely",     "cowardly",    "boldly",      "timidly",     "wisely",      "foolishly",   "honestly",    "deceptively",
        "patiently",   "impatiently", "calmly",      "anxiously",   "peacefully",  "violently",   "tenderly",    "brutally",
        "elegantly",   "messily",     "neatly",      "sloppily",    "precisely",   "vaguely",     "clearly",     "confusingly",
        "successfully", "unsuccessfully", "efficiently", "inefficiently", "perfectly", "poorly",   "excellently", "terribly",
        // Degree (to what extent)
        "very",        "extremely",   "incredibly",  "remarkably",  "exceptionally", "unusually", "particularly", "especially",
        "quite",       "rather",      "fairly",      "somewhat",    "slightly",    "barely",      "hardly",      "scarcely",
        "too",         "enough",      "sufficiently", "insufficiently", "totally",  "partially",   "completely",  "almost",
        "nearly",      "almost",      "approximately", "exactly",    "precisely",   "roughly",     "about",       "around",
        "more",        "less",        "most",        "least",       "much",        "little",      "far",         "way",
        "so",          "such",        "as",          "how",         "however",     "whatever",    "whenever",    "wherever",
        // Frequency (how often)
        "always",      "never",       "often",       "rarely",      "usually",     "seldom",      "frequently",  "occasionally",
        "sometimes",   "constantly",  "continually", "continuously", "regularly",   "irregularly", "periodically", "sporadically",
        "daily",       "weekly",      "monthly",     "yearly",      "hourly",      "repeatedly",  "routinely",   "habitually",
        // Time (when)
        "now",         "then",        "today",       "yesterday",   "tomorrow",    "soon",        "later",       "earlier",
        "recently",    "lately",      "formerly",    "previously",  "currently",   "presently",   "eventually",  "finally",
        "already",     "still",       "yet",         "just",        "immediately", "instantly",   "promptly",    "shortly",
        "early",       "late",        "beforehand",  "afterward",   "meanwhile",   "simultaneously", "temporarily", "permanently",
        // Place (where)
        "here",        "there",       "everywhere",  "nowhere",     "somewhere",   "anywhere",    "nearby",      "far",
        "inside",      "outside",     "upstairs",    "downstairs",  "abroad",      "away",        "back",        "forward",
        "above",       "below",       "underneath",  "overhead",    "nearby",      "distant",     "close",       "remotely",
        // Certainty & Probability
        "certainly",   "definitely",  "surely",      "probably",    "possibly",    "maybe",       "perhaps",     "likely",
        "unlikely",    "obviously",   "clearly",     "undoubtedly", "apparently",  "evidently",   "presumably",  "supposedly",
        // Attitude & Opinion
        "fortunately", "unfortunately", "luckily",   "unluckily",   "happily",     "sadly",       "surprisingly", "unsurprisingly",
        "naturally",   "ironically",  "admittedly",  "frankly",     "honestly",    "seriously",   "truly",       "really",
        // Others
        "well",        "better",      "best",        "worse",       "worst",       "badly",       "bad",         "good",
        "fast",        "faster",      "fastest",     "slow",        "slower",      "slowest",     "hard",        "harder",
        "strongly",    "weakly",      "firmly",      "loosely",     "tightly",     "freely",      "broadly",     "narrowly",
        "directly",    "indirectly",  "openly",      "secretly",    "publicly",    "privately",   "personally",  "impersonally",
    };

    const conjunctions_list = [_][]const u8{
        "and",     "but",     "or",      "nor",     "for",     "yet",
        "so",      "because", "although", "since",   "unless",  "while",
        "if",      "when",    "where",   "after",   "before",  "though",
    };

    const interjections_list = [_][]const u8{
        "wow",     "oh",      "hey",     "oops",    "ouch",    "aha",
        "hooray",  "yay",     "yikes",   "ugh",     "hmm",     "shh",
        "whoa",    "alas",    "bravo",   "hello",   "goodbye", "please",
    };

    const nouns_list = [_][]const u8{
        // People & Relationships
        "person",   "man",      "woman",    "child",    "baby",     "boy",      "girl",     "adult",
        "teenager", "elder",    "parent",   "mother",   "father",   "son",      "daughter", "sibling",
        "brother",  "sister",   "family",   "relative", "grandparent", "uncle", "aunt",     "cousin",
        "friend",   "neighbor", "stranger", "acquaintance", "enemy", "rival",   "partner",  "spouse",
        "husband",  "wife",     "couple",   "team",     "group",    "crowd",    "audience", "community",
        // Occupations
        "teacher",  "doctor",   "nurse",    "lawyer",   "engineer", "scientist", "artist",  "writer",
        "musician", "actor",    "director", "producer", "photographer", "designer", "architect", "chef",
        "farmer",   "fisher",   "hunter",   "miner",    "worker",   "employee", "boss",     "manager",
        "president", "king",    "queen",    "prince",   "princess", "knight",   "soldier",  "officer",
        "pilot",    "driver",   "captain",  "sailor",   "astronaut", "explorer", "guide",   "leader",
        "student",  "pupil",    "scholar",  "graduate", "professor", "researcher", "expert", "specialist",
        "athlete",  "player",   "coach",    "trainer",  "referee",  "judge",    "jury",     "witness",
        "customer", "client",   "buyer",    "seller",   "merchant", "trader",   "vendor",   "dealer",
        // Animals
        "dog",      "cat",      "mouse",    "rat",      "rabbit",   "hamster",  "bird",     "fish",
        "horse",    "cow",      "pig",      "sheep",    "goat",     "chicken",  "duck",     "goose",
        "lion",     "tiger",    "bear",     "wolf",     "fox",      "deer",     "elephant", "giraffe",
        "monkey",   "ape",      "snake",    "lizard",   "frog",     "turtle",   "whale",    "dolphin",
        "shark",    "octopus",  "squid",    "crab",     "lobster",  "insect",   "butterfly", "bee",
        // Buildings & Places
        "house",    "home",     "apartment", "building", "castle",   "palace",   "mansion",  "cottage",
        "hotel",    "motel",    "inn",      "restaurant", "cafe",   "bar",      "pub",      "club",
        "school",   "university", "college", "library", "museum",   "theater",  "cinema",   "stadium",
        "hospital", "clinic",   "pharmacy", "bank",     "office",   "factory",  "warehouse", "shop",
        "store",    "mall",     "market",   "supermarket", "bakery", "butcher", "garage",  "station",
        "church",   "temple",   "mosque",   "cathedral", "chapel",  "shrine",   "monastery", "abbey",
        "prison",   "jail",     "fort",     "tower",    "bridge",   "tunnel",   "road",     "street",
        "park",     "garden",   "yard",     "field",    "farm",     "ranch",    "orchard",  "vineyard",
        // Geographic Features
        "city",     "town",     "village",  "country",  "nation",   "state",    "province", "region",
        "continent", "island",  "peninsula", "coast",    "shore",    "beach",    "bay",      "harbor",
        "mountain", "hill",     "valley",   "canyon",   "cliff",    "peak",     "summit",   "slope",
        "forest",   "woods",    "jungle",   "desert",   "plain",    "meadow",   "prairie",  "swamp",
        "river",    "stream",   "creek",    "brook",    "lake",     "pond",     "ocean",    "sea",
        "cave",     "cavern",   "volcano",  "crater",   "glacier",  "iceberg",  "tundra",   "plateau",
        // Nature & Weather
        "tree",     "plant",    "flower",   "grass",    "bush",     "shrub",    "vine",     "moss",
        "leaf",     "branch",   "trunk",    "root",     "seed",     "fruit",    "vegetable", "crop",
        "sun",      "moon",     "star",     "planet",   "comet",    "asteroid", "meteor",   "galaxy",
        "sky",      "cloud",    "rain",     "snow",     "hail",     "sleet",    "fog",      "mist",
        "wind",     "breeze",   "storm",    "hurricane", "tornado", "thunder",  "lightning", "rainbow",
        "fire",     "flame",    "smoke",    "ash",      "ember",    "spark",    "blaze",    "inferno",
        "water",    "ice",      "steam",    "dew",      "frost",    "wave",     "tide",     "current",
        "earth",    "soil",     "dirt",     "mud",      "sand",     "rock",     "stone",    "pebble",
        // Objects & Things
        "thing",    "object",   "item",     "piece",    "part",     "component", "element", "material",
        "tool",     "instrument", "device", "machine",  "equipment", "apparatus", "gadget", "contraption",
        "book",     "magazine", "newspaper", "journal", "article",  "letter",   "document", "paper",
        "pen",      "pencil",   "marker",   "crayon",   "brush",    "eraser",   "ruler",    "scissors",
        "computer", "laptop",   "tablet",   "phone",    "keyboard", "mouse",    "screen",   "monitor",
        "camera",   "lens",     "tripod",   "flash",    "film",     "photo",    "picture",  "image",
        "table",    "desk",     "chair",    "sofa",     "couch",    "bed",      "cabinet",  "shelf",
        "door",     "window",   "wall",     "floor",    "ceiling",  "roof",     "stairs",   "ladder",
        "box",      "container", "bag",     "basket",   "bottle",   "jar",      "can",      "cup",
        "plate",    "bowl",     "fork",     "knife",    "spoon",    "pot",      "pan",      "oven",
        "car",      "truck",    "bus",      "train",    "plane",    "boat",     "ship",     "bicycle",
        "wheel",    "tire",     "engine",   "motor",    "battery",  "fuel",     "gas",      "oil",
        "clock",    "watch",    "timer",    "alarm",    "calendar", "schedule", "agenda",   "plan",
        "mirror",   "glass",    "lens",     "crystal",  "diamond",  "gem",      "jewel",    "treasure",
        "key",      "lock",     "chain",    "rope",     "wire",     "cable",    "cord",     "string",
        "cloth",    "fabric",   "textile",  "thread",   "yarn",     "needle",   "button",   "zipper",
        "ring",     "bracelet", "necklace", "earring",  "crown",    "tiara",    "medal",    "badge",
        "coin",     "bill",     "money",    "cash",     "dollar",   "cent",     "penny",    "fortune",
        "weapon",   "sword",    "knife",    "dagger",   "gun",      "rifle",    "pistol",   "cannon",
        "shield",   "armor",    "helmet",   "mask",     "uniform",  "costume",  "dress",    "suit",
        // Food & Drink
        "food",     "meal",     "dish",     "recipe",   "ingredient", "spice",  "herb",     "sauce",
        "bread",    "cake",     "cookie",   "pie",      "pastry",   "donut",    "muffin",   "biscuit",
        "meat",     "beef",     "pork",     "chicken",  "fish",     "seafood",  "egg",      "cheese",
        "fruit",    "apple",    "orange",   "banana",   "grape",    "berry",    "melon",    "peach",
        "vegetable", "carrot",  "potato",   "tomato",   "onion",    "pepper",   "lettuce",  "cabbage",
        "drink",    "water",    "juice",    "milk",     "coffee",   "tea",      "soda",     "wine",
        "beer",     "cocktail", "smoothie", "shake",    "soup",     "broth",    "stew",     "gravy",
        // Abstract Concepts
        "life",     "death",    "birth",    "existence", "being",   "soul",     "spirit",   "mind",
        "thought",  "idea",     "concept",  "notion",   "theory",   "principle", "rule",    "law",
        "love",     "hate",     "like",     "dislike",  "emotion",  "feeling",  "passion",  "desire",
        "hope",     "fear",     "joy",      "sorrow",   "happiness", "sadness", "anger",    "rage",
        "peace",    "war",      "conflict", "battle",   "fight",    "struggle", "effort",   "attempt",
        "time",     "moment",   "instant",  "second",   "minute",   "hour",     "day",      "week",
        "month",    "year",     "decade",   "century",  "age",      "era",      "period",   "season",
        "past",     "present",  "future",   "history",  "memory",   "tradition", "custom",  "culture",
        "truth",    "lie",      "fact",     "fiction",  "reality",  "fantasy",  "dream",    "nightmare",
        "good",     "evil",     "right",    "wrong",    "justice",  "crime",    "sin",      "virtue",
        "power",    "strength", "force",    "energy",   "might",    "weakness", "ability",  "skill",
        "knowledge", "wisdom",  "intelligence", "ignorance", "understanding", "confusion", "clarity", "mystery",
        "art",      "music",    "song",     "dance",    "poetry",   "literature", "story",  "tale",
        "science",  "math",     "physics",  "chemistry", "biology", "astronomy", "geology", "ecology",
        "language", "word",     "sentence", "phrase",   "grammar",  "vocabulary", "speech", "voice",
        "sound",    "noise",    "music",    "melody",   "harmony",  "rhythm",   "beat",     "tone",
        "color",    "hue",      "shade",    "tint",     "light",    "darkness", "shadow",   "brightness",
        "space",    "room",     "area",     "zone",     "region",   "territory", "domain",  "realm",
        "world",    "universe", "cosmos",   "galaxy",   "dimension", "plane",   "sphere",   "orbit",
        "number",   "digit",    "figure",   "amount",   "quantity", "total",    "sum",      "value",
        "size",     "length",   "width",    "height",   "depth",    "distance", "range",    "scale",
        "shape",    "form",     "structure", "pattern", "design",   "style",    "fashion",  "trend",
        "quality",  "property", "feature",  "characteristic", "trait", "attribute", "aspect", "nature",
        "change",   "difference", "variation", "contrast", "similarity", "comparison", "relation", "connection",
        "cause",    "effect",   "result",   "consequence", "outcome", "impact",  "influence", "factor",
        "problem",  "issue",    "question", "answer",   "solution", "resolution", "fix",    "remedy",
        "success",  "failure",  "victory",  "defeat",   "triumph",  "loss",     "win",      "achievement",
        "goal",     "aim",      "target",   "objective", "purpose", "mission",  "vision",   "ambition",
        "plan",     "strategy", "tactic",   "method",   "approach", "technique", "procedure", "process",
        "system",   "network",  "framework", "platform", "foundation", "base",  "ground",   "core",
        "beginning", "start",   "origin",   "source",   "end",      "finish",   "conclusion", "finale",
        "part",     "whole",    "section",  "segment",  "portion",  "fraction", "piece",    "fragment",
        "way",      "path",     "route",    "road",     "trail",    "track",    "course",   "direction",
        "chance",   "opportunity", "possibility", "probability", "risk", "danger", "threat",  "hazard",
        "safety",   "security", "protection", "defense", "guard",   "shield",   "shelter",  "refuge",
        "freedom",  "liberty",  "independence", "autonomy", "rights", "privilege", "duty",   "responsibility",
        "work",     "job",      "task",     "assignment", "project", "duty",    "chore",    "labor",
        "play",     "game",     "sport",    "activity", "hobby",    "pastime",  "recreation", "entertainment",
        "health",   "fitness",  "wellness", "sickness", "disease",  "illness",  "injury",   "pain",
        "medicine", "drug",     "pill",     "tablet",   "vaccine",  "treatment", "therapy", "cure",
        "education", "learning", "teaching", "training", "study",   "lesson",   "class",    "course",
        "religion", "faith",    "belief",   "worship",  "prayer",   "ritual",   "ceremony", "tradition",
        "economy",  "business", "trade",    "commerce", "market",   "industry", "company",  "corporation",
        "politics", "government", "state",  "nation",   "democracy", "republic", "empire",  "kingdom",
        "society",  "civilization", "culture", "community", "population", "public", "people", "citizen",
        "technology", "innovation", "invention", "discovery", "progress", "development", "advancement", "improvement",
    };

    const prepositions_list = [_][]const u8{
        "in",      "on",      "at",      "by",      "with",    "from",
        "to",      "for",     "of",      "about",   "above",   "below",
        "under",   "over",    "through", "between", "among",   "behind",
        "before",  "after",   "during",  "within",  "without", "toward",
    };

    const verbs_list = [_][]const u8{
        // Movement & Travel
        "walk",     "run",      "jog",      "sprint",   "dash",     "race",     "hurry",    "rush",
        "crawl",    "climb",    "jump",     "leap",     "hop",      "skip",     "bounce",   "roll",
        "slide",    "slip",     "fall",     "trip",     "stumble",  "tumble",   "rise",     "stand",
        "sit",      "lie",      "kneel",    "crouch",   "bend",     "stretch",  "reach",    "grab",
        "fly",      "soar",     "glide",    "float",    "drift",    "hover",    "land",     "crash",
        "swim",     "dive",     "splash",   "wade",     "surf",     "sail",     "row",      "paddle",
        "drive",    "ride",     "travel",   "journey",  "wander",   "roam",     "explore",  "navigate",
        "go",       "come",     "arrive",   "leave",    "depart",   "return",   "enter",    "exit",
        "pass",     "cross",    "follow",   "lead",     "guide",    "chase",    "pursue",   "escape",
        // Communication & Expression
        "talk",     "speak",    "say",      "tell",     "ask",      "answer",   "reply",    "respond",
        "chat",     "converse", "discuss",  "debate",   "argue",    "quarrel",  "fight",    "disagree",
        "agree",    "confirm",  "deny",     "refuse",   "accept",   "approve",  "reject",   "decline",
        "whisper",  "murmur",   "mumble",   "shout",    "yell",     "scream",   "cry",      "weep",
        "laugh",    "giggle",   "chuckle",  "smile",    "grin",     "frown",    "scowl",    "glare",
        "sing",     "hum",      "chant",    "recite",   "announce", "declare",  "proclaim", "state",
        "explain",  "describe", "define",   "clarify",  "interpret", "translate", "express", "articulate",
        "write",    "type",     "compose",  "draft",    "edit",     "revise",   "correct",  "erase",
        "read",     "scan",     "skim",     "study",    "examine",  "review",   "analyze",  "evaluate",
        "call",     "phone",    "text",     "message",  "email",    "contact",  "reach",    "notify",
        // Perception & Cognition
        "see",      "watch",    "observe",  "notice",   "spot",     "glimpse",  "view",     "witness",
        "look",     "stare",    "gaze",     "glance",   "peek",     "peer",     "squint",   "blink",
        "hear",     "listen",   "overhear", "eavesdrop", "sound",   "echo",     "ring",     "chime",
        "feel",     "touch",    "handle",   "hold",     "grip",     "grasp",    "squeeze",  "press",
        "taste",    "savor",    "sample",   "sip",      "gulp",     "swallow",  "chew",     "bite",
        "smell",    "sniff",    "inhale",   "breathe",  "exhale",   "gasp",     "pant",     "sigh",
        "think",    "ponder",   "consider", "contemplate", "reflect", "meditate", "wonder", "imagine",
        "know",     "understand", "comprehend", "grasp", "realize",  "recognize", "identify", "distinguish",
        "remember", "recall",   "recollect", "forget",  "memorize", "learn",    "discover", "find",
        "believe",  "doubt",    "trust",    "suspect",  "assume",   "suppose",  "presume",  "guess",
        "decide",   "choose",   "select",   "pick",     "prefer",   "opt",      "determine", "resolve",
        // Emotion & Desire
        "love",     "adore",    "cherish",  "treasure", "worship",  "idolize",  "admire",   "respect",
        "like",     "enjoy",    "appreciate", "fancy",  "prefer",   "favor",    "value",    "prize",
        "hate",     "detest",   "despise",  "loathe",   "abhor",    "dislike",  "resent",   "mind",
        "want",     "desire",   "wish",     "hope",     "long",     "crave",    "yearn",    "hunger",
        "need",     "require",  "demand",   "request",  "seek",     "search",   "hunt",     "look",
        "fear",     "dread",    "worry",    "panic",    "frighten", "scare",    "terrify",  "alarm",
        "care",     "concern",  "matter",   "bother",   "trouble",  "disturb",  "annoy",    "irritate",
        // Action & Change
        "do",       "act",      "perform",  "execute",  "carry",    "conduct",  "practice", "exercise",
        "make",     "create",   "produce",  "generate", "manufacture", "construct", "build", "assemble",
        "form",     "shape",    "mold",     "craft",    "fashion",  "design",   "invent",   "devise",
        "break",    "crack",    "smash",    "shatter",  "fracture", "split",    "tear",     "rip",
        "destroy",  "ruin",     "wreck",    "demolish", "obliterate", "annihilate", "eradicate", "eliminate",
        "fix",      "repair",   "mend",     "patch",    "restore",  "renovate", "rebuild",  "reconstruct",
        "change",   "alter",    "modify",   "transform", "convert",  "switch",   "shift",    "vary",
        "improve",  "enhance",  "upgrade",  "refine",   "perfect",  "optimize", "boost",    "increase",
        "worsen",   "deteriorate", "decline", "degrade", "diminish", "decrease", "reduce",  "lower",
        "open",     "close",    "shut",     "lock",     "unlock",   "seal",     "unseal",   "cover",
        "uncover",  "reveal",   "expose",   "hide",     "conceal",  "bury",     "disguise", "mask",
        "start",    "begin",    "commence", "initiate", "launch",   "establish", "found",   "originate",
        "end",      "finish",   "complete", "conclude", "terminate", "cease",   "stop",     "halt",
        "continue", "proceed",  "advance",  "progress", "develop",  "evolve",   "grow",     "expand",
        // Possession & Transfer
        "have",     "own",      "possess",  "keep",     "retain",   "maintain", "preserve", "conserve",
        "get",      "obtain",   "acquire",  "gain",     "earn",     "win",      "achieve",  "attain",
        "give",     "offer",    "present",  "provide",  "supply",   "furnish",  "deliver",  "hand",
        "take",     "grab",     "seize",    "snatch",   "steal",    "rob",      "pilfer",   "swipe",
        "receive",  "accept",   "welcome",  "embrace",  "adopt",    "take",     "collect",  "gather",
        "bring",    "carry",    "transport", "convey",  "deliver",  "fetch",    "retrieve", "return",
        "send",     "dispatch", "forward",  "ship",     "mail",     "transmit", "transfer", "move",
        "buy",      "purchase", "acquire",  "shop",     "order",    "pay",      "spend",    "invest",
        "sell",     "vend",     "market",   "trade",    "exchange", "swap",     "barter",   "deal",
        "lend",     "loan",     "borrow",   "rent",     "lease",    "hire",     "employ",   "engage",
        // Daily Activities
        "eat",      "dine",     "consume",  "devour",   "gobble",   "feast",    "snack",    "nibble",
        "drink",    "sip",      "gulp",     "guzzle",   "slurp",    "swallow",  "quaff",    "imbibe",
        "cook",     "bake",     "roast",    "grill",    "fry",      "boil",     "steam",    "prepare",
        "sleep",    "rest",     "nap",      "doze",     "slumber",  "snooze",   "dream",    "wake",
        "wash",     "clean",    "scrub",    "wipe",     "polish",   "shine",    "dust",     "sweep",
        "wear",     "dress",    "clothe",   "don",      "put",      "remove",   "strip",    "undress",
        "live",     "exist",    "reside",   "dwell",    "inhabit",  "occupy",   "stay",     "remain",
        "work",     "labor",    "toil",     "serve",    "function", "operate",  "perform",  "execute",
        "play",     "frolic",   "romp",     "gambol",   "sport",    "compete",  "contest",  "vie",
        // Mental & Learning
        "study",    "research", "investigate", "explore", "probe",   "examine",  "inspect", "survey",
        "teach",    "instruct", "educate",  "train",    "coach",    "tutor",    "mentor",   "guide",
        "learn",    "master",   "grasp",    "absorb",   "assimilate", "acquire", "gain",    "pick up",
        "practice", "rehearse", "drill",    "exercise", "repeat",   "review",   "revise",   "refresh",
        "solve",    "resolve",  "figure",   "calculate", "compute",  "count",   "measure",  "estimate",
        // Social & Interaction
        "meet",     "encounter", "greet",   "welcome",  "introduce", "present", "acquaint", "familiarize",
        "help",     "assist",   "aid",      "support",  "back",     "sustain",  "uphold",   "maintain",
        "serve",    "attend",   "wait",     "cater",    "minister", "tend",     "nurse",    "care",
        "join",     "unite",    "combine",  "merge",    "blend",    "mix",      "fuse",     "integrate",
        "separate", "divide",   "split",    "part",     "disconnect", "detach", "isolate",  "segregate",
        "share",    "distribute", "allocate", "assign",  "portion",  "divide",   "split",    "partition",
        "invite",   "welcome",  "summon",   "call",     "beckon",   "signal",   "wave",     "gesture",
        "visit",    "attend",   "frequent", "patronize", "haunt",   "tour",     "inspect",  "view",
        "marry",    "wed",      "unite",    "join",     "divorce",  "separate", "split",    "part",
        "celebrate", "commemorate", "observe", "honor",  "mark",    "remember", "acknowledge", "recognize",
        // Physical State & Being
        "grow",     "develop",  "mature",   "age",      "ripen",    "blossom",  "flourish", "thrive",
        "die",      "perish",   "expire",   "decease",  "pass",     "succumb",  "fade",     "wither",
        "live",     "survive",  "endure",   "last",     "persist",  "continue", "remain",   "stay",
        "become",   "turn",     "grow",     "develop",  "transform", "evolve",  "change",   "shift",
        "seem",     "appear",   "look",     "sound",    "feel",     "smell",    "taste",    "strike",
        "happen",   "occur",    "transpire", "arise",   "emerge",   "develop",  "unfold",   "ensue",
        "cause",    "create",   "produce",  "generate", "bring",    "induce",   "provoke",  "trigger",
        "prevent",  "stop",     "block",    "hinder",   "impede",   "obstruct", "thwart",   "foil",
        "allow",    "permit",   "let",      "enable",   "authorize", "approve", "sanction", "license",
        "force",    "compel",   "oblige",   "require",  "make",     "coerce",   "pressure", "push",
    };

    /// Generate a random adjective
    pub fn adjective(self: *Word, random: *Random) []const u8 {
        _ = self;
        return random.arrayElement([]const u8, &adjectives_list);
    }

    /// Generate a random adverb
    pub fn adverb(self: *Word, random: *Random) []const u8 {
        _ = self;
        return random.arrayElement([]const u8, &adverbs_list);
    }

    /// Generate a random conjunction
    pub fn conjunction(self: *Word, random: *Random) []const u8 {
        _ = self;
        return random.arrayElement([]const u8, &conjunctions_list);
    }

    /// Generate a random interjection
    pub fn interjection(self: *Word, random: *Random) []const u8 {
        _ = self;
        return random.arrayElement([]const u8, &interjections_list);
    }

    /// Generate a random noun
    pub fn noun(self: *Word, random: *Random) []const u8 {
        _ = self;
        return random.arrayElement([]const u8, &nouns_list);
    }

    /// Generate a random preposition
    pub fn preposition(self: *Word, random: *Random) []const u8 {
        _ = self;
        return random.arrayElement([]const u8, &prepositions_list);
    }

    /// Generate a random verb
    pub fn verb(self: *Word, random: *Random) []const u8 {
        _ = self;
        return random.arrayElement([]const u8, &verbs_list);
    }

    /// Generate multiple words
    pub fn words(self: *Word, random: *Random, count: usize) ![]u8 {
        var result = std.ArrayList([]const u8).initCapacity(self.allocator, count) catch unreachable;
        defer result.deinit(self.allocator);

        const all_words = [_][]const []const u8{
            &adjectives_list, &nouns_list, &verbs_list,
        };

        for (0..count) |_| {
            const word_list = random.arrayElement([]const []const u8, &all_words);
            const word = random.arrayElement([]const u8, word_list);
            try result.append(self.allocator, word);
        }

        return std.mem.join(self.allocator, " ", result.items);
    }
};
