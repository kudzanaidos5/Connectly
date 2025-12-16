# Connectly App - Student Setup Guide

This guide will help you get the Connectly ride-sharing app up and running on your development machine.

## 📋 Prerequisites

Before you begin, make sure you have the following installed:

### 1. Flutter SDK
- **Download**: Visit [https://docs.flutter.dev/get-started/install](https://docs.flutter.dev/get-started/install)
- **Version Required**: Flutter SDK 3.9.0 or higher
- **Verify Installation**: Open terminal/command prompt and run:
  ```bash
  flutter --version
  flutter doctor
  ```
- **Fix Issues**: Follow the suggestions from `flutter doctor` to install missing dependencies

### 2. Development IDE
Choose one of the following:
- **VS Code** (Recommended for beginners)
  - Install the Flutter extension from the VS Code marketplace
  - Install the Dart extension
- **Android Studio**
  - Install Flutter and Dart plugins
  - Configure Android SDK

### 3. Platform-Specific Requirements

#### For Android Development:
- **Android Studio** with Android SDK
- **Android SDK Platform 33** or higher
- **Android Emulator** or a physical Android device
- Enable **Developer Options** and **USB Debugging** on physical devices

#### For iOS Development (macOS only):
- **Xcode** (latest version from App Store)
- **CocoaPods**: `sudo gem install cocoapods`
- **iOS Simulator** or a physical iOS device

#### For Windows Development:
- **Visual Studio 2022** with "Desktop development with C++" workload
- **Windows 10 SDK**

## 🚀 Step-by-Step Setup

### Step 1: Clone or Download the Project
If you haven't already, navigate to the project directory:
```bash
cd ConnectlyApp/ConnectlyApp
```

### Step 2: Install Dependencies
Install all Flutter packages required by the project:
```bash
flutter pub get
```

This will download all dependencies listed in `pubspec.yaml`:
- **State Management**: Provider (target: Riverpod)
- **Backend**: Supabase Flutter (target tech stack)
- **HTTP & API**: Dio, HTTP
- **Location Services**: Geolocator & Google Maps
- **Storage**: Shared Preferences
- **Notifications**: Firebase Cloud Messaging (target tech stack)
- And more...

**Note**: See [TECH_STACK.md](TECH_STACK.md) for the complete target technology stack.

### Step 3: Verify Flutter Setup
Run Flutter doctor to check for any issues:
```bash
flutter doctor -v
```

Fix any issues shown in red before proceeding.

### Step 4: Set Up Supabase Backend (Required for Full Functionality)

The app is designed to use **Supabase** as the backend. This provides authentication, database, storage, and real-time features.

#### 4.1 Create a Supabase Project

1. **Sign up for Supabase**:
   - Go to [https://supabase.com](https://supabase.com)
   - Click "Start your project" or "Sign up"
   - Sign up with GitHub (recommended for students) or email
   - **Note**: Free tier is perfect for student projects!

2. **Create a New Project**:
   - Click "New Project"
   - Choose an organization (or create one)
   - Enter project details:
     - **Name**: `connectly-app` (or your preferred name)
     - **Database Password**: Create a strong password (save it!)
     - **Region**: Choose closest to you
   - Click "Create new project"
   - Wait 2-3 minutes for project to initialize

#### 4.2 Get Your Supabase Credentials

1. **Go to Project Settings**:
   - In your Supabase dashboard, click the gear icon (⚙️) → "Project Settings"
   - Navigate to "API" section

2. **Copy Your Credentials**:
   - **Project URL**: `https://xxxxx.supabase.co`
   - **anon/public key**: `eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...`
   - **service_role key**: (Keep this secret! Only for server-side)

#### 4.3 Add Supabase to Your Flutter App

1. **Install Supabase Flutter Package**:
   - The package should already be in `pubspec.yaml` as `supabase_flutter`
   - If not, add it:
   ```yaml
   dependencies:
     supabase_flutter: ^2.0.0
   ```
   - Run: `flutter pub get`

2. **Initialize Supabase** (if not already done):
   - Create or update `lib/main.dart` to initialize Supabase:
   ```dart
   import 'package:supabase_flutter/supabase_flutter.dart';
   
   void main() async {
     WidgetsFlutterBinding.ensureInitialized();
     
     await Supabase.initialize(
       url: 'YOUR_SUPABASE_URL',
       anonKey: 'YOUR_ANON_KEY',
     );
     
     runApp(const ConnectlyApp());
   }
   ```

3. **Create Environment File** (Recommended):
   - Create `.env` file in project root:
   ```
   SUPABASE_URL=https://xxxxx.supabase.co
   SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
   ```
   - Add `.env` to `.gitignore` (never commit secrets!)
   - Use `flutter_dotenv` package to load environment variables

#### 4.4 Set Up Database Schema

1. **Go to SQL Editor** in Supabase dashboard
2. **Create Tables** (you'll need to create these based on your data models):
   - `users` - User profiles
   - `trips` - Trip information
   - `trip_requests` - Passenger requests
   - `payments` - Payment transactions
   - `messages` - Chat messages
   - `ratings` - User ratings

3. **Enable Row Level Security (RLS)**:
   - This ensures users can only access their own data
   - Create RLS policies for each table

**Note**: For now, the app uses mock data. Supabase integration is the next step. See "Next Steps for Development" section.

### Step 5: Configure Google Maps (Optional but Recommended)

The app uses Google Maps for location features. To enable maps:

1. **Get a Google Maps API Key**:
   - Go to [Google Cloud Console](https://console.cloud.google.com/)
   - Create a new project or select an existing one
   - Enable "Maps SDK for Android" and/or "Maps SDK for iOS"
   - Create credentials (API Key)
   - Restrict the key to your app's package name for security

2. **Add API Key to Android**:
   - Open `android/app/src/main/AndroidManifest.xml`
   - Add the following inside the `<application>` tag:
   ```xml
   <meta-data
       android:name="com.google.android.geo.API_KEY"
       android:value="YOUR_API_KEY_HERE"/>
   ```

3. **Add API Key to iOS** (if developing for iOS):
   - Open `ios/Runner/AppDelegate.swift`
   - Add the API key initialization in the `application` method

**Note**: For testing purposes, you can skip this step, but maps won't work. The app will still run for other features.

### Step 6: Configure Location Permissions

#### Android:
The app needs location permissions. Open `android/app/src/main/AndroidManifest.xml` and add these permissions before the `<application>` tag:
```xml
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
```

#### iOS:
Open `ios/Runner/Info.plist` and add:
```xml
<key>NSLocationWhenInUseUsageDescription</key>
<string>We need your location to show nearby trips and track your ride.</string>
<key>NSLocationAlwaysUsageDescription</key>
<string>We need your location to track trips in real-time.</string>
```

### Step 7: Run the App

#### Option A: Run on Emulator/Simulator
1. **Start an Emulator**:
   - Android: Open Android Studio → AVD Manager → Start an emulator
   - iOS: Open Xcode → Window → Devices and Simulators → Start a simulator

2. **Run the App**:
   ```bash
   flutter run
   ```

#### Option B: Run on Physical Device
1. **Android**:
   - Enable USB Debugging on your device
   - Connect via USB
   - Run: `flutter run`

2. **iOS** (macOS only):
   - Connect your iPhone/iPad
   - Trust the computer on your device
   - Run: `flutter run`

#### Option C: Run on Specific Platform
```bash
flutter run -d android    # Android only
flutter run -d ios        # iOS only
flutter run -d windows    # Windows only
```

### Step 8: Test the App

1. **Login Screen**: The app starts with a login screen
   - Currently uses mock authentication (any email/password works)
   - You can register a new account

2. **Driver Mode**: 
   - Create trips, view earnings dashboard, manage requests

3. **Passenger Mode**:
   - Search for trips, request to join, view ride history

## 🛠️ Troubleshooting

### Issue: `flutter pub get` fails
**Solution**: 
- Check your internet connection
- Run `flutter clean` then `flutter pub get`
- Ensure you're using Flutter 3.9.0+

### Issue: Android build fails
**Solution**:
- Run `flutter clean`
- Delete `android/.gradle` folder
- Run `flutter pub get`
- Try `flutter run` again

### Issue: "SDK location not found"
**Solution**:
- Set `ANDROID_HOME` environment variable
- Or configure SDK location in Android Studio

### Issue: Maps not showing
**Solution**:
- Verify Google Maps API key is correctly added
- Check API key restrictions in Google Cloud Console
- Ensure Maps SDK is enabled for your project

### Issue: Location permissions not working
**Solution**:
- Verify permissions are added to AndroidManifest.xml (Android)
- Check Info.plist (iOS)
- Grant permissions manually in device settings

### Issue: App crashes on startup
**Solution**:
- Check `flutter doctor` for missing dependencies
- Review error logs: `flutter run --verbose`
- Ensure all dependencies are installed: `flutter pub get`

## 📱 Current App Status

### ✅ Working Features (Current Implementation):
- User authentication (mock implementation)
- Driver and Passenger mode switching
- Trip creation (driver)
- Trip search (passenger)
- Request/approval system
- Basic UI navigation
- Material Design 3 UI

### ⚠️ Needs Migration to Target Tech Stack:

**Current → Target**:
- ❌ **Provider** → **Riverpod** (State Management)
- ❌ **Mock Services** → **Supabase** (Backend)
- ❌ **Local Notifications** → **Firebase Cloud Messaging** (Push Notifications)
- ⚠️ **In-Memory Storage** → **Supabase PostgreSQL** (Database)
- ⚠️ **No Real-time** → **Supabase Realtime** (Live Updates)

### 🎯 Target Features (To Be Implemented):
- Real authentication via Supabase Auth
- Persistent database (PostgreSQL via Supabase)
- Real-time location tracking
- In-app chat with real-time messaging
- Payment processing (EcoCash/OneMoney integration)
- Push notifications via FCM
- File storage (Supabase Storage for images/documents)

## 🎓 Learning Resources

- **Flutter Documentation**: [https://docs.flutter.dev/](https://docs.flutter.dev/)
- **Dart Language Tour**: [https://dart.dev/guides/language/language-tour](https://dart.dev/guides/language/language-tour)
- **Supabase Documentation**: [https://supabase.com/docs](https://supabase.com/docs)
- **Supabase Flutter**: [https://pub.dev/packages/supabase_flutter](https://pub.dev/packages/supabase_flutter)
- **Riverpod Documentation**: [https://riverpod.dev/](https://riverpod.dev/)
- **Provider Package** (Current): [https://pub.dev/packages/provider](https://pub.dev/packages/provider)
- **Google Maps Flutter**: [https://pub.dev/packages/google_maps_flutter](https://pub.dev/packages/google_maps_flutter)
- **Firebase Cloud Messaging**: [https://firebase.google.com/docs/cloud-messaging](https://firebase.google.com/docs/cloud-messaging)

## 🔄 Next Steps for Development

### Phase 1: Backend Integration (Priority)
1. **Complete Supabase Setup**:
   - Create database schema (users, trips, trip_requests, payments, messages, ratings)
   - Set up Row Level Security (RLS) policies
   - Configure authentication providers (email, phone)

2. **Migrate from Mock to Supabase**:
   - Replace `AuthService` with Supabase Auth
   - Replace `TripService` with Supabase database calls
   - Implement real-time subscriptions for live updates

3. **Set Up Supabase Storage**:
   - Configure buckets for user photos and documents
   - Implement image upload functionality

### Phase 2: State Management Migration
1. **Migrate from Provider to Riverpod**:
   - Install `riverpod` and `flutter_riverpod` packages
   - Convert providers to Riverpod providers
   - Update all screens to use Riverpod

### Phase 3: Real-time Features
1. **Firebase Cloud Messaging**:
   - Set up Firebase project
   - Configure FCM for iOS and Android
   - Implement push notification handlers

2. **Supabase Realtime**:
   - Enable real-time subscriptions for trips
   - Implement live location tracking
   - Real-time chat messaging

### Phase 4: Payment Integration
1. **Payment Gateway Setup**:
   - Research EcoCash/OneMoney APIs
   - Create Supabase Edge Functions for payment processing
   - Implement payment webhooks
   - Add transaction history

### Phase 5: Testing & Polish
1. **Testing**:
   - Write unit tests for services
   - Add widget tests for UI components
   - Integration tests for critical flows
   - Test on multiple devices and platforms

2. **Performance Optimization**:
   - Optimize database queries
   - Implement caching strategies
   - Optimize image loading

**See [TECH_STACK.md](TECH_STACK.md) for complete technology stack details.**

## 💡 Tips for Students

- **Start Small**: Focus on one feature at a time
- **Read the Code**: Explore `lib/` folder to understand the structure
- **Use Debug Mode**: Run with `flutter run` to see helpful error messages
- **Hot Reload**: Press `r` in terminal while app is running to see changes instantly
- **Check Logs**: Use `flutter run --verbose` for detailed error information
- **Git**: Use version control to track your changes

## 📞 Getting Help

If you encounter issues:
1. Check Flutter documentation
2. Search Stack Overflow
3. Review error messages carefully
4. Check the `PROMPT.md` file for app requirements
5. Consult with your instructor or classmates

---

**Happy Coding! 🚀**

