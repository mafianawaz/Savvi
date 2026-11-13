# Savvi — OneSignal Android + iOS integration

This project is configured for:

- Android application ID: `com.savur.mobile`
- iOS bundle ID: `com.savur.mobile`
- Firebase project: `savur-platform-staging` (`506638930308`)
- Flutter OneSignal SDK: `onesignal_flutter: ^5.7.2`
- OneSignal SDK App ID: supplied at build/run time using `ONESIGNAL_APP_ID`

## 1. Files configured in this project

- `android/app/google-services.json` — Firebase Android app config for `com.savur.mobile`.
- `ios/Runner/GoogleService-Info.plist` — Firebase iOS app config for `com.savur.mobile`, included in the Runner target resources.
- `android/app/build.gradle.kts` — namespace and application ID set to `com.savur.mobile`; Google Services plugin applied when the JSON exists.
- `android/app/src/main/kotlin/com/savur/mobile/MainActivity.kt` — moved to the matching Kotlin package.
- `ios/Runner.xcodeproj/project.pbxproj` — Runner bundle ID set to `com.savur.mobile`; OneSignal extension bundle ID set to `com.savur.mobile.OneSignalNotificationServiceExtension`.
- `ios/OneSignalNotificationServiceExtension` — OneSignal v5 notification service extension.
- `ios/Podfile` — OneSignal XCFramework pod added to the notification service extension target.
- `lib/core/notifications/one_signal_service.dart` — shared Android/iOS initialization, permission request, subscription ID observer, user identity and click listener.
- `lib/main.dart` — initializes OneSignal after app dependencies and registers authenticated backend ID synchronization.
- Login and registration send `oneSignalPlayerId` when the OneSignal v5 push subscription ID is available. Authenticated sessions also call `OneSignal.login(memberId)`.

## 2. OneSignal dashboard — Android / FCM

Create or open the OneSignal app and configure Android using the Firebase project above.

Important: `google-services.json` is a client configuration file. It is **not** the Firebase service-account credential OneSignal needs to send FCM messages.

In Firebase / Google Cloud:
1. Open project `savur-platform-staging`.
2. Ensure the Firebase Cloud Messaging API is enabled.
3. Create or use a service account with permission to send Firebase Cloud Messaging messages (Firebase Cloud Messaging API Admin / an appropriately scoped least-privilege role).
4. Create/download its JSON private-key file securely.
5. Upload that service-account JSON in OneSignal's Android FCM configuration.

Never put the service-account private-key JSON in this Flutter repository or app bundle.

## 3. OneSignal dashboard — iOS / APNs

1. In Apple Developer, ensure the App ID is exactly `com.savur.mobile` and Push Notifications is enabled.
2. Create an APNs authentication key (`.p8`) and record its Key ID and Apple Team ID.
3. In OneSignal's iOS platform settings, upload the APNs key and enter the Key ID and Team ID.
4. In Xcode, select the Runner target and confirm Push Notifications capability and Background Modes > Remote notifications.
5. Confirm the provisioning profile used for the Runner target includes `aps-environment`.
6. Ensure the OneSignal Notification Service Extension target is signed with the matching Team and its bundle ID remains `com.savur.mobile.OneSignalNotificationServiceExtension`.

The extension is used for OneSignal rich notification processing. Ordinary visible push notifications can arrive without images, but the extension should be retained for full OneSignal rich-push support.

## 4. Configure the OneSignal App ID

Use the same OneSignal App ID for Android and iOS. It is not the Firebase project ID or Firebase app ID.

Debug Android:
```bash
flutter run -d <android-device-id> --dart-define=ONESIGNAL_APP_ID=YOUR_ONESIGNAL_APP_ID
```

Debug iOS:
```bash
flutter run -d <ios-device-id> --dart-define=ONESIGNAL_APP_ID=YOUR_ONESIGNAL_APP_ID
```

Android release:
```bash
flutter build appbundle --release --dart-define=ONESIGNAL_APP_ID=YOUR_ONESIGNAL_APP_ID
```

iOS release:
```bash
flutter build ipa --release --dart-define=ONESIGNAL_APP_ID=YOUR_ONESIGNAL_APP_ID
```

If `ONESIGNAL_APP_ID` is omitted, the app deliberately skips OneSignal initialization. The Firebase config files alone do not activate OneSignal delivery.

## 5. Backend contract currently wired

- `POST /savi-user-auth/register` — includes `oneSignalPlayerId` when available.
- `POST /savi-user-auth/login` — includes `oneSignalPlayerId` when available.
- `PATCH /savi-users/one-signal-player-id` — synchronizes the current push subscription ID when OneSignal reports it and the member has an authenticated session.
- `GET /savi-user-notifications?page=1&limit=10`
- `PATCH /savi-user-notifications/{UUID}/read`
- `PATCH /savi-user-notifications/read-all`
- `DELETE /savi-user-notifications/{UUID}`
- `DELETE /savi-user-notifications`

**Backend compatibility check:** OneSignal Flutter SDK v5 exposes `OneSignal.User.pushSubscription.id`. This is a v5 Push Subscription ID, not the legacy v4 Player ID. The backend's `oneSignalPlayerId` field and push-sending logic must accept this ID type. The field name can remain unchanged if backend semantics are updated accordingly.

## 6. Install and build

From the project root:

```bash
flutter clean
flutter pub get
cd ios
pod install
cd ..
flutter analyze
```

Then run with the OneSignal App ID as shown above.

## 7. End-to-end device test

1. Install a fresh build on a real Android device with Google Play services and a real iPhone.
2. Launch the app and allow notifications when prompted.
3. Sign in (or register). Check app logs for OneSignal initialization and the subscription ID.
4. Confirm the backend receives `oneSignalPlayerId` on login/register or the authenticated PATCH endpoint.
5. In OneSignal dashboard, confirm the device appears as a subscribed user/subscription.
6. Send a test notification to that subscription from OneSignal.
7. Verify delivery while the app is foregrounded, backgrounded and terminated.
8. Tap the notification and verify Savvi opens the notifications screen.
9. Sign out and sign in as another account to verify OneSignal user association changes.

## 8. Important limitations / production checklist

- iOS push delivery requires valid APNs credentials in OneSignal and a correctly signed physical-device build. The iOS simulator is not a reliable substitute for final APNs testing.
- Android push requires valid FCM service-account credentials in OneSignal; the client `google-services.json` does not replace them.
- The `aps-environment` entitlement must match the provisioning profile (development for debug; production for distribution). Do not manually force a development entitlement into a distribution build.
- Keep APNs `.p8`, Firebase service-account JSON, signing certificates and provisioning profiles out of source control.
- If the Android/iOS app IDs have already been published, changing them creates a different app identity; existing installs will not update as the same app. Confirm the new ID before release.
