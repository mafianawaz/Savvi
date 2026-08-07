import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/localization/locale_controller.dart';
import 'core/network/savvi_api.dart';
import 'core/state/providers.dart';
import 'features/app/savvi_app.dart';
import 'features/auth/auth_controller.dart';

/// Entry point.
///
/// SharedPreferences is loaded before the app starts so the initial locale can
/// be read synchronously, then injected into the provider graph via an override.
///
/// Firebase (Auth + Cloud Messaging) is initialized in a later stage; the hooks
/// (token provider on the API client, FCM registration) already have their
/// contracts in place so wiring is additive.

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/localization/locale_controller.dart';
import 'core/network/savvi_api.dart';
import 'core/state/providers.dart';
import 'core/state/shell_nav.dart';
import 'features/access/access_controller.dart';
import 'features/app/savvi_app.dart';
import 'features/auth/auth_controller.dart';
import 'features/home/requests_controller.dart';
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
///   1. SharedPreferences  -> raw dependency, no controller needs
///   2. LocaleController   -> depends on SharedPreferences
///   3. AppBindings.init() -> AppConfig, ApiClient, SavviApi, Fmt
///   4. AuthController     -> depends on SavviApi
///   5. AccessController   -> depends on SavviApi
///   6. EditProfileController -> depends on SavviApi + AuthController
///   7. ShellController    -> no dependencies, drives bottom-nav tab state
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();

  // Raw dependencies
  Get.put<SharedPreferences>(prefs, permanent: true);

  // Locale (needed by AppBindings for the API client's locale header)
  Get.put(LocaleController(), permanent: true);

  // App-level services: AppConfig, ApiClient, SavviApi, Fmt
  AppBindings.init();

  // Session controllers
  Get.put<AuthController>(
    AuthController(api: Get.find<SavviApi>()),
    permanent: true,
  );

  Get.put<AccessController>(
    AccessController(api: Get.find<SavviApi>()),
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

  // Signed-in shell (bottom-nav) state
  Get.put<ShellController>(ShellController(), permanent: true);

  runApp(const SavviApp());
}


