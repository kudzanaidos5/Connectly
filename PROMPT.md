# Connectly App Development Prompt

## Overview
Build a Flutter ride-sharing application called "Connectly" that connects drivers with empty seats to passengers traveling in the same direction. The app enables cost-sharing for trips, with automatic fare splitting and a rating system to build trust.

## Core Business Logic

### Step-by-Step Flow:

1. **Driver Posts Trip**
   - Driver has empty seats and posts a trip
   - Example: "I'm going from Point A to Point B at 2pm, I have 3 empty seats, fare is $15"
   - Driver specifies: origin, destination, departure time, available seats, total fare

2. **Passengers Search**
   - Passengers need rides and search for trips going their direction
   - Search filters: origin, destination, date/time, number of passengers

3. **System Matching**
   - System matches passengers with drivers going their way
   - Shows passengers which drivers are available for their route

4. **Request & Approval**
   - Passengers request to join a specific trip
   - Driver reviews and approves/denies passenger requests
   - Driver has full control over who can join their trip

5. **Automatic Payment Splitting**
   - Money splits automatically when passengers join
   - Example: If 3 passengers join a $15 trip:
     - Each passenger pays $5 (total $15)
     - Driver receives $12 (80% of total)
     - Connectly platform keeps $3 (20% commission)
   - Payment happens automatically when driver approves passengers

6. **Trip Execution**
   - Real-time location tracking during trip
   - In-app chat between driver and passengers
   - Boarding confirmation feature
   - Trip status updates (upcoming, in-progress, completed)

7. **Rating System**
   - After trip completion, drivers and passengers rate each other
   - Builds trust for future rides
   - Ratings displayed on profiles

## Technical Requirements

### Platform
- Flutter framework (Dart)
- Support for iOS and Android
- Modern, responsive UI design

### Key Features to Implement

#### Authentication & User Management
- User registration and login
- Separate user types: Driver and Passenger (users can be both)
- User profiles with ratings, ride history, and statistics
- Profile editing capabilities

#### Driver Features
- **Driver Dashboard:**
  - View earnings summary (Today, This Week, This Month)
  - Quick stats (Trips Today, Rating, Pending Requests)
  - One-tap "Create New Trip" button
- **Post new trips with:**
  - Pickup location (origin)
  - Drop-off location (destination)
  - Departure date and time
  - Number of available seats (1-4)
  - Base fare amount (total trip cost)
  - Vehicle type selection
  - Additional notes/instructions
- **Trip Management:**
  - View active trips with real-time status
  - See confirmed passengers list
  - View pending passenger requests with ratings
  - Approve/deny passenger requests (with one-tap buttons)
  - Start trip (activates live tracking)
  - Cancel trip functionality
  - View scheduled trips
- **Passenger Management:**
  - See passenger ratings before approval
  - Chat with confirmed passengers
  - View passenger verification status
- **Earnings Management:**
  - View total available balance
  - See earnings breakdown (weekly, monthly)
  - View average earnings per trip
  - Request payouts to EcoCash/OneMoney
  - View transaction history (earnings and payouts)
- **Trip History:**
  - View all trips (Active, Completed, Cancelled)
  - Filter by status
- **Real-time Features:**
  - Location sharing during active trips
  - Chat with passengers
  - Push notifications for new requests
- **Profile Management:**
  - Vehicle details management
  - Document upload (license, registration, insurance)
  - View ratings and reviews from passengers
  - Acceptance rate tracking

#### Passenger Features
- Search for available trips:
  - From (pickup location)
  - To (destination)
  - When (date and time)
  - Number of passengers
- View search results with:
  - Driver information (name, rating, number of rides)
  - Trip route (origin to destination)
  - Price per passenger
  - Available seats
  - Departure time
  - Vehicle information
- View detailed trip information
- Request to join trips
- View request status (pending, approved, denied)
- View "My Rides" with tabs:
  - Upcoming rides
  - Completed rides
  - Cancelled rides
- Real-time location tracking during active trips
- Chat with drivers
- View ride history and statistics

#### Payment System
- Automatic fare calculation:
  - Total fare ÷ number of passengers = price per passenger
  - Driver receives 80% of total fare
  - Platform commission: 20% of total fare
- Payment method integration (EcoCash, OneMoney mentioned in UI)
- Payment history and receipts
- Earnings dashboard for drivers

#### Messaging System
- In-app chat between drivers and passengers
- Message notifications
- Chat history
- Unread message indicators

#### Location Services
- Real-time GPS tracking during active trips
- Location-based search
- Route visualization
- Distance and duration calculations

#### Rating & Reviews
- Post-trip rating system (1-5 stars)
- Written reviews
- Rating display on profiles
- Trust building through ratings

## UI/UX Design Requirements

### Design System
- **Color Scheme:**
  - **Passenger UI Primary gradient:** `#667eea` to `#764ba2` (purple gradient)
  - **Driver UI Primary gradient:** `#f093fb` to `#f5576c` (pink/red gradient)
  - Success/Positive: `#27ae60` (green)
  - Error/Negative: `#e74c3c` (red)
  - Background: `#f8f9fa` (light gray)
  - Text: `#333` (dark gray), `#666` (medium gray), `#999` (light gray)

- **Typography:**
  - Modern, clean sans-serif font (similar to Segoe UI)
  - Clear hierarchy with different font sizes and weights

- **Components:**
  - Rounded corners (8-20px border radius)
  - Card-based design with shadows
  - Gradient headers
  - Bottom navigation bar
  - Consistent spacing and padding

### Passenger UI Pages

#### 1. Home Page
- Header with app name and tagline
- Search section with:
  - From (pickup location input)
  - To (destination input)
  - When (datetime picker)
  - Passengers (dropdown selector)
  - Search button
- Available rides list showing:
  - Driver avatar and name
  - Driver rating and ride count
  - Price per passenger
  - Route (origin → destination)
  - Departure time
  - Available seats
  - Vehicle type
  - Request button
- Bottom navigation (Home, My Rides, Messages, Profile)

#### 2. Trip Details Page
- Hero section with:
  - Back button
  - Driver avatar and name
  - Driver rating and stats
  - Price per passenger (large display)
- Trip route visualization:
  - Pickup location with timeline
  - Drop-off location with timeline
  - Estimated duration
- Trip details grid:
  - Available seats
  - Departure time
  - Distance
  - Duration
- Vehicle information card
- Trip policies/rules
- Action buttons:
  - "Request to Join" (primary)
  - Message driver (secondary)

#### 3. My Rides Page
- Header with title
- Status tabs: Upcoming, Completed, Cancelled
- Ride cards for each status
- Empty state when no rides
- Bottom navigation

#### 4. Messages Page
- Header with title
- Message list with:
  - Contact avatar
  - Contact name
  - Message preview
  - Timestamp
  - Unread indicator
- Bottom navigation

#### 5. Profile Page
- Profile header with:
  - User avatar
  - User name
  - Rating and role
- Statistics grid:
  - Total Rides
  - Money Saved (for passengers) / Total Earnings (for drivers)
  - On-Time Rate
- Menu items:
  - Edit Profile
  - Payment Methods
  - Ride History
  - Settings
  - Help Center
  - Logout
- Bottom navigation

### Driver UI Pages

#### 1. Home Page (Driver Dashboard)
- Header with:
  - "Driver Mode" title with "ACTIVE" badge
  - Earnings card displaying:
    - Today's earnings
    - This week's earnings
    - This month's earnings
- Quick stats grid (3 columns):
  - Trips Today (count)
  - Rating (average)
  - Pending Requests (count)
- "Create New Trip" button (prominent, gradient background)
- Active Trips section:
  - Trip cards showing:
    - Status badge (ACTIVE, SCHEDULED, PENDING)
    - Route (origin → destination with colored dots)
    - Trip info grid:
      - Departure time
      - Base fare
      - Confirmed passengers (X/Y seats)
      - Earnings (80% of total)
  - Confirmed Passengers list:
    - Passenger avatar and name
    - Passenger rating
    - Chat button for each passenger
  - Pending Requests section:
    - Passenger avatar and name
    - Passenger rating
    - Accept (✓) and Decline (✗) buttons
  - Trip action buttons:
    - "Start Trip" (green)
    - "Cancel Trip" (red)
- Bottom navigation (Home, My Trips, Messages, Earnings, Profile)

#### 2. Create Trip Page
- Header with back button and title
- Form fields:
  - Starting Location (text input)
  - Destination (text input)
  - Date and Time (separate inputs in a row)
  - Available Seats (dropdown: 1-4 seats)
  - Base Fare in USD (number input)
  - Vehicle Type (dropdown: Toyota Corolla, Honda Fit, Mazda Demio, etc.)
  - Additional Notes (optional textarea)
- "Publish Trip" button (primary, gradient)
- "Cancel" button (secondary, outlined)

#### 3. My Trips Page
- Header with back button
- Status tabs: Active, Completed, Cancelled
- Trip cards list showing:
  - Status badge
  - Route information
  - Trip info (date/time, passenger count)
- Bottom navigation

#### 4. Trip Management Page
- Header with back button
- Detailed trip view:
  - Status badge
  - Full route with timeline
  - Trip information grid
  - Confirmed passengers list
  - Pending requests with approve/deny actions
  - Trip action buttons

#### 5. Earnings Page
- Header with back button
- Earnings summary card:
  - Total Available Balance (large display)
  - "Request Payout" button (green)
  - Summary details grid:
    - This Week earnings
    - This Month earnings
    - Total Trips count
    - Average per trip
- Recent Transactions list:
  - Transaction items showing:
    - Route (origin → destination)
    - Amount (positive for earnings, negative for payouts)
    - Date and time
    - Passenger count or status
- Bottom navigation

#### 6. Profile Page (Driver)
- Profile header with:
  - Driver avatar
  - Driver name
  - Rating and "Verified Driver" badge
- Statistics grid (3 columns):
  - Total Trips
  - Rating
  - Acceptance Rate
- Menu items:
  - Edit Profile
  - Vehicle Details (make, model, registration)
  - Documents (license, registration, insurance)
  - Payment Methods (EcoCash, OneMoney)
  - Ratings & Reviews
  - Settings
  - Help Center
  - Logout
- Bottom navigation

#### 7. Messages Page (Driver)
- Similar to passenger messages but with driver context
- Notification badges on navigation items (showing unread count)
- Chat with passengers functionality

### Key Differences: Passenger vs Driver UI

**Navigation:**
- **Passenger:** Home, My Rides, Messages, Profile (4 items)
- **Driver:** Home, My Trips, Messages, Earnings, Profile (5 items - includes Earnings)

**Color Scheme:**
- **Passenger:** Purple gradient (`#667eea` to `#764ba2`)
- **Driver:** Pink/Red gradient (`#f093fb` to `#f5576c`)

**Primary Focus:**
- **Passenger:** Search and book rides, track upcoming rides
- **Driver:** Create trips, manage requests, track earnings

**Key Features:**
- **Passenger:** Search interface, trip details, request to join
- **Driver:** Earnings dashboard, request approval, trip management, payout system

## Data Models

### User
- id
- name
- email
- phone
- role (driver, passenger, or both)
- rating (average)
- totalRides
- avatar
- createdAt

### Trip
- id
- driverId
- origin (location)
- destination (location)
- departureTime
- totalFare
- availableSeats
- totalSeats
- vehicleInfo (make, model, registration, color)
- status (upcoming, in-progress, completed, cancelled)
- policies
- createdAt

### TripRequest
- id
- tripId
- passengerId
- status (pending, approved, denied)
- requestedSeats
- createdAt

### Payment
- id
- tripId
- passengerId
- driverId
- amount
- platformCommission
- driverEarnings
- status (pending, completed, refunded)
- paymentMethod
- createdAt

### Message
- id
- tripId
- senderId
- receiverId
- content
- read
- createdAt

### Rating
- id
- tripId
- raterId (who gave the rating)
- ratedId (who received the rating)
- rating (1-5)
- review (optional text)
- createdAt

## Technical Implementation Notes

### State Management
- Use a state management solution (Provider, Riverpod, Bloc, or GetX)
- Manage user authentication state
- Manage trip data and requests
- Manage real-time location updates
- Manage chat messages

### Backend Requirements
- RESTful API or GraphQL for data operations
- Real-time database (Firebase Firestore, Supabase, or custom WebSocket)
- Authentication service
- Payment processing integration
- Push notifications for:
  - Trip request approvals/denials
  - New messages
  - Trip reminders
  - Payment confirmations

### Required Packages (Flutter)
- `flutter_map` or `google_maps_flutter` for maps
- `geolocator` for location services
- `http` or `dio` for API calls
- `provider` or `riverpod` for state management
- `firebase_core`, `firebase_auth`, `cloud_firestore` (if using Firebase)
- `shared_preferences` for local storage
- `intl` for date/time formatting
- `cached_network_image` for image loading
- `flutter_local_notifications` for notifications

### Security Considerations
- Secure authentication
- Encrypted data transmission
- Payment security compliance
- User data privacy
- Location privacy controls

## Development Phases

### Phase 1: Core Setup
- Project initialization
- Authentication system
- Basic navigation
- User profiles

### Phase 2: Driver Features
- Post trip functionality
- Trip management
- Request approval system

### Phase 3: Passenger Features
- Search functionality
- Trip browsing
- Request to join trips
- My Rides page

### Phase 4: Payment Integration
- Payment calculation logic
- Payment processing
- Earnings tracking

### Phase 5: Real-time Features
- Location tracking
- Chat system
- Push notifications

### Phase 6: Rating System
- Rating interface
- Review system
- Profile ratings display

### Phase 7: Polish & Testing
- UI/UX refinements
- Bug fixes
- Performance optimization
- Testing

## Success Criteria
- Users can register as drivers or passengers
- Drivers can post trips with all required details
- Passengers can search and find relevant trips
- Request/approval flow works seamlessly
- Payments calculate and process correctly (80/20 split)
- Real-time location tracking works during trips
- Chat functionality enables communication
- Rating system builds trust
- UI matches the provided design aesthetic
- App is performant and user-friendly

## Additional Notes
- The app should feel modern and polished
- Focus on user experience and ease of use
- Ensure the app works well in areas with limited connectivity
- Consider offline functionality for viewing booked trips
- Implement proper error handling and user feedback
- Add loading states and animations for better UX

