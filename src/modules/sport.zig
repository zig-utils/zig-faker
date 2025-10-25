const std = @import("std");
const Random = @import("../random.zig").Random;

pub const Sport = struct {
    random: *Random,
    allocator: std.mem.Allocator,

    pub fn init(allocator: std.mem.Allocator, random: *Random) Sport {
        return Sport{
            .random = random,
            .allocator = allocator,
        };
    }

    const sports = [_][]const u8{
        "Football",     "Basketball",   "Baseball",     "Soccer",       "Hockey",
        "Tennis",       "Golf",         "Boxing",       "MMA",          "Wrestling",
        "Volleyball",   "Swimming",     "Track",        "Gymnastics",   "Skiing",
        "Snowboarding", "Surfing",      "Skateboarding", "Cricket",     "Rugby",
        "Lacrosse",     "Softball",     "Handball",     "Badminton",    "Table Tennis",
        "Cycling",      "Marathon",     "Triathlon",    "Archery",      "Fencing",
        "Karate",       "Judo",         "Taekwondo",    "Rock Climbing", "Rowing",
        "Sailing",      "Diving",       "Water Polo",   "Figure Skating", "Curling",
        "Polo",         "Squash",       "Racquetball",  "Bowling",      "Darts",
        "Billiards",    "Snooker",      "Esports",      "Auto Racing",  "Horse Racing",
    };

    const teams = [_][]const u8{
        "Lions",     "Tigers",    "Bears",     "Eagles",    "Hawks",     "Falcons",
        "Ravens",    "Cardinals", "Warriors",  "Knights",   "Spartans",  "Trojans",
        "Vikings",   "Titans",    "Giants",    "Dragons",   "Phoenix",   "Thunder",
        "Lightning", "Storm",     "Blizzard",  "Avalanche", "Hurricanes", "Tornados",
        "Wolves",    "Coyotes",   "Panthers",  "Jaguars",   "Leopards",  "Cheetahs",
        "Bulls",     "Rams",      "Broncos",   "Mustangs",  "Stallions", "Colts",
        "Pirates",   "Raiders",   "Bandits",   "Outlaws",   "Rebels",    "Renegades",
        "Sharks",    "Barracudas", "Marlins",  "Dolphins",  "Whales",    "Orcas",
        "Cobras",    "Vipers",    "Pythons",   "Rattlers",  "Strikers",  "United",
        "Royals",    "Monarchs",  "Kings",     "Queens",    "Emperors",  "Czars",
    };

    const athletes = [_][]const u8{
        "Michael Jordan", "LeBron James",   "Tom Brady",      "Serena Williams", "Roger Federer",
        "Lionel Messi",   "Cristiano Ronaldo", "Tiger Woods", "Muhammad Ali",   "Mike Tyson",
        "Usain Bolt",     "Simone Biles",   "Michael Phelps", "Wayne Gretzky",  "Babe Ruth",
        "Kobe Bryant",    "Shaquille O'Neal", "Magic Johnson", "Larry Bird",    "Kareem Abdul-Jabbar",
        "Pele",           "Diego Maradona", "Neymar",         "Rafael Nadal",   "Novak Djokovic",
        "Lewis Hamilton", "Valentino Rossi", "Floyd Mayweather", "Conor McGregor", "Anderson Silva",
    };

    const positions = [_][]const u8{
        // Football/Soccer
        "Quarterback", "Running Back", "Wide Receiver", "Tight End", "Offensive Line",
        "Defensive Line", "Linebacker", "Cornerback", "Safety", "Kicker",
        "Goalkeeper", "Defender", "Midfielder", "Forward", "Striker",
        // Basketball
        "Point Guard", "Shooting Guard", "Small Forward", "Power Forward", "Center",
        // Baseball
        "Pitcher", "Catcher", "First Base", "Second Base", "Third Base",
        "Shortstop", "Outfield", "Designated Hitter",
        // Hockey
        "Goalie", "Left Wing", "Right Wing", "Center", "Defenseman",
    };

    /// Generate a random sport name
    pub fn sport(self: *Sport) []const u8 {
        return self.random.arrayElement([]const u8, &sports);
    }

    /// Generate a random team name
    pub fn team(self: *Sport) []const u8 {
        return self.random.arrayElement([]const u8, &teams);
    }

    /// Generate a random athlete name
    pub fn athlete(self: *Sport) []const u8 {
        return self.random.arrayElement([]const u8, &athletes);
    }

    /// Generate a random position
    pub fn position(self: *Sport) []const u8 {
        return self.random.arrayElement([]const u8, &positions);
    }

    /// Generate a full team name (City + Team)
    pub fn fullTeamName(self: *Sport) ![]u8 {
        const cities = [_][]const u8{
            "New York",    "Los Angeles", "Chicago",     "Houston",     "Phoenix",
            "Philadelphia", "San Antonio", "San Diego",  "Dallas",      "San Jose",
            "Austin",      "Jacksonville", "Fort Worth", "Columbus",    "Charlotte",
            "Seattle",     "Denver",      "Boston",      "Portland",    "Las Vegas",
            "Detroit",     "Memphis",     "Louisville",  "Baltimore",   "Milwaukee",
            "Miami",       "Atlanta",     "Cleveland",   "Minneapolis", "Tampa",
        };

        const city = self.random.arrayElement([]const u8, &cities);
        const team_name = self.team();
        return std.fmt.allocPrint(self.allocator, "{s} {s}", .{ city, team_name });
    }
};
