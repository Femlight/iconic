# Iconic University - Location-Based Reporting App

A Flutter mobile application that allows users to create location-based reports with media attachments and GPS coordinates. Built using Clean Architecture principles and BLoC state management.

## 📱 Features

- **User Authentication**: Login/logout functionality with local storage
- **Report Creation**: Create detailed reports with categories and descriptions
- **Location Services**: 
  - Get current GPS location
  - Manual address input
  - Location coordinates embedded in reports
- **Media Attachments**: 
  - Capture photos/videos using device camera
  - Select media from gallery
  - Multiple media attachments per report
- **Report Management**: View list of submitted reports with filtering by category
- **Offline Support**: Local data persistence using SharedPreferences

## 🏗️ Architecture

This project follows **Clean Architecture** principles with the following structure:

```
lib/
├── core/
│   ├── error/
│   │   └── failures.dart
│   └── theme/
│       └── app_theme.dart
├── features/
│   ├── auth/
│   │   ├── data/
│   │   │   ├── datasources/
│   │   │   ├── models/
│   │   │   └── repositories/
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   ├── repositories/
│   │   │   └── usecases/
│   │   └── presentation/
│   │       ├── bloc/
│   │       ├── pages/
│   │       └── widgets/
│   ├── reports/
│   ├── location/
│   └── camera/
├── injection_container.dart
└── main.dart
```

### Architecture Layers

1. **Presentation Layer**: 
   - BLoC for state management
   - UI components (pages, widgets)
   - User input handling

2. **Domain Layer**: 
   - Business entities
   - Use cases (business logic)
   - Repository interfaces

3. **Data Layer**: 
   - Repository implementations
   - Data sources (local storage, APIs)
   - Data models

## 🛠️ Tech Stack

- **Framework**: Flutter 3.x
- **State Management**: BLoC Pattern
- **Dependency Injection**: GetIt
- **Local Storage**: SharedPreferences
- **Camera**: image_picker, camera packages
- **Location**: location package
- **Architecture**: Clean Architecture
- **Error Handling**: d (Either type)

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (>=3.0.0)
- Dart SDK (>=3.0.0)
- Android Studio / VS Code
- Android device or emulator
- iOS device or simulator (for iOS development)

### Installation

1. **Clone the repository**:
   ```bash
   git clone <repository-url>
   cd iconic_university
   ```

2. **Install dependencies**:
   ```bash
   flutter pub get
   ```

3. **Platform-specific setup**:

   **Android** (`android/app/src/main/AndroidManifest.xml`):
   ```xml
   <!-- Add before </application> -->
   <uses-permission android:name="android.permission.CAMERA" />
   <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
   <uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
   <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
   ```

   **iOS** (`ios/Runner/Info.plist`):
   ```xml
   <key>NSCameraUsageDescription</key>
   <string>This app needs camera access to capture photos and videos for reports.</string>
   <key>NSLocationWhenInUseUsageDescription</key>
   <string>This app needs location access to attach GPS coordinates to reports.</string>
   <key>NSPhotoLibraryUsageDescription</key>
   <string>This app needs photo library access to attach images to reports.</string>
   ```

4. **Run the app**:
   ```bash
   flutter run
   ```

## 📦 Dependencies

Add these to your `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_bloc: ^8.1.3
  equatable: ^2.0.5
  get_it: ^7.6.4
  shared_preferences: ^2.2.2
  location: ^5.0.3
  image_picker: ^1.0.4
  camera: ^0.10.5+5
  dartz: ^0.10.1
  intl: ^0.18.1

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^3.0.0
```

## 🔧 Configuration

### Authentication
- Currently uses mock authentication for demo purposes
- Any email with password >= 6 characters will authenticate
- User data is stored locally using SharedPreferences

### Location Services
- Requests location permissions on first use
- Falls back to manual address input if GPS unavailable
- Mock geocoding service (replace with real service in production)

### Media Storage
- Images and videos are stored locally on device
- Paths are stored in reports for reference
- Consider cloud storage for production use

## 📱 Usage

1. **Login**: Enter any valid email and password (min 6 chars)
2. **View Reports**: See all previously created reports
3. **Create Report**: 
   - Tap the + button
   - Fill in title, category, and description
   - Add location (GPS or manual)
   - Attach photos/videos
   - Submit report
4. **Logout**: Use the logout button in the top-right corner

## 🎨 UI Design Reference

The UI is inspired by the Figma design:
[Location-based reporting app with working maps](https://www.figma.com/design/ZH6xZhrbWPTFYlrbJSdrUt/Location-based-reporting-app-with-working-maps-and-admin-interface--Community-)

## 🔍 Testing

Run tests using:
```bash
flutter test
```

## 🚀 Production Considerations

For production deployment, consider:

1. **Backend Integration**: Replace local storage with REST API
2. **Real Geocoding**: Integrate Google Maps/MapBox for address lookup
3. **Authentication**: Implement proper JWT/OAuth authentication
4. **Media Upload**: Use cloud storage (AWS S3, Firebase Storage)
5. **Offline Sync**: Implement data synchronization when online
6. **Push Notifications**: Notify users of report status updates
7. **Analytics**: Add crash reporting and analytics
8. **Security**: Implement proper data encryption

## 🐛 Known Issues

- Location permission dialog may not appear on some Android versions
- Camera preview might not work on certain emulators
- Large video files may cause memory issues

## 📄 License

This project is created for assessment purposes at Iconic University.

## 🤝 Contributing

This is an assessment project. For educational purposes, you may:

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request

## 📞 Support

For technical support or questions about this assessment project, please contact the developer.
Joseph Aretola
Email: aretolafemi@gmail.com
Phone No: 08137140937(WhatsApp)
---

**Built with ❤️ using Flutter and Clean Architecture**
