import 'package:flutter/material.dart';
import '../../core/theme/tokens.dart';
import '../../data/models/request_status.dart';

/// Standard surface card (v45 `.card`).
class SavCard extends StatelessWidget {
  const SavCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(SavSpace.x16),
    this.onTap,
  });

  final Widget child;
  final EdgeInsets padding;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final content = Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: SavColors.surface,
        borderRadius: SavRadius.card,
        border: Border.all(color: SavColors.border, width: 1.5),
      ),
      child: child,
    );
    if (onTap == null) return content;
    return Semantics(
      button: true,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: SavRadius.card,
          onTap: onTap,
          child: content,
        ),
      ),
    );
  }
}

/// Selectable chip (v45 `.chip`) with 44px hit target.
// class SavChip extends StatelessWidget {
//   const SavChip({
//     super.key,
//     required this.label,
//     required this.selected,
//     required this.onTap,
//   });
//
//   final String label;
//   final bool selected;
//   final VoidCallback onTap;
//
//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       color: selected ? SavColors.navy : SavColors.surface,
//       borderRadius: SavRadius.pill,
//       child: InkWell(
//         borderRadius: SavRadius.pill,
//         onTap: onTap,
//         child: Container(
//           // constraints: const BoxConstraints(minHeight: SavSpace.x24,),
//           padding: const EdgeInsets.symmetric(
//               horizontal: SavSpace.x14, vertical: SavSpace.x10),
//           decoration: BoxDecoration(
//             borderRadius: SavRadius.pill,
//             border: Border.all(
//               color: selected ? SavColors.navy : SavColors.border,
//               width: 1.5,
//             ),
//           ),
//           alignment: Alignment.center,
//           child: Text(
//             label,
//             style: TextStyle(
//               fontFamily: SavFonts.sans,
//               fontSize: 13,
//               fontWeight: FontWeight.w600,
//               color: selected ? Colors.white : SavColors.txt2,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
class SavChip extends StatelessWidget {
  const SavChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(4);

    return Material(
      color: selected ? SavColors.navy : SavColors.surface,
      borderRadius: borderRadius,
      child: InkWell(
        onTap: onTap,
        borderRadius: borderRadius,
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            border: Border.all(
              color: selected
                  ? SavColors.navy
                  : SavColors.border,
              width: 1,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: SavSpace.x14,
              vertical: SavSpace.x10,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  label,
                  maxLines: 1,
                  softWrap: false,
                  style: TextStyle(
                    fontFamily: SavFonts.sans,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: selected
                        ? Colors.white
                        : SavColors.txt2,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
/// Boxed label/value fact (v56 request-detail "Method" / "Household" /
/// "Weight" tiles) — a light filled tile, distinct from the plain label/value
/// rows used for categories, dietary, and allergens.
class SavFactBox extends StatelessWidget {
  const SavFactBox({super.key, required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minWidth: 120),
      padding: const EdgeInsets.symmetric(
          horizontal: SavSpace.x12, vertical: SavSpace.x10),
      decoration: const BoxDecoration(
        color: SavColors.page,
        borderRadius: SavRadius.field,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontFamily: SavFonts.sans,
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: SavColors.txt3,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: const TextStyle(
              fontFamily: SavFonts.sans,
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: SavColors.navy,
            ),
          ),
        ],
      ),
    );
  }
}

/// Status pill that colours itself from a [RequestStatus]'s [PillTone].
/// [label] is the already-localised status text (resolved by the caller).
class StatusPill extends StatelessWidget {
  const StatusPill({super.key, required this.status, required this.label});

  final RequestStatus status;
  final String label;

  @override
  Widget build(BuildContext context) {
    final (bg, fg) = _colors(status.tone);
    return Container(
      padding:
          const EdgeInsets.symmetric(horizontal: SavSpace.x10, vertical: 5),
      decoration: BoxDecoration(color: bg, borderRadius: SavRadius.pill),
      child: Text(
        label,
        style: TextStyle(
          fontFamily: SavFonts.sans,
          fontSize: 11,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.3,
          color: fg,
        ),
      ),
    );
  }

  static (Color, Color) _colors(PillTone tone) => switch (tone) {
        PillTone.navy => (const Color(0xFFE7EDF5), SavColors.navy),
        PillTone.green => (SavColors.greenLight, SavColors.pillGreenFg),
        PillTone.blue => (SavColors.blueLight, SavColors.pillBlueFg),
        PillTone.amber => (SavColors.amberLight, SavColors.pillAmberFg),
        PillTone.red => (SavColors.redLight, SavColors.pillRedFg),
        PillTone.gray => (const Color(0xFFF1F3F5), SavColors.txt3),
      };
}
