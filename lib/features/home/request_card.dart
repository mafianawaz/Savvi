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

// class RequestCard extends StatelessWidget {
//   const RequestCard({
//     super.key,
//     required this.request,
//     this.onTap,
//   });
//
//   final MemberRequest request;
//   final VoidCallback? onTap;
//
//   @override
//   Widget build(BuildContext context) {
//     final l = AppLocalizations.of(context);
//
//     final formatter = Get.find<FormatterService>();
//
//     final isDelivery =
//         request.method == RequestMethod.delivery;
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
//                   color: isDelivery
//                       ? SavColors.blueLight
//                       : SavColors.greenLight,
//                   borderRadius: SavRadius.field,
//                 ),
//                 child: Icon(
//                   isDelivery
//                       ? Icons.local_shipping_outlined
//                       : Icons.storefront_outlined,
//                   size: 20,
//                   color: isDelivery
//                       ? SavColors.blue
//                       : SavColors.greenDark,
//                 ),
//               ),
//
//               const SizedBox(width: SavSpace.x12),
//
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       request.id,
//                       style: const TextStyle(
//                         fontFamily: SavFonts.sans,
//                         fontSize: 14,
//                         fontWeight: FontWeight.w700,
//                         color: SavColors.navy,
//                       ),
//                     ),
//
//                     Text(
//                       formatter.timestamp(request.createdAt),
//                       style: const TextStyle(
//                         fontFamily: SavFonts.sans,
//                         fontSize: 12,
//                         fontWeight: FontWeight.w500,
//                         color: SavColors.txt3,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//
//               StatusPill(
//                 status: request.status,
//                 label: Labels.status(
//                   l,
//                   request.status,
//                 ),
//               ),
//             ],
//           ),
//
//           const SizedBox(height: SavSpace.x10),
//
//           Wrap(
//             spacing: SavSpace.x6,
//             runSpacing: SavSpace.x6,
//             children: [
//               for (final c in request.categories)
//                 _CatChip(
//                   label: Labels.category(l, c),
//                   controlled: c.controlled,
//                 ),
//             ],
//           ),
//
//           if (request.weightLb != null ||
//               (isDelivery && request.etaHi != null))
//             Padding(
//               padding: const EdgeInsets.only(
//                 top: SavSpace.x10,
//               ),
//               child: Row(
//                 children: [
//                   if (request.weightLb != null) ...[
//                     const Icon(
//                       Icons.scale_outlined,
//                       size: 14,
//                       color: SavColors.txt3,
//                     ),
//                     const SizedBox(width: SavSpace.x4),
//                     Text(
//                       formatter.weight(
//                         lbs: request.weightLb,
//                       ),
//                       style: const TextStyle(
//                         fontFamily: SavFonts.sans,
//                         fontSize: 12.5,
//                         fontWeight: FontWeight.w600,
//                         color: SavColors.txt2,
//                       ),
//                     ),
//                   ],
//
//                   if (request.weightLb != null &&
//                       isDelivery &&
//                       request.etaHi != null)
//                     const SizedBox(width: SavSpace.x14),
//
//                   if (isDelivery &&
//                       request.etaHi != null) ...[
//                     const Icon(
//                       Icons.schedule,
//                       size: 14,
//                       color: SavColors.txt3,
//                     ),
//                     const SizedBox(width: SavSpace.x4),
//
//                     Text(
//                       l.etaAway(
//                         formatter.eta(
//                           lo: request.etaLo,
//                           hi: request.etaHi!,
//                         ),
//                       ),
//                       style: const TextStyle(
//                         fontFamily: SavFonts.sans,
//                         fontSize: 12.5,
//                         fontWeight: FontWeight.w600,
//                         color: SavColors.txt2,
//                       ),
//                     ),
//                   ],
//                 ],
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }
// class _CatChip extends StatelessWidget {
//   const _CatChip({required this.label, required this.controlled});
//   final String label;
//   final bool controlled;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding:
//           const EdgeInsets.symmetric(horizontal: SavSpace.x10, vertical: 5),
//       decoration: BoxDecoration(
//         color: controlled ? SavColors.amberLight : SavColors.page,
//         borderRadius: SavRadius.field,
//         border: Border.all(
//             color: controlled ? const Color(0x33F59E0B) : SavColors.border),
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           if (controlled) ...[
//             const Icon(Icons.lock_outline,
//                 size: 11, color: SavColors.pillAmberFg),
//             const SizedBox(width: 4),
//           ],
//           Text(label,
//               style: TextStyle(
//                   fontFamily: SavFonts.sans,
//                   fontSize: 11.5,
//                   fontWeight: FontWeight.w600,
//                   color: controlled ? SavColors.pillAmberFg : SavColors.txt2)),
//         ],
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/formatting/formatters.dart';
import '../../core/theme/tokens.dart';
import '../../data/models/enums.dart';
import '../../data/models/labels.dart';
import '../../data/models/member_request.dart';
import '../../l10n/app_localizations.dart';
import '../../shared/widgets/sav_cards.dart';

/// Compact summary of a member request: method icon, id, status pill,
/// category chips, and (when present) weight in lbs/kg and delivery
/// ETA/distance. Used on Home (in-progress) and Activity.
// class RequestCard extends StatelessWidget {
//   const RequestCard({super.key, required this.request, this.onTap});
//
//   final MemberRequest request;
//   final VoidCallback? onTap;
//
//   @override
//   Widget build(BuildContext context) {
//     final l = AppLocalizations.of(context);
//     final fmt = Get.find<Fmt>();
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
//                   color: isDelivery ? SavColors.blueLight : SavColors.greenLight,
//                   borderRadius: SavRadius.field,
//                 ),
//                 child: Icon(
//                   isDelivery
//                       ? Icons.local_shipping_outlined
//                       : Icons.storefront_outlined,
//                   size: 20,
//                   color: isDelivery ? SavColors.blue : SavColors.greenDark,
//                 ),
//               ),
//               const SizedBox(width: SavSpace.x12),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       request.id,
//                       style: const TextStyle(
//                         fontFamily: SavFonts.sans,
//                         fontSize: 14,
//                         fontWeight: FontWeight.w700,
//                         color: SavColors.navy,
//                       ),
//                     ),
//                     Text(
//                       fmt.timestamp(request.createdAt),
//                       style: const TextStyle(
//                         fontFamily: SavFonts.sans,
//                         fontSize: 12,
//                         fontWeight: FontWeight.w500,
//                         color: SavColors.txt3,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               StatusPill(
//                 status: request.status,
//                 label: Labels.status(l, request.status),
//               ),
//             ],
//           ),
//           const SizedBox(height: SavSpace.x10),
//           Wrap(
//             spacing: SavSpace.x6,
//             runSpacing: SavSpace.x6,
//             children: [
//               for (final c in request.categories)
//                 _CatChip(
//                   label: Labels.category(l, c),
//                   controlled: c.controlled,
//                 ),
//             ],
//           ),
//           if (request.weightLb != null ||
//               (isDelivery && request.etaHi != null))
//             Padding(
//               padding: const EdgeInsets.only(top: SavSpace.x10),
//               child: Row(
//                 children: [
//                   if (request.weightLb != null) ...[
//                     const Icon(
//                       Icons.scale_outlined,
//                       size: 14,
//                       color: SavColors.txt3,
//                     ),
//                     const SizedBox(width: SavSpace.x4),
//                     Text(
//                       fmt.weight(lbs: request.weightLb),
//                       style: const TextStyle(
//                         fontFamily: SavFonts.sans,
//                         fontSize: 12.5,
//                         fontWeight: FontWeight.w600,
//                         color: SavColors.txt2,
//                       ),
//                     ),
//                   ],
//                   if (request.weightLb != null &&
//                       isDelivery &&
//                       request.etaHi != null)
//                     const SizedBox(width: SavSpace.x14),
//                   if (isDelivery && request.etaHi != null) ...[
//                     const Icon(
//                       Icons.schedule,
//                       size: 14,
//                       color: SavColors.txt3,
//                     ),
//                     const SizedBox(width: SavSpace.x4),
//                     Text(
//                       l.etaAway(
//                         fmt.eta(lo: request.etaLo, hi: request.etaHi!),
//                       ),
//                       style: const TextStyle(
//                         fontFamily: SavFonts.sans,
//                         fontSize: 12.5,
//                         fontWeight: FontWeight.w600,
//                         color: SavColors.txt2,
//                       ),
//                     ),
//                   ],
//                 ],
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }
//
// class _CatChip extends StatelessWidget {
//   const _CatChip({required this.label, required this.controlled});
//   final String label;
//   final bool controlled;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding:
//       const EdgeInsets.symmetric(horizontal: SavSpace.x10, vertical: 5),
//       decoration: BoxDecoration(
//         color: controlled ? SavColors.amberLight : SavColors.page,
//         borderRadius: SavRadius.field,
//         border: Border.all(
//             color: controlled ? const Color(0x33F59E0B) : SavColors.border),
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           if (controlled) ...[
//             const Icon(Icons.lock_outline,
//                 size: 11, color: SavColors.pillAmberFg),
//             const SizedBox(width: 4),
//           ],
//           Text(label,
//               style: TextStyle(
//                   fontFamily: SavFonts.sans,
//                   fontSize: 11.5,
//                   fontWeight: FontWeight.w600,
//                   color: controlled ? SavColors.pillAmberFg : SavColors.txt2)),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/formatting/formatters.dart';
import '../../core/theme/tokens.dart';
import '../../data/models/enums.dart';
import '../../data/models/labels.dart';
import '../../data/models/member_request.dart';
import '../../l10n/app_localizations.dart';
import '../../shared/widgets/sav_cards.dart';

/// Compact summary of a member request: photo method badge, id, status
/// pill, category photo chips, and (when present) weight in lbs/kg and
/// delivery ETA/distance. Used on Home (in-progress) and Activity.
class RequestCard extends StatelessWidget {
  const RequestCard({super.key, required this.request, this.onTap});

  final MemberRequest request;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final fmt = Get.find<Fmt>();
    final isDelivery = request.method == RequestMethod.delivery;

    return SavCard(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: SavRadius.field,
                child: SizedBox(
                  width: 42,
                  height: 42,
                  child: Image.asset(
                    SavImages.method(request.method),
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stack) =>
                        _methodFallback(isDelivery),
                  ),
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
                      fmt.timestamp(request.createdAt),
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
                label: Labels.status(l, request.status),
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
                  image: SavImages.category(c),
                  label: Labels.category(l, c),
                  controlled: c.controlled,
                ),
            ],
          ),
          if (request.weightLb != null ||
              (isDelivery && request.etaHi != null))
            Padding(
              padding: const EdgeInsets.only(top: SavSpace.x10),
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
                      fmt.weight(lbs: request.weightLb),
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
                  if (isDelivery && request.etaHi != null) ...[
                    const Icon(
                      Icons.schedule,
                      size: 14,
                      color: SavColors.txt3,
                    ),
                    const SizedBox(width: SavSpace.x4),
                    Text(
                      l.etaAway(
                        fmt.eta(lo: request.etaLo, hi: request.etaHi!),
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

  Widget _methodFallback(bool isDelivery) {
    return Container(
      color: isDelivery ? SavColors.blueLight : SavColors.greenLight,
      child: Icon(
        isDelivery ? Icons.local_shipping_outlined : Icons.storefront_outlined,
        size: 20,
        color: isDelivery ? SavColors.blue : SavColors.greenDark,
      ),
    );
  }
}

/// Category chip with a small round photo thumbnail (instead of the
/// previous text-only chip) so requests read consistently with the
/// photo-forward v56 design used elsewhere on Home.
class _CatChip extends StatelessWidget {
  const _CatChip({
    required this.image,
    required this.label,
    required this.controlled,
  });

  final String image;
  final String label;
  final bool controlled;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 4,
        right: SavSpace.x10,
        top: 4,
        bottom: 4,
      ),
      decoration: BoxDecoration(
        color: controlled ? SavColors.amberLight : SavColors.page,
        borderRadius: SavRadius.pill,
        border: Border.all(
          color: controlled ? const Color(0x33F59E0B) : SavColors.border,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(9),
            child: SizedBox(
              width: 18,
              height: 18,
              child: Image.asset(
                image,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stack) => Container(
                  color: SavColors.border,
                ),
              ),
            ),
          ),
          const SizedBox(width: SavSpace.x6),
          if (controlled) ...[
            const Icon(Icons.lock_outline, size: 11, color: SavColors.pillAmberFg),
            const SizedBox(width: 3),
          ],
          Text(
            label,
            style: TextStyle(
              fontFamily: SavFonts.sans,
              fontSize: 11.5,
              fontWeight: FontWeight.w600,
              color: controlled ? SavColors.pillAmberFg : SavColors.txt2,
            ),
          ),
        ],
      ),
    );
  }
}