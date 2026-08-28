import 'package:flutter/material.dart';
import 'package:get/get.dart';
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


  /// Shows API feedback without requiring a BuildContext in every controller.
  /// Uses the same Savvi toast styling as [toast].
  static void globalToast(
    String message, {
    FeedbackTone tone = FeedbackTone.info,
  }) {
    final context = Get.context;
    if (context == null || message.trim().isEmpty) return;

    final messenger = ScaffoldMessenger.maybeOf(context);
    if (messenger == null) return;

    final (bg, fg, icon) = _style(tone);
    messenger
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
                  message.trim(),
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

  /// Confirm bottom sheet returning true/false (v56 pattern — a serif
  /// title, a plain-language body, and full-width stacked actions with the
  /// primary/destructive action on top). [confirmLabel]/[cancelLabel] are
  /// passed in already-localised.
  static Future<bool> confirm(
    BuildContext context, {
    required String title,
    required String message,
    required String confirmLabel,
    required String cancelLabel,
    bool destructive = false,
  }) async {
    final result = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: SavColors.surface,
      shape: const RoundedRectangleBorder(borderRadius: SavRadius.sheet),
      builder: (ctx) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
              SavSpace.x20, SavSpace.x12, SavSpace.x20, SavSpace.x20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 36,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: SavSpace.x20),
                  decoration: BoxDecoration(
                    color: SavColors.border,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              Text(
                title,
                style: const TextStyle(
                  fontFamily: SavFonts.serif,
                  fontSize: 20,
                  color: SavColors.navy,
                ),
              ),
              const SizedBox(height: SavSpace.x8),
              Text(
                message,
                style: const TextStyle(
                  fontFamily: SavFonts.sans,
                  fontSize: 13.5,
                  height: 1.45,
                  fontWeight: FontWeight.w500,
                  color: SavColors.txt3,
                ),
              ),
              const SizedBox(height: SavSpace.x20),
              SavButton(
                label: confirmLabel,
                variant:
                    destructive ? SavButtonVariant.danger : SavButtonVariant.primary,
                onPressed: () => Navigator.of(ctx).pop(true),
              ),
              const SizedBox(height: SavSpace.x10),
              SavButton(
                label: cancelLabel,
                variant: SavButtonVariant.ghost,
                onPressed: () => Navigator.of(ctx).pop(false),
              ),
            ],
          ),
        ),
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
