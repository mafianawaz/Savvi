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

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();

  // Register dependencies
  Get.put<SharedPreferences>(prefs, permanent: true);

  // Register controllers
  Get.put(LocaleController(), permanent: true);
  AppBindings.init();
  Get.put<AuthController>(
    AuthController(
      api: Get.find<SavviApi>(),
    ),
    permanent: true,
  );

  runApp(const SavviApp());
}

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//
//   final prefs = await SharedPreferences.getInstance();
//
//   runApp(
//     ProviderScope(
//       overrides: [
//         sharedPreferencesProvider.overrideWithValue(prefs),
//       ],
//       child: const SavviApp(),
//     ),
//   );
// }
