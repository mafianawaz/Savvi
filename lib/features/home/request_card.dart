import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

import '../../core/formatting/formatters.dart';
import '../../core/state/providers.dart';
import '../../core/theme/tokens.dart';
import '../../data/models/enums.dart';
import '../../data/models/labels.dart';
import '../../data/models/member_request.dart';
import '../../l10n/app_localizations.dart';
import '../../shared/widgets/sav_cards.dart';

/// Compact summary of a member request: method icon, id, status pill, category
/// chips, and (when present) weight in lbs/kg and delivery ETA/distance.
/// Used on Home (in-progress) and Activity (Stage 3B).
// class RequestCard extends ConsumerWidget {
//   const RequestCard({super.key, required this.request, this.onTap});
//
//   final MemberRequest request;
//   final VoidCallback? onTap;
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final l = AppLocalizations.of(context);
//     final fmt = ref.watch(formatterProvider);
//     final isDelivery = request.method == RequestMethod.delivery;
//
//     return SavCard(
//       onTap: onTap,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Container(
//                 width: 42,
//                 height: 42,
//                 decoration: BoxDecoration(
//                     color: isDelivery ? SavColors.blueLight : SavColors.greenLight,
//                     borderRadius: SavRadius.field),
//                 child: Icon(
//                     isDelivery
//                         ? Icons.local_shipping_outlined
//                         : Icons.storefront_outlined,
//                     size: 20,
//                     color: isDelivery ? SavColors.blue : SavColors.greenDark),
//               ),
//               const SizedBox(width: SavSpace.x12),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(request.id,
//                         style: const TextStyle(
//                             fontFamily: SavFonts.sans,
//                             fontSize: 14,
//                             fontWeight: FontWeight.w700,
//                             color: SavColors.navy)),
//                     Text(fmt.timestamp(request.createdAt),
//                         style: const TextStyle(
//                             fontFamily: SavFonts.sans,
//                             fontSize: 12,
//                             fontWeight: FontWeight.w500,
//                             color: SavColors.txt3)),
//                   ],
//                 ),
//               ),
//               StatusPill(
//                   status: request.status,
//                   label: Labels.status(l, request.status)),
//             ],
//           ),
//           const SizedBox(height: SavSpace.x10),
//           Wrap(
//             spacing: SavSpace.x6,
//             runSpacing: SavSpace.x6,
//             children: [
//               for (final c in request.categories)
//                 _CatChip(label: Labels.category(l, c), controlled: c.controlled),
//             ],
//           ),
//           if (request.weightLb != null || (isDelivery && request.etaHi != null))
//             Padding(
//               padding: const EdgeInsets.only(top: SavSpace.x10),
//               child: Row(
//                 children: [
//                   if (request.weightLb != null) ...[
//                     const Icon(Icons.scale_outlined,
//                         size: 14, color: SavColors.txt3),
//                     const SizedBox(width: SavSpace.x4),
//                     Text(fmt.weight(lbs: request.weightLb),
//                         style: const TextStyle(
//                             fontFamily: SavFonts.sans,
//                             fontSize: 12.5,
//                             fontWeight: FontWeight.w600,
//                             color: SavColors.txt2)),
//                   ],
//                   if (request.weightLb != null &&
//                       isDelivery &&
//                       request.etaHi != null)
//                     const SizedBox(width: SavSpace.x14),
//                   if (isDelivery && request.etaHi != null) ...[
//                     const Icon(Icons.schedule,
//                         size: 14, color: SavColors.txt3),
//                     const SizedBox(width: SavSpace.x4),
//                     Text(
//                         l.etaAway(
//                             fmt.eta(lo: request.etaLo, hi: request.etaHi!)),
//                         style: const TextStyle(
//                             fontFamily: SavFonts.sans,
//                             fontSize: 12.5,
//                             fontWeight: FontWeight.w600,
//                             color: SavColors.txt2)),
//                   ],
//                 ],
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }
class RequestCard extends StatelessWidget {
  const RequestCard({
    super.key,
    required this.request,
    this.onTap,
  });

  final MemberRequest request;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);

    final formatter = Get.find<FormatterService>();

    final isDelivery =
        request.method == RequestMethod.delivery;

    return SavCard(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: isDelivery
                      ? SavColors.blueLight
                      : SavColors.greenLight,
                  borderRadius: SavRadius.field,
                ),
                child: Icon(
                  isDelivery
                      ? Icons.local_shipping_outlined
                      : Icons.storefront_outlined,
                  size: 20,
                  color: isDelivery
                      ? SavColors.blue
                      : SavColors.greenDark,
                ),
              ),

              const SizedBox(width: SavSpace.x12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      request.id,
                      style: const TextStyle(
                        fontFamily: SavFonts.sans,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: SavColors.navy,
                      ),
                    ),

                    Text(
                      formatter.timestamp(request.createdAt),
                      style: const TextStyle(
                        fontFamily: SavFonts.sans,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: SavColors.txt3,
                      ),
                    ),
                  ],
                ),
              ),

              StatusPill(
                status: request.status,
                label: Labels.status(
                  l,
                  request.status,
                ),
              ),
            ],
          ),

          const SizedBox(height: SavSpace.x10),

          Wrap(
            spacing: SavSpace.x6,
            runSpacing: SavSpace.x6,
            children: [
              for (final c in request.categories)
                _CatChip(
                  label: Labels.category(l, c),
                  controlled: c.controlled,
                ),
            ],
          ),

          if (request.weightLb != null ||
              (isDelivery && request.etaHi != null))
            Padding(
              padding: const EdgeInsets.only(
                top: SavSpace.x10,
              ),
              child: Row(
                children: [
                  if (request.weightLb != null) ...[
                    const Icon(
                      Icons.scale_outlined,
                      size: 14,
                      color: SavColors.txt3,
                    ),
                    const SizedBox(width: SavSpace.x4),
                    Text(
                      formatter.weight(
                        lbs: request.weightLb,
                      ),
                      style: const TextStyle(
                        fontFamily: SavFonts.sans,
                        fontSize: 12.5,
                        fontWeight: FontWeight.w600,
                        color: SavColors.txt2,
                      ),
                    ),
                  ],

                  if (request.weightLb != null &&
                      isDelivery &&
                      request.etaHi != null)
                    const SizedBox(width: SavSpace.x14),

                  if (isDelivery &&
                      request.etaHi != null) ...[
                    const Icon(
                      Icons.schedule,
                      size: 14,
                      color: SavColors.txt3,
                    ),
                    const SizedBox(width: SavSpace.x4),

                    Text(
                      l.etaAway(
                        formatter.eta(
                          lo: request.etaLo,
                          hi: request.etaHi!,
                        ),
                      ),
                      style: const TextStyle(
                        fontFamily: SavFonts.sans,
                        fontSize: 12.5,
                        fontWeight: FontWeight.w600,
                        color: SavColors.txt2,
                      ),
                    ),
                  ],
                ],
              ),
            ),
        ],
      ),
    );
  }
}
class _CatChip extends StatelessWidget {
  const _CatChip({required this.label, required this.controlled});
  final String label;
  final bool controlled;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.symmetric(horizontal: SavSpace.x10, vertical: 5),
      decoration: BoxDecoration(
        color: controlled ? SavColors.amberLight : SavColors.page,
        borderRadius: SavRadius.field,
        border: Border.all(
            color: controlled ? const Color(0x33F59E0B) : SavColors.border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (controlled) ...[
            const Icon(Icons.lock_outline,
                size: 11, color: SavColors.pillAmberFg),
            const SizedBox(width: 4),
          ],
          Text(label,
              style: TextStyle(
                  fontFamily: SavFonts.sans,
                  fontSize: 11.5,
                  fontWeight: FontWeight.w600,
                  color: controlled ? SavColors.pillAmberFg : SavColors.txt2)),
        ],
      ),
    );
  }
}
