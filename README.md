Here's a GitHub README template for your Flutter Islamic app project:

---

# 📱 Hidaya

An Islamic mobile application built using Flutter, allowing users to read the Quran and Hadith, listen to Quranic audio, find the Qibla direction, and interact with friends through a user-friendly experience. The app tracks Quran reading activity and provides a heatmap of user activity. This app is developed using **Clean Architecture**.

## 📸 Screenshots

**Homepage**
![image](https://github.com/user-attachments/assets/c71a1d84-3f5a-4a34-af76-4ea9704e4ffb)



**Quran Surah List**
![image](https://github.com/user-attachments/assets/48d6b035-dc38-43d8-889a-b605657e3ce7)



**Quran**
![image](https://github.com/user-attachments/assets/5c1a3288-b15c-454c-bb72-8fe97170dd41)



**User Profile**
![image](https://github.com/user-attachments/assets/dbad0cda-b3c3-44c6-a199-3725d05e2f01)



**Dark Mode**
![image](https://github.com/user-attachments/assets/bb7ddf98-a8a1-4252-9861-ed564936b5de)





## 🌟 Features

- 📖 **Quran Reading:** Read the complete Quran with beautiful Arabic fonts.
- 🎧 **Quran Audio:** Listen to Quran recitations.
- 📜 **Hadith Reading:** Access a collection of Hadith.
- 🌑 **Dark Mode:** Switch between light and dark themes for a comfortable reading experience.
- 🧭 **Qibla Finder:** Find the Qibla direction using your device's location.
- 👥 **User Accounts:** Create and manage user profiles with Firebase Authentication.
- 💬 **Message Friends:** Send and receive messages with friends using the built-in chat feature.
- 🤝 **Follow Friends:** Follow other users and keep track of their reading progress.
- 🔥 **Heatmap Activity:** Track Quran reading activity, with a daily heatmap visualization.
- 🌙 **Onboarding:** Smooth onboarding experience for new users.
- 📤 **Share:** Share Quranic verses and other content with friends.
- 📲 **Phone Authentication:** Secure authentication using phone numbers.

## 🛠 Packages Used

| Package                             | Description                                             |
| ------------------------------------ | -------------------------------------------------------|
| `cupertino_icons`                    | Provides iOS-style icons for the app UI                |
| `intro_screen_onboarding_flutter`    | For onboarding screen implementation                   |
| `flutter_svg`                        | SVG rendering for icons and images                     |
| `path_provider`                      | Access to the device's file storage paths              |
| `get_it`                             | Dependency injection in Flutter                        |
| `intl`                               | Date and time formatting                               |
| `dartz`                              | Functional programming support                         |
| `cloud_firestore`                    | Cloud Firestore database integration                   |
| `firebase_core`                      | Core Firebase library                                  |
| `firebase_auth`                      | Firebase Authentication for user login                 |
| `flutter_islamic_icons`              | Islamic-themed icons                                   |
| `quran_flutter`                      | Displays Quranic content                               |
| `bloc` & `flutter_bloc`              | State management using Bloc                            |
| `quran`                              | Quran data handling                                    |
| `arabic_font`                        | Provides Arabic fonts                                  |
| `awesome_bottom_bar`                 | Bottom navigation bar                                  |
| `just_audio`                         | Audio playback functionality                           |
| `hadith`                             | Hadith content integration                             |
| `geolocator`                         | Access to device location                              |
| `permission_handler`                 | Handles permissions for location access                |
| `flutter_qiblah`                     | Qibla direction functionality                          |
| `share_plus`                         | Sharing content across apps                            |
| `http`                               | For making HTTP requests                               |
| `firebase_phone_auth_handler`        | Handles Firebase phone authentication                  |
| `intl_phone_number_input`            | International phone number input field                 |
| `adhan`                              | Provides prayer times                                  |
| `flutter_heatmap_calendar`           | Heatmap calendar for user activity tracking           |
| `image_picker`                       | Picking images from the device                         |
| `firebase_storage`                   | Firebase cloud storage integration                     |
| `hydrated_bloc`                      | State management with persistence                      |
| `animated_page_transition`           | Page transitions with animations                       |
| `device_preview`                     | Previewing the app in different device configurations  |
| `cached_network_image`               | Caching images for performance                         |
| `fluttertoast`                       | Displaying toast notifications                         |
| `shimmer`                            | Shimmer loading effect                                 |

## 🧑‍💻 Getting Started

### Prerequisites

- Flutter SDK: [Installation Guide](https://flutter.dev/docs/get-started/install)
- Firebase Project: Set up a Firebase project and enable Firebase Authentication, Firestore, and Firebase Storage.

### Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/Ahmedx44/hidaya.git
   cd hidaya
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **Configure Firebase:**

   - Create a Firebase project.
   - Add `google-services.json` for Android and `GoogleService-Info.plist` for iOS.
   - Place these files in the appropriate directories as per [Firebase setup](https://firebase.google.com/docs/flutter/setup).

4. **Run the app:**
   ```bash
   flutter run
   ```

## 🧱 Project Structure

This project follows the **Clean Architecture** principles:
- `lib/core/`: Core utilities, constants, and themes.
- `lib/data/`: Data sources and models.
- `lib/domain/`: Business logic and entities.
- `lib/presentation/`: UI components, widgets, screens, Bloc .


## 🔗 Usage

- Create an account or log in using Firebase Authentication.
- Navigate through the app to read the Quran, listen to recitations, and access Hadith.
- Use the Qibla finder for accurate prayer direction.
- Follow friends and track quran reading progress with heatmap activity.


## 🚀 Contributing

Contributions are welcome! 


📧 Contact

For any questions or support, reach out to Ahmedgemechu14@gmail.com.
