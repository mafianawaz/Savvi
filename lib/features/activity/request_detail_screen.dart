import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/state/providers.dart';
import '../../core/theme/tokens.dart';
import '../../data/models/enums.dart';
import '../../data/models/labels.dart';
import '../../data/models/member_request.dart';
import '../../data/models/request_status.dart';
import '../../l10n/app_localizations.dart';
import '../../shared/patterns/error_text.dart';
import '../../shared/patterns/feedback.dart';
import '../../shared/patterns/state_views.dart';
import '../../shared/widgets/sav_button.dart';
import '../../shared/widgets/sav_cards.dart';
import '../../shared/widgets/sav_inputs.dart';
import '../home/requests_controller.dart';


const _canEdit = <RequestStatus>{
  RequestStatus.submitted,
  RequestStatus.needsUpdate,
};
const _canCancel = <RequestStatus>{
  RequestStatus.submitted,
  RequestStatus.needsUpdate,
  RequestStatus.approved,
  RequestStatus.scheduled,
  RequestStatus.preparing,
  RequestStatus.readyPickup,
};
const _trackDelivery = <RequestStatus>{
  RequestStatus.scheduled,
  RequestStatus.preparing,
  RequestStatus.outForDelivery,
  RequestStatus.nearby,
  RequestStatus.delivered,
  RequestStatus.delayed,
  RequestStatus.unavailable,
};
const _viewPickup = <RequestStatus>{
  RequestStatus.approved,
  RequestStatus.preparing,
  RequestStatus.readyPickup,
  RequestStatus.pickupConfirmed,
  RequestStatus.completed,
  RequestStatus.missed,
};

/// Request detail: status, facts, categories/dietary/allergens/notes, a
/// per-method progress timeline, and edit/cancel actions.
// class RequestDetailScreen extends ConsumerWidget {
//   const RequestDetailScreen({super.key, required this.requestId});
//   final String requestId;
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final l = AppLocalizations.of(context);
//     final async = ref.watch(requestDetailProvider(requestId));
//
//     return Scaffold(
//       backgroundColor: SavColors.page,
//       appBar: AppBar(
//         backgroundColor: SavColors.surface,
//         elevation: 0,
//         scrolledUnderElevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: SavColors.navy),
//           onPressed: () => context.pop(),
//         ),
//         title: Text(requestId,
//             style: const TextStyle(
//                 fontFamily: SavFonts.sans,
//                 fontSize: 15,
//                 fontWeight: FontWeight.w700,
//                 color: SavColors.navy)),
//         centerTitle: true,
//       ),
//       body: async.when(
//         loading: () => StateViews.loading(),
//         error: (_, __) => StateViews.empty(
//             title: l.notFoundTitle,
//             message: l.actEmptyBody,
//             icon: Icons.search_off),
//         data: (r) => _body(context, ref, l, r),
//       ),
//     );
//   }
//
//   Widget _body(
//       BuildContext context, WidgetRef ref, AppLocalizations l, MemberRequest r) {
//     final fmt = ref.watch(formatterProvider);
//     return ListView(
//       padding: const EdgeInsets.fromLTRB(
//           SavSpace.x16, SavSpace.x16, SavSpace.x16, SavSpace.x24),
//       children: [
//         Padding(
//           padding: const EdgeInsets.only(bottom: SavSpace.x12),
//           child: Text(
//               '${Labels.method(l, r.method)} · ${fmt.timestamp(r.createdAt)}',
//               style: const TextStyle(
//                   fontFamily: SavFonts.sans,
//                   fontSize: 12.5,
//                   fontWeight: FontWeight.w600,
//                   color: SavColors.txt3)),
//         ),
//         // ── Facts card ──
//         SavCard(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(l.statusLabel.toUpperCase(),
//                       style: const TextStyle(
//                           fontFamily: SavFonts.sans,
//                           fontSize: 11,
//                           fontWeight: FontWeight.w700,
//                           letterSpacing: 0.5,
//                           color: SavColors.txt4)),
//                   StatusPill(status: r.status, label: Labels.status(l, r.status)),
//                 ],
//               ),
//               const SizedBox(height: SavSpace.x14),
//               Wrap(
//                 spacing: SavSpace.x24,
//                 runSpacing: SavSpace.x12,
//                 children: [
//                   _fact(l.rvMethod, Labels.method(l, r.method)),
//                   _fact(l.rvHousehold, r.household),
//                   if (r.weightLb != null)
//                     _fact(l.weightLabel, fmt.weight(lbs: r.weightLb)),
//                   if (r.pickupCode != null)
//                     _fact(l.pickupCodeLabel, r.pickupCode!),
//                 ],
//               ),
//               const Divider(height: SavSpace.x24, color: SavColors.border),
//               _row(l.rvCats,
//                   r.categories.map((c) => Labels.category(l, c)).join(', ')),
//               _row(
//                   l.rvDiet,
//                   r.diet.isEmpty
//                       ? l.rvNone
//                       : r.diet.map((d) => Labels.diet(l, d)).join(', ')),
//               _row(
//                   l.rvAlg,
//                   r.allergens.isEmpty
//                       ? l.rvNone
//                       : r.allergens
//                           .map((a) => Labels.allergen(l, a))
//                           .join(', ')),
//               if (r.notes != null) _row(l.rvNotes, r.notes!),
//             ],
//           ),
//         ),
//         if (r.categories.contains(FoodCategory.infantFormula))
//           Padding(
//             padding: const EdgeInsets.only(top: SavSpace.x12),
//             child: SavNotice(
//                 message: l.formulaNote,
//                 tone: NoticeTone.amber,
//                 icon: Icons.lock_outline,
//                 title: l.catInfantFormula),
//           ),
//         const SizedBox(height: SavSpace.x12),
//         // ── Timeline card ──
//         SavCard(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(l.statusLabel,
//                   style: const TextStyle(
//                       fontFamily: SavFonts.serif,
//                       fontSize: 16,
//                       color: SavColors.navy)),
//               const SizedBox(height: SavSpace.x12),
//               _Timeline(request: r, l: l),
//             ],
//           ),
//         ),
//         const SizedBox(height: SavSpace.x16),
//         _actions(context, ref, l, r),
//       ],
//     );
//   }
//
//   Widget _actions(
//       BuildContext context, WidgetRef ref, AppLocalizations l, MemberRequest r) {
//     final showTrack =
//         r.method == RequestMethod.delivery && _trackDelivery.contains(r.status);
//     final showPickup =
//         r.method == RequestMethod.pickup && _viewPickup.contains(r.status);
//     final canEdit = _canEdit.contains(r.status);
//     final canCancel = _canCancel.contains(r.status);
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: [
//         if (showTrack)
//           SavButton(
//             label: l.trackDelivery,
//             icon: Icons.local_shipping_outlined,
//             onPressed: () => context.push('/delivery/${r.id}'),
//           )
//         else if (showPickup)
//           SavButton(
//             label: l.viewPickup,
//             icon: Icons.qr_code_2,
//             onPressed: () => context.push('/pickup/${r.id}'),
//           ),
//         if (showTrack || showPickup) const SizedBox(height: SavSpace.x10),
//         Row(
//           children: [
//             Expanded(
//               child: SavButton(
//                 label: l.editRequest,
//                 variant: SavButtonVariant.ghost,
//                 onPressed: canEdit
//                     ? () => context.push('/request-edit/${r.id}')
//                     : null,
//               ),
//             ),
//             const SizedBox(width: SavSpace.x10),
//             Expanded(
//               child: SavButton(
//                 label: l.cancelRequest,
//                 variant:
//                     canCancel ? SavButtonVariant.danger : SavButtonVariant.ghost,
//                 onPressed:
//                     canCancel ? () => _confirmCancel(context, ref, l, r) : null,
//               ),
//             ),
//           ],
//         ),
//         if (!canEdit)
//           Padding(
//             padding: const EdgeInsets.only(top: SavSpace.x10),
//             child: Text(l.editLocked,
//                 textAlign: TextAlign.center,
//                 style: const TextStyle(
//                     fontFamily: SavFonts.sans,
//                     fontSize: 11.5,
//                     height: 1.45,
//                     fontWeight: FontWeight.w500,
//                     color: SavColors.txt4)),
//           ),
//       ],
//     );
//   }
//
//   Future<void> _confirmCancel(BuildContext context, WidgetRef ref,
//       AppLocalizations l, MemberRequest r) async {
//     final confirmed = await showDialog<bool>(
//       context: context,
//       builder: (ctx) => AlertDialog(
//         backgroundColor: SavColors.surface,
//         title: Text(l.cancelConfirmTitle,
//             style: const TextStyle(
//                 fontFamily: SavFonts.serif,
//                 fontSize: 18,
//                 color: SavColors.navy)),
//         content: Text(l.cancelConfirmBody,
//             style: const TextStyle(
//                 fontFamily: SavFonts.sans,
//                 fontSize: 13.5,
//                 height: 1.45,
//                 color: SavColors.txt2)),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(ctx, false),
//             child: Text(l.keepRequest,
//                 style: const TextStyle(
//                     fontFamily: SavFonts.sans,
//                     fontWeight: FontWeight.w700,
//                     color: SavColors.navy)),
//           ),
//           TextButton(
//             onPressed: () => Navigator.pop(ctx, true),
//             child: Text(l.cancelRequest,
//                 style: const TextStyle(
//                     fontFamily: SavFonts.sans,
//                     fontWeight: FontWeight.w700,
//                     color: SavColors.red)),
//           ),
//         ],
//       ),
//     );
//     if (confirmed != true) return;
//     final res = await ref.read(savviApiProvider).cancelRequest(r.id);
//     if (!context.mounted) return;
//     res.when(
//       ok: (_) {
//         ref.invalidate(requestsProvider);
//         ref.invalidate(requestDetailProvider(r.id));
//         SavFeedback.toast(context, l.requestCancelled, tone: FeedbackTone.info);
//         context.pop();
//       },
//       err: (f) => SavFeedback.toast(context, errText(l, f.messageKey),
//           tone: FeedbackTone.error),
//     );
//   }
//
//   Widget _fact(String label, String value) => Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Text(label,
//               style: const TextStyle(
//                   fontFamily: SavFonts.sans,
//                   fontSize: 11,
//                   fontWeight: FontWeight.w600,
//                   color: SavColors.txt3)),
//           const SizedBox(height: 2),
//           Text(value,
//               style: const TextStyle(
//                   fontFamily: SavFonts.sans,
//                   fontSize: 14,
//                   fontWeight: FontWeight.w700,
//                   color: SavColors.navy)),
//         ],
//       );
//
//   Widget _row(String label, String value) => Padding(
//         padding: const EdgeInsets.only(top: SavSpace.x10),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(
//               width: 88,
//               child: Text(label,
//                   style: const TextStyle(
//                       fontFamily: SavFonts.sans,
//                       fontSize: 12.5,
//                       fontWeight: FontWeight.w600,
//                       color: SavColors.txt3)),
//             ),
//             Expanded(
//               child: Text(value,
//                   style: const TextStyle(
//                       fontFamily: SavFonts.sans,
//                       fontSize: 12.5,
//                       height: 1.4,
//                       fontWeight: FontWeight.w600,
//                       color: SavColors.txt)),
//             ),
//           ],
//         ),
//       );
// }

/// Per-method progress timeline. Step state is derived from the current
/// status's position in the flow (the backend history will drive per-step
/// timestamps in a later stage). Off-timeline statuses render as a warn node.
class _Timeline extends StatelessWidget {
  const _Timeline({required this.request, required this.l});
  final MemberRequest request;
  final AppLocalizations l;

  @override
  Widget build(BuildContext context) {
    final flow = StatusFlow.forMethod(request.method);
    final off = StatusFlow.isOffTimeline(request.status);
    final currentIdx = flow.indexOf(request.status);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i = 0; i < flow.length; i++)
          _step(
            label: Labels.status(l, flow[i]),
            state: off
                ? (i == 0 ? _StepState.done : _StepState.upcoming)
                : (i < currentIdx
                    ? _StepState.done
                    : i == currentIdx
                        ? _StepState.active
                        : _StepState.upcoming),
            isLast: i == flow.length - 1 && !off,
          ),
        if (off)
          _step(
            label: Labels.status(l, request.status),
            state: _StepState.warn,
            isLast: true,
          ),
      ],
    );
  }

  Widget _step(
      {required String label,
      required _StepState state,
      required bool isLast}) {
    final (dot, txt) = switch (state) {
      _StepState.done => (SavColors.green, SavColors.txt2),
      _StepState.active => (SavColors.navy, SavColors.navy),
      _StepState.warn => (SavColors.red, SavColors.pillRedFg),
      _StepState.upcoming => (SavColors.border, SavColors.txt4),
    };
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 12,
                height: 12,
                margin: const EdgeInsets.only(top: 2),
                decoration: BoxDecoration(
                  color: state == _StepState.upcoming ? SavColors.surface : dot,
                  shape: BoxShape.circle,
                  border: Border.all(color: dot, width: 2),
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(width: 2, color: SavColors.border),
                ),
            ],
          ),
          const SizedBox(width: SavSpace.x12),
          Padding(
            padding: EdgeInsets.only(bottom: isLast ? 0 : SavSpace.x14),
            child: Text(label,
                style: TextStyle(
                    fontFamily: SavFonts.sans,
                    fontSize: 13.5,
                    fontWeight: state == _StepState.active ||
                            state == _StepState.warn
                        ? FontWeight.w700
                        : FontWeight.w600,
                    color: txt)),
          ),
        ],
      ),
    );
  }
}

enum _StepState { done, active, upcoming, warn }
