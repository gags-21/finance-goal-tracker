# Financial Goal Tracker

Visualizing and tracking Financial goals.

This Goal Tracker is a Flutter application designed to help users manage their financial goals by tracking savings. It offers real-time data updates, Google sign-in for authentication, along with a visually appealing and user-friendly interface.

## Features

- Google authentication for easy sign-in.
- Real-time savings tracker with a radial gauge chart.
- Financial goal setting and monitoring for long-term savings plans.
- Transaction history for keeping tabs on your daily savings.
- Predictive analysis based on current saving trends.
- Provider pattern for state management ensuring efficient data flow.

## Preview

The app comprises three main screens:

### Login Screen
Users can sign in conveniently using their Google account.

```dart
LoginScreen();
```

### Home Screen
Displays the current savings with a goal tracker gauge and a transaction history list.

```dart
HomeScreen();
```

### Tracker Screen
Allows users to set and submit financial targets for long-term goals such as buying a home.

```dart
TrackerScreen();
```

## Getting Started

To build and run the app on your device, follow these steps:

1. **Clone the repository:**

```sh
git clone https://github.com/gags-21/finance-goal-tracker.git
```

2. **Navigate to the project directory:**

```sh
cd finance-goal-tracker
```

3. **Install dependencies:**

```sh
flutter pub get
```

4. **Run the app:**

```sh
flutter run
```

> Please first submit goal target amount & monthly target amount in Tracker screen.

## Screenshots

<img src="https://github.com/gags-21/finance-goal-tracker/assets/61724325/76257ef2-e23d-4895-8f68-fa894bae4bf1" alt="Login Screen" height="500"/>

<img src="https://github.com/gags-21/finance-goal-tracker/assets/61724325/1edcf092-8c3d-482b-a487-a999a6d86e19" alt="Home Screen" height="500"/>

<img src="https://github.com/gags-21/finance-goal-tracker/assets/61724325/ea509004-b235-418a-afbf-1d7b0c5e9ed8" alt="Tracking Screen" height="500"/>
