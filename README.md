# Flutter ChatGPT API Project

Welcome to the Flutter ChatGPT API project! This project demonstrates how to integrate the ChatGPT API into a Flutter application, allowing users to have natural language conversations with an AI-powered chatbot. Additionally, this project includes authentication methods for Google and Apple, providing a seamless login experience for your users.

## Getting Started

Follow these steps to get the project up and running on your local machine.

### Prerequisites

Before you begin, ensure that you have the following installed on your system:

- [Flutter](https://flutter.dev/docs/get-started/install)
- [Dart](https://dart.dev/get-dart)
- A code editor or IDE of your choice (e.g., Visual Studio Code)

### Setting up the Project

1. Clone this repository to your local machine:

   ```bash
   git clone https://github.com/yourusername/flutter-chatgpt-api.git
   ```

2. Navigate to the project directory:

   ```bash
   cd flutter-chatgpt-api
   ```

3. Install the project dependencies:

   ```bash
   flutter pub get
   ```

### Configuring ChatGPT API

To use ChatGPT in your project, you'll need an API key from OpenAI. Set up your API key in the `lib/services/chatgpt_service.dart` file:

```dart
static const String apiKey = 'YOUR_API_KEY_HERE';
```

### Setting up Google and Apple Authentication

To enable Google and Apple authentication, you'll need to configure the project in Firebase. Follow these steps:

1. Create a new project in the [Firebase Console](https://console.firebase.google.com/).

2. Add your Flutter app to the Firebase project. You will receive a `google-services.json` file that you should place in the `android/app` directory for Android and a `GoogleService-Info.plist` file that you should place in the `ios/Runner` directory for iOS.

3. Enable Google and Apple sign-in methods in the Firebase Authentication section of your project.

4. Make sure you have the necessary dependencies for Firebase in your `pubspec.yaml` file:

   ```yaml
   dependencies:
     firebase_core: ^latest_version
     firebase_auth: ^latest_version
   ```

5. Initialize Firebase in your Flutter app. This should be done in the `main.dart` file:

   ```dart
   void main() async {
     WidgetsFlutterBinding.ensureInitialized();
     await Firebase.initializeApp();
     runApp(MyApp());
   }
   ```

6. In your Firebase project settings, you can find configuration information that you should replace in the `lib/services/auth_service.dart` file.

### Running the App

You can now run the Flutter app on your device or emulator:

```bash
flutter run
```

## Features

- ChatGPT API integration for natural language conversations.
- Google and Apple authentication for easy user login.
- Extensible and customizable Flutter project structure.
- A clean and user-friendly UI for chat interactions.


