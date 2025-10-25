const std = @import("std");
const Random = @import("../random.zig").Random;

pub const Music = struct {
    random: *Random,
    allocator: std.mem.Allocator,

    pub fn init(allocator: std.mem.Allocator, random: *Random) Music {
        return Music{
            .random = random,
            .allocator = allocator,
        };
    }

    const genres = [_][]const u8{
        "Rock",         "Pop",          "Hip Hop",      "Jazz",         "Blues",
        "Country",      "Electronic",   "Classical",    "Metal",        "Punk",
        "Reggae",       "R&B",          "Soul",         "Funk",         "Disco",
        "House",        "Techno",       "Trance",       "Dubstep",      "Drum and Bass",
        "Indie",        "Alternative",  "Grunge",       "Folk",         "Bluegrass",
        "Gospel",       "Opera",        "Ska",          "Swing",        "Ambient",
        "EDM",          "Trap",         "Lo-fi",        "Synthwave",    "Vaporwave",
        "K-pop",        "J-pop",        "Latin",        "Salsa",        "Reggaeton",
        "Flamenco",     "Bossa Nova",   "Samba",        "Cumbia",       "Tango",
        "Afrobeat",     "Highlife",     "Zouk",         "Calypso",      "Soca",
    };

    const artists = [_][]const u8{
        "The Beatles",    "Elvis Presley",  "Michael Jackson", "Madonna",       "Bob Dylan",
        "Led Zeppelin",   "Pink Floyd",     "Queen",          "David Bowie",   "Prince",
        "Nirvana",        "Radiohead",      "Coldplay",       "U2",            "The Rolling Stones",
        "AC/DC",          "Metallica",      "Iron Maiden",    "Black Sabbath", "Deep Purple",
        "Jimi Hendrix",   "Eric Clapton",   "B.B. King",      "Miles Davis",   "John Coltrane",
        "Beyonce",        "Taylor Swift",   "Adele",          "Ed Sheeran",    "Drake",
        "Eminem",         "Jay-Z",          "Kanye West",     "Kendrick Lamar", "Travis Scott",
        "Billie Eilish",  "Ariana Grande",  "The Weeknd",     "Post Malone",   "Bad Bunny",
    };

    const songs = [_][]const u8{
        "Bohemian Rhapsody", "Stairway to Heaven", "Hotel California", "Imagine",      "Hey Jude",
        "Smells Like Teen Spirit", "One",          "Yesterday",        "Let It Be",    "Come Together",
        "Purple Haze",       "Sweet Child O' Mine", "November Rain", "Don't Stop Believin'", "Livin' on a Prayer",
        "Wonderwall",        "Mr. Brightside",   "Creep",            "Karma Police",  "Paranoid Android",
        "Billie Jean",       "Thriller",         "Beat It",          "Like a Prayer", "Material Girl",
        "Sweet Dreams",      "Every Breath You Take", "With or Without You", "One Love",  "Redemption Song",
    };

    const instruments = [_][]const u8{
        "Guitar",      "Piano",       "Drums",       "Bass",        "Violin",
        "Cello",       "Trumpet",     "Saxophone",   "Flute",       "Clarinet",
        "Oboe",        "Bassoon",     "Trombone",    "French Horn", "Tuba",
        "Harmonica",   "Accordion",   "Banjo",       "Mandolin",    "Ukulele",
        "Harp",        "Xylophone",   "Marimba",     "Vibraphone",  "Timpani",
        "Synthesizer", "Keyboard",    "Organ",       "Turntables",  "Sampler",
        "Percussion",  "Tambourine",  "Bongos",      "Congas",      "Djembe",
    };

    const albums = [_][]const u8{
        "Abbey Road",         "The Dark Side of the Moon", "Thriller",           "Back in Black",
        "The Wall",           "Rumours",                   "Nevermind",          "OK Computer",
        "The Joshua Tree",    "Led Zeppelin IV",           "Born to Run",        "Purple Rain",
        "Blood Sugar Sex Magik", "Appetite for Destruction", "Ten",              "Dirt",
        "The Chronic",        "Illmatic",                  "Enter the Wu-Tang",  "The Miseducation",
        "Random Access Memories", "Discovery",             "Homogenic",          "Vespertine",
    };

    /// Generate a random music genre
    pub fn genre(self: *Music) []const u8 {
        return self.random.arrayElement([]const u8, &genres);
    }

    /// Generate a random artist name
    pub fn artist(self: *Music) []const u8 {
        return self.random.arrayElement([]const u8, &artists);
    }

    /// Generate a random song title
    pub fn song(self: *Music) []const u8 {
        return self.random.arrayElement([]const u8, &songs);
    }

    /// Generate a random instrument
    pub fn instrument(self: *Music) []const u8 {
        return self.random.arrayElement([]const u8, &instruments);
    }

    /// Generate a random album title
    pub fn album(self: *Music) []const u8 {
        return self.random.arrayElement([]const u8, &albums);
    }
};
