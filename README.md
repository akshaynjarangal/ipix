## Project Structure

The project follows a standard Flutter application structure:

- `lib/`: Contains the main application code.
  - `main.dart`: The entry point of the app.
  - `screens/`: Contains various pages/screens of the app.
  - `data/models/`: Contains data models used within the app.
  - `data/services/`: Contains services responsible for handling API calls and data operations.
  - `data/repositories`: Contains repository classes and helper functions.
  - `logic/`: Contains BLoCs (Business Logic Components) for state management.

## Dependencies

The project uses the following Flutter packages for common functionalities:

- `flutter_bloc`: For implementing the BLoC pattern and state management.
- `equatable`: For easy comparison of objects to implement value equality.
- `http`: For making API calls and handling HTTP requests.
- `shared_preferences`: For simple and persistent local storage of app preferences.
- `dartz`: For functional programming in Dart, providing options, and other algebraic data types.
- `shimmer`: For creating shimmering loading effects for placeholders in the UI.
- `url_launcher`: For launching URLs and navigating to external web pages.

Please ensure you have the required dependencies installed before running the project.

## Flutter Version
This project created with SDK v3.10.5 and following Material3 Design
