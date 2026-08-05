import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../auth/firebase_auth_gateaway.dart';
import '../formatting/formatters.dart';
import '../localization/locale_controller.dart';
import '../network/api_client.dart';
import '../network/savvi_api.dart';
import '../../data/mock/mock_savvi_api.dart';

/// App-wide configuration. In production these come from --dart-define / env.
// class AppConfig {
//   const AppConfig({
//     required this.apiBaseUrl,
//     required this.useMockApi,
//   });
//
//   final String apiBaseUrl;
//   final bool useMockApi;
//
//   static const dev = AppConfig(
//     apiBaseUrl: 'https://api.savur.example/savvi/v1', // placeholder
//     useMockApi: true, // Stage 1: mock backend. Flip to false when live.
//   );
// }
//
// final appConfigProvider = Provider<AppConfig>((ref) => AppConfig.dev);
//
// /// The Dio-backed client (used by the live SavviApi implementation in a later
// /// stage). Wired now so interceptors and providers exist from Stage 1.
// final apiClientProvider = Provider<ApiClient>((ref) {
//   final cfg = ref.watch(appConfigProvider);
//   return ApiClient(
//     baseUrl: cfg.apiBaseUrl,
//     tokenProvider: stubTokenProvider, // auth stage swaps in Firebase token
//     localeTagProvider: () => SavviLocales.tag(ref.read(localeControllerProvider)),
//   );
// });
//
// /// The single seam screens depend on. Returns the mock in Stage 1; a live
// /// Dio-backed implementation replaces it later with NO screen changes, because
// /// everything programs against [SavviApi].
// final savviApiProvider = Provider<SavviApi>((ref) {
//   final cfg = ref.watch(appConfigProvider);
//   if (cfg.useMockApi) return MockSavviApi();
//   // Later stage:
//   //   final client = ref.watch(apiClientProvider);
//   //   return LiveSavviApi(client);
//   throw UnimplementedError('Live SavviApi is wired in a later stage.');
// });
//
// /// Locale-aware formatter that always reflects the active locale.
// final formatterProvider = Provider<Fmt>((ref) {
//   final locale = ref.watch(localeControllerProvider);
//   return Fmt(locale);
// });


/// GetX

import 'package:get/get.dart';

/// App-wide configuration.
///
/// In production these come from --dart-define / env.
class AppConfig {
  const AppConfig({
    required this.apiBaseUrl,
    required this.useMockApi,
  });

  final String apiBaseUrl;
  final bool useMockApi;

  static const dev = AppConfig(
    apiBaseUrl: 'https://api.savur.example/savvi/v1', // placeholder
    useMockApi: true, // Stage 1: mock backend. Flip to false when live.
  );
}

/// Register all application-level dependencies.
///
/// Call this once from main() before runApp().
class AppBindings {
  static void init() {
    // App configuration
    Get.put<AppConfig>(
      AppConfig.dev,
      permanent: true,
    );
    Get.put<FirebaseAuthGateway>(StubFirebaseAuthGateway(), permanent: true);
    // API Client
    Get.put<ApiClient>(
      ApiClient(
        baseUrl: Get.find<AppConfig>().apiBaseUrl,
        tokenProvider: stubTokenProvider,
        localeTagProvider: () {
          final locale =
              Get.find<LocaleController>().locale.value;
          return SavviLocales.tag(locale);
        },
      ),
      permanent: true,
    );

    // API implementation
    final config = Get.find<AppConfig>();

    if (config.useMockApi) {
      Get.put<SavviApi>(
        MockSavviApi(),
        permanent: true,
      );
    } else {
      // Later stage
      //
      // Get.put<SavviApi>(
      //   LiveSavviApi(Get.find<ApiClient>()),
      //   permanent: true,
      // );

      throw UnimplementedError(
        'Live SavviApi is wired in a later stage.',
      );
    }

    // Locale-aware formatter
    Get.lazyPut<Fmt>(
          () => Fmt(
        Get.find<LocaleController>().locale.value,
      ),
      fenix: true,
    );
  }
}