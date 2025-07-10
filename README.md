# ✨ Flutter Notes App

A beautiful, modern notes app built with Flutter, Firebase, and GetX. This app lets you securely log in, add notes, and view your notes in real time—with a responsive UI that looks great on both mobile and tablet.

---

## 🚀 Features

- **Email/Password Authentication** (Firebase Auth)
- **Persistent Login** (auto-login across sessions)
- **Add, Edit, Delete Notes** (Firestore, real-time updates)
- **Responsive UI** (single-column on mobile, grid on tablet)
- **Modern Design** (custom theming, Google Fonts, beautiful dialogs)
- **User-Friendly Error Handling** (clear, actionable messages)
- **Centralized Loading State** (global loading indicators)
- **Splash Screen** (auth check and navigation)
- **GetX Named Routing** (clean, scalable navigation)
- **Clean Architecture** (separation of logic, UI, and data layers)

---

## 📱 Screenshots

> _Add screenshots of mobile and tablet layouts here!_

---

## 🛠️ Getting Started

1. **Clone the repo:**
   ```bash
   git clone https://github.com/yourusername/flutter-notes-app.git
   cd flutter-notes-app
   ```
2. **Install dependencies:**
   ```bash
   flutter pub get
   ```
3. **Firebase setup:**
   - Add your `google-services.json` (Android) and `GoogleService-Info.plist` (iOS) if needed.
   - The project is already configured for Firebase Auth and Firestore.
4. **Run the app:**
   ```bash
   flutter run
   ```
5. **Build APK for submission:**
   ```bash
   flutter build apk --release
   ```

---

## 🧑‍💻 Architecture & Code Quality

- **State Management:** GetX (controllers for auth and notes, bindings for dependency injection)
- **Routing:** GetX named routes with splash, login, signup, and home screens
- **Data Layer:** Firestore for notes, Firebase Auth for users
- **UI Layer:** Clean separation, reusable widgets (buttons, dialogs, text fields)
- **Responsiveness:** Uses `LayoutBuilder` and `MediaQuery` for adaptive layouts
- **Error Handling:** All errors are caught and shown as friendly messages (e.g., login/signup errors, network issues)
- **Loading State:** Centralized loading observables in controllers, global splash screen for auth check
- **No Dead Code:** All imports and code are actively used and maintained
- **Documentation:** All major classes and functions are documented for clarity

---

## 🔒 Security & Best Practices

- **No sensitive data is stored on the device.**
- **All authentication and data operations are secure and follow best practices.**
- **No secrets or API keys in the codebase.**
- **Input validation and error handling throughout the app.**
- **Uses HTTPS for all network requests.**
- **Permissions are requested only when needed and explained to the user.**
- **Code is ready for obfuscation and production deployment.**

---

## 💡 Developer Notes

- **User Experience:**
  - All dialogs and forms are modern, accessible, and easy to use.
  - Loading states use a primary color spinner for clarity.
  - Logout and destructive actions always ask for confirmation.
- **Extensibility:**
  - The codebase is ready for new features (labels, search, etc.)
  - Easy to swap state management or add more platforms.

---

## 🙋‍♂️ Questions?

If you have any questions or want to see more features, feel free to reach out!

---

**Made with ❤️ using Flutter, Firebase, and GetX.**
