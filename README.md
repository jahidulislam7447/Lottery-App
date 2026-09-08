# LuckyDraw Flutter App

A Flutter recreation of the LuckyDraw lottery interface shown in the supplied reference image.

## Screens

- Entry/Login
- Home lottery number selection
- Latest Results
- Profile tab

## Requirements

- Flutter stable channel
- Dart SDK included with Flutter
- Android Studio or Xcode for native device builds

## Run locally

```bash
flutter pub get
flutter analyze
flutter test
flutter run
```

## Build

```bash
flutter build apk --release
flutter build appbundle --release
flutter build web --release
```

The app currently uses local UI state only. Authentication, payments, ticket persistence, and lottery APIs can be added behind the existing screen flow.
