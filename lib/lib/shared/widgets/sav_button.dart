import 'package:flutter/material.dart';
import '../../core/theme/tokens.dart';

/// Button variants ported from the v45 `.btn` system. All enforce the 44px
/// minimum height.

enum SavButtonVariant { primary, secondary, ghost, danger }

class SavButton extends StatelessWidget {
  const SavButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = SavButtonVariant.primary,
    this.busy = false,
    this.expand = true,
    this.icon,
  });

  final String label;
  final VoidCallback? onPressed;
  final SavButtonVariant variant;
  final bool busy;
  final bool expand;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final (Color, Color, Color?) style = switch (variant) {
      SavButtonVariant.primary => (SavColors.navy, Colors.white, null),
      SavButtonVariant.secondary => (SavColors.green, SavColors.navy, null),
      SavButtonVariant.ghost => (Colors.white, SavColors.txt2, SavColors.border),
      SavButtonVariant.danger => (SavColors.red, Colors.white, null),
    };
    final bg = style.$1;
    final fg = style.$2;
    final border = style.$3;

    final child = busy
        ? const SizedBox(
            height: 18,
            width: 18,
            child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                Icon(icon, size: 18, color: fg),
                const SizedBox(width: SavSpace.x8),
              ],
              Flexible(
                child: Text(
                  label,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: SavFonts.sans,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: fg,
                  ),
                ),
              ),
            ],
          );

    final button = Material(
      color: bg,
      borderRadius: SavRadius.button,
      child: InkWell(
        borderRadius: SavRadius.button,
        onTap: busy ? null : onPressed,
        child: Container(
          constraints: const BoxConstraints(minHeight: SavSpace.minTouch),
          padding: const EdgeInsets.symmetric(
              horizontal: SavSpace.x20, vertical: SavSpace.x12),
          decoration: border == null
              ? null
              : BoxDecoration(
                  borderRadius: SavRadius.button,
                  border: Border.all(color: border, width: 1.5),
                ),
          alignment: Alignment.center,
          child: child,
        ),
      ),
    );

    return expand ? SizedBox(width: double.infinity, child: button) : button;
  }
}
