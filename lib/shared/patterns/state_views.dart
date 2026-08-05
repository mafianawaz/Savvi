import 'package:flutter/material.dart';
import '../../core/theme/tokens.dart';
import '../widgets/sav_button.dart';

/// Standard full-area state views (v45 empty/loading/error/success patterns).
/// Screens reuse these so async states look identical everywhere.
class StateViews {
  StateViews._();

  static Widget loading({String? label}) => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 26,
              width: 26,
              child: CircularProgressIndicator(
                  strokeWidth: 2.5, color: SavColors.navy),
            ),
            if (label != null) ...[
              const SizedBox(height: SavSpace.x12),
              Text(label,
                  style: const TextStyle(
                    fontFamily: SavFonts.sans,
                    fontSize: 13,
                    color: SavColors.txt3,
                  )),
            ],
          ],
        ),
      );

  static Widget empty({
    required String title,
    String? message,
    IconData icon = Icons.inbox_outlined,
    Widget? action,
  }) =>
      _centered(
        icon: icon,
        iconColor: SavColors.txt4,
        title: title,
        message: message,
        action: action,
      );

  static Widget error({
    required String title,
    String? message,
    String? retryLabel,
    VoidCallback? onRetry,
  }) =>
      _centered(
        icon: Icons.error_outline,
        iconColor: SavColors.red,
        title: title,
        message: message,
        action: (retryLabel != null && onRetry != null)
            ? SavButton(
                label: retryLabel,
                variant: SavButtonVariant.ghost,
                expand: false,
                onPressed: onRetry,
              )
            : null,
      );

  static Widget success({
    required String title,
    String? message,
    IconData icon = Icons.check_circle_outline,
  }) =>
      _centered(
        icon: icon,
        iconColor: SavColors.greenDark,
        title: title,
        message: message,
      );

  static Widget _centered({
    required IconData icon,
    required Color iconColor,
    required String title,
    String? message,
    Widget? action,
  }) =>
      Center(
        child: Padding(
          padding: const EdgeInsets.all(SavSpace.x24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 34, color: iconColor),
              const SizedBox(height: SavSpace.x12),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: SavFonts.serif,
                  fontSize: 18,
                  color: SavColors.navy,
                ),
              ),
              if (message != null) ...[
                const SizedBox(height: SavSpace.x6),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: SavFonts.sans,
                    fontSize: 13,
                    height: 1.5,
                    fontWeight: FontWeight.w500,
                    color: SavColors.txt3,
                  ),
                ),
              ],
              if (action != null) ...[
                const SizedBox(height: SavSpace.x16),
                action,
              ],
            ],
          ),
        ),
      );
}
