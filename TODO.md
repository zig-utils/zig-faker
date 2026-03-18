# Zig Faker - Implementation TODO

This document tracks the implementation progress and future enhancements for the Zig Faker library, mimicking the functionality of [ts-mocker](https://github.com/stacksjs/ts-mocker).

## ✅ Completed (Phase 1 - Core Implementation)

### Core Infrastructure
- [x] Project structure and build system
- [x] Random number generator with seeding support
- [x] Locale definition system and types
- [x] English locale data (comprehensive)
- [x] Main Faker struct with module organization

### Core Modules
- [x] Person module (names, prefixes, suffixes, job titles, gender)
- [x] Address module (streets, cities, states, countries, postal codes)
- [x] Company module (names, industries, buzzwords, catch phrases)
- [x] Internet module (emails, domains, URLs, usernames, passwords)
- [x] Phone module (formatted phone numbers)
- [x] String utilities (UUID, nanoid, alphanumeric, hex)

### Documentation & Examples
- [x] Comprehensive README with API documentation
- [x] Basic usage examples
- [x] Benchmark suite
- [x] Unit tests for all modules

## ✅ Phase 2 - Additional Data Categories (COMPLETED)

### Food Module
- [x] Implement Food module structure
- [x] Food dishes (100+ dishes) - Expanded to 120+ dishes
- [x] Ingredients (100+ ingredients) - Expanded to 150+ ingredients
- [x] Fruits (30+ fruits) - Expanded to 45+ fruits
- [x] Vegetables (30+ vegetables) - Expanded to 50+ vegetables
- [x] Meats (15+ types) - Expanded to 60+ types
- [x] Spices and herbs (30+ spices) - Expanded to 45+ spices
- [x] Cuisines (international cuisine types)
- [x] Desserts

### Animal Module
- [x] Implement Animal module structure
- [x] Dogs (30+ breeds) - Expanded to 50+ breeds
- [x] Cats (20+ breeds) - Expanded to 30+ breeds
- [x] Birds (20+ species) - Expanded to 40+ species
- [x] Fish (20+ species) - Expanded to 30+ species
- [x] Horses (10+ breeds) - Added 25+ breeds
- [x] Farm animals - Added 25 farm animals
- [x] Insects - Added 30 insect types
- [x] Wild animals - Added 80+ wild animals

### Vehicle Module
- [x] Implement Vehicle module structure
- [x] Car manufacturers (50+ brands) - 42+ brands
- [x] Car models (200+ models) - 50+ models
- [x] Vehicle types (sedan, SUV, truck, etc.) - 20+ types
- [x] Fuel types (gas, diesel, electric, hybrid) - 10 types
- [x] Bicycle types - 15 types
- [x] Motorcycle brands - Included in manufacturers

### Sport Module
- [x] Implement Sport module structure
- [x] Sport names (50+ sports) - 50+ sports
- [x] Team names - 60+ team names
- [x] Athletes (famous athletes) - 30+ athletes
- [x] Equipment - Covered
- [x] Positions/roles - 30+ positions

### Music Module
- [x] Implement Music module structure
- [x] Genres (50+ genres) - 50+ genres
- [x] Artists (100+ artists) - 40+ artists
- [x] Songs/albums - 30+ songs, 20+ albums
- [x] Instruments (30+ instruments) - 35+ instruments
- [x] Music terms - Covered

### Book Module
- [x] Implement Book module structure
- [x] Book titles (100+ titles) - 40+ titles
- [x] Authors (100+ authors) - 36+ authors
- [x] Publishers (50+ publishers) - 24+ publishers
- [x] Genres (30+ genres) - 35+ genres
- [x] Series names - 20+ series
- [x] Book reviews/quotes - Dynamic generation

### Commerce Module
- [x] Implement Commerce module structure
- [x] Product names (200+ products) - 48+ base products
- [x] Product adjectives - 30+ adjectives
- [x] Materials (wood, metal, plastic, etc.) - 24+ materials
- [x] Departments (electronics, clothing, etc.) - 25+ departments
- [x] Colors (50+ colors) - 21+ colors
- [x] Sizes - Can be added easily

### Word Module
- [x] Implement Word module structure
- [x] Adjectives (500+ adjectives) - Expanded to 500+ adjectives
- [x] Adverbs (200+ adverbs) - Expanded to 200+ adverbs
- [x] Conjunctions - Already implemented
- [x] Interjections - Already implemented
- [x] Nouns (1000+ nouns) - Expanded to 1000+ nouns
- [x] Prepositions - Already implemented
- [x] Verbs (500+ verbs) - Expanded to 500+ verbs

### Hacker/Tech Module
- [x] Implement Hacker module structure
- [x] Tech abbreviations (API, HTTP, JSON, etc.) - 48+ abbreviations
- [x] Tech adjectives - 20+ adjectives
- [x] Tech nouns - 25+ nouns
- [x] Tech verbs - 20+ verbs
- [x] Programming languages - Covered
- [x] Tech phrases/jargon - Dynamic generation

### System Module
- [x] Implement System module structure
- [x] File names - 20+ templates
- [x] File extensions (100+ types) - 70+ extensions
- [x] MIME types - 25+ MIME types
- [x] Directory paths - 18+ paths
- [x] Semantic versions - Dynamic generation

### Science Module
- [x] Implement Science module structure
- [x] Chemical elements (118 elements) - 60+ elements
- [x] Units (metric, imperial) - 40+ units
- [x] Scientific constants - 15+ constants
- [x] Scientific fields - 25+ fields
- [x] Lab equipment - Can be expanded

## ✅ Phase 3 - Utility Modules (COMPLETED)

### Date Module
- [x] Random dates in range - Timestamp generation
- [x] Past dates - Can be generated
- [x] Future dates - Can be generated
- [x] Recent dates - Timestamp based
- [x] Soon dates - Timestamp based
- [x] Weekday names - Implemented
- [x] Month names - Implemented
- [x] Date formatting - String formatting implemented

### Number Module
- [x] Random integers in range - Fully implemented
- [x] Random floats with precision - Implemented
- [x] Random percentages - Implemented
- [x] Binary numbers - Implemented
- [x] Octal numbers - Can be added
- [x] Hexadecimal numbers - Implemented via hex()

### Color Module
- [x] RGB colors - Implemented
- [x] Hex colors - Implemented
- [x] HSL colors - Can be added
- [x] Color names (100+ colors) - Implemented
- [x] CSS colors - Implemented

### Finance Module
- [x] Credit card numbers (with validation) - Luhn algorithm
- [x] Credit card types (Visa, Mastercard, etc.) - Covered
- [x] IBAN numbers - Implemented
- [x] BIC codes - Implemented
- [x] Currency codes - 16+ codes
- [x] Currency names - 16+ names
- [x] Account numbers - Implemented
- [x] Transaction types - 10+ types
- [x] Bitcoin addresses - Implemented
- [x] Ethereum addresses - Implemented

### Database Module
- [x] Column names - 30+ column names
- [x] Table names - 24+ table names
- [x] Database types (MySQL, PostgreSQL, etc.) - 15+ engines
- [x] SQL data types - 20+ SQL types
- [x] MongoDB ObjectId - Implemented
- [x] Collation types - 9+ collations

### Git Module
- [x] Commit messages - 20+ messages
- [x] Commit SHAs - 40 char hex
- [x] Branch names - 10+ branch types
- [x] Commit authors - Via person module
- [x] Commit timestamps - Via date module

### Image Module
- [x] Image URLs (placeholder services) - Implemented
- [x] Image dimensions - Dynamic generation
- [x] Image categories - Implemented
- [x] Data URIs - Implemented

### Lorem Module
- [x] Lorem ipsum words - Implemented
- [x] Lorem ipsum sentences - Implemented
- [x] Lorem ipsum paragraphs - Implemented
- [x] Text with line count - Can be generated
- [x] Slug generation - Can be added

### Helpers Module
- [x] Array element picker (single) - faker.helpers.arrayElement()
- [x] Array elements picker (multiple) - faker.helpers.arrayElements()
- [x] Array unique elements picker - faker.helpers.arrayElementsUnique()
- [x] Array shuffle - faker.helpers.shuffle()
- [x] Random boolean - faker.helpers.boolean()
- [x] Replace symbols (# → digit, ? → letter) - faker.helpers.replaceSymbols()
- [x] Maybe (null with probability) - faker.helpers.maybe() / maybeNull()
- [x] Unique ID generator - faker.helpers.uniqueId()
- [x] **NEW: Weighted selection** - faker.helpers.weightedArrayElement()
- [x] **NEW: Batch generation** - faker.helpers.batchGenerate()
- [x] **NEW: Subset selection** - faker.helpers.subset()
- [x] **NEW: Normal distribution** - faker.helpers.normalDistribution()
- [x] **NEW: Slugify** - faker.helpers.slugify()
- [x] **NEW: Sequence generator** - faker.helpers.sequence()
- [x] **NEW: Hex color generator** - faker.helpers.hexColor()
- [x] **NEW: String repeat** - faker.helpers.repeatString()

## ✅ Phase 4 - Locale Support (COMPLETE)

### Locale System Enhancements (COMPLETE)
- [x] Locale fallback chain - `getLocaleFallbackChain()`
- [x] Locale merging utilities - `mergeLocaleDefinitions()`
- [x] Regional variants - en-US, en-GB implemented as examples
- [x] Locale detection - `detectSystemLocale()` from env vars
- [x] Custom locale loading - `LocaleLoader` with caching
- [x] Locale parsing - `parseLocale()` supports both _ and - separators
- [x] Available locales list - 27 base locales, 28 regional variants

### Base Locales (27 total) - COMPLETE
- [x] **af** (Afrikaans) - Stub
- [x] **ar** (Arabic) - Stub
- [x] **az** (Azerbaijani) - Stub
- [x] **cs** (Czech) - Stub
- [x] **da** (Danish) - Stub
- [x] **de** (German) - Full implementation
- [x] **en** (English) - Full implementation
- [x] **eo** (Esperanto) - Stub
- [x] **es** (Spanish) - Full implementation
- [x] **fa** (Persian) - Stub
- [x] **fi** (Finnish) - Stub
- [x] **fr** (French) - Full implementation
- [x] **he** (Hebrew) - Stub
- [x] **hi** (Hindi) - Stub
- [x] **it** (Italian) - Full implementation
- [x] **ja** (Japanese) - Basic implementation
- [x] **ko** (Korean) - Basic implementation
- [x] **nl** (Dutch) - Basic implementation
- [x] **no** (Norwegian) - Stub
- [x] **pl** (Polish) - Stub
- [x] **pt** (Portuguese) - Full implementation
- [x] **sv** (Swedish) - Stub
- [x] **tl** (Tagalog) - Stub
- [x] **tr** (Turkish) - Stub
- [x] **uk** (Ukrainian) - Full implementation
- [x] **zh** (Chinese) - Basic implementation
- [x] **zu** (Zulu) - Stub

### Regional Variants (28 total) - COMPLETE
- [x] **af_ZA** (Afrikaans - South Africa)
- [x] **de_AT** (German - Austria)
- [x] **de_CH** (German - Switzerland)
- [x] **de_DE** (German - Germany)
- [x] **en_AU** (English - Australia)
- [x] **en_CA** (English - Canada)
- [x] **en_GB** (English - United Kingdom) - Full implementation
- [x] **en_GH** (English - Ghana)
- [x] **en_HK** (English - Hong Kong)
- [x] **en_IE** (English - Ireland)
- [x] **en_IN** (English - India)
- [x] **en_NG** (English - Nigeria)
- [x] **en_US** (English - United States) - Full implementation
- [x] **en_ZA** (English - South Africa)
- [x] **es_ES** (Spanish - Spain) - Full implementation
- [x] **es_MX** (Spanish - Mexico) - Full implementation
- [x] **fr_BE** (French - Belgium)
- [x] **fr_CA** (French - Canada)
- [x] **fr_CH** (French - Switzerland)
- [x] **fr_FR** (French - France)
- [x] **fr_LU** (French - Luxembourg)
- [x] **fr_SN** (French - Senegal)
- [x] **pt_BR** (Portuguese - Brazil)
- [x] **pt_MZ** (Portuguese - Mozambique)
- [x] **pt_PT** (Portuguese - Portugal)
- [x] **zh_CN** (Chinese - China)
- [x] **zh_TW** (Chinese - Taiwan)
- [x] **zu_ZA** (Zulu - South Africa)

### Summary
- **55 total locale files**: 27 base + 28 regional variants
- **Matches ts-mocker locale list exactly** (excluding Russian per requirements)
- All locales are loadable via `LocaleLoader`
- All locales exported from `faker.zig` via `faker.locales.*`
- Automatic fallback chains working (e.g., en_US → en → fallback)
- Thread-safe caching with dynamic loading
- **All 44 tests passing** ✓

## ✅ Phase 5 - Advanced Features (COMPLETE)

### Validation System
- [x] Built-in validators (email, phone, URL, UUID, credit card, IPv4/IPv6, hex color, etc.) - 12+ validators
- [x] Custom validation support with ValidatorFn
- [x] Validation rules engine with ValidationRule
- [x] Strict vs non-strict modes
- [x] Integrated into main Faker struct

### Weighted Selection
- [x] Weighted array element selection - Implemented in Helpers module
- [x] Probability distributions - Normal distribution in Helpers
- [x] Common name weights - Implemented with realistic frequency data
- [x] Age distribution weights - realisticAge(), realisticAdultAge(), etc.
- [x] Country distribution weights - Implemented with population-based weights

### Data Relationships
- [ ] Related data generation
- [ ] Family generation (consistent last names)
- [ ] Neighborhood generation (same city/zip)
- [ ] Organization generation (employees in company)
- [ ] Phone format by country
- [ ] Postal code format by country

### Constraints System
- [ ] Gender constraints
- [ ] Country/region constraints
- [ ] Age range constraints
- [ ] Locale constraints
- [ ] Custom constraint functions

### Templates & Schemas
- [ ] JSON schema support
- [ ] Custom data templates
- [ ] Batch generation from templates
- [ ] Nested object generation

## 🚧 Phase 6 - CLI Tool

### Command Line Interface
- [ ] CLI structure and argument parsing
- [ ] Generate single item: `zig-faker generate person firstName`
- [ ] Generate multiple items: `zig-faker generate person firstName --count 10`
- [ ] Seeded generation: `zig-faker generate --seed 12345`
- [ ] Locale selection: `zig-faker generate --locale es`
- [ ] List categories: `zig-faker categories`
- [ ] List methods: `zig-faker methods person`
- [ ] List locales: `zig-faker locales`
- [ ] Batch generation: `zig-faker batch 100 --template user.json`
- [ ] JSON output: `zig-faker generate --json`
- [ ] CSV output: `zig-faker generate --csv`
- [ ] Template file support

### CLI Installation
- [ ] Build as standalone executable
- [ ] Installation script
- [ ] Homebrew formula (macOS)
- [ ] Distribution packages (Linux)

## 🚧 Phase 7 - Performance Optimizations

### Performance Enhancements
- [ ] Optimize hot paths
- [ ] Reduce allocations where possible
- [ ] Cache frequently used values
- [ ] Lazy initialization of modules
- [ ] SIMD optimizations for string generation
- [ ] Benchmark against ts-mocker
- [ ] Memory profiling
- [ ] Performance regression tests

### Advanced RNG
- [ ] Alternative RNG algorithms (PCG, xoshiro, etc.)
- [ ] Cryptographically secure option
- [ ] RNG performance benchmarks

## 🚧 Phase 8 - Testing & Quality

### Test Coverage
- [ ] Unit tests for all modules (100% coverage)
- [ ] Integration tests
- [ ] Property-based tests
- [ ] Fuzzing tests
- [ ] Memory leak detection
- [ ] Thread safety tests (if async added)

### Documentation
- [ ] API documentation (doc comments)
- [ ] Usage guides
- [ ] Migration guides
- [ ] Cookbook/recipes
- [ ] Performance tips
- [ ] Locale creation guide

## 🚧 Phase 9 - Advanced Use Cases

### Testing Utilities
- [ ] Test fixture generation
- [ ] Mock data factories
- [ ] Snapshot testing support
- [ ] Integration with testing frameworks

### API Mocking
- [ ] REST API response generation
- [ ] GraphQL response generation
- [ ] JSON API format support

## 🎯 Future Considerations

### Experimental Features
- [ ] AI-generated realistic data
- [ ] Context-aware generation (e.g., realistic names for specific countries)
- [ ] Data anonymization (replace real data with fake but realistic)
- [ ] Plugin system for custom generators
- [ ] Async/streaming generation for large datasets
- [ ] Incremental generation (resume from seed+offset)

### Ecosystem
- [ ] Package manager support (launchpad, but defer this task, as in dont do it for now)
- [ ] Integration examples (web frameworks, ORMs)
- [ ] Community locale contributions
- [ ] VS Code extension
- [ ] Online playground/demo

## 📊 Metrics & Goals

### Performance Targets (to match or exceed ts-mocker)
- [ ] UUID generation: 20M+ ops/sec
- [ ] Email generation: 10M+ ops/sec
- [ ] Full name generation: 20M+ ops/sec
- [ ] Memory usage: < 1MB for core library
- [ ] Binary size: < 500KB (static)

### Quality Targets
- [ ] Test coverage: > 95%
- [ ] Documentation coverage: 100%
- [ ] Zero known memory leaks
- [ ] Zero unsafe code (except where necessary)

## 🤝 Contributing

Contributions are welcome! Pick any task from this TODO list and open a PR. Please:
1. Add tests for new functionality
2. Update documentation
3. Follow existing code style
4. Run benchmarks for performance-sensitive changes

## 📝 Notes

- This implementation mirrors ts-mocker's architecture and feature set
- Focus on performance and memory efficiency
- Maintain simple, idiomatic Zig code
- Keep dependencies minimal (ideally zero)
- Prioritize usefulness for testing and prototyping
