import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/state/providers.dart';
import '../../core/theme/tokens.dart';
import '../../data/models/member_request.dart';
import '../../l10n/app_localizations.dart';
import '../../shared/patterns/error_text.dart';
import '../../shared/patterns/feedback.dart';
import '../../shared/patterns/state_views.dart';
import '../auth/auth_controller.dart';
import 'alerts_controller.dart';

/// Maps an [ApiFailure] messageKey to localized text for RSVP error toasts.

/// Food Access Alerts (v45 fidelity): hot meals and distributions nearby, each
/// with an editable RSVP. The stepper starts at 0 and the member must select at
/// least 1 before confirming; the count is capped at min(household, remaining).
/// The backend validates the final count — the frontend is guidance only.
// class AlertsScreen extends ConsumerWidget {
//   const AlertsScreen({super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final l = AppLocalizations.of(context);
//     final async = ref.watch(alertsControllerProvider);
//     final auth = ref.watch(authControllerProvider);
//     final household = switch (auth) {
//       AuthSignedIn(:final profile) =>
//         int.tryParse(((profile['household'] as String?) ?? '1')
//                 .replaceAll('+', '')) ??
//             1,
//       _ => 1,
//     };
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: const EdgeInsets.fromLTRB(
//               SavSpace.x16, SavSpace.x14, SavSpace.x16, SavSpace.x4),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(l.alertsTitle,
//                   style: const TextStyle(
//                       fontFamily: SavFonts.serif,
//                       fontSize: 21,
//                       color: SavColors.navy)),
//               const SizedBox(height: 2),
//               Text(l.alertsSubtitle,
//                   style: const TextStyle(
//                       fontFamily: SavFonts.sans,
//                       fontSize: 13,
//                       fontWeight: FontWeight.w500,
//                       color: SavColors.txt3)),
//             ],
//           ),
//         ),
//         Expanded(
//           child: async.when(
//             loading: () => StateViews.loading(),
//             error: (_, __) => StateViews.error(
//               title: l.errUnknown,
//               retryLabel: l.tryAgain,
//               onRetry: () =>
//                   ref.read(alertsControllerProvider.notifier).load(),
//             ),
//             data: (alerts) => alerts.isEmpty
//                 ? StateViews.empty(
//                     title: l.alertsEmpty,
//                     message: l.alertsEmptyBody,
//                     icon: Icons.notifications_none)
//                 : RefreshIndicator(
//                     onRefresh: () =>
//                         ref.read(alertsControllerProvider.notifier).refresh(),
//                     child: ListView.separated(
//                       padding: const EdgeInsets.fromLTRB(SavSpace.x16,
//                           SavSpace.x12, SavSpace.x16, SavSpace.x24),
//                       itemCount: alerts.length,
//                       separatorBuilder: (_, __) =>
//                           const SizedBox(height: SavSpace.x12),
//                       itemBuilder: (_, i) =>
//                           _AlertCard(alert: alerts[i], household: household),
//                     ),
//                   ),
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// class _AlertCard extends ConsumerStatefulWidget {
//   const _AlertCard({required this.alert, required this.household});
//   final FoodAlert alert;
//   final int household;
//
//   @override
//   ConsumerState<_AlertCard> createState() => _AlertCardState();
// }
//
// class _AlertCardState extends ConsumerState<_AlertCard> {
//   int _count = 0; // starts at 0 — member must actively select
//   bool _editing = false;
//
//   bool get _confirmed => widget.alert.rsvp > 0;
//   int get _max =>
//       widget.household < widget.alert.left ? widget.household : widget.alert.left;
//
//   @override
//   Widget build(BuildContext context) {
//     final l = AppLocalizations.of(context);
//     final fmt = ref.watch(formatterProvider);
//     final a = widget.alert;
//     final isHot = a.type == AlertType.hot;
//     final accent = isHot ? SavColors.amber : SavColors.greenDark;
//     final accentBg = isHot ? SavColors.amberLight : SavColors.greenLight;
//
//     return Container(
//       decoration: BoxDecoration(
//         color: SavColors.surface,
//         borderRadius: SavRadius.card,
//         border: Border.all(color: SavColors.border, width: 1.5),
//       ),
//       padding: const EdgeInsets.all(SavSpace.x16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Container(
//                 padding: const EdgeInsets.symmetric(
//                     horizontal: SavSpace.x10, vertical: 4),
//                 decoration: BoxDecoration(
//                     color: accentBg, borderRadius: SavRadius.pill),
//                 child: Text(isHot ? l.alertTypeHot : l.alertTypeDist,
//                     style: TextStyle(
//                         fontFamily: SavFonts.sans,
//                         fontSize: 10.5,
//                         fontWeight: FontWeight.w700,
//                         letterSpacing: 0.3,
//                         color: accent)),
//               ),
//               const Spacer(),
//               Text(l.alertSpotsLeft(a.left),
//                   style: const TextStyle(
//                       fontFamily: SavFonts.sans,
//                       fontSize: 11.5,
//                       fontWeight: FontWeight.w600,
//                       color: SavColors.txt3)),
//             ],
//           ),
//           const SizedBox(height: SavSpace.x10),
//           Text(a.title,
//               style: const TextStyle(
//                   fontFamily: SavFonts.serif,
//                   fontSize: 17,
//                   color: SavColors.navy)),
//           const SizedBox(height: SavSpace.x4),
//           Text(a.host,
//               style: const TextStyle(
//                   fontFamily: SavFonts.sans,
//                   fontSize: 12.5,
//                   fontWeight: FontWeight.w600,
//                   color: SavColors.txt2)),
//           const SizedBox(height: SavSpace.x10),
//           _metaRow(Icons.schedule, fmt.window(a.windowStart, a.windowEnd)),
//           const SizedBox(height: SavSpace.x6),
//           _metaRow(Icons.place_outlined, a.where),
//           const SizedBox(height: SavSpace.x14),
//           if (!_confirmed || _editing) _rsvpRow(l, a) else _confirmedRow(l),
//         ],
//       ),
//     );
//   }
//
//   Widget _metaRow(IconData icon, String text) {
//     return Row(
//       children: [
//         Icon(icon, size: 14, color: SavColors.txt3),
//         const SizedBox(width: SavSpace.x6),
//         Expanded(
//           child: Text(text,
//               style: const TextStyle(
//                   fontFamily: SavFonts.sans,
//                   fontSize: 12.5,
//                   fontWeight: FontWeight.w500,
//                   color: SavColors.txt2)),
//         ),
//       ],
//     );
//   }
//
//   Widget _rsvpRow(AppLocalizations l, FoodAlert a) {
//     final canConfirm = _count >= 1;
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(l.alertRsvpPrompt,
//             style: const TextStyle(
//                 fontFamily: SavFonts.sans,
//                 fontSize: 12.5,
//                 fontWeight: FontWeight.w700,
//                 color: SavColors.txt2)),
//         const SizedBox(height: 2),
//         Text(l.alertRsvpMax(widget.household),
//             style: const TextStyle(
//                 fontFamily: SavFonts.sans,
//                 fontSize: 11,
//                 fontWeight: FontWeight.w500,
//                 color: SavColors.txt3)),
//         const SizedBox(height: SavSpace.x8),
//         Row(
//           children: [
//             _stepBtn(Icons.remove, _count > 0, () => setState(() => _count--)),
//             SizedBox(
//               width: 48,
//               child: Text('$_count',
//                   textAlign: TextAlign.center,
//                   style: const TextStyle(
//                       fontFamily: SavFonts.sans,
//                       fontSize: 16,
//                       fontWeight: FontWeight.w700,
//                       color: SavColors.navy)),
//             ),
//             _stepBtn(Icons.add, _count < _max, () => setState(() => _count++)),
//             const SizedBox(width: SavSpace.x12),
//             Expanded(
//               child: SizedBox(
//                 height: 44,
//                 child: FilledButton(
//                   style: FilledButton.styleFrom(
//                       backgroundColor: SavColors.navy,
//                       disabledBackgroundColor: SavColors.border,
//                       shape: RoundedRectangleBorder(
//                           borderRadius: SavRadius.field)),
//                   onPressed: canConfirm
//                       ? () async {
//                           final err = await ref
//                               .read(alertsControllerProvider.notifier)
//                               .rsvp(a.id, _count);
//                           if (!mounted) return;
//                           if (err == null) {
//                             setState(() => _editing = false);
//                             if (context.mounted) {
//                               SavFeedback.toast(
//                                   context, l.alertRsvpConfirmed(_count),
//                                   tone: FeedbackTone.success);
//                             }
//                           } else if (context.mounted) {
//                             SavFeedback.toast(context, errText(l, err),
//                                 tone: FeedbackTone.error);
//                           }
//                         }
//                       : null,
//                   child: Text(l.alertRsvpConfirm,
//                       style: const TextStyle(
//                           fontFamily: SavFonts.sans,
//                           fontSize: 13.5,
//                           fontWeight: FontWeight.w700)),
//                 ),
//               ),
//             ),
//           ],
//         ),
//         if (!canConfirm)
//           Padding(
//             padding: const EdgeInsets.only(top: SavSpace.x8),
//             child: Text(l.alertRsvpSelectFirst,
//                 style: const TextStyle(
//                     fontFamily: SavFonts.sans,
//                     fontSize: 11.5,
//                     fontWeight: FontWeight.w600,
//                     color: SavColors.pillAmberFg)),
//           ),
//       ],
//     );
//   }
//
//   Widget _confirmedRow(AppLocalizations l) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: [
//         Container(
//           padding: const EdgeInsets.all(SavSpace.x12),
//           decoration: BoxDecoration(
//               color: SavColors.greenLight,
//               borderRadius: SavRadius.field,
//               border: Border.all(color: const Color(0xFFA7D7A8))),
//           child: Row(
//             children: [
//               const Icon(Icons.check_circle,
//                   size: 18, color: SavColors.greenDark),
//               const SizedBox(width: SavSpace.x8),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(l.alertRsvpConfirmed(widget.alert.rsvp),
//                         style: const TextStyle(
//                             fontFamily: SavFonts.sans,
//                             fontSize: 12.5,
//                             fontWeight: FontWeight.w700,
//                             color: SavColors.pillGreenFg)),
//                     Text(l.alertRsvpSeeYou,
//                         style: const TextStyle(
//                             fontFamily: SavFonts.sans,
//                             fontSize: 11.5,
//                             fontWeight: FontWeight.w500,
//                             color: SavColors.pillGreenFg)),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//         const SizedBox(height: SavSpace.x8),
//         Row(
//           children: [
//             Expanded(
//               child: SizedBox(
//                 height: 44,
//                 child: OutlinedButton(
//                   style: OutlinedButton.styleFrom(
//                       foregroundColor: SavColors.navy,
//                       side: const BorderSide(
//                           color: SavColors.border, width: 1.5),
//                       shape: RoundedRectangleBorder(
//                           borderRadius: SavRadius.field)),
//                   onPressed: () => setState(() {
//                     _count = widget.alert.rsvp;
//                     _editing = true;
//                   }),
//                   child: Text(l.alertRsvpChange,
//                       style: const TextStyle(
//                           fontFamily: SavFonts.sans,
//                           fontSize: 13,
//                           fontWeight: FontWeight.w700)),
//                 ),
//               ),
//             ),
//             const SizedBox(width: SavSpace.x10),
//             Expanded(
//               child: SizedBox(
//                 height: 44,
//                 child: TextButton(
//                   style: TextButton.styleFrom(
//                       foregroundColor: SavColors.red,
//                       shape: RoundedRectangleBorder(
//                           borderRadius: SavRadius.field)),
//                   onPressed: () async {
//                     final err = await ref
//                         .read(alertsControllerProvider.notifier)
//                         .cancel(widget.alert.id);
//                     if (!mounted) return;
//                     if (err == null) {
//                       setState(() => _count = 0);
//                       if (context.mounted) {
//                         SavFeedback.toast(context, l.alertRsvpCancelled,
//                             tone: FeedbackTone.info);
//                       }
//                     } else if (context.mounted) {
//                       SavFeedback.toast(context, errText(l, err),
//                           tone: FeedbackTone.error);
//                     }
//                   },
//                   child: Text(l.alertRsvpCancel,
//                       style: const TextStyle(
//                           fontFamily: SavFonts.sans,
//                           fontSize: 13,
//                           fontWeight: FontWeight.w700)),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
//
//   Widget _stepBtn(IconData icon, bool enabled, VoidCallback onTap) {
//     return SizedBox(
//       width: 44,
//       height: 44,
//       child: IconButton(
//         onPressed: enabled ? onTap : null,
//         icon: Icon(icon, size: 20),
//         style: IconButton.styleFrom(
//           backgroundColor: SavColors.page,
//           foregroundColor: SavColors.navy,
//           disabledForegroundColor: SavColors.txt4,
//           shape: RoundedRectangleBorder(
//               borderRadius: SavRadius.field,
//               side: const BorderSide(color: SavColors.border, width: 1.5)),
//         ),
//       ),
//     );
//   }
// }
