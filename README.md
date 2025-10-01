# Drinkit iOS

An iOS app built with SwiftUI to explore, save, and craft cocktails using TheCocktailDB API as data source.

## Features

- **Explore Cocktails**: Browse random cocktails, search by first letter, and filter by ingredients
- **Search & Filter**: Find cocktails by name, ingredient, category, glass type, or alcoholic content
- **Favorites**: Save your favorite cocktails locally with SwiftData persistence
- **Detailed Information**: View complete cocktail recipes with ingredients, measurements, and instructions
- **Localization**: Instructions available in Spanish and English based on system preferences
- **Responsive UI**: Pull-to-refresh, loading states, empty states, and smooth transitions

## Technical Highlights

### Architecture
- **MV Pattern** with separate State Management layer
- **Type-safe navigation** using enum-based routing system with dedicated routers
- **Modular structure** with clear separation of concerns (Models, Services, Managers, Views, State)

### Networking
- **Async/await** with modern Swift Concurrency
- **Parallel requests** using TaskGroup for optimal performance
- **Intelligent caching** with 5-minute refresh interval to reduce unnecessary API calls
- **Response caching** prevents duplicate requests during the same session
- **Error handling** with custom RequestStatus enum and timeout configuration
- **Combine publishers** for reactive search functionality

### Performance & UX
- **Image caching** with Kingfisher for smooth scrolling
- **Smart loader** with delay to avoid flashes on fast requests
- **SwiftData** for efficient local persistence of favorites
- **Pull-to-refresh** with configurable refresh policies
- **Deduplication** of random cocktail results

### Modern Swift Features
- **Swift Actors** for thread-safe networking
- **@Observable macro** for state management
- **SwiftData** for persistence
- **TaskGroup** for concurrent operations
- **Custom Property Wrappers** (@ObservableUserDefault)

### Code Quality
- **SOLID principles** applied throughout
- **Custom ViewModifiers** for reusable UI components
- **Extensions** for organized code structure
- **Unit tests** included

## Requirements

* Xcode 16.4+
* iOS 17.0+
* SwiftUI

## Getting Started

1. Clone the repository to your local machine
2. Open `Drinkit.xcodeproj` in Xcode
3. Build and run the project

## Dependencies (Swift Package Manager)

- **Alamofire** ([GitHub](https://github.com/Alamofire/Alamofire)): HTTP networking library with async/await support
- **Kingfisher** ([GitHub](https://github.com/onevcat/Kingfisher)): Image downloading and caching library
- **ObservableUserDefault** ([GitHub](https://github.com/davidsteppenbeck/ObservableUserDefault)): Swift macro for @Observable properties that sync with UserDefaults

## Project Structure

```
Drinkit/
├── Models/
│   ├── Domain/          # API response models
│   └── Persistence/     # SwiftData models
├── Services/            # API layer (CocktaildbWebServices)
├── Managers/            # Shared managers (WebService, Loader, Haptic)
├── State Management/    # Observable state classes
├── User Interfaces/     # SwiftUI views and screens
│   └── App/
│       ├── Categories/
│       ├── Cocktails/
│       ├── Favorites/
│       ├── Home/
│       └── MainTab/
├── Extensions/          # Swift extensions
├── Modifiers/           # Custom ViewModifiers
├── Resources/           # Assets, fonts, colors
└── Utils/               # Helper utilities
```

## Design Pattern

The design pattern chosen for this project is **MV (Model-View)** with a dedicated State Management layer:

- **Models**: Data structures (Cocktail, DrinkResponse, FavoriteCocktail)
- **Views**: SwiftUI views with minimal logic
- **State**: Observable classes that handle business logic and API calls (@Observable macro)

This approach leverages Swift's modern observation system while keeping views clean and testable.

## API

This app uses [TheCocktailDB API](https://www.thecocktaildb.com/api.php) to fetch cocktail data.

## License

This project is available for review purposes as part of a technical assessment.