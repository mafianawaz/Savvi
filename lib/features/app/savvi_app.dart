import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

import '../../core/localization/locale_controller.dart';
import '../../core/routing/app_router.dart';
import '../../core/theme/app_theme.dart';
import '../../l10n/app_localizations.dart';
import '../auth/binding.dart';

/// Root of the Savvi app. Wires theme, localization (en-US / es-US), and the
/// go_router instance. The active locale comes from [localeControllerProvider]
/// so switching language rebuilds the whole tree.


class SavviApp extends StatelessWidget {
  const SavviApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<LocaleController>(
      builder: (controller) {
        return GetMaterialApp(
          initialBinding: InitialBinding(),
          title: 'Savvi',
          debugShowCheckedModeBanner: false,

          theme: AppTheme.light(),

          getPages: AppPages.routes,

          initialRoute: Routes.signIn,

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

// class SavviApp extends ConsumerWidget {
//   const SavviApp({super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final locale = ref.watch(localeControllerProvider);
//
//     return MaterialApp.router(
//       title: 'Savvi',
//       debugShowCheckedModeBanner: false,
//       theme: AppTheme.light(),
//       routerConfig: appRouter,
//
//       // Respect the OS text-size setting, clamped to 1.5x so large-text users
//       // get real relief while layouts stay intact (owner decision).
//       builder: (context, child) {
//         final mq = MediaQuery.of(context);
//         final scaler = mq.textScaler.clamp(maxScaleFactor: 1.5);
//         return MediaQuery(
//             data: mq.copyWith(textScaler: scaler), child: child ?? const SizedBox.shrink());
//       },
//
//       locale: locale,
//       supportedLocales: SavviLocales.supported,
//       localizationsDelegates: const [
//         AppLocalizations.delegate,
//         GlobalMaterialLocalizations.delegate,
//         GlobalWidgetsLocalizations.delegate,
//         GlobalCupertinoLocalizations.delegate,
//       ],
//       // Resolve any unsupported system locale to the MVP fallback.
//       localeResolutionCallback: (device, supported) {
//         for (final l in supported) {
//           if (l.languageCode == device?.languageCode) return l;
//         }
//         return SavviLocales.fallback;
//       },
//     );
//   }
// }
