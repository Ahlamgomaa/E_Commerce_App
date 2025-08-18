

# 🛍️ E-Commerce Flutter App

This is a simple **E-Commerce Flutter Application** built with **MVVM architecture** and **Cubit state management**.  
It demonstrates fetching products from an API, displaying them in a clean UI, and handling offline support using local caching.

---

## 📱 Features
- Fetch products from API (using Dio / HTTP).
- Display products in a grid with image, title, and price.
- MVVM architecture (Model - View - ViewModel).
- Offline support using Hive (cache data locally).
- State management using ** Bloc**.
- Responsive design for both Android & iOS.

---

## 🏗️ Project Structure (MVVM)
```
lib/
 ┣ 📂 models/        # Data models (e.g., ProductModel)
 ┣ 📂 services/      # API & Local DB services (Dio/HTTP + Hive/SQLite)
 ┣ 📂 viewmodels/    # Cubits (Business logic)
 ┣ 📂 views/         # UI screens (Home, Product Details, Cart...)
 ┣ 📂 widgets/       # Reusable UI components
 ┗ main.dart         # App entry point
```

---

## 🚀 Getting Started

### 1️⃣ Clone the Repository
```bash
git clone https://github.com/your-username/ecommerce_flutter.git
cd ecommerce_flutter
```

### 2️⃣ Install Dependencies
```bash
flutter pub get
```

### 3️⃣ Run the App
```bash
flutter run
```

---

## 📸 Screenshots
(Add 3-4 screenshots of your app here)

---

## 📦 Build APK
To generate a release APK for testing:
```bash
flutter build apk --release
```
The APK will be available in:
```
build/app/outputs/flutter-apk/app-release.apk
```

---

## 📖 Architecture Explanation
We used **MVVM with Cubit**:
- **Model** → Represents the data (e.g., Product model).
- **View** → Flutter UI widgets.
- **ViewModel (Cubit)** → Manages state and business logic.

Offline support is handled by:
- Fetching products from the API.
- Caching them locally using **Hive**.
- On next launch → Load cached data first, then fetch fresh data if available.

---

## 👩‍💻 Author
Developed by **Ahlam Gomaa Snosy**  
📧 Email: your-email@example.com  
🔗 GitHub: [your-username](https://github.com/your-username)


