# Connectly App - Quick Start Checklist

Use this checklist to quickly get the app running. For detailed instructions, see [SETUP_GUIDE.md](SETUP_GUIDE.md).

## ✅ Pre-Flight Checklist

- [ ] Flutter SDK installed (3.9.0+)
- [ ] `flutter doctor` shows no critical issues
- [ ] IDE installed (VS Code or Android Studio)
- [ ] Android Emulator/iOS Simulator ready OR physical device connected

## 🚀 Setup Steps

1. **Install Dependencies**
   ```bash
   flutter pub get
   ```

2. **Set Up Supabase** (Required for full functionality)
   - Sign up at [supabase.com](https://supabase.com) (free tier)
   - Create a new project
   - Copy your project URL and anon key
   - Add credentials to your app (see [SETUP_GUIDE.md](SETUP_GUIDE.md) Step 4)

3. **Add Location Permissions** (Required)
   
   **Android**: Edit `android/app/src/main/AndroidManifest.xml`
   ```xml
   <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
   <uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
   ```
   
   **iOS**: Edit `ios/Runner/Info.plist` (add location usage descriptions)

4. **Configure Google Maps** (Optional - for maps to work)
   - Get API key from [Google Cloud Console](https://console.cloud.google.com/)
   - Add to `android/app/src/main/AndroidManifest.xml`:
   ```xml
   <meta-data
       android:name="com.google.android.geo.API_KEY"
       android:value="YOUR_API_KEY_HERE"/>
   ```

5. **Run the App**
   ```bash
   flutter run
   ```

## 🧪 Test Login

- **Email**: Any email (e.g., `test@example.com`)
- **Password**: Any password (mock authentication)
- The app will create a test user automatically

## 🐛 Common Issues

| Issue | Quick Fix |
|-------|-----------|
| `flutter pub get` fails | Run `flutter clean` then `flutter pub get` |
| Build fails | Delete `android/.gradle`, run `flutter clean` |
| Maps not showing | Add Google Maps API key (see step 3) |
| Location not working | Add permissions (see step 2) |

## 📱 What Works Now

✅ Login/Registration (mock)  
✅ Driver mode with trip creation  
✅ Passenger mode with trip search  
✅ Request/approval flow  
✅ Basic navigation  

## ⚠️ What Needs Backend (Target: Supabase)

❌ Real authentication (Supabase Auth)  
❌ Persistent data storage (Supabase PostgreSQL)  
❌ Real-time location tracking (Supabase Realtime)  
❌ Payment processing (Supabase Edge Functions)  
❌ Chat functionality (Supabase Realtime)  
❌ Push notifications (Firebase Cloud Messaging)  

**See [TECH_STACK.md](TECH_STACK.md) for complete tech stack details.**  

---

**Need more help?** See [SETUP_GUIDE.md](SETUP_GUIDE.md) for detailed instructions.

