import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../formatting/formatters.dart';

/// The MVP locales. Additional locales are post-MVP and must not be added
/// here without founder approval.
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
/// In production the source of truth is the backend user language
/// preference; this controller loads a locally cached value for first paint
/// and writes changes both locally (SharedPreferences) and — in a later
/// stage — to the backend via SavviApi.setLanguagePreference.
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

    // FIX: Fmt is immutable (final fields), so a locale change needs a new
    // instance re-registered under the same type — every `Get.find<Fmt>()`
    // call site (date/time/weight formatting across Home, Events, Activity,
    // Notifications) picks this up on their next build rather than holding
    // a stale-locale formatter.
    Get.put<Fmt>(Fmt(newLocale), permanent: true);

    await _prefs.setString(
      SavviLocales.prefsKey,
      SavviLocales.tag(newLocale),
    );

    // Later stage:
    // await Get.find<SavviApi>().setLanguagePreference(newLocale);
  }
}
