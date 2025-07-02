# ✨ Flutter Notes App

## 🚀 Features

- **Email/Password Authentication** (Firebase Auth)
- **Persistent Login** (auto-login across sessions)
- **Add, Edit, Delete Notes** (Firestore, real-time updates)
- **Responsive UI** (single-column on mobile, grid on tablet)
- **Modern Design** (custom theming, Google Fonts, beautiful dialogs)
- **User-Friendly Error Handling** (clear, actionable messages)
- **Clean Architecture** (separation of logic, UI, and data layers)


## 🧑‍💻 Architecture & Code Quality

- **State Management:** GetX (controllers for auth and notes)
- **Data Layer:** Firestore for notes, Firebase Auth for users
- **UI Layer:** Clean separation, reusable widgets (buttons, dialogs, text fields)
- **Responsiveness:** Uses `LayoutBuilder` and `MediaQuery` for adaptive layouts
- **Error Handling:** All errors are caught and shown as friendly messages (e.g., login/signup errors, network issues)
- **No Dead Code:** All imports and code are actively used and maintained

---

## 💡 Developer Notes

- **User Experience:**
  - All dialogs and forms are modern, accessible, and easy to use.
  - Loading states use a primary color spinner for clarity.
  - Logout and destructive actions always ask for confirmation.
- **Security:**
  - No sensitive data is stored on the device.
  - All authentication and data operations are secure and follow best practices.
- **Extensibility:**
  - The codebase is ready for new features (labels, search, etc.)
  - Easy to swap state management or add more platforms.


