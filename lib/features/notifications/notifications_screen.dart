import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../core/formatting/formatters.dart';
import '../../core/routing/app_router.dart';
import '../../core/state/providers.dart';
import '../../core/theme/tokens.dart';
import '../../data/models/labels.dart';
import '../../data/models/notification.dart';
import '../../l10n/app_localizations.dart';
import '../../shared/patterns/feedback.dart';
import '../../shared/patterns/error_text.dart';
import '../../shared/patterns/state_views.dart';
import '../../shared/widgets/sav_button.dart';
import '../../shared/widgets/sav_cards.dart';
import 'notifications_controller.dart';

/// The member's notification center: request updates and Food Access Alerts.
// class NotificationsScreen extends ConsumerWidget {
//   const NotificationsScreen({super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final l = AppLocalizations.of(context);
//     final st = ref.watch(notificationsControllerProvider);
//     final ctrl = ref.read(notificationsControllerProvider.notifier);
//
//     return Scaffold(
//       backgroundColor: SavColors.page,
//       appBar: AppBar(
//         backgroundColor: SavColors.surface,
//         elevation: 0,
//         scrolledUnderElevation: 0,
//         leading: IconButton(
//             icon: const Icon(Icons.arrow_back, color: SavColors.navy),
//             onPressed: () => context.pop()),
//         title: Text(l.notifTitle,
//             style: const TextStyle(
//                 fontFamily: SavFonts.serif, fontSize: 18, color: SavColors.navy)),
//         centerTitle: true,
//       ),
//       body: st.items.when(
//         loading: () => StateViews.loading(),
//         error: (_, __) => StateViews.error(
//             title: l.stateErrorTitle,
//             message: l.errUnknown,
//             retryLabel: l.tryAgain,
//             onRetry: ctrl.load),
//         data: (items) => _body(context, ref, l, ctrl, items, st.mutating),
//       ),
//     );
//   }
//
//   Widget _body(BuildContext context, WidgetRef ref, AppLocalizations l,
//       NotificationsController ctrl, List<MemberNotification> items, bool mutating) {
//     return ListView(
//       padding: const EdgeInsets.fromLTRB(
//           SavSpace.x16, SavSpace.x12, SavSpace.x16, SavSpace.x24),
//       children: [
//         Text(l.notifSub,
//             style: const TextStyle(
//                 fontFamily: SavFonts.sans,
//                 fontSize: 13,
//                 fontWeight: FontWeight.w500,
//                 color: SavColors.txt3)),
//         const SizedBox(height: SavSpace.x14),
//         if (items.isEmpty)
//           Padding(
//             padding: const EdgeInsets.only(top: SavSpace.x24),
//             child: StateViews.empty(
//                 title: l.notifEmptyTitle,
//                 message: l.notifEmptyBody,
//                 icon: Icons.notifications_none),
//           )
//         else ...[
//           Row(
//             children: [
//               Expanded(
//                 child: SavButton(
//                     label: l.markAllRead,
//                     variant: SavButtonVariant.ghost,
//                     busy: mutating,
//                     onPressed: () async {
//                       final r = await ctrl.markAll();
//                       if (context.mounted) {
//                         SavFeedback.toast(
//                             context,
//                             r.ok ? l.markedReadOk : errText(l, r.errorKey!),
//                             tone: r.ok
//                                 ? FeedbackTone.info
//                                 : FeedbackTone.error);
//                       }
//                     }),
//               ),
//               const SizedBox(width: SavSpace.x10),
//               Expanded(
//                 child: SavButton(
//                     label: l.clearAllNotifs,
//                     variant: SavButtonVariant.ghost,
//                     busy: mutating,
//                     onPressed: () => _confirmClear(context, l, ctrl)),
//               ),
//             ],
//           ),
//           const SizedBox(height: SavSpace.x12),
//           for (final n in items)
//             Padding(
//               padding: const EdgeInsets.only(bottom: SavSpace.x8),
//               child: _NotifCard(
//                 notification: n,
//                 onTap: () {
//                   ctrl.markRead(n.id);
//                   if (n.requestId != null) {
//                     context.push('/request/${n.requestId}');
//                   }
//                 },
//               ),
//             ),
//         ],
//         const SizedBox(height: SavSpace.x10),
//         _prefsLink(context, l),
//       ],
//     );
//   }
//
//   Widget _prefsLink(BuildContext context, AppLocalizations l) => Material(
//         color: SavColors.surface,
//         borderRadius: SavRadius.card,
//         child: InkWell(
//           onTap: () => context.push(Routes.notifPrefs),
//           borderRadius: SavRadius.card,
//           child: Container(
//             padding: const EdgeInsets.all(SavSpace.x16),
//             decoration: BoxDecoration(
//                 borderRadius: SavRadius.card,
//                 border: Border.all(color: SavColors.border, width: 1.5)),
//             child: Row(
//               children: [
//                 const Icon(Icons.tune, size: 18, color: SavColors.navy),
//                 const SizedBox(width: SavSpace.x12),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(l.prefsTitle,
//                           style: const TextStyle(
//                               fontFamily: SavFonts.sans,
//                               fontSize: 14,
//                               fontWeight: FontWeight.w700,
//                               color: SavColors.navy)),
//                       Text(l.prefsSub,
//                           style: const TextStyle(
//                               fontFamily: SavFonts.sans,
//                               fontSize: 12,
//                               fontWeight: FontWeight.w500,
//                               color: SavColors.txt3)),
//                     ],
//                   ),
//                 ),
//                 const Icon(Icons.chevron_right, color: SavColors.txt4),
//               ],
//             ),
//           ),
//         ),
//       );
//
//   Future<void> _confirmClear(
//       BuildContext context, AppLocalizations l, NotificationsController ctrl) async {
//     final ok = await showDialog<bool>(
//       context: context,
//       builder: (ctx) => AlertDialog(
//         backgroundColor: SavColors.surface,
//         title: Text(l.clearConfirmTitle,
//             style: const TextStyle(
//                 fontFamily: SavFonts.serif, fontSize: 18, color: SavColors.navy)),
//         content: Text(l.clearConfirmBody,
//             style: const TextStyle(
//                 fontFamily: SavFonts.sans, fontSize: 13.5, height: 1.45, color: SavColors.txt2)),
//         actions: [
//           TextButton(
//               onPressed: () => Navigator.pop(ctx, false),
//               child: Text(l.cancelAction,
//                   style: const TextStyle(
//                       fontFamily: SavFonts.sans,
//                       fontWeight: FontWeight.w700,
//                       color: SavColors.navy))),
//           TextButton(
//               onPressed: () => Navigator.pop(ctx, true),
//               child: Text(l.clearAllNotifs,
//                   style: const TextStyle(
//                       fontFamily: SavFonts.sans,
//                       fontWeight: FontWeight.w700,
//                       color: SavColors.red))),
//         ],
//       ),
//     );
//     if (ok == true) {
//       final r = await ctrl.clearAll();
//       if (context.mounted) {
//         SavFeedback.toast(context, r.ok ? l.clearedOk : errText(l, r.errorKey!),
//             tone: r.ok ? FeedbackTone.info : FeedbackTone.error);
//       }
//     }
//   }
// }
class NotificationsScreen extends StatelessWidget {
  NotificationsScreen({super.key});

  final NotificationsController logic = Get.find<NotificationsController>();

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: SavColors.page,
      appBar: AppBar(
        backgroundColor: SavColors.surface,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: SavColors.navy,
          ),
          onPressed: Get.back,
        ),
        title: Text(
          l.notifTitle,
          style: const TextStyle(
            fontFamily: SavFonts.serif,
            fontSize: 18,
            color: SavColors.navy,
          ),
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        if (logic.loading) {
          return StateViews.loading();
        }

        if (logic.notifications.isEmpty) {
          return ListView(
            padding: const EdgeInsets.all(SavSpace.x16),
            children: [
              Text(
                l.notifSub,
                style: const TextStyle(
                  fontFamily: SavFonts.sans,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: SavColors.txt3,
                ),
              ),
              const SizedBox(height: SavSpace.x24),
              StateViews.empty(
                title: l.notifEmptyTitle,
                message: l.notifEmptyBody,
                icon: Icons.notifications_none,
              ),
              const SizedBox(height: SavSpace.x20),
              _prefsLink(context),
            ],
          );
        }

        return RefreshIndicator(
          onRefresh: logic.refreshNotifications,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(
              SavSpace.x16,
              SavSpace.x12,
              SavSpace.x16,
              SavSpace.x24,
            ),
            children: [
              Text(
                l.notifSub,
                style: const TextStyle(
                  fontFamily: SavFonts.sans,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: SavColors.txt3,
                ),
              ),

              const SizedBox(height: SavSpace.x14),

              Row(
                children: [
                  Expanded(
                    child: SavButton(
                      label: l.markAllRead,
                      variant: SavButtonVariant.ghost,
                      busy: logic.mutating,
                      onPressed: () async {
                        final r = await logic.markAllRead();

                        if (!context.mounted) return;

                        SavFeedback.toast(
                          context,
                          r.ok
                              ? l.markedReadOk
                              : errText(l, r.errorKey!),
                          tone: r.ok
                              ? FeedbackTone.info
                              : FeedbackTone.error,
                        );
                      },
                    ),
                  ),

                  const SizedBox(width: SavSpace.x10),

                  Expanded(
                    child: SavButton(
                      label: l.clearAllNotifs,
                      variant: SavButtonVariant.ghost,
                      busy: logic.mutating,
                      onPressed: () => _confirmClear(context),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: SavSpace.x14),

              ...logic.notifications.map(
                    (n) => Padding(
                  padding:
                  const EdgeInsets.only(bottom: SavSpace.x8),
                  child: NotificationCard(
                    notification: n,
                  ),
                ),
              ),

              const SizedBox(height: SavSpace.x20),

              _prefsLink(context),
            ],
          ),
        );
      }),
    );
  }

  Widget _prefsLink(BuildContext context) {
    final l = AppLocalizations.of(context);

    return Material(
      color: SavColors.surface,
      borderRadius: SavRadius.card,
      child: InkWell(
        borderRadius: SavRadius.card,
        onTap: () => Get.toNamed(Routes.notifPrefs),
        child: Container(
          padding: const EdgeInsets.all(SavSpace.x16),
          decoration: BoxDecoration(
            borderRadius: SavRadius.card,
            border: Border.all(
              color: SavColors.border,
              width: 1.5,
            ),
          ),
          child: Row(
            children: [
              const Icon(
                Icons.tune,
                color: SavColors.navy,
              ),

              const SizedBox(width: SavSpace.x12),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Text(
                      l.prefsTitle,
                      style: const TextStyle(
                        fontFamily: SavFonts.sans,
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: SavColors.navy,
                      ),
                    ),
                    Text(
                      l.prefsSub,
                      style: const TextStyle(
                        fontFamily: SavFonts.sans,
                        fontSize: 12,
                        color: SavColors.txt3,
                      ),
                    ),
                  ],
                ),
              ),

              const Icon(
                Icons.chevron_right,
                color: SavColors.txt4,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _confirmClear(BuildContext context) async {
    final l = AppLocalizations.of(context);

    final ok = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(l.clearConfirmTitle),
        content: Text(l.clearConfirmBody),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: Text(l.cancelAction),
          ),
          TextButton(
            onPressed: () => Get.back(result: true),
            child: Text(
              l.clearAllNotifs,
              style: const TextStyle(
                color: SavColors.red,
              ),
            ),
          ),
        ],
      ),
    );

    if (ok != true) return;

    final result = await logic.clearAll();

    if (!context.mounted) return;

    SavFeedback.toast(
      context,
      result.ok
          ? l.clearedOk
          : errText(l, result.errorKey!),
      tone: result.ok
          ? FeedbackTone.info
          : FeedbackTone.error,
    );
  }
}
// class _NotifCard extends ConsumerWidget {
//   const _NotifCard({required this.notification, required this.onTap});
//   final MemberNotification notification;
//   final VoidCallback onTap;
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final l = AppLocalizations.of(context);
//     final fmt = ref.watch(formatterProvider);
//     final n = notification;
//
//     // Prefer backend copy; fall back to the status label for request updates.
//     final title = n.title ??
//         (n.status != null ? Labels.status(l, n.status!) : n.body ?? '');
//     final subtitle = n.title != null ? n.body : n.requestId;
//
//     final (icon, fg, tintBg) = switch (n.kind) {
//       NotificationKind.alert => (
//           Icons.restaurant_outlined,
//           SavColors.green,
//           const Color(0x1429E050)
//         ),
//       NotificationKind.request => (
//           Icons.receipt_long_outlined,
//           SavColors.navy,
//           const Color(0x1401284D)
//         ),
//       NotificationKind.general => (
//           Icons.notifications_none,
//           SavColors.navy,
//           const Color(0x1401284D)
//         ),
//     };
//
//     return Semantics(
//       button: true,
//       label: title,
//       excludeSemantics: true,
//       child: Material(
//         color: n.read ? SavColors.surface : const Color(0xFFF2F7FF),
//         borderRadius: SavRadius.card,
//         child: InkWell(
//           onTap: onTap,
//           borderRadius: SavRadius.card,
//           child: Container(
//             padding: const EdgeInsets.all(SavSpace.x14),
//             decoration: BoxDecoration(
//                 borderRadius: SavRadius.card,
//                 border: Border.all(
//                     color: n.read ? SavColors.border : SavColors.navy,
//                     width: 1.5)),
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Container(
//                   width: 34,
//                   height: 34,
//                   decoration:
//                       BoxDecoration(color: tintBg, shape: BoxShape.circle),
//                   child: Icon(icon, size: 17, color: fg),
//                 ),
//                 const SizedBox(width: SavSpace.x12),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(title,
//                           style: TextStyle(
//                               fontFamily: SavFonts.sans,
//                               fontSize: 14,
//                               fontWeight:
//                                   n.read ? FontWeight.w600 : FontWeight.w700,
//                               color: SavColors.navy)),
//                       if (subtitle != null && subtitle.isNotEmpty)
//                         Text(subtitle,
//                             style: const TextStyle(
//                                 fontFamily: SavFonts.sans,
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.w500,
//                                 color: SavColors.txt3)),
//                       const SizedBox(height: 2),
//                       Text(fmt.timestamp(n.at),
//                           style: const TextStyle(
//                               fontFamily: SavFonts.sans,
//                               fontSize: 11,
//                               fontWeight: FontWeight.w500,
//                               color: SavColors.txt4)),
//                     ],
//                   ),
//                 ),
//                 if (!n.read)
//                   Container(
//                     width: 9,
//                     height: 9,
//                     margin: const EdgeInsets.only(top: 4),
//                     decoration: const BoxDecoration(
//                         color: SavColors.navy, shape: BoxShape.circle),
//                   ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
class NotificationCard extends StatelessWidget {
  NotificationCard({
    super.key,
    required this.notification,
  });

  final MemberNotification notification;

  final NotificationsController logic =
  Get.find<NotificationsController>();

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final fmt = Get.find<Fmt>();

    final title = notification.title ??
        (notification.status != null
            ? Labels.status(l, notification.status!)
            : notification.body ?? '');

    final subtitle =
    notification.title != null ? notification.body : notification.requestId;

    final (icon, fg, bg) = switch (notification.kind) {
      NotificationKind.alert => (
      Icons.restaurant_outlined,
      SavColors.green,
      const Color(0x1429E050),
      ),
      NotificationKind.request => (
      Icons.receipt_long_outlined,
      SavColors.navy,
      const Color(0x1401284D),
      ),
      _ => (
      Icons.notifications_none,
      SavColors.navy,
      const Color(0x1401284D),
      ),
    };

    return SavCard(
      onTap: () async {
        await logic.markRead(notification.id);

        if (notification.requestId != null) {
          Get.toNamed(
            '/request/${notification.requestId}',
          );
        }
      },
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: bg,
            child: Icon(
              icon,
              color: fg,
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: notification.read
                        ? FontWeight.w600
                        : FontWeight.bold,
                  ),
                ),

                if (subtitle != null)
                  Text(subtitle),

                Text(
                  fmt.timestamp(notification.at),
                  style: const TextStyle(
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),

          if (!notification.read)
            const CircleAvatar(
              radius: 5,
              backgroundColor: SavColors.navy,
            ),
        ],
      ),
    );
  }
}