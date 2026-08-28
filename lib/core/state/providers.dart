import 'package:get/get.dart';

import '../auth/firebase_auth_gateaway.dart';
import '../auth/token_storage.dart';
import '../formatting/formatters.dart';
import '../localization/locale_controller.dart';
import '../network/api_client.dart';
import '../network/live_savvi_api.dart';
import '../network/savvi_api.dart';

/// App-wide configuration.
class AppConfig {
  const AppConfig({
    required this.apiBaseUrl,
    required this.useMockApi,
  });

  final String apiBaseUrl;
  final bool useMockApi;

  static const dev = AppConfig(
    apiBaseUrl: 'https://ed10-203-128-15-206.ngrok-free.app/',
    useMockApi: false,
  );
}

class AppBindings {
  static void init() {
    Get.put<AppConfig>(AppConfig.dev, permanent: true);

    Get.put<FirebaseAuthGateway>(
      StubFirebaseAuthGateway(),
      permanent: true,
    );

    Get.put<ApiClient>(
      ApiClient(
        baseUrl: Get.find<AppConfig>().apiBaseUrl,
        tokenStorage: Get.find<TokenStorage>(),
        localeTagProvider: () {
          final locale = Get.find<LocaleController>().locale.value;
          return SavviLocales.tag(locale);
        },
      ),
      permanent: true,
    );

    Get.put<SavviApi>(
      LiveSavviApi(Get.find<ApiClient>()),
      permanent: true,
    );

    Get.lazyPut<Fmt>(
      () => Fmt(Get.find<LocaleController>().locale.value),
      fenix: true,
    );
  }
}
