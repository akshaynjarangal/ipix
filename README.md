
## Flutter Restaurants App

This Flutter application is designed to display a list of restaurants and their details. The app includes a Splash Screen, Login Screen, Home Screen, and Restaurant Details Screen. It fetches data from an API to populate the restaurant list and displays restaurant details when a restaurant is selected.

## Features

1. Splash Screen: Displays the app logo while initializing the app.
2. Login Screen: Allows users to log in using their email and password.
3. Home Screen: Lists restaurants with their basic information. Provides a logout button.
4. Restaurant Details Screen: Shows detailed information about a selected restaurant, including address, working days, rating, reviews, and a Google Maps link for directions.

## API

The app uses the following API to fetch restaurant data:
API Endpoint: `https://run.mocky.io/v3/b91498e7-c7fd-48bc-b16a-5cb970a3af8a`

## Screens

# Splash Screen
The Splash Screen displays the app logo while the app initializes. It transitions to the Login Screen after a brief period.

# Login Screen
The Login Screen allows users to log in using their email and password. Upon successful login, the app saves the email in local storage and redirects the user to the Home Screen.

# Home Screen
The Home Screen displays a list of restaurants, each with its restaurant image, name, rating, cuisine type, and address. The Home Screen fetches restaurant data from the API.

# Actions on Home Screen

1. Logout: Allows users to log out from the app. It redirects the user back to the Login Screen.
2. Restaurant Details Screen
The Restaurant Details Screen shows detailed information about a selected restaurant, including its image, name, neighborhood, cuisine type, address, working days, rating, and reviews. Additionally, it includes a "Directions" button that redirects the user to Google Maps using the restaurant's latitude and longitude.

## API Integration

The app fetches restaurant data from the provided API and displays it on the Home Screen. When a restaurant is selected, the app navigates to the Restaurant Details Screen with the selected restaurant's data.

## Project Structure

The project follows a standard Flutter application structure:

- `lib/`: Contains the main application code.
  - `main.dart`: The entry point of the app.
  - `src/screens/`: Contains various pages/screens of the app.
  - `src/data/models/`: Contains data models used within the app.
  - `src/data/services/`: Contains services responsible for handling API calls and data operations.
  - `src/data/repositories`: Contains repository classes and helper functions.
  - `src/logic/`: Contains BLoCs (Business Logic Components) for state management.

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
This project created with SDK `v3.10.5` and following `Material3` Design
