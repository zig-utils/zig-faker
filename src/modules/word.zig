const std = @import("std");
const Random = @import("../random.zig").Random;

pub const Word = struct {
    random: *Random,
    allocator: std.mem.Allocator,

    pub fn init(allocator: std.mem.Allocator, random: *Random) Word {
        return Word{
            .random = random,
            .allocator = allocator,
        };
    }

    const adjectives_list = [_][]const u8{
        "beautiful", "happy",     "sad",       "large",     "small",     "big",
        "tiny",      "huge",      "fast",      "slow",      "quick",     "bright",
        "dark",      "light",     "heavy",     "soft",      "hard",      "smooth",
        "rough",     "clean",     "dirty",     "new",       "old",       "young",
        "ancient",   "modern",    "fresh",     "stale",     "hot",       "cold",
        "warm",      "cool",      "wet",       "dry",       "sharp",     "dull",
        "loud",      "quiet",     "strong",    "weak",      "brave",     "afraid",
        "careful",   "careless",  "friendly",  "mean",      "kind",      "cruel",
        "honest",    "dishonest", "patient",   "impatient", "polite",    "rude",
    };

    const adverbs_list = [_][]const u8{
        "quickly",   "slowly",    "carefully", "carelessly", "happily",   "sadly",
        "quietly",   "loudly",    "gently",    "roughly",    "smoothly",  "easily",
        "hardly",    "softly",    "strongly",  "weakly",     "bravely",   "nervously",
        "patiently", "impatiently", "politely", "rudely",    "honestly",  "badly",
        "well",      "better",    "best",      "worse",      "worst",     "more",
        "less",      "very",      "too",       "quite",      "rather",    "fairly",
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
        "dog",     "cat",     "house",   "car",     "tree",    "book",
        "table",   "chair",   "phone",   "computer", "music",  "art",
        "love",    "hope",    "dream",   "life",    "death",   "time",
        "space",   "world",   "city",    "country", "ocean",   "mountain",
        "river",   "forest",  "desert",  "island",  "person",  "child",
        "family",  "friend",  "teacher", "doctor",  "student", "worker",
        "food",    "water",   "fire",    "earth",   "wind",    "sun",
        "moon",    "star",    "cloud",   "rain",    "snow",    "light",
    };

    const prepositions_list = [_][]const u8{
        "in",      "on",      "at",      "by",      "with",    "from",
        "to",      "for",     "of",      "about",   "above",   "below",
        "under",   "over",    "through", "between", "among",   "behind",
        "before",  "after",   "during",  "within",  "without", "toward",
    };

    const verbs_list = [_][]const u8{
        "run",     "walk",    "talk",    "eat",     "sleep",   "work",
        "play",    "study",   "read",    "write",   "sing",    "dance",
        "jump",    "swim",    "fly",     "drive",   "ride",    "climb",
        "build",   "make",    "create",  "destroy", "love",    "hate",
        "want",    "need",    "have",    "give",    "take",    "bring",
        "go",      "come",    "see",     "hear",    "feel",    "think",
        "know",    "understand", "believe", "hope", "wish",    "dream",
    };

    /// Generate a random adjective
    pub fn adjective(self: *Word) []const u8 {
        return self.random.arrayElement([]const u8, &adjectives_list);
    }

    /// Generate a random adverb
    pub fn adverb(self: *Word) []const u8 {
        return self.random.arrayElement([]const u8, &adverbs_list);
    }

    /// Generate a random conjunction
    pub fn conjunction(self: *Word) []const u8 {
        return self.random.arrayElement([]const u8, &conjunctions_list);
    }

    /// Generate a random interjection
    pub fn interjection(self: *Word) []const u8 {
        return self.random.arrayElement([]const u8, &interjections_list);
    }

    /// Generate a random noun
    pub fn noun(self: *Word) []const u8 {
        return self.random.arrayElement([]const u8, &nouns_list);
    }

    /// Generate a random preposition
    pub fn preposition(self: *Word) []const u8 {
        return self.random.arrayElement([]const u8, &prepositions_list);
    }

    /// Generate a random verb
    pub fn verb(self: *Word) []const u8 {
        return self.random.arrayElement([]const u8, &verbs_list);
    }

    /// Generate multiple words
    pub fn words(self: *Word, count: usize) ![]u8 {
        var result = std.ArrayList([]const u8).initCapacity(self.allocator, count) catch unreachable;
        defer result.deinit(self.allocator);

        const all_words = [_][]const []const u8{
            &adjectives_list, &nouns_list, &verbs_list,
        };

        for (0..count) |_| {
            const word_list = self.random.arrayElement([]const []const u8, &all_words);
            const word = self.random.arrayElement([]const u8, word_list);
            try result.append(self.allocator, word);
        }

        return std.mem.join(self.allocator, " ", result.items);
    }
};
