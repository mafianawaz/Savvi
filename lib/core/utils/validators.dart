import '../../l10n/app_localizations.dart';

/// Reusable field validators. Each takes the generated [AppLocalizations] so
/// messages are localised (en-US / es-US). Use with Flutter's Form/
/// TextFormField `validator:` slot.
///
/// Signature matches FormFieldValidator<String>: returns null when valid, or a
/// localised error string when invalid.
class Validators {
  Validators._();

  static String? Function(String?) required(AppLocalizations l) =>
      (v) => (v == null || v.trim().isEmpty) ? l.valRequired : null;

  static String? Function(String?) email(AppLocalizations l) => (v) {
        final s = (v ?? '').trim();
        if (s.isEmpty) return l.valRequired;
        final ok = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(s);
        return ok ? null : l.valEmail;
      };

  /// Phone is REQUIRED at profile setup (locked founder decision). Validates
  /// presence first, then that at least 10 digits are present. Does NOT imply
  /// SMS — Savvi uses no SMS channel.
  static String? Function(String?) phoneRequired(AppLocalizations l) => (v) {
        final s = (v ?? '').trim();
        if (s.isEmpty) return l.valPhoneRequired;
        final digits = s.replaceAll(RegExp(r'\D'), '');
        return digits.length >= 10 ? null : l.valPhoneInvalid;
      };

  static String? Function(String?) zip(AppLocalizations l) => (v) {
        final s = (v ?? '').trim();
        if (s.isEmpty) return l.valRequired;
        return RegExp(r'^\d{5}(-\d{4})?$').hasMatch(s) ? null : l.valZip;
      };

  /// Compose several validators; first failure wins.
  static String? Function(String?) compose(
    List<String? Function(String?)> validators,
  ) =>
      (v) {
        for (final validate in validators) {
          final r = validate(v);
          if (r != null) return r;
        }
        return null;
      };
}
