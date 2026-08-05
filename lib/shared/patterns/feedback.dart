import 'package:flutter/material.dart';
import '../../core/theme/tokens.dart';
import '../widgets/sav_button.dart';

/// Feedback tone for toasts and inline notices.
enum FeedbackTone { info, success, warning, error }

/// Centralised snackbar / toast / alert helpers so feedback looks consistent
/// everywhere (ported from the v45 toast + confirm patterns).
class SavFeedback {
  SavFeedback._();

  static (Color, Color, IconData) _style(FeedbackTone tone) => switch (tone) {
        FeedbackTone.info => (SavColors.navy, Colors.white, Icons.info_outline),
        FeedbackTone.success => (
            SavColors.greenDark,
            Colors.white,
            Icons.check_circle_outline
          ),
        FeedbackTone.warning => (
            SavColors.amber,
            SavColors.navy,
            Icons.warning_amber_rounded
          ),
        FeedbackTone.error => (
            SavColors.red,
            Colors.white,
            Icons.error_outline
          ),
      };

  /// Floating toast-style snackbar.
  static void toast(
    BuildContext context,
    String message, {
    FeedbackTone tone = FeedbackTone.info,
  }) {
    final (bg, fg, icon) = _style(tone);
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          backgroundColor: bg,
          behavior: SnackBarBehavior.floating,
          shape: const RoundedRectangleBorder(borderRadius: SavRadius.field),
          content: Row(
            children: [
              Icon(icon, size: 18, color: fg),
              const SizedBox(width: SavSpace.x10),
              Expanded(
                child: Text(
                  message,
                  style: TextStyle(
                    fontFamily: SavFonts.sans,
                    fontSize: 13.5,
                    fontWeight: FontWeight.w600,
                    color: fg,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
  }

  /// Confirm dialog returning true/false. [confirmLabel]/[cancelLabel] are
  /// passed in already-localised.
  static Future<bool> confirm(
    BuildContext context, {
    required String title,
    required String message,
    required String confirmLabel,
    required String cancelLabel,
    bool destructive = false,
  }) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: SavColors.surface,
        shape: const RoundedRectangleBorder(borderRadius: SavRadius.card),
        title: Text(title, style: Theme.of(ctx).textTheme.titleMedium),
        content: Text(message, style: Theme.of(ctx).textTheme.bodyMedium),
        actions: [
          SavButton(
            label: cancelLabel,
            variant: SavButtonVariant.ghost,
            expand: false,
            onPressed: () => Navigator.of(ctx).pop(false),
          ),
          SavButton(
            label: confirmLabel,
            variant: destructive
                ? SavButtonVariant.danger
                : SavButtonVariant.primary,
            expand: false,
            onPressed: () => Navigator.of(ctx).pop(true),
          ),
        ],
      ),
    );
    return result ?? false;
  }

  /// Bottom sheet host (v45 `.sheet`). Content is provided by the caller.
  static Future<T?> sheet<T>(
    BuildContext context, {
    required WidgetBuilder builder,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      backgroundColor: SavColors.surface,
      shape: const RoundedRectangleBorder(borderRadius: SavRadius.sheet),
      builder: builder,
    );
  }
}
