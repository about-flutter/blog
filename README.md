# Flutter Blog Application

A modern blog application built with Flutter using Clean Architecture, BLoC pattern, and modular design.

## Features

- User authentication (sign up, login, logout)
- Create and manage blog posts
- Offline support with local caching
- Display blog posts with author information

## Refactored Improvements

1. **Standardized Project Structure**: Consistent folder organization and naming conventions
2. **Dependency Injection**: Proper DI with Flutter Modular and singleton management
3. **Navigation**: Centralized routing with guards and a navigation service
4. **Error Handling**: Comprehensive error handling system with proper exceptions and failures
5. **Local Storage**: Efficient caching with Hive TypeAdapters
6. **Authentication**: Secure auth flow with proper session management
7. **Code Documentation**: Added meaningful documentation to classes and methods

## Tech Stack

- **Flutter**: UI framework
- **Supabase**: Backend service for authentication and data storage
- **flutter_bloc**: State management
- **flutter_modular**: Dependency injection and routing
- **Hive**: Local storage for offline support
- **fpdart**: Functional programming with Either type for error handling

## Project Structure

The application follows Clean Architecture principles with the following layers:

### Presentation Layer
- **Blocs/Cubits**: Manage UI state
- **Views**: UI screens
- **Widgets**: Reusable UI components

### Domain Layer
- **Entities**: Core business models
- **Repositories**: Abstract definitions of data operations
- **Usecases**: Business logic use cases

### Data Layer
- **Repositories Implementations**: Concrete implementations of repositories
- **Data Sources**: Remote and local data sources
- **Models**: Data models extending domain entities
