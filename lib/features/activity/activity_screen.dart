import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/tokens.dart';
import '../../data/models/member_request.dart';
import '../../l10n/app_localizations.dart';
import '../../shared/patterns/state_views.dart';
import '../../shared/widgets/sav_button.dart';
import '../home/request_card.dart';
import '../home/requests_controller.dart';

enum _ActTab { active, history, all }

/// My Requests: a tabbed list (Active / History / All) of the member's
/// requests. Tabs filter by status group, not label strings.
// class ActivityScreen extends ConsumerStatefulWidget {
//   const ActivityScreen({super.key});
//
//   @override
//   ConsumerState<ActivityScreen> createState() => _ActivityScreenState();
// }
//
// class _ActivityScreenState extends ConsumerState<ActivityScreen> {
//   _ActTab _tab = _ActTab.active;
//
//   List<MemberRequest> _filter(List<MemberRequest> all) => switch (_tab) {
//         _ActTab.active => all.where((r) => r.isActive).toList(),
//         _ActTab.history => all.where((r) => !r.isActive).toList(),
//         _ActTab.all => all,
//       };
//
//   @override
//   Widget build(BuildContext context) {
//     final l = AppLocalizations.of(context);
//     final async = ref.watch(requestsProvider);
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
//               Text(l.actTitle,
//                   style: const TextStyle(
//                       fontFamily: SavFonts.serif,
//                       fontSize: 21,
//                       color: SavColors.navy)),
//               const SizedBox(height: 2),
//               Text(l.actSub,
//                   style: const TextStyle(
//                       fontFamily: SavFonts.sans,
//                       fontSize: 13,
//                       fontWeight: FontWeight.w500,
//                       color: SavColors.txt3)),
//             ],
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.fromLTRB(
//               SavSpace.x16, SavSpace.x10, SavSpace.x16, SavSpace.x4),
//           child: Row(
//             children: [
//               _tabBtn(l.tabActive, _ActTab.active),
//               const SizedBox(width: SavSpace.x8),
//               _tabBtn(l.tabHistory, _ActTab.history),
//               const SizedBox(width: SavSpace.x8),
//               _tabBtn(l.tabAll, _ActTab.all),
//             ],
//           ),
//         ),
//         Expanded(
//           child: async.when(
//             loading: () => StateViews.loading(),
//             error: (_, __) => StateViews.error(
//               title: l.stateErrorTitle,
//               message: l.errUnknown,
//               retryLabel: l.tryAgain,
//               onRetry: () => ref.invalidate(requestsProvider),
//             ),
//             data: (all) {
//               final list = _filter(all);
//               if (list.isEmpty) {
//                 return StateViews.empty(
//                   title: l.actEmptyTitle,
//                   message: l.actEmptyBody,
//                   icon: Icons.receipt_long_outlined,
//                   action: SavButton(
//                     label: l.homeCtaTitle,
//                     expand: false,
//                     onPressed: () => context.push('/request'),
//                   ),
//                 );
//               }
//               return RefreshIndicator(
//                 onRefresh: () => ref.refresh(requestsProvider.future),
//                 child: ListView.separated(
//                   padding: const EdgeInsets.fromLTRB(
//                       SavSpace.x16, SavSpace.x10, SavSpace.x16, SavSpace.x24),
//                   itemCount: list.length,
//                   separatorBuilder: (_, __) =>
//                       const SizedBox(height: SavSpace.x12),
//                   itemBuilder: (_, i) => RequestCard(
//                     request: list[i],
//                     onTap: () => context.push('/request/${list[i].id}'),
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _tabBtn(String label, _ActTab tab) {
//     final on = _tab == tab;
//     return Expanded(
//       child: Semantics(
//         button: true,
//         selected: on,
//         label: label,
//         excludeSemantics: true,
//         child: InkWell(
//           onTap: () => setState(() => _tab = tab),
//           borderRadius: SavRadius.field,
//           child: Container(
//             height: 38,
//             alignment: Alignment.center,
//             decoration: BoxDecoration(
//               color: on ? SavColors.navy : SavColors.surface,
//               borderRadius: SavRadius.field,
//               border: Border.all(
//                   color: on ? SavColors.navy : SavColors.border, width: 1.5),
//             ),
//             child: Text(label,
//                 style: TextStyle(
//                     fontFamily: SavFonts.sans,
//                     fontSize: 13,
//                     fontWeight: FontWeight.w700,
//                     color: on ? Colors.white : SavColors.txt2)),
//           ),
//         ),
//       ),
//     );
//   }
// }
