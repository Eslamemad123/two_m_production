Listed directory two_m_production
Viewed pubspec.yaml:1-116
Listed directory lib
Listed directory features
Listed directory pages
Listed directory RecordSale
Listed directory core
Listed directory services
Listed directory Firebase
Listed directory routes
Viewed routes.dart:1-97
Viewed NavBar.dart:1-137
Viewed main.dart:1-62
Viewed firebaseServices.dart:1-5
Listed directory Data
Listed directory DataSource
Viewed addOrderDateSource.dart:1-228
Listed directory Profits
Listed directory Home
Viewed counting_session_screen.dart:1-238

# 2M Production

## 📱 About The App

**2M Production** is a comprehensive, production-grade Flutter application designed specifically for manufacturing and inventory management. It streamlines the entire workflow of a production facility—from tracking real-time manufacturing sessions (e.g., injection molding counts) to managing inventory, recording sales, and calculating profits. The app features a robust, offline-aware architecture backed by Firebase, providing business owners with an all-in-one dashboard to manage products, monitor analytics, and handle customer orders efficiently.

---

## ✨ Features

### 🔐 Authentication
*   **Secure Login:** Firebase Authentication for secure user access.
*   **Biometric App Lock:** Local authentication (`local_auth`) to lock the app and protect sensitive business data.

### 🏠 Main Features
*   **Home Dashboard:** A centralized overview of production metrics and quick access to core functionalities.
*   **Production Tracking (Injection Sessions):** Track manufacturing sessions in real-time, including start/stop capabilities and counting total injections produced per session.
*   **Inventory Management:** Add new products, update stock levels, and view detailed product information.
*   **Offline Support & Caching:** Graceful handling of network timeouts and localized caching for fast data retrieval and offline resilience.

### 🛒 Shopping / Business Features
*   **Record Sales:** Streamlined point-of-sale (POS) interface to record customer orders and automatically deduct sold quantities from inventory.
*   **Order Management:** Track comprehensive order history, total spent per customer, and items purchased.
*   **Profits & Analytics:** Dynamic charts and visualizations to track daily/monthly revenues, items sold, and overall profits.
*   **Payment & Delivery Tracking:** Built-in support for tracking payments via **Vodafone Cash** and deliveries via **InDrive**.

### 👤 User Management
*   **Customer Profiles:** Automatically generate and update customer profiles based on sales records, tracking lifetime value and order history.
*   **Profile Settings:** Edit profile information seamlessly from the settings dashboard.

### ⚙️ Additional Features
*   **Multi-language Support:** Full localization in Arabic and English using `easy_localization`.
*   **Dynamic Theming:** Seamless toggling between Light and Dark modes.
*   **Responsive UI:** Scalable UI components using `flutter_screenutil` to support multiple screen sizes perfectly.
*   **Image Handling:** Pick, view, and upload product images using `image_picker` and `photo_view`.

---

## 🧠 App Flow

1.  **Splash Screen:** Initial loading and dependency injection setup.
2.  **App Lock Screen:** Prompts the user for a PIN or biometric scan to unlock the application.
3.  **Authentication (Login):** Validates user credentials via Firebase.
4.  **Main Navigation (Bottom NavBar):** Routes the user to the Home, Profits, Add Sale, Orders, or Settings screens.
5.  **Main Functionality (Production & Sales):** 
    *   Navigate to **Injection Page** to start a counting session for manufacturing.
    *   Navigate to **Record Sale** to input a customer's phone number, select products, specify delivery/payment (InDrive/Vodafone Cash), and execute a Firestore transaction to update stock and customer history.
6.  **Analytics & Management:** View charts in the Profits screen or manage inventory via the Add Product flow.

---

## 🏗️ Architecture

The application is built using **Clean Architecture** combined with a **Feature-Based Structure**. This ensures modularity, testability, and a clear separation of concerns.

*   **Presentation Layer:** Contains UI components, Pages, and State Management (`flutter_bloc` Cubits/Blocs).
*   **Domain Layer:** Contains core business logic, Entities, and Repository interfaces.
*   **Data Layer:** Contains Repository implementations, Data Sources (Firebase), and Models.
*   **Core Layer:** Houses shared resources, network error handling (`dartz` Either), dependency injection setup, and routing logic.

---

## 🛠️ Tech Stack

*   **Programming Language:** Dart
*   **Framework:** Flutter
*   **State Management:** `flutter_bloc`
*   **Routing:** `go_router`
*   **Dependency Injection:** `get_it`
*   **Database:** Firebase Cloud Firestore
*   **Authentication:** `firebase_auth`, `local_auth`
*   **Local Storage / Caching:** `shared_preferences`
*   **Networking & Offline:** `connectivity_plus`
*   **Data Visualization:** `fl_chart`
*   **Localization:** `easy_localization`
*   **UI/UX Packages:** `flutter_screenutil`, `lottie`, `flutter_svg`, `gap`, `carousel_slider`, `smooth_page_indicator`

---

## 📂 Project Structure

```text
lib/
├── components/          # Reusable, global UI components (buttons, text fields)
├── core/                # Core configurations and utilities
│   ├── GetIt/           # Dependency injection setup
│   ├── bloc/            # Global state management (e.g., ThemeManager)
│   ├── constatnts/      # App constants, assets, and colors
│   ├── error/           # Failure models and error handling
│   ├── extentions/      # Dart extensions for Context, String, etc.
│   ├── routes/          # Navigation and GoRouter configurations
│   ├── services/        # Third-party services (Firebase, Cache/LocalHelper)
│   └── utils/           # Utility functions and theme data
├── features/            # Feature-based modules
│   └── pages/
│       ├── Auth/            # Login and authentication flow
│       ├── Home/            # Main dashboard and inventory view
│       ├── Main/            # Bottom navigation bar host
│       ├── ProductDetails/  # Detailed view for specific products
│       ├── Profits/         # Analytics and revenue charts
│       ├── RecordSale/      # POS, order creation, and stock deduction
│       ├── Setting/         # Profile, app settings, and Injection Tracking
│       ├── addToStock/      # Inventory restocking
│       ├── intro/           # Splash screen and App Lock
│       └── oreder/          # Order history and tracking
├── generated/           # Code generation (Localization keys, etc.)
└── main.dart            # Application entry point and initialization
```

---

## 🔥 Key Implementations

*   **Atomic Firestore Transactions:** The `RecordSale` feature uses robust `firestore.runTransaction` to safely deduct product stock, update customer history, and increment order counters simultaneously, ensuring data consistency even with concurrent sales.
*   **Advanced State Management:** Utilizes `flutter_bloc` to cleanly separate business logic from the UI layer, specifically tailored for asynchronous Firebase calls.
*   **Robust Error Handling:** Uses functional programming patterns via the `dartz` package (`Either<Failure, Type>`) to gracefully handle Firebase timeouts, network errors, and data validation without crashing the app.
*   **Custom Router Architecture:** Centralized navigation using `go_router` with state extractions and type-safe argument passing across deep links and feature modules.
*   **Biometric Security:** Integration of `local_auth` to enforce a security layer before the user accesses the financial and production data.
*   **Responsive Localization:** Real-time toggling of Arabic and English layouts using `easy_localization`, heavily optimized with custom fonts (Tajawal & Manrope).

---

## 📸 Screenshots

<p align="center">
  <img src="screenshots/screen1.png" width="200" alt="Home Dashboard"/>
  <img src="screenshots/screen2.png" width="200" alt="Record Sale Screen"/>
  <img src="screenshots/screen3.png" width="200" alt="Profits & Analytics"/>
</p>

---

## 🚀 Future Improvements

*   **Export Reports:** Add the ability to export order history and monthly profits to PDF or Excel formats.
*   **Push Notifications:** Integrate Firebase Cloud Messaging (FCM) to notify users of low stock thresholds or when an injection session completes.
*   **Role-Based Access Control (RBAC):** Differentiate UI and permissions between Admins (full access) and Employees (sales and production tracking only).
*   **Barcode/QR Scanner:** Implement a barcode scanner to quickly add products to a sale or update inventory.

---

## 👨‍💻 Author

Developed by **Eslam Medny**
