# Crypto Wallet Login Screen with Swipe Button in Flutter 💰✨

A modern **dark crypto wallet login screen** built with Flutter, featuring a terracotta-and-cream design, a folder-style **Log In / Sign Up** tab sheet and a **Swipe to Log In** button.

The UI is split into small, reusable components, the same way you would structure a React Native app.

## 🚀 Demo & Project

🌐 **Live Preview:**  
https://yaqoobdeveloper.github.io/Crypto-Wallet-Login-Screen-with-Swipe-Button-in-Flutter/

💻 **GitHub Repository:**  
https://github.com/YaqoobDeveloper/Crypto-Wallet-Login-Screen-with-Swipe-Button-in-Flutter

## ✨ Features

- 🌙 Dark-only wallet theme with orange and cream accents
- 👉 Swipe to Log In / Sign Up button with success and spring-back states
- 🗂️ Folder-tab sheet to switch between Log In and Sign Up
- 📧 Email, password and full-name fields with validation
- 👁️ Password visibility toggle
- 🔐 Quick login with Google, Apple, Facebook and fingerprint
- 🚫 No Material ripple or hover effects, for a clean iOS-like feel
- 🧩 Reusable components with a barrel export (like `components/index.ts`)

## 📁 Project Structure

```
lib/
├── main.dart
├── app.dart
├── screens/wallet_login_screen.dart
├── components/wallet/
│   ├── wallet_components.dart     # barrel export
│   ├── wallet_header.dart
│   ├── round_action_button.dart
│   ├── tabbed_sheet.dart
│   ├── wallet_field.dart
│   ├── wallet_password_field.dart
│   └── swipe_button.dart
├── theme/wallet_colors.dart
└── utils/validators.dart
```

## 🛠️ Built With

- **Flutter 3.47.2**
- **Dart**
- [google_fonts](https://pub.dev/packages/google_fonts) (Plus Jakarta Sans)
- [font_awesome_flutter](https://pub.dev/packages/font_awesome_flutter)

## 📋 Requirements

- Flutter **3.47.2** or compatible version
- Dart SDK included with Flutter
- Android Studio or VS Code
- Xcode for iOS development

## ▶️ Run

### 1. Clone the repository

```bash
git clone https://github.com/YaqoobDeveloper/Crypto-Wallet-Login-Screen-with-Swipe-Button-in-Flutter.git
```

### 2. Navigate to the project

```bash
cd Crypto-Wallet-Login-Screen-with-Swipe-Button-in-Flutter
```

### 3. Install dependencies

```bash
flutter pub get
```

### 4. Run the app

```bash
flutter run
```

## 👨‍💻 Created By

### Yaqoob Developer

**Flutter Developer & YouTuber**

▶️ **YouTube:**  
https://youtube.com/@yaqoob_developer

🌐 **Website:**  
https://yaqoobdeveloper.com/

⭐ If you find this project useful, consider giving the repository a **star**!
