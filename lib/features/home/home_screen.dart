import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../core/formatting/formatters.dart';
import '../../core/routing/app_router.dart';
import '../../core/state/shell_nav.dart';
import '../../core/theme/tokens.dart';
import '../../l10n/app_localizations.dart';
import '../auth/auth_controller.dart';
import '../notifications/notifications_controller.dart';
import 'request_card.dart';
import 'requests_controller.dart';

/// Home dashboard (v45 fidelity): member line + greeting + tagline, a request
/// CTA card, two navigation tiles (Alerts, My Requests), and the active-request
/// preview. No monetary or Delivery Credit content.
// class HomeScreen extends ConsumerWidget {
//   const HomeScreen({super.key, this.onSelectTab});
//
//   /// Switches the shell's bottom-nav tab from the tiles.
//   final ValueChanged<int>? onSelectTab;
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final l = AppLocalizations.of(context);
//     final auth = ref.watch(authControllerProvider);
//     final profile = switch (auth) {
//       AuthSignedIn(:final profile) => profile,
//       _ => const <String, dynamic>{},
//     };
//     final firstName = (profile['firstName'] as String?) ?? '';
//     final memberId = (profile['memberId'] as String?) ?? '';
//     final household = (profile['household'] as String?) ?? '';
//     final nonprofit = (profile['nonprofit'] as String?) ?? '';
//     final active = ref.watch(activeRequestProvider);
//
//     final unread = ref.watch(notificationsControllerProvider).items.maybeWhen(
//       data: (items) => items.where((n) => !n.read).length,
//       orElse: () => 0,
//     );
//
//     return RefreshIndicator(
//       onRefresh: () => ref.refresh(requestsProvider.future),
//       child: ListView(
//         padding: const EdgeInsets.fromLTRB(
//             SavSpace.x16, SavSpace.x10, SavSpace.x16, SavSpace.x24),
//         children: [
//           _header(context, l, firstName, memberId, unread,),
//           const SizedBox(height: SavSpace.x16),
//           _ctaCard(context, l, nonprofit, household),
//           const SizedBox(height: SavSpace.x16),
//           _tiles(l),
//           const SizedBox(height: SavSpace.x20),
//           Text(l.activeRequest,
//               style: const TextStyle(
//                   fontFamily: SavFonts.sans,
//                   fontSize: 11,
//                   fontWeight: FontWeight.w700,
//                   letterSpacing: 0.5,
//                   color: SavColors.txt3)),
//           const SizedBox(height: SavSpace.x8),
//           if (active != null)
//             RequestCard(
//               request: active,
//               onTap: () => context.push('/request/${active.id}'),
//             )
//           else
//             _emptyActive(context, l),
//         ],
//       ),
//     );
//   }
//
//   Widget _header(
//       BuildContext context, AppLocalizations l, String name, String memberId,int unread,) {
//     final hour = DateTime.now().hour;
//     final greeting = hour < 12
//         ? l.greetMorning
//         : hour < 17
//             ? l.greetAfternoon
//             : l.greetEvening;
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 children: [
//                   Container(
//                     width: 7,
//                     height: 7,
//                     decoration: const BoxDecoration(
//                         color: SavColors.greenDk, shape: BoxShape.circle),
//                   ),
//                   const SizedBox(width: SavSpace.x6),
//                   Text(
//                       memberId.isEmpty
//                           ? l.savviMember
//                           : '${l.savviMember} · $memberId',
//                       style: const TextStyle(
//                           fontFamily: SavFonts.sans,
//                           fontSize: 11.5,
//                           fontWeight: FontWeight.w700,
//                           color: SavColors.txt3)),
//                 ],
//               ),
//               const SizedBox(height: SavSpace.x4),
//               Text(name.isEmpty ? greeting : '$greeting, $name',
//                   style: const TextStyle(
//                       fontFamily: SavFonts.serif,
//                       fontSize: 22,
//                       height: 1.1,
//                       color: SavColors.navy)),
//               const SizedBox(height: SavSpace.x4),
//               Text(l.homeSub,
//                   style: const TextStyle(
//                       fontFamily: SavFonts.sans,
//                       fontSize: 13,
//                       height: 1.45,
//                       fontWeight: FontWeight.w500,
//                       color: SavColors.txt3)),
//             ],
//           ),
//         ),
//         const SizedBox(width: SavSpace.x12),
//         _NotifButton(
//           unread: unread,
//           onTap: () => context.push(Routes.notifications),
//         ),
//       ],
//     );
//   }
//
//   Widget _ctaCard(BuildContext context, AppLocalizations l, String nonprofit,
//       String household) {
//     final meta = [
//       if (nonprofit.isNotEmpty) nonprofit,
//       if (household.isNotEmpty) l.householdOf(household),
//     ].join('  ·  ');
//     return InkWell(
//       onTap: () => context.push(Routes.request),
//       borderRadius: SavRadius.cardLg,
//       child: Container(
//         padding: const EdgeInsets.all(SavSpace.x20),
//         decoration:
//             BoxDecoration(color: SavColors.navy, borderRadius: SavRadius.cardLg),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             if (meta.isNotEmpty) ...[
//               Text(meta,
//                   style: const TextStyle(
//                       fontFamily: SavFonts.sans,
//                       fontSize: 11.5,
//                       fontWeight: FontWeight.w600,
//                       color: Colors.white70)),
//               const SizedBox(height: SavSpace.x10),
//             ],
//             Row(
//               children: [
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(l.homeCtaTitle,
//                           style: const TextStyle(
//                               fontFamily: SavFonts.serif,
//                               fontSize: 19,
//                               color: Colors.white)),
//                       const SizedBox(height: SavSpace.x4),
//                       Text(l.homeCtaBody,
//                           style: const TextStyle(
//                               fontFamily: SavFonts.sans,
//                               fontSize: 12.5,
//                               fontWeight: FontWeight.w500,
//                               color: Colors.white70)),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(width: SavSpace.x12),
//                 Container(
//                   padding: const EdgeInsets.symmetric(
//                       horizontal: SavSpace.x16, vertical: SavSpace.x10),
//                   decoration: BoxDecoration(
//                       color: SavColors.green, borderRadius: SavRadius.field),
//                   child: Text(l.homeCtaBtn,
//                       style: const TextStyle(
//                           fontFamily: SavFonts.sans,
//                           fontSize: 13,
//                           fontWeight: FontWeight.w700,
//                           color: SavColors.navy)),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _tiles(AppLocalizations l) {
//     return Row(
//       children: [
//         Expanded(
//           child: _Tile(
//               icon: Icons.notifications_active_outlined,
//               title: l.tileAlertsTitle,
//               sub: l.tileAlertsSub,
//               onTap: () => onSelectTab?.call(1)),
//         ),
//         const SizedBox(width: SavSpace.x10),
//         Expanded(
//           child: _Tile(
//               icon: Icons.receipt_long_outlined,
//               title: l.tileReqTitle,
//               sub: l.tileReqSub,
//               onTap: () => onSelectTab?.call(2)),
//         ),
//       ],
//     );
//   }
//
//   Widget _emptyActive(BuildContext context, AppLocalizations l) {
//     return Container(
//       padding: const EdgeInsets.all(SavSpace.x20),
//       decoration: BoxDecoration(
//         color: SavColors.surface,
//         borderRadius: SavRadius.card,
//         border: Border.all(color: SavColors.border, width: 1.5),
//       ),
//       child: Column(
//         children: [
//           const Icon(Icons.inbox_outlined, size: 30, color: SavColors.txt4),
//           const SizedBox(height: SavSpace.x8),
//           Text(l.homeNoActive,
//               style: const TextStyle(
//                   fontFamily: SavFonts.serif,
//                   fontSize: 16,
//                   color: SavColors.navy)),
//           const SizedBox(height: SavSpace.x4),
//           Text(l.homeNoActiveBody,
//               textAlign: TextAlign.center,
//               style: const TextStyle(
//                   fontFamily: SavFonts.sans,
//                   fontSize: 12.5,
//                   height: 1.45,
//                   fontWeight: FontWeight.w500,
//                   color: SavColors.txt3)),
//           const SizedBox(height: SavSpace.x14),
//           SizedBox(
//             height: 44,
//             child: FilledButton(
//               style: FilledButton.styleFrom(
//                   backgroundColor: SavColors.navy,
//                   shape:
//                       RoundedRectangleBorder(borderRadius: SavRadius.field)),
//               onPressed: () => context.push(Routes.request),
//               child: Text(l.homeCtaTitle,
//                   style: const TextStyle(
//                       fontFamily: SavFonts.sans,
//                       fontSize: 13.5,
//                       fontWeight: FontWeight.w700)),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
class HomeScreen extends StatelessWidget {
  HomeScreen({
    super.key,
    this.onSelectTab,
  });

  final ValueChanged<int>? onSelectTab;

  final AuthController authController = Get.find<AuthController>();
  final RequestsController requestsController =
  Get.find<RequestsController>();
  final NotificationsController notificationsController =
  Get.find<NotificationsController>();
  final ShellController shellController =
  Get.find<ShellController>();
  final Fmt fmt = Get.find<Fmt>();

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);

    return Obx(() {
      final profile = authController.profile;

      final firstName =
          profile?['firstName'] as String? ?? '';

      final memberId =
          profile?['memberId'] as String? ?? '';

      final household =
          profile?['household'] as String? ?? '';

      final nonprofit =
          profile?['nonprofit'] as String? ?? '';

      final unread = notificationsController.unreadCount;

      final active = requestsController.activeRequest;

      return RefreshIndicator(
        onRefresh: requestsController.refreshRequests,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
            SavSpace.x16,
            SavSpace.x10,
            SavSpace.x16,
            SavSpace.x24,
          ),
          children: [
            _header(
              context,
              l,
              firstName,
              memberId,
              unread,
            ),

            const SizedBox(height: SavSpace.x16),

            _ctaCard(
              context,
              l,
              nonprofit,
              household,
            ),

            const SizedBox(height: SavSpace.x16),

            _tiles(l),

            const SizedBox(height: SavSpace.x20),

            Text(
              l.activeRequest,
              style: const TextStyle(
                fontFamily: SavFonts.sans,
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: .5,
                color: SavColors.txt3,
              ),
            ),

            const SizedBox(height: SavSpace.x8),

            if (active != null)
              RequestCard(
                request: active,
                onTap: () => Get.toNamed(
                  Routes.requestDetail,
                  arguments: active.id,
                ),
              )
            else
              _emptyActive(context, l),
          ],
        ),
      );
    });
  }

  Widget _header(
      BuildContext context,
      AppLocalizations l,
      String name,
      String memberId,
      int unread,
      ) {
    final hour = DateTime.now().hour;

    final greeting = hour < 12
        ? l.greetMorning
        : hour < 17
        ? l.greetAfternoon
        : l.greetEvening;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 7,
                    height: 7,
                    decoration: const BoxDecoration(
                      color: SavColors.greenDk,
                      shape: BoxShape.circle,
                    ),
                  ),

                  const SizedBox(width: SavSpace.x6),

                  Text(
                    memberId.isEmpty
                        ? l.savviMember
                        : '${l.savviMember} · $memberId',
                    style: const TextStyle(
                      fontFamily: SavFonts.sans,
                      fontSize: 11.5,
                      fontWeight: FontWeight.w700,
                      color: SavColors.txt3,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: SavSpace.x4),

              Text(
                name.isEmpty
                    ? greeting
                    : '$greeting, $name',
                style: const TextStyle(
                  fontFamily: SavFonts.serif,
                  fontSize: 22,
                  height: 1.1,
                  color: SavColors.navy,
                ),
              ),

              const SizedBox(height: SavSpace.x4),

              Text(
                l.homeSub,
                style: const TextStyle(
                  fontFamily: SavFonts.sans,
                  fontSize: 13,
                  height: 1.45,
                  fontWeight: FontWeight.w500,
                  color: SavColors.txt3,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(width: SavSpace.x12),

        _NotifButton(
          unread: unread,
          onTap: () => shellController.goToAlerts(),
        ),
      ],
    );
  }

  Widget _ctaCard(
      BuildContext context,
      AppLocalizations l,
      String nonprofit,
      String household,
      ) {
    final meta = [
      if (nonprofit.isNotEmpty) nonprofit,
      if (household.isNotEmpty)
        l.householdOf(household),
    ].join('  ·  ');

    return InkWell(
      borderRadius: SavRadius.cardLg,
      onTap: () => Get.toNamed(
        Routes.request,
      ),
      child: Container(
        padding: const EdgeInsets.all(
          SavSpace.x20,
        ),
        decoration: BoxDecoration(
          color: SavColors.navy,
          borderRadius: SavRadius.cardLg,
        ),
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [
            if (meta.isNotEmpty) ...[
              Text(
                meta,
                style: const TextStyle(
                  fontFamily: SavFonts.sans,
                  fontSize: 11.5,
                  fontWeight: FontWeight.w600,
                  color: Colors.white70,
                ),
              ),

              const SizedBox(
                  height: SavSpace.x10),
            ],

            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Text(
                        l.homeCtaTitle,
                        style: const TextStyle(
                          fontFamily:
                          SavFonts.serif,
                          fontSize: 19,
                          color: Colors.white,
                        ),
                      ),

                      const SizedBox(
                          height: SavSpace.x4),

                      Text(
                        l.homeCtaBody,
                        style: const TextStyle(
                          fontFamily:
                          SavFonts.sans,
                          fontSize: 12.5,
                          fontWeight:
                          FontWeight.w500,
                          color:
                          Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(
                    width: SavSpace.x12),

                Container(
                  padding:
                  const EdgeInsets.symmetric(
                    horizontal: SavSpace.x16,
                    vertical: SavSpace.x10,
                  ),
                  decoration: BoxDecoration(
                    color: SavColors.green,
                    borderRadius:
                    SavRadius.field,
                  ),
                  child: Text(
                    l.homeCtaBtn,
                    style: const TextStyle(
                      fontFamily:
                      SavFonts.sans,
                      fontSize: 13,
                      fontWeight:
                      FontWeight.w700,
                      color:
                      SavColors.navy,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _tiles(AppLocalizations l) {
    return Row(
      children: [
        Expanded(
          child: _Tile(
            icon:
            Icons.notifications_active_outlined,
            title: l.tileAlertsTitle,
            sub: l.tileAlertsSub,
            onTap:
            shellController.goToAlerts,
          ),
        ),

        const SizedBox(width: SavSpace.x10),

        Expanded(
          child: _Tile(
            icon:
            Icons.receipt_long_outlined,
            title: l.tileReqTitle,
            sub: l.tileReqSub,
            onTap:
            shellController.goToActivity,
          ),
        ),
      ],
    );
  }

  Widget _emptyActive(
      BuildContext context,
      AppLocalizations l) {
    // Keep exactly your existing implementation.
    // No changes needed.
    return const SizedBox();
  }
}
class _Tile extends StatelessWidget {
  const _Tile(
      {required this.icon,
      required this.title,
      required this.sub,
      required this.onTap});
  final IconData icon;
  final String title;
  final String sub;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: SavRadius.card,
      child: Container(
        padding: const EdgeInsets.all(SavSpace.x14),
        decoration: BoxDecoration(
          color: SavColors.surface,
          borderRadius: SavRadius.card,
          border: Border.all(color: SavColors.border, width: 1.5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 22, color: SavColors.navy),
            const SizedBox(height: SavSpace.x10),
            Text(title,
                style: const TextStyle(
                    fontFamily: SavFonts.sans,
                    fontSize: 13.5,
                    fontWeight: FontWeight.w700,
                    color: SavColors.navy)),
            const SizedBox(height: 2),
            Text(sub,
                style: const TextStyle(
                    fontFamily: SavFonts.sans,
                    fontSize: 11.5,
                    height: 1.35,
                    fontWeight: FontWeight.w500,
                    color: SavColors.txt3)),
          ],
        ),
      ),
    );
  }
}

class _NotifButton extends StatelessWidget {
  const _NotifButton({required this.onTap, this.unread = 0});
  final VoidCallback onTap;
  final int unread;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Semantics(
      button: true,
      label: l.notificationsTitle,
      child: InkWell(
        onTap: onTap,
        borderRadius: SavRadius.field,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                  color: SavColors.surface,
                  borderRadius: SavRadius.field,
                  border: Border.all(color: SavColors.border, width: 1.5)),
              child: const Icon(Icons.notifications_none,
                  size: 20, color: SavColors.navy),
            ),
            if (unread > 0)
              Positioned(
                top: -4,
                right: -4,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  constraints:
                      const BoxConstraints(minWidth: 18, minHeight: 18),
                  decoration: BoxDecoration(
                      color: SavColors.green,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(9),
                      border: Border.all(color: SavColors.surface, width: 2)),
                  child: Center(
                    child: Text(unread > 9 ? '9+' : '$unread',
                        style: const TextStyle(
                            fontFamily: SavFonts.sans,
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: SavColors.navy)),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
