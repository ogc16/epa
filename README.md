# EPA - On-Demand Delivery Platform

A multi-vendor delivery platform built with Flutter, inspired by DoorDash and Deliveroo. Three apps in one project: **Customer**, **Rider**, and **Vendor**.

## Apps

| App | Entry Point | Description |
|-----|------------|-------------|
| **Customer** | `lib/main_customer.dart` | Browse products, place orders, track delivery |
| **Rider** | `lib/main_rider.dart` | Accept deliveries, navigate, track earnings |
| **Vendor** | `lib/main_vendor.dart` | Manage products, orders, store settings |

## Categories

- Groceries
- Household Items
- Fast Food
- Gas Refill
- Water Refill

## Project Structure

```
lib/
├── main_customer.dart        # Customer app entry
├── main_rider.dart            # Rider app entry
├── main_vendor.dart           # Vendor app entry
├── core/
│   ├── constants/             # App constants
│   ├── models/                # User, Product, Order, Cart, Store
│   ├── services/              # API, Auth, Storage services
│   ├── theme/                 # Light/dark theme
│   ├── utils/                 # Helpers
│   └── widgets/               # Shared widgets
├── customer/screens/          # Customer UI screens
├── rider/screens/             # Rider UI screens
└── vendor/screens/            # Vendor UI screens
```

## Getting Started

### Prerequisites

- Flutter SDK (>=3.0.0)
- Dart SDK (>=3.0.0)

### Installation

```bash
# Clone the repo
git clone <repo-url>
cd epa

# Get dependencies
flutter pub get

# Generate platform files (first time)
flutter create --platforms=android,ios .

# Run Customer app
flutter run -t lib/main_customer.dart

# Run Rider app
flutter run -t lib/main_rider.dart

# Run Vendor app
flutter run -t lib/main_vendor.dart
```

### Build

```bash
# Customer APK
flutter build apk -t lib/main_customer.dart

# Rider APK
flutter build apk -t lib/main_rider.dart

# Vendor APK
flutter build apk -t lib/main_vendor.dart
```
Or , to Output: customer.apk, rider.apk, vendor.apk (in build/app/outputs/flutter-apk/).
```
flutter build apk --flavor customer --target lib/main_customer.dart
flutter build apk --flavor rider --target lib/main_rider.dart
flutter build apk --flavor vendor --target lib/main_vendor.dart
```


## Features

### Customer
- Browse products by category
- Search & filter products
- View product details with reviews
- Add to cart with quantity control
- Checkout with delivery address & payment
- Order tracking (real-time status)
- Order history
- Profile management

### Rider
- View available delivery requests
- Accept/decline deliveries
- Navigate to store/customer
- Track active deliveries
- Earnings dashboard (daily/weekly)
- Withdraw earnings
- Profile & vehicle info

### Vendor
- Dashboard with revenue & order stats
- Product CRUD (add/edit/toggle)
- Order management (accept/prepare/ready)
- Tab-based order filtering by status
- Store settings (hours, delivery radius, fees)
- Business analytics

## Tech Stack

- **Framework:** Flutter (Dart)
- **State Management:** Provider
- **HTTP Client:** http
- **Local Storage:** shared_preferences
- **Maps/Location:** geolocator, geocoding
- **UI:** Material 3, google_fonts, shimmer, carousel_slider

## License

MIT
