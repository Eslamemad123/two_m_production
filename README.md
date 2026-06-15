# 2M Production

## 📱 About The App
**2M Production** is an offline-first inventory and sales management app designed for plastic manufacturing facilities. It solves the critical problem of tracking live factory production (injection molding counts) and synchronizing it instantly with sales, customer debt, and stock levels in a single dashboard.

---

## 🎥 Demo Video
[Watch the Demo Video Here](#)

---

## 📊 Project Statistics
* **10+ Features/Screens**
* **Firebase Backend** (Auth & Firestore)
* **Clean Architecture**
* **Arabic & English Support**
* **Dark & Light Themes**
* **Real-time Data Updates**
* **Offline Caching**
* **Production Tracking System**
* **Inventory Management System**

---

## ✨ Key Features
✔ Inventory Management
✔ Production Tracking (Injection Sessions)
✔ Sales & POS Recording
✔ Order History & Analytics
✔ Customer Lifetime Value Tracking
✔ Biometric Authentication
✔ Offline Caching & Resilience
✔ Arabic & English Support
✔ Dark & Light Themes

---

## 📸 Screenshots

### Onboarding & Authentication
<p align="center">
  <img src="App Screens/splash.jpeg" width="200"/>
  <img src="App Screens/Login.jpeg" width="200"/>
</p>

### Main & Dashboard
<p align="center">
  <img src="App Screens/home.jpeg" width="200"/>
  <img src="App Screens/productdetails.jpeg" width="200"/>
  <img src="App Screens/profits.jpeg" width="200"/>
</p>

### Sales & Operations
<p align="center">
  <img src="App Screens/recordSale.jpeg" width="200"/>
  <img src="App Screens/injuction.jpeg" width="200"/>
  <img src="App Screens/addProduct.jpeg" width="200"/>
</p>

### Settings & Localization
<p align="center">
  <img src="App Screens/arabic.jpeg" width="200"/>
  <img src="App Screens/dark0.jpeg" width="200"/>
</p>

---

## 🛠️ Tech Stack
* Flutter & Dart
* Firebase Auth & Cloud Firestore
* Flutter Bloc (State Management)
* GetIt (Dependency Injection)
* GoRouter (Navigation)
* Shared Preferences (Local Cache)
* Easy Localization

---

## 🏗️ Architecture
The app follows **Clean Architecture** organized by a **Feature-Based Structure** (Presentation, Domain, Data layers). This ensures high testability and complete separation between UI components and complex Firebase/Caching logic.

---

## 🔥 Technical Highlights
* **Atomic Firestore Transactions:** POS sales strictly use `firestore.runTransaction` to simultaneously deduct stock and update customer history safely.
* **Offline Cache Fallback:** Automatically traps network timeouts and gracefully degrades to `Shared Preferences` or Firebase cache to keep the UI responsive.
* **Real-time Firestore Streams:** Live inventory dashboard powered by `query.snapshots()`.
* **Functional Error Handling:** Entire data pipeline uses `dartz` (`Either<Failure, Type>`) for predictable, crash-free error state management.
* **Biometric Authentication:** Enterprise-grade security via `local_auth` protecting financial records.

---

## 👨‍💻 Author
Developed by Eslam Emad
