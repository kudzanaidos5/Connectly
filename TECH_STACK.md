# Connectly App - Technology Stack

This document outlines the complete technology stack used in the Connectly ride-sharing application.

## 📱 Frontend Layer

### Flutter (Cross-Platform Mobile Framework)
**Purpose**: Cross-platform mobile app UI  
**Why Perfect for Students**:
- Single codebase for iOS & Android
- Industry-standard skill
- Great for portfolios
- Rich widget library
- Hot reload for fast development

**Version**: Flutter SDK 3.9.0+

---

## 🗄️ Backend Layer

### Supabase (Full Stack Backend)
**Purpose**: Complete backend solution  
**Why Perfect for Students**:
- Everything in one platform (Auth, Database, Storage, Functions)
- No server management required
- Free generous tier (perfect for student projects)
- Built-in real-time capabilities
- Excellent documentation and community support

**Services Used**:
- Supabase Auth (authentication)
- Supabase Database (PostgreSQL)
- Supabase Storage (file uploads)
- Supabase Realtime (live updates)
- Supabase Edge Functions (serverless functions)

---

## 💾 Database Layer

### PostgreSQL (via Supabase)
**Purpose**: Relational database for all app data  
**Why Perfect for Students**:
- Auto-managed by Supabase
- Learn industry-standard SQL
- Built-in backups and migrations
- Real-time subscriptions
- Row Level Security (RLS) for data protection

**Key Tables**:
- `users` - User profiles and authentication
- `trips` - Trip information
- `trip_requests` - Passenger requests
- `payments` - Payment transactions
- `messages` - In-app chat
- `ratings` - User ratings and reviews

---

## 🔐 Authentication Layer

### Supabase Auth
**Purpose**: User login & security  
**Why Perfect for Students**:
- Phone/Email/OTP support
- Built-in JWT tokens
- Row Level Security (RLS) policies
- No coding required for basic auth
- Social login options (Google, Apple, etc.)
- Magic link authentication

**Features**:
- Email/Password authentication
- Phone number authentication (OTP)
- Social providers
- Session management
- Password reset flows

---

## ⚙️ Server Logic Layer

### PostgreSQL Functions + Supabase Edge Functions
**Purpose**: Business logic execution  
**Why Perfect for Students**:

**PostgreSQL Functions**:
- Fast data operations
- Fare calculations
- Trip matching algorithms
- Data validation
- Trigger-based automation

**Supabase Edge Functions** (TypeScript/Deno):
- External API calls (payments, notifications)
- Globally distributed
- Auto-scaling
- Webhook handlers
- Payment processing integration

---

## 🗺️ Maps & Location Layer

### Google Maps SDK for Flutter
**Purpose**: Route display & live tracking  
**Why Perfect for Students**:
- Free for students (with generous limits)
- Excellent documentation
- Native Flutter integration
- Familiar interface
- Route planning and navigation
- Real-time location tracking

**Additional Packages**:
- `google_maps_flutter` - Map display
- `geolocator` - Location services
- `geocoding` - Address conversion

---

## 💳 Payment Layer

### Mock Payment Service + Supabase Functions
**Purpose**: Payment simulation and processing  
**Why Perfect for Students**:

**Phase 1: Mock Service**
- Safe testing environment
- Learn payment flows
- No real money involved
- Test all scenarios

**Phase 2: Real Integration**
- EcoCash API integration
- OneMoney API integration
- Edge Functions handle webhooks
- Secure payment processing

---

## 🎯 State Management Layer

### Riverpod
**Purpose**: App state & data flow  
**Why Perfect for Students**:
- Updated from Provider (more powerful)
- Type-safe state management
- Better for complex apps
- Industry trend in 2025
- Excellent DevTools
- Compile-time safety

**Note**: Current codebase uses Provider, migration to Riverpod recommended.

---

## 📁 File Storage Layer

### Supabase Storage
**Purpose**: User photos & documents  
**Why Perfect for Students**:
- Integrated with Supabase
- Easy image uploads
- CDN for fast delivery
- Free generous storage
- Automatic image optimization
- Secure file access

**Use Cases**:
- User profile pictures
- Driver license documents
- Vehicle registration documents
- Insurance documents

---

## 🔔 Notifications Layer

### Firebase Cloud Messaging (FCM)
**Purpose**: Push notifications  
**Why Perfect for Students**:
- Industry standard
- Works with both iOS & Android
- Free unlimited notifications
- Reliable delivery
- Easy integration with Flutter
- Background notifications

**Notification Types**:
- Trip request approvals/denials
- New messages
- Trip reminders
- Payment confirmations
- Trip status updates

---

## 🔄 Real-time Updates Layer

### Supabase Realtime
**Purpose**: Live trip updates & location  
**Why Perfect for Students**:
- WebSocket-based communication
- Instant data sync
- Works offline
- Built into Supabase
- No additional setup needed
- Real-time location tracking

**Use Cases**:
- Live trip status updates
- Real-time location sharing
- Instant message delivery
- Live passenger count updates

---

## 🎨 UI Design Layer

### Material Design 3 (Flutter)
**Purpose**: Beautiful modern UI  
**Why Perfect for Students**:
- Flutter's latest design system
- Pre-built components
- Professional appearance
- Follows Google standards
- Customizable themes
- Responsive design

**Design System**:
- **Passenger UI**: Purple gradient (`#667eea` to `#764ba2`)
- **Driver UI**: Pink/Red gradient (`#f093fb` to `#f5576c`)
- Material 3 components
- Custom app theme

---

## 💻 Development Tools

### Visual Studio Code
**Purpose**: Development environment  
**Why Perfect for Students**:
- Free & powerful
- Flutter/Dart extensions
- Git integration
- Debugging tools
- IntelliSense support
- Integrated terminal

**Recommended Extensions**:
- Flutter
- Dart
- Supabase
- GitLens
- Error Lens

---

## 📦 Version Control

### GitHub
**Purpose**: Team collaboration  
**Why Perfect for Students**:
- Industry standard
- Free for students (GitHub Education Pack)
- Code reviews
- Project management tools
- CI/CD integration
- Issue tracking

---

## 🧪 Testing Layer

### Flutter Test + Supabase Test Environment
**Purpose**: Quality assurance  
**Why Perfect for Students**:
- Unit tests for Flutter
- Integration tests
- Widget tests
- Local Supabase for testing
- Test coverage reports
- Automated testing

**Testing Tools**:
- `flutter_test` - Unit & widget tests
- `integration_test` - Integration tests
- Supabase Local Development
- Mock services for testing

---

## 📊 Project Management

### GitHub Projects + Discord
**Purpose**: Team coordination  
**Why Perfect for Students**:
- Track tasks & bugs
- Sprint planning
- Team communication
- Free for students
- Kanban boards
- Milestone tracking

---

## 📚 Additional Packages

### Core Dependencies
```yaml
# State Management
riverpod: ^2.x.x  # (Currently using provider, migration recommended)

# HTTP & API
dio: ^5.4.0
http: ^1.2.0

# Supabase
supabase_flutter: ^2.x.x

# Location Services
geolocator: ^11.0.0
google_maps_flutter: ^2.5.0

# Local Storage
shared_preferences: ^2.2.2

# Date/Time
intl: ^0.19.0

# Image Loading
cached_network_image: ^3.3.1

# Notifications
firebase_messaging: ^14.x.x
flutter_local_notifications: ^17.2.3
```

---

## 🏗️ Architecture Overview

```
┌─────────────────────────────────────────┐
│         Flutter Frontend                │
│  (Material Design 3 UI)                 │
└──────────────┬──────────────────────────┘
               │
               ├── State Management (Riverpod)
               ├── Navigation (GoRouter)
               └── Local Storage (SharedPreferences)
                       │
                       ▼
┌─────────────────────────────────────────┐
│         Supabase Backend                │
│  ┌──────────────────────────────────┐   │
│  │  Supabase Auth                   │   │
│  │  (JWT, Sessions, RLS)            │   │
│  └──────────────────────────────────┘   │
│  ┌──────────────────────────────────┐   │
│  │  PostgreSQL Database             │   │
│  │  (Users, Trips, Payments)        │   │
│  └──────────────────────────────────┘   │
│  ┌──────────────────────────────────┐   │
│  │  Supabase Realtime               │   │
│  │  (WebSockets, Live Updates)      │   │
│  └──────────────────────────────────┘   │
│  ┌──────────────────────────────────┐   │
│  │  Supabase Storage                │   │
│  │  (Images, Documents)             │   │
│  └──────────────────────────────────┘   │
│  ┌──────────────────────────────────┐   │
│  │  Edge Functions                   │   │
│  │  (Payment, Notifications)         │   │
│  └──────────────────────────────────┘   │
└──────────────┬──────────────────────────┘
               │
               ▼
┌─────────────────────────────────────────┐
│      External Services                  │
│  • Google Maps API                      │
│  • Firebase Cloud Messaging             │
│  • Payment Gateways (EcoCash/OneMoney)  │
└─────────────────────────────────────────┘
```

---

## 🎓 Learning Path for Students

1. **Week 1-2**: Flutter Basics & UI
   - Flutter widgets and layouts
   - Material Design 3
   - Navigation

2. **Week 3-4**: State Management
   - Riverpod fundamentals
   - State providers
   - Async state handling

3. **Week 5-6**: Backend Integration
   - Supabase setup
   - Authentication
   - Database operations

4. **Week 7-8**: Advanced Features
   - Real-time updates
   - Location services
   - File uploads

5. **Week 9-10**: Payment & Notifications
   - Payment integration
   - Push notifications
   - Edge Functions

---

## 🔄 Migration Notes

**Current State → Target State**:
- ✅ Flutter: Already using
- ⚠️ Provider → Riverpod: Migration recommended
- ⚠️ Mock Services → Supabase: Backend integration needed
- ⚠️ Local Notifications → FCM: Push notification setup needed
- ✅ Material Design: Already using

---

## 📖 Resources

- [Flutter Documentation](https://docs.flutter.dev/)
- [Supabase Documentation](https://supabase.com/docs)
- [Riverpod Documentation](https://riverpod.dev/)
- [Google Maps Flutter](https://pub.dev/packages/google_maps_flutter)
- [Firebase Cloud Messaging](https://firebase.google.com/docs/cloud-messaging)

---

**Last Updated**: 2025

