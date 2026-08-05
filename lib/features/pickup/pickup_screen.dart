import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/tokens.dart';
import '../../data/models/labels.dart';
import '../../data/models/member_request.dart';
import '../../data/models/request_status.dart';
import '../../l10n/app_localizations.dart';
import '../../shared/patterns/feedback.dart';
import '../../shared/patterns/state_views.dart';
import '../../shared/widgets/sav_button.dart';
import '../../shared/widgets/sav_cards.dart';
import '../../shared/widgets/sav_inputs.dart';
import '../auth/auth_controller.dart';
import '../home/requests_controller.dart';

/// Pickup details: status banner, window/location, and the pickup code + QR.
/// Codes and QR are issued by the backend — the frontend only displays them,
/// and shows a waiting state until a code exists (locked decision).
// class PickupScreen extends ConsumerWidget {
//   const PickupScreen({super.key, required this.requestId});
//   final String requestId;
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final l = AppLocalizations.of(context);
//     final async = ref.watch(requestDetailProvider(requestId));
//     return Scaffold(
//       backgroundColor: SavColors.page,
//       appBar: AppBar(
//         backgroundColor: SavColors.surface,
//         elevation: 0,
//         scrolledUnderElevation: 0,
//         leading: IconButton(
//             icon: const Icon(Icons.arrow_back, color: SavColors.navy),
//             onPressed: () => context.pop()),
//         title: Text(l.pkTitle,
//             style: const TextStyle(
//                 fontFamily: SavFonts.serif, fontSize: 18, color: SavColors.navy)),
//         centerTitle: true,
//       ),
//       body: async.when(
//         loading: () => StateViews.loading(),
//         error: (_, __) => StateViews.empty(
//             title: l.notFoundTitle, message: l.actEmptyBody, icon: Icons.search_off),
//         data: (r) => _body(context, ref, l, r),
//       ),
//     );
//   }
//
//   Widget _body(
//       BuildContext context, WidgetRef ref, AppLocalizations l, MemberRequest r) {
//     final auth = ref.read(authControllerProvider);
//     final nonprofit =
//         auth is AuthSignedIn ? (auth.profile['nonprofit'] as String? ?? '—') : '—';
//
//     return ListView(
//       padding: const EdgeInsets.fromLTRB(
//           SavSpace.x16, SavSpace.x16, SavSpace.x16, SavSpace.x24),
//       children: [
//         Text(l.pkSub,
//             style: const TextStyle(
//                 fontFamily: SavFonts.sans,
//                 fontSize: 13,
//                 fontWeight: FontWeight.w500,
//                 color: SavColors.txt3)),
//         const SizedBox(height: SavSpace.x14),
//         _banner(l, r.status),
//         const SizedBox(height: SavSpace.x12),
//         SavCard(
//           child: Column(
//             children: [
//               _row(l.requestIdLabel, r.id),
//               _row(l.nonprofitLabel, nonprofit),
//               _row(l.pkWindow, l.naLabel),
//               _row(l.pkLocation, l.naLabel),
//               _row(l.rvHousehold, r.household),
//             ],
//           ),
//         ),
//         const SizedBox(height: SavSpace.x12),
//         SavButton(
//             label: l.directions,
//             variant: SavButtonVariant.ghost,
//             icon: Icons.map_outlined,
//             onPressed: () => SavFeedback.toast(context, l.protoNote)),
//         const SizedBox(height: SavSpace.x12),
//         _codeBlock(context, l, r),
//         if (r.status == RequestStatus.missed) ...[
//           const SizedBox(height: SavSpace.x12),
//           SavButton(
//               label: l.pkReschedule,
//               onPressed: () =>
//                   SavFeedback.toast(context, l.pkReschedSent, tone: FeedbackTone.success)),
//         ],
//       ],
//     );
//   }
//
//   Widget _banner(AppLocalizations l, RequestStatus st) {
//     final (String? title, String body, NoticeTone tone, IconData icon) =
//         switch (st) {
//       RequestStatus.readyPickup => (
//           l.pkReadyTitle,
//           l.pkReadyBody,
//           NoticeTone.green,
//           Icons.check_circle_outline
//         ),
//       RequestStatus.pickupConfirmed => (
//           l.pkConfirmedTitle,
//           l.pkConfirmedBody,
//           NoticeTone.green,
//           Icons.check_circle_outline
//         ),
//       RequestStatus.completed => (
//           l.pkCompletedTitle,
//           l.pkCompletedBody,
//           NoticeTone.green,
//           Icons.check_circle_outline
//         ),
//       RequestStatus.missed => (
//           l.pkMissedTitle,
//           l.pkMissedBody,
//           NoticeTone.amber,
//           Icons.warning_amber_rounded
//         ),
//       // Approved / preparing / anything else: show the real status, not "ready".
//       _ => (null, Labels.status(l, st), NoticeTone.neutral, Icons.info_outline),
//     };
//     return SavNotice(title: title, message: body, tone: tone, icon: icon);
//   }
//
//   Widget _codeBlock(BuildContext context, AppLocalizations l, MemberRequest r) {
//     // Codes/QR are backend-issued. Until one exists, show a waiting state.
//     if (r.pickupCode == null) {
//       return SavCard(
//         child: Column(
//           children: [
//             Container(
//               width: 150,
//               height: 34,
//               decoration: BoxDecoration(
//                   color: SavColors.border,
//                   borderRadius: BorderRadius.circular(8)),
//             ),
//             const SizedBox(height: SavSpace.x10),
//             Text(l.pkReadyBody,
//                 textAlign: TextAlign.center,
//                 style: const TextStyle(
//                     fontFamily: SavFonts.sans,
//                     fontSize: 12.5,
//                     fontWeight: FontWeight.w500,
//                     color: SavColors.txt3)),
//           ],
//         ),
//       );
//     }
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: [
//         Container(
//           padding: const EdgeInsets.all(SavSpace.x20),
//           decoration: BoxDecoration(
//               color: SavColors.navy, borderRadius: SavRadius.cardLg),
//           child: Column(
//             children: [
//               Text(l.pickupCodeLabel.toUpperCase(),
//                   style: const TextStyle(
//                       fontFamily: SavFonts.sans,
//                       fontSize: 11,
//                       fontWeight: FontWeight.w700,
//                       letterSpacing: 1.0,
//                       color: Color(0xAAFFFFFF))),
//               const SizedBox(height: SavSpace.x8),
//               Text(r.pickupCode!,
//                   style: const TextStyle(
//                       fontFamily: SavFonts.serif,
//                       fontSize: 32,
//                       letterSpacing: 2,
//                       color: Colors.white)),
//               const SizedBox(height: SavSpace.x6),
//               Text(l.pkCodeSub,
//                   style: const TextStyle(
//                       fontFamily: SavFonts.sans,
//                       fontSize: 12,
//                       fontWeight: FontWeight.w500,
//                       color: Color(0xAAFFFFFF))),
//             ],
//           ),
//         ),
//         const SizedBox(height: SavSpace.x10),
//         SavButton(
//             label: l.pkShowQr,
//             variant: SavButtonVariant.secondary,
//             icon: Icons.qr_code_2,
//             onPressed: () => _showQr(context, l, r)),
//         const SizedBox(height: SavSpace.x12),
//         SavNotice(
//             message: l.pkWarn,
//             tone: NoticeTone.amber,
//             icon: Icons.info_outline),
//       ],
//     );
//   }
//
//   void _showQr(BuildContext context, AppLocalizations l, MemberRequest r) {
//     showModalBottomSheet<void>(
//       context: context,
//       backgroundColor: SavColors.surface,
//       shape: const RoundedRectangleBorder(borderRadius: SavRadius.sheet),
//       builder: (ctx) => Padding(
//         padding: const EdgeInsets.fromLTRB(
//             SavSpace.x24, SavSpace.x24, SavSpace.x24, SavSpace.x24),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Text(l.pkQrLabel,
//                 style: const TextStyle(
//                     fontFamily: SavFonts.serif,
//                     fontSize: 18,
//                     color: SavColors.navy)),
//             const SizedBox(height: SavSpace.x16),
//             // Backend-issued QR renders here in production; the frontend never
//             // generates the code/QR itself.
//             Container(
//               width: 200,
//               height: 200,
//               decoration: BoxDecoration(
//                   color: SavColors.page,
//                   borderRadius: SavRadius.card,
//                   border: Border.all(color: SavColors.border, width: 1.5)),
//               child: const Icon(Icons.qr_code_2, size: 120, color: SavColors.navy),
//             ),
//             const SizedBox(height: SavSpace.x16),
//             Text(r.pickupCode!,
//                 style: const TextStyle(
//                     fontFamily: SavFonts.serif,
//                     fontSize: 24,
//                     letterSpacing: 2,
//                     color: SavColors.navy)),
//             const SizedBox(height: SavSpace.x4),
//             Text(l.pkCodeSub,
//                 style: const TextStyle(
//                     fontFamily: SavFonts.sans,
//                     fontSize: 12.5,
//                     fontWeight: FontWeight.w500,
//                     color: SavColors.txt3)),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _row(String label, String value) => Padding(
//         padding: const EdgeInsets.symmetric(vertical: SavSpace.x6),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(
//                 width: 96,
//                 child: Text(label,
//                     style: const TextStyle(
//                         fontFamily: SavFonts.sans,
//                         fontSize: 12.5,
//                         fontWeight: FontWeight.w600,
//                         color: SavColors.txt3))),
//             Expanded(
//                 child: Text(value,
//                     style: const TextStyle(
//                         fontFamily: SavFonts.sans,
//                         fontSize: 12.5,
//                         fontWeight: FontWeight.w600,
//                         color: SavColors.txt))),
//           ],
//         ),
//       );
// }
