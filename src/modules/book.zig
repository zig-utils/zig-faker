const std = @import("std");
const Random = @import("../random.zig").Random;

pub const Book = struct {
    random: *Random,
    allocator: std.mem.Allocator,

    pub fn init(allocator: std.mem.Allocator, random: *Random) Book {
        return Book{
            .random = random,
            .allocator = allocator,
        };
    }

    const titles = [_][]const u8{
        "To Kill a Mockingbird", "1984",              "Pride and Prejudice", "The Great Gatsby",
        "One Hundred Years of Solitude", "Moby-Dick", "War and Peace",      "The Odyssey",
        "The Divine Comedy",     "Hamlet",            "The Catcher in the Rye", "Lord of the Flies",
        "Animal Farm",           "Brave New World",   "The Lord of the Rings", "Harry Potter",
        "The Hobbit",            "The Chronicles of Narnia", "Dune",        "Foundation",
        "Neuromancer",           "Snow Crash",        "The Handmaid's Tale", "Beloved",
        "The Color Purple",      "Things Fall Apart", "One Thousand and One Nights", "The Iliad",
        "Don Quixote",           "Ulysses",           "Madame Bovary",      "Crime and Punishment",
        "The Brothers Karamazov", "Anna Karenina",    "Jane Eyre",          "Wuthering Heights",
        "Frankenstein",          "Dracula",           "The Picture of Dorian Gray", "Alice's Adventures",
    };

    const authors = [_][]const u8{
        "William Shakespeare",   "Jane Austen",        "Charles Dickens",   "Mark Twain",
        "Ernest Hemingway",      "F. Scott Fitzgerald", "George Orwell",    "J.K. Rowling",
        "Stephen King",          "Agatha Christie",    "Isaac Asimov",      "Arthur C. Clarke",
        "J.R.R. Tolkien",        "C.S. Lewis",         "Gabriel Garcia Marquez", "Toni Morrison",
        "Maya Angelou",          "James Baldwin",      "Virginia Woolf",    "Leo Tolstoy",
        "Fyodor Dostoevsky",     "Franz Kafka",        "Albert Camus",      "Hermann Hesse",
        "Jorge Luis Borges",     "Haruki Murakami",    "Chinua Achebe",     "Salman Rushdie",
        "Margaret Atwood",       "Neil Gaiman",        "Terry Pratchett",   "Douglas Adams",
        "Philip K. Dick",        "Ursula K. Le Guin",  "Octavia Butler",    "Ray Bradbury",
    };

    const genres = [_][]const u8{
        "Fiction",         "Non-Fiction",    "Mystery",        "Thriller",       "Romance",
        "Science Fiction", "Fantasy",        "Horror",         "Biography",      "Autobiography",
        "History",         "Self-Help",      "Travel",         "Cookbook",       "Poetry",
        "Drama",           "Comedy",         "Adventure",      "Crime",          "Detective",
        "Dystopian",       "Utopian",        "Magical Realism", "Historical Fiction", "Contemporary",
        "Young Adult",     "Children's",     "Graphic Novel",  "Comic",          "Manga",
        "Philosophy",      "Psychology",     "Sociology",      "Political",      "Economics",
    };

    const publishers = [_][]const u8{
        "Penguin Random House", "HarperCollins",   "Simon & Schuster", "Hachette",
        "Macmillan",            "Scholastic",      "Wiley",            "Pearson",
        "Oxford University Press", "Cambridge University Press", "Springer", "Elsevier",
        "Bloomsbury",           "Knopf",           "Viking",           "Vintage",
        "Bantam",               "Dell",            "Tor",              "Orbit",
        "DAW",                  "Ace",             "Baen",             "Angry Robot",
    };

    const series_names = [_][]const u8{
        "Harry Potter",          "The Lord of the Rings", "A Song of Ice and Fire", "The Wheel of Time",
        "The Chronicles of Narnia", "Discworld",         "The Foundation Series", "Dune",
        "The Hitchhiker's Guide", "Sherlock Holmes",    "The Dark Tower",       "Twilight",
        "The Hunger Games",      "Divergent",          "Percy Jackson",        "The Mortal Instruments",
        "The Kingkiller Chronicle", "Mistborn",        "Stormlight Archive",   "The First Law",
    };

    /// Generate a random book title
    pub fn title(self: *Book) []const u8 {
        return self.random.arrayElement([]const u8, &titles);
    }

    /// Generate a random author name
    pub fn author(self: *Book) []const u8 {
        return self.random.arrayElement([]const u8, &authors);
    }

    /// Generate a random book genre
    pub fn genre(self: *Book) []const u8 {
        return self.random.arrayElement([]const u8, &genres);
    }

    /// Generate a random publisher
    pub fn publisher(self: *Book) []const u8 {
        return self.random.arrayElement([]const u8, &publishers);
    }

    /// Generate a random series name
    pub fn series(self: *Book) []const u8 {
        return self.random.arrayElement([]const u8, &series_names);
    }

    /// Generate an ISBN-10
    pub fn isbn10(self: *Book) ![]u8 {
        return self.random.replaceSymbols(self.allocator, "##########");
    }

    /// Generate an ISBN-13
    pub fn isbn13(self: *Book) ![]u8 {
        return self.random.replaceSymbols(self.allocator, "###-##########");
    }
};
