# Savvi OneSignal setup (Android + iOS)

The Flutter integration is shared by both platforms and uses the OneSignal Flutter SDK 5.7.2. Supply the **same OneSignal App ID** to both builds:

```bash
flutter run --dart-define=ONESIGNAL_APP_ID=YOUR_ONESIGNAL_APP_ID
```

For release builds, pass the same define to `flutter build appbundle` / `flutter build ipa`. Do not commit the App ID into source control if your team manages build configuration centrally.

## OneSignal dashboard

Create one OneSignal app with both Android and iOS platforms enabled.

### Android / FCM

1. Register the Android app in Firebase using the exact Android application ID shown in `android/app/build.gradle.kts` (`com.example.savvi` in this supplied project; replace it with Savvi's final production ID before release).
2. Download the Firebase `google-services.json` and put it at `android/app/google-services.json`.
3. In Firebase Console, create/use a service account with Firebase Cloud Messaging permissions.
4. In OneSignal, configure Android (FCM) using the service-account JSON as requested by the OneSignal dashboard.
5. The Gradle project conditionally applies Google Services when `android/app/google-services.json` exists. Without that file the project can compile, but Android push delivery is not configured.

Android notification permission is declared in the manifest. Android 13+ runtime permission is requested through OneSignal when the app starts. The app must be installed on a physical device or suitable emulator with Google Play services for real FCM delivery.

### iOS / APNs

1. Register the iOS app in Apple Developer using the exact bundle ID in `ios/Runner.xcodeproj` (`com.example.savvi` in this supplied project; replace it with the production bundle ID before release).
2. Enable Push Notifications for the App ID in Apple Developer.
3. Create an APNs authentication key (`.p8`) and note its Key ID and Team ID.
4. Upload the APNs key in OneSignal's iOS platform settings.
5. In Xcode, select Runner > Signing & Capabilities and ensure Push Notifications and Background Modes > Remote notifications are enabled for the selected signing team. The project includes `Runner/Runner.entitlements` and the `remote-notification` background mode; the provisioning profile must include the push entitlement.

Debug is configured with the development APNs entitlement; Profile and Release use production. A valid Apple Developer team and matching provisioning profile are still required. Simulator push support depends on the simulator/Xcode version; validate final delivery on a physical iPhone too.

## Backend integration

- `POST /savi-user-auth/register`: adds `oneSignalPlayerId` to the existing registration payload when a OneSignal push subscription ID is available.
- `POST /savi-user-auth/login`: sends email, password and `oneSignalPlayerId` when available.
- `PATCH /savi-users/one-signal-player-id`: synchronizes the subscription ID after authentication and whenever OneSignal reports a changed ID.
- `GET /savi-user-notifications?page=1&limit=10`
- `PATCH /savi-user-notifications/{UUID}/read`
- `PATCH /savi-user-notifications/read-all`
- `DELETE /savi-user-notifications/{UUID}`
- `DELETE /savi-user-notifications`

The OneSignal v5 SDK exposes a **push subscription ID** (`OneSignal.User.pushSubscription.id`). This integration sends that value in the backend field named `oneSignalPlayerId`. Confirm that the backend stores/uses the v5 subscription ID rather than expecting the legacy OneSignal Player ID. These identifiers are not interchangeable.

## Build / verify

```bash
flutter clean
flutter pub get
flutter analyze
flutter run --dart-define=ONESIGNAL_APP_ID=YOUR_ONESIGNAL_APP_ID
```

For Android release:

```bash
flutter build appbundle --release --dart-define=ONESIGNAL_APP_ID=YOUR_ONESIGNAL_APP_ID
```

For iOS release (run on macOS with Xcode and signing configured):

```bash
flutter build ipa --release --dart-define=ONESIGNAL_APP_ID=YOUR_ONESIGNAL_APP_ID
```

Do not commit `google-services.json`, APNs `.p8` keys, signing certificates, or provisioning profiles to a public repository.
