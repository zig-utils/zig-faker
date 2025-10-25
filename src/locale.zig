const std = @import("std");

pub const Gender = enum {
    male,
    female,
    neutral,
};

pub const PersonLocale = struct {
    first_name_male: []const []const u8,
    first_name_female: []const []const u8,
    first_name_neutral: []const []const u8,
    last_name: []const []const u8,
    prefix: []const []const u8,
    suffix: []const []const u8,
    gender: []const []const u8,
    job_title: []const []const u8,
};

pub const AddressLocale = struct {
    street_name: []const []const u8,
    city: []const []const u8,
    state: []const []const u8,
    state_abbr: []const []const u8,
    country: []const []const u8,
    postal_code_format: []const []const u8,
    building_number: []const []const u8,
    direction: []const []const u8,
};

pub const CompanyLocale = struct {
    name: []const []const u8,
    suffix: []const []const u8,
    industry: []const []const u8,
    buzzwords: []const []const u8,
    descriptor: []const []const u8,
};

pub const InternetLocale = struct {
    domain_suffix: []const []const u8,
    domain_word: []const []const u8,
    free_email: []const []const u8,
};

pub const PhoneLocale = struct {
    format: []const []const u8,
};

pub const FoodLocale = struct {
    dish: []const []const u8,
    ingredient: []const []const u8,
    fruit: []const []const u8,
    vegetable: []const []const u8,
    meat: []const []const u8,
    spice: []const []const u8,
};

pub const AnimalLocale = struct {
    dog: []const []const u8,
    cat: []const []const u8,
    bird: []const []const u8,
    fish: []const []const u8,
    horse: []const []const u8,
    farm: []const []const u8,
    insect: []const []const u8,
    wild: []const []const u8,
};

pub const LocaleDefinition = struct {
    title: []const u8,
    person: PersonLocale,
    address: AddressLocale,
    company: CompanyLocale,
    internet: InternetLocale,
    phone: PhoneLocale,
    food: ?FoodLocale = null,
    animal: ?AnimalLocale = null,
};
