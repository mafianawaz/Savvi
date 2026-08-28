import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/auth/token_storage.dart';
import 'core/auth/user_storage.dart';
import 'core/localization/locale_controller.dart';
import 'core/network/savvi_api.dart';
import 'core/state/providers.dart';
import 'core/state/shell_nav.dart';
import 'core/formatting/formatters.dart';
import 'features/app/savvi_app.dart';
import 'features/auth/auth_controller.dart';
import 'features/home/requests_controller.dart';
import 'features/notifications/notifications_controller.dart';
import 'features/profile/profile_controller.dart';

/// Entry point.
///
/// SharedPreferences is loaded before the app starts so the initial locale
/// can be read synchronously, then injected into the dependency graph.
///
/// Firebase (Auth + Cloud Messaging) is initialized in a later stage; the
/// hooks (token provider on the API client, FCM registration) already have
/// their contracts in place so wiring is additive.
///
/// Registration order matters: each controller below only depends on
/// controllers registered before it.
///   1. SharedPreferences      -> raw dependency, no controller needs
///   2. LocaleController       -> depends on SharedPreferences
///   3. Fmt                    -> depends on LocaleController's resolved locale
///   4. AppBindings.init()     -> AppConfig, ApiClient, SavviApi
///   5. AuthController         -> depends on SavviApi
///   6. AccessController       -> depends on SavviApi
///   7. EditProfileController  -> depends on SavviApi + AuthController
///   8. RequestsController     -> depends on SavviApi
///   9. NotificationsController -> depends on SavviApi
///   10. ShellController        -> no dependencies, drives bottom-nav tab state
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();

  // Raw dependencies
  Get.put<SharedPreferences>(prefs, permanent: true);
  Get.put<TokenStorage>(
    TokenStorage(prefs),
    permanent: true,
  );
  Get.put<UserStorage>(
    UserStorage(prefs),
    permanent: true,
  );

  // Locale (needed by AppBindings for the API client's locale header)
  Get.put(LocaleController(), permanent: true);

  // FIX: previously nothing ever registered Fmt itself (only the unused
  // FormatterService wrapper), so every Get.find<Fmt>() call across Home,
  // Events, Activity, and Notifications would have thrown at runtime.
  // LocaleController.setLocale() re-puts this with the new locale whenever
  // the member switches language.
  Get.put<Fmt>(
    Fmt(Get.find<LocaleController>().locale.value),
    permanent: true,
  );

  // App-level services: AppConfig, ApiClient, SavviApi, Fmt
  AppBindings.init();

  // Session controllers
  Get.put<AuthController>(
    AuthController(
      api: Get.find<SavviApi>(),
      tokenStorage: Get.find<TokenStorage>(),
      userStorage: Get.find<UserStorage>(),
    ),
    permanent: true,
  );


  Get.put<EditProfileController>(
    EditProfileController(
      api: Get.find<SavviApi>(),
      authController: Get.find<AuthController>(),
    ),
    permanent: true,
  );

  // Member requests (shared by Home preview + Activity full list)
  Get.put<RequestsController>(
    RequestsController(api: Get.find<SavviApi>()),
    permanent: true,
  );

  // FIX: previously only registered in the orphaned InitialBinding (never
  // wired into GetMaterialApp or any GetPage), so every Get.find call on
  // this controller — Notifications, NotifPrefs, and the Home bell badge —
  // would have thrown at runtime the first time any of them ran. Permanent
  // singleton here, like the other session-scoped controllers above.
  Get.put<NotificationsController>(
    NotificationsController(api: Get.find<SavviApi>()),
    permanent: true,
  );

  // Signed-in shell (bottom-nav) state
  Get.put<ShellController>(ShellController(), permanent: true);

  runApp(const SavviApp());
}
