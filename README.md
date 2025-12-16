# Connectly - Ride Sharing App

Connectly is a Flutter-based ride-sharing application that connects drivers with empty seats to passengers traveling in the same direction. The app enables cost-sharing for trips with automatic fare splitting and a rating system.

## 🚀 Quick Start

**New to this project?** Start here: **[SETUP_GUIDE.md](SETUP_GUIDE.md)**

The setup guide includes:
- Prerequisites and installation steps
- Configuration instructions
- Troubleshooting tips
- Learning resources

## 📋 Quick Setup Commands

```bash
# Install dependencies
flutter pub get

# Run the app
flutter run

# Check for issues
flutter doctor
```

## 📱 Features

- **Driver Mode**: Create trips, manage requests, track earnings
- **Passenger Mode**: Search trips, request rides, track bookings
- **Real-time Features**: Location tracking, in-app chat (backend integration needed)
- **Payment System**: Automatic fare splitting (80% driver, 20% platform)
- **Rating System**: Build trust through user ratings

## 🏗️ Project Structure

```
lib/
├── main.dart                 # App entry point
├── models/                   # Data models (User, Trip, etc.)
├── providers/                # State management (AuthProvider, TripProvider)
├── screens/                  # UI screens
│   ├── auth/                 # Login/Registration
│   ├── driver/               # Driver-specific screens
│   └── passenger/            # Passenger-specific screens
├── services/                 # Business logic (AuthService, TripService)
├── utils/                    # Utilities (Theme, Colors)
└── widgets/                  # Reusable UI components
```

## 🛠️ Tech Stack

**Target Technology Stack** (See [TECH_STACK.md](TECH_STACK.md) for complete details):

- **Frontend**: Flutter (Dart) with Material Design 3
- **Backend**: Supabase (Full Stack - Auth, Database, Storage, Functions)
- **Database**: PostgreSQL (via Supabase)
- **State Management**: Riverpod (target) | Provider (current)
- **Authentication**: Supabase Auth
- **Maps & Location**: Google Maps SDK for Flutter, Geolocator
- **Real-time**: Supabase Realtime
- **Notifications**: Firebase Cloud Messaging (FCM)
- **Storage**: Supabase Storage
- **Payments**: Mock Service → EcoCash/OneMoney APIs (via Supabase Edge Functions)

**Current Status**: App uses mock services. Migration to Supabase backend in progress.

## 📚 Documentation

- **[SETUP_GUIDE.md](SETUP_GUIDE.md)** - Complete setup instructions for students
- **[TECH_STACK.md](TECH_STACK.md)** - Detailed technology stack documentation
- **[QUICK_START.md](QUICK_START.md)** - Quick reference checklist
- **[PROMPT.md](PROMPT.md)** - Detailed app requirements and specifications

## ⚠️ Current Status

### Current Implementation:
- ✅ Flutter UI with Material Design 3
- ✅ Mock authentication (any credentials work)
- ✅ In-memory trip storage (resets on restart)
- ✅ Provider for state management

### Target Implementation (To Be Migrated):
- 🔄 **Supabase** backend integration
- 🔄 **Riverpod** state management
- 🔄 **Firebase Cloud Messaging** for push notifications
- 🔄 **Supabase Realtime** for live updates
- 🔄 **Payment gateway** integration

**See [SETUP_GUIDE.md](SETUP_GUIDE.md) for migration steps.**

## 🔗 Resources

- [Flutter Documentation](https://docs.flutter.dev/)
- [Supabase Documentation](https://supabase.com/docs)
- [Riverpod Documentation](https://riverpod.dev/)
- [Dart Language Tour](https://dart.dev/guides/language/language-tour)
- [Google Maps Flutter](https://pub.dev/packages/google_maps_flutter)
- [Firebase Cloud Messaging](https://firebase.google.com/docs/cloud-messaging)

---

**For detailed setup instructions, see [SETUP_GUIDE.md](SETUP_GUIDE.md)**
