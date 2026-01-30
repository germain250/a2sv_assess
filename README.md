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


.
├── core
│   ├── constants
│   │   └── app_keys.dart
│   ├── database
│   ├── error
│   │   └── failures.dart
│   ├── network
│   │   ├── api_client.dart
│   │   └── network_info.dart
│   ├── theme
│   │   ├── app_theme.dart
│   │   └── theme_cubit.dart
│   └── widgets
│       ├── bottom_bar_item.dart
│       └── empty_state.dart
├── features
│   └── countries
│       ├── bloc
│       │   ├── country_bloc.dart
│       │   ├── country_event.dart
│       │   └── country_state.dart
│       ├── data
│       │   ├── datasources
│       │   │   ├── country_local_datasource.dart
│       │   │   ├── country_remote_datasource.dart
│       │   │   └── favorite_local_datasource.dart
│       │   ├── models
│       │   │   └── country_model.dart
│       │   └── repositories
│       │       └── country_repository_impl.dart
│       ├── domain
│       │   ├── entities
│       │   │   └── country.dart
│       │   └── repositories
│       │       └── country_repository.dart
│       └── presentation
│           ├── screens
│           │   ├── country_details_screen.dart
│           │   ├── favorite_screen.dart
│           │   └── home_screen.dart
│           └── widgets
│               ├── country_card.dart
│               ├── country_details_skeleton.dart
│               ├── country_search_bar.dart
│               ├── skeleton_loader.dart
│               ├── stat_row.dart
│               └── timezone_chip.dart
├── folder_structure
└── main.dart

21 directories, 29 files

## Future Improvements

-Use hive for offline first app
-Localization to enhence accessibility


### Steps
```bash
git clone https://github.com/germain250/a2sv_assess.git
cd a2sv_assess
flutter pub get
flutter run
flutter build apk --release