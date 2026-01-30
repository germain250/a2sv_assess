# discover

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


# Discover Countries App

A Flutter application for browsing countries and viewing detailed information, built using Clean Architecture and BLoC for state management.

---

## Setup & Run Locally

### Prerequisites
- Flutter SDK (stable)
- Dart SDK
- Android Studio / VS Code
- Emulator or physical device



## State Management

## BLoC (flutter_bloc) was chosen because it:

-Provides predictable and explicit state transitions

-Separates UI from business logic

-Scales well for medium to large applications

-Works naturally with Clean Architecture

## Architecture

### The project follows Clean Architecture to ensure:

-Clear separation of concerns
-Better maintainability and scalability
-Easier testing and refactoring
-Independence of UI from data sources

lib/
├── core/                        # Shared infrastructure
│   ├── constants/               # App-wide keys and strings
│   ├── database/                # Local database setup
│   ├── error/                   # Failures and Exception handling
│   ├── network/                 # API client and Network info
│   ├── theme/                   # App theme and Theme Cubit
│   └── widgets/                 # Reusable global UI components
│
├── features/                    # Feature-driven modules
│   └── countries/               # Countries feature module
│       ├── bloc/                # BLoC logic (Events & States)
│       ├── data/                # Repository impl & Data sources
│       ├── domain/              # Entities & Repository interfaces
│       └── presentation/        # UI Screens and Widgets
│
└── main.dart                    # Application entry point

## Future Improvements

- Use hive for offline first app
- Localization to enhence accessibility


### Steps
```bash
git clone https://github.com/germain250/a2sv_assess.git
cd a2sv_assess
flutter pub get
flutter run
flutter build apk --release