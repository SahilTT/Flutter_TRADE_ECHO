# Trade Echo

Trade Echo is a modern Flutter application built with **Clean Architecture** and **BLoC** pattern for robust state management.

## 🏗️ Architecture Overview

The project follows the principles of **Clean Architecture**, separating the code into three main layers:

### 1. Domain Layer (The Core)
This is the most inner layer, which contains the business logic independent of any external frameworks.
- **Entities**: Business models (e.g., `UserEntity`).
- **Repositories (Interfaces)**: Abstract definitions of data operations.
- **Use Cases**: Specific business rules (e.g., `LoginUseCase`, `RegisterUseCase`).

### 2. Data Layer
Handles data retrieval from external sources and maps it to domain entities.
- **Models**: Data transfer objects (DTOs) with JSON serialization.
- **Repositories (Implementations)**: Concrete implementations of domain repositories.
- **Data Sources**: Interaction with external APIs (Remote) or Databases (Local).

### 3. Presentation Layer
Contains the UI and state management logic.
- **BLoC**: Handles events and emits states based on business logic.
- **Screens**: Full pages of the application.
- **Widgets**: Reusable UI components.

---

## 📂 Project Structure

```text
lib/
├── config/
│   ├── di/
│   │   └── injection_container.dart
│   ├── router/
│   │   └── app_router.dart
│   └── theme/
│       ├── app_colors.dart
│       └── app_theme.dart
├── core/
│   ├── error/
│   │   ├── exceptions.dart
│   │   └── failures.dart
│   ├── network/
│   │   └── network_info.dart
│   ├── usecase/
│   │   └── usecase.dart
│   └── utils/
│       └── constants.dart
├── features/
│   └── auth/
│       ├── data/
│       │   ├── datasources/
│       │   │   ├── auth_remote_data_source.dart
│       │   │   └── auth_remote_data_source_impl.dart
│       │   ├── models/
│       │   │   └── auth_model.dart
│       │   └── repositories/
│       │       └── auth_repository_impl.dart
│       ├── domain/
│       │   ├── entities/
│       │   │   └── auth_entity.dart
│       │   ├── repositories/
│       │   │   └── auth_repository.dart
│       │   └── usecases/
│       │       ├── forgot_password_use_case.dart
│       │       ├── login_use_case.dart
│       │       └── register_use_case.dart
│       └── presentation/
│           ├── bloc/
│           │   ├── auth_bloc.dart
│           │   ├── auth_event.dart
│           │   └── auth_state.dart
│           ├── screens/
│           │   ├── forgot_password_screen.dart
│           │   ├── register_screen.dart
│           │   └── sign_in_screen.dart
│           └── widgets/
│               └── common_dark_textfield.dart
└── main.dart
```

---

## 🛠️ Key Technologies

- **State Management**: [flutter_bloc](https://pub.dev/packages/flutter_bloc)
- **Routing**: [go_router](https://pub.dev/packages/go_router)
- **Dependency Injection**: [get_it](https://pub.dev/packages/get_it)
- **Data Persistence**: [shared_preferences](https://pub.dev/packages/shared_preferences)
- **Network**: [http](https://pub.dev/packages/http) & [connectivity_plus](https://pub.dev/packages/connectivity_plus)
- **Utilities**: [equatable](https://pub.dev/packages/equatable) & [dartz](https://pub.dev/packages/dartz) (for Functional Programming)

## 🚀 Getting Started

1. **Clone the repository**
2. **Install dependencies**: `flutter pub get`
3. **Run the app**: `flutter run`

---

## ✨ Features Implemented

- **Sign In**: Secure login with field validation.
- **Registration**: High-fidelity signup with password strength indicators.
- **Forgot Password**: Email-based reset link simulation.
- **Consolidated Design System**: Unified colors and utilities for a premium look.
- **Robust API Simulation**: Realistic loading states and background processing simulation.
