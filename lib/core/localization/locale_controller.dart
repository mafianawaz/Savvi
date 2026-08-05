import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// RiverPod
// /// The MVP locales. Additional locales are post-MVP and must not be added here
// /// without founder approval.
// class SavviLocales {
//   SavviLocales._();
//   static const enUS = Locale('en', 'US');
//   static const esUS = Locale('es', 'US');
//   static const supported = <Locale>[enUS, esUS];
//   static const fallback = enUS;
//
//   static const _prefsKey = 'savvi_locale_tag';
//
//   /// Resolve a stored tag (e.g. "es-US") back to a supported [Locale].
//   static Locale fromTag(String? tag) {
//     switch (tag) {
//       case 'es-US':
//         return esUS;
//       case 'en-US':
//         return enUS;
//       default:
//         return fallback;
//     }
//   }
//
//   static String tag(Locale l) => '${l.languageCode}-${l.countryCode}';
// }
//
// /// Holds the active locale. In production the source of truth is the backend
// /// user language preference; this controller loads a locally cached value for
// /// first paint and writes changes both locally (shared_preferences, non-
// /// sensitive) and — in a later stage — to the backend via
// /// SavviApi.setLanguagePreference.
// class LocaleController extends StateNotifier<Locale> {
//   LocaleController(this._prefs) : super(_read(_prefs));
//
//   final SharedPreferences _prefs;
//
//   static Locale _read(SharedPreferences p) =>
//       SavviLocales.fromTag(p.getString(SavviLocales._prefsKey));
//
//   Future<void> setLocale(Locale locale) async {
//     if (!SavviLocales.supported.contains(locale)) return;
//     state = locale;
//     await _prefs.setString(SavviLocales._prefsKey, SavviLocales.tag(locale));
//     // Later stage: also persist to backend (SavviApi.setLanguagePreference).
//   }
// }
//
// /// Provided at app start once SharedPreferences is ready (see providers.dart).
// final sharedPreferencesProvider = Provider<SharedPreferences>(
//   (ref) => throw UnimplementedError(
//       'sharedPreferencesProvider must be overridden in main()'),
// );
//
// final localeControllerProvider =
//     StateNotifierProvider<LocaleController, Locale>((ref) {
//   final prefs = ref.watch(sharedPreferencesProvider);
//   return LocaleController(prefs);
// });

/// GETx

/// The MVP locales. Additional locales are post-MVP and must not be added here
/// without founder approval.
class SavviLocales {
  SavviLocales._();

  static const enUS = Locale('en', 'US');
  static const esUS = Locale('es', 'US');

  static const supported = <Locale>[
    enUS,
    esUS,
  ];

  static const fallback = enUS;

  static const prefsKey = 'savvi_locale_tag';

  /// Resolve a stored tag (e.g. "es-US") back to a supported [Locale].
  static Locale fromTag(String? tag) {
    switch (tag) {
      case 'es-US':
        return esUS;
      case 'en-US':
        return enUS;
      default:
        return fallback;
    }
  }

  static String tag(Locale locale) {
    return '${locale.languageCode}-${locale.countryCode}';
  }
}

/// Holds the active locale.
///
/// In production the source of truth is the backend user language preference;
/// this controller loads a locally cached value for first paint and writes
/// changes both locally (SharedPreferences) and — in a later stage — to the
/// backend via SavviApi.setLanguagePreference.
class LocaleController extends GetxController {
  late final SharedPreferences _prefs;

  final Rx<Locale> locale = SavviLocales.fallback.obs;

  @override
  void onInit() {
    super.onInit();

    _prefs = Get.find<SharedPreferences>();

    locale.value = SavviLocales.fromTag(
      _prefs.getString(SavviLocales.prefsKey),
    );
  }

  Future<void> setLocale(Locale newLocale) async {
    if (!SavviLocales.supported.contains(newLocale)) return;

    locale.value = newLocale;

    Get.updateLocale(newLocale);

    await _prefs.setString(
      SavviLocales.prefsKey,
      SavviLocales.tag(newLocale),
    );

    // Later stage:
    // await Get.find<SavviApi>().setLanguagePreference(newLocale);
  }
}
