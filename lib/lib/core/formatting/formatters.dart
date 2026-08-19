import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

/// Locale-aware formatting for every temporal and measured value shown to a
/// member. Ported from the v45 formatting layer.
///
/// Backend stores RAW canonical values only — ISO-8601 timestamps, pounds,
/// miles, minute ranges, and (for weight) both normalized_weight_lbs and
/// normalized_weight_kg. The client decides presentation from the active
/// [Locale]. It never persists formatted strings.
///
/// U.S. MVP unit policy (locked): display lbs first, kg second
/// (e.g. "340 lbs / 154 kg"). en-US and es-US both use lbs/kg; Spanish
/// translates surrounding labels only — the units stay lbs/kg.
class Fmt {
  Fmt(this.locale);

  /// BCP-47 tag, e.g. `en-US` or `es-US`. intl uses underscores internally.
  final Locale locale;
  String get _tag => locale.toLanguageTag(); // en-US / es-US

  static const double _lbPerKg = 0.45359237;
  static const double _kmPerMi = 1.609344;

  // ── Dates & times ─────────────────────────────────────────────────────────

  /// Relative-aware calendar date. Today / Yesterday / Tomorrow inside a
  /// one-day window, otherwise a locale short date. The Today/Yesterday/
  /// Tomorrow words come from l10n and are injected via [relativeWords] so this
  /// utility stays independent of the generated AppLocalizations.
  String date(
    DateTime dt, {
    RelativeDayWords? relativeWords,
    bool absolute = false,
  }) {
    if (!absolute && relativeWords != null) {
      final days = _dayDelta(dt, DateTime.now());
      if (days == 0) return relativeWords.today;
      if (days == -1) return relativeWords.yesterday;
      if (days == 1) return relativeWords.tomorrow;
    }
    final sameYear = dt.year == DateTime.now().year;
    final pattern = sameYear ? DateFormat.MMMd(_tag) : DateFormat.yMMMd(_tag);
    return pattern.format(dt);
  }

  /// Clock time, locale-appropriate 12h/24h.
  String time(DateTime dt) => DateFormat.jm(_tag).format(dt);

  /// Date + time, e.g. "Today · 8:40 AM" / "Hoy · 8:40 a. m.".
  String dateTime(DateTime dt, {RelativeDayWords? relativeWords}) =>
      '${date(dt, relativeWords: relativeWords)} · ${time(dt)}';

  /// Pickup / delivery window from two timestamps.
  String window(DateTime start, DateTime? end,
      {RelativeDayWords? relativeWords}) {
    if (end == null) return dateTime(start, relativeWords: relativeWords);
    final sameDay = _dayDelta(start, end) == 0;
    final range = '${time(start)}–${time(end)}';
    return sameDay
        ? '${date(start, relativeWords: relativeWords)} · $range'
        : '${dateTime(start, relativeWords: relativeWords)} – '
            '${dateTime(end, relativeWords: relativeWords)}';
  }

  /// Notification / audit timestamp.
  String timestamp(DateTime dt, {RelativeDayWords? relativeWords}) =>
      dateTime(dt, relativeWords: relativeWords);

  // ── Weight (lbs first, kg second) ─────────────────────────────────────────

  /// Dual weight display. Prefer passing both backend-provided canonical values
  /// ([lbs], [kg]); if only [lbs] is supplied the kg value is derived for
  /// prototype display. Whole numbers for summaries (locked rounding rule).
  ///
  /// Returns e.g. "340 lbs / 154 kg". Labels around this string are localised
  /// by the caller; the unit tokens themselves stay lbs/kg for the U.S. MVP.
  String weight({double? lbs, double? kg}) {
    if (lbs == null && kg == null) return '';
    final l = lbs ?? (kg! / _lbPerKg);
    final k = kg ?? (lbs! * _lbPerKg);
    final nf = NumberFormat.decimalPattern(_tag)..maximumFractionDigits = 0;
    return '${nf.format(l.round())} lbs / ${nf.format(k.round())} kg';
  }

  /// Single-unit weight when only one unit is appropriate (rarely used in the
  /// member UI; dual display is the default). [unit] selects lbs or kg.
  String weightSingle(double lbs, {bool asKg = false}) {
    final nf = NumberFormat.decimalPattern(_tag)..maximumFractionDigits = 0;
    return asKg
        ? '${nf.format((lbs * _lbPerKg).round())} kg'
        : '${nf.format(lbs.round())} lbs';
  }

  // ── Distance & ETA ────────────────────────────────────────────────────────

  /// Distance. U.S. MVP keeps miles. Backend value is miles.
  String distance(double miles) {
    final nf = NumberFormat.decimalPattern(_tag)..maximumFractionDigits = 1;
    return '${nf.format(miles)} mi';
  }

  /// ETA as a minute range, e.g. "20–30 min". Pass [lo]==[hi] (or lo null) for
  /// a single value like "5 min".
  String eta({int? lo, required int hi, String unit = 'min'}) {
    final nf = NumberFormat.decimalPattern(_tag)..maximumFractionDigits = 0;
    if (lo != null && lo != hi) {
      return '${nf.format(lo)}–${nf.format(hi)} $unit';
    }
    return '${nf.format(hi)} $unit';
  }

  // ── Currency ──────────────────────────────────────────────────────────────

  /// USD for the U.S. MVP. NOTE: Delivery Credits and any monetary balances are
  /// NOT shown to Savvi members; this exists for any future member-safe pricing
  /// surface only.
  String currencyUsd(num amount) =>
      NumberFormat.currency(locale: _tag, symbol: r'$').format(amount);

  // ── helpers ────────────────────────────────────────────────────────────────

  int _dayDelta(DateTime a, DateTime b) {
    final da = DateTime(a.year, a.month, a.day);
    final db = DateTime(b.year, b.month, b.day);
    return da.difference(db).inDays;
  }
}

/// The three relative-day words, resolved from l10n and handed to [Fmt] so the
/// formatter has no dependency on generated localization classes.
class RelativeDayWords {
  const RelativeDayWords({
    required this.today,
    required this.yesterday,
    required this.tomorrow,
  });
  final String today;
  final String yesterday;
  final String tomorrow;
}



class FormatterService extends GetxService {
  late Fmt _formatter;

  Fmt get formatter => _formatter;

  @override
  void onInit() {
    super.onInit();

    _formatter = Fmt(Get.locale ?? const Locale('en', 'US'));
  }

  void updateLocale(Locale locale) {
    _formatter = Fmt(locale);
    // update();
  }

  //-------------------------------------------------------------------------
  // Wrappers
  //-------------------------------------------------------------------------

  String date(
      DateTime dt, {
        RelativeDayWords? relativeWords,
        bool absolute = false,
      }) {
    return _formatter.date(
      dt,
      relativeWords: relativeWords,
      absolute: absolute,
    );
  }

  String time(DateTime dt) {
    return _formatter.time(dt);
  }

  String dateTime(
      DateTime dt, {
        RelativeDayWords? relativeWords,
      }) {
    return _formatter.dateTime(
      dt,
      relativeWords: relativeWords,
    );
  }

  String window(
      DateTime start,
      DateTime? end, {
        RelativeDayWords? relativeWords,
      }) {
    return _formatter.window(
      start,
      end,
      relativeWords: relativeWords,
    );
  }

  String timestamp(
      DateTime dt, {
        RelativeDayWords? relativeWords,
      }) {
    return _formatter.timestamp(
      dt,
      relativeWords: relativeWords,
    );
  }

  String weight({
    double? lbs,
    double? kg,
  }) {
    return _formatter.weight(
      lbs: lbs,
      kg: kg,
    );
  }

  String weightSingle(
      double lbs, {
        bool asKg = false,
      }) {
    return _formatter.weightSingle(
      lbs,
      asKg: asKg,
    );
  }

  String distance(double miles) {
    return _formatter.distance(miles);
  }

  String eta({
    int? lo,
    required int hi,
    String unit = 'min',
  }) {
    return _formatter.eta(
      lo: lo,
      hi: hi,
      unit: unit,
    );
  }

  String currencyUsd(num amount) {
    return _formatter.currencyUsd(amount);
  }
}