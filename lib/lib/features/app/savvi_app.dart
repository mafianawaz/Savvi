import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import '../../core/localization/locale_controller.dart';
import '../../core/routing/app_router.dart';
import '../../core/state/shell_nav.dart';
import '../../core/theme/app_theme.dart';
import '../../l10n/app_localizations.dart';

/// Root of the Savvi app. Wires theme, localization (en-US / es-US), and the
/// GetX route table. The active locale comes from [LocaleController] so
/// switching language rebuilds the whole tree.
class SavviApp extends StatelessWidget {
  const SavviApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<LocaleController>(
      builder: (controller) {
        return GetMaterialApp(
          title: 'Savvi',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light(),
          getPages: AppPages.routes,
          initialRoute: Routes.signIn,
          navigatorObservers: [shellRouteObserver],
          builder: (context, child) {
            final mq = MediaQuery.of(context);
            final scaler = mq.textScaler.clamp(maxScaleFactor: 1.5);

            return MediaQuery(
              data: mq.copyWith(textScaler: scaler),
              child: child ?? const SizedBox.shrink(),
            );
          },

          locale: controller.locale.value,
          supportedLocales: SavviLocales.supported,
          fallbackLocale: SavviLocales.fallback,

          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],

          localeResolutionCallback: (device, supported) {
            for (final locale in supported) {
              if (locale.languageCode == device?.languageCode) {
                return locale;
              }
            }
            return SavviLocales.fallback;
          },
        );
      },
    );
  }
}
