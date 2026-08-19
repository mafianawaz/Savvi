import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/formatting/formatters.dart';
import '../../core/routing/app_router.dart';
import '../../core/theme/tokens.dart';
import '../../l10n/app_localizations.dart';
import '../auth/auth_controller.dart';
import '../notifications/notifications_controller.dart';
import 'request_card.dart';
import 'requests_controller.dart';

/// Home dashboard (v56): avatar + greeting + member/nonprofit/household +
/// Approved status, a flat navy request-CTA row, two photo tiles (Events,
/// My Requests), and the single active-request preview. No monetary or
/// Delivery Credit content.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, this.onSelectTab});

  /// Switches the shell's bottom-nav tab from the tiles.
  final ValueChanged<int>? onSelectTab;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final authController = Get.find<AuthController>();
    final requestsController = Get.find<RequestsController>();
    final notificationsController = Get.find<NotificationsController>();

    return Obx(() {
      final auth = authController.state.value;
      final profile = switch (auth) {
        AuthSignedIn(:final profile) => profile,
        _ => const <String, dynamic>{},
      };

      final firstName = (profile['firstName'] as String?) ?? '';
      final lastName = (profile['lastName'] as String?) ?? '';
      final fullName = [firstName, lastName]
          .where((s) => s.isNotEmpty)
          .join(' ');
      final memberId = (profile['memberId'] as String?) ?? '';
      final household = (profile['household'] as String?) ?? '';
      final nonprofit = (profile['nonprofit'] as String?) ?? '';

      final active = requestsController.activeRequest;
      final unread = notificationsController.unreadCount;

      return RefreshIndicator(
        onRefresh: requestsController.refresh,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
            SavSpace.x16,
            SavSpace.x14,
            SavSpace.x16,
            SavSpace.x24,
          ),
          children: [
            _header(
              context,
              l,
              firstName: firstName,
              fullName: fullName,
              memberId: memberId,
              nonprofit: nonprofit,
              household: household,
              unread: unread,
            ),
            const SizedBox(height: SavSpace.x16),
            _ctaRow(context, l),
            const SizedBox(height: SavSpace.x14),
            _tiles(l),
            const SizedBox(height: SavSpace.x20),
            Text(
              l.activeRequest.toUpperCase(),
              style: const TextStyle(
                fontFamily: SavFonts.sans,
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.6,
                color: SavColors.txt3,
              ),
            ),
            const SizedBox(height: SavSpace.x8),
            if (active != null)
              ActiveRequestCard(
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
    AppLocalizations l, {
    required String firstName,
    required String fullName,
    required String memberId,
    required String nonprofit,
    required String household,
    required int unread,
  }) {
    final hour = DateTime.now().hour;
    final greeting = hour < 12
        ? l.greetMorning
        : hour < 17
            ? l.greetAfternoon
            : l.greetEvening;

    final memberLine = [
      if (fullName.isNotEmpty) fullName,
      if (memberId.isNotEmpty) memberId,
    ].join(' \u00b7 ');

    final orgLine = [
      if (nonprofit.isNotEmpty) nonprofit,
      if (household.isNotEmpty) l.householdOf(household),
    ].join(' \u00b7 ');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: SavRadius.field,
              child: SizedBox(
                width: 44,
                height: 44,
                child: Image.asset(
                  SavImages.logo,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stack) => Container(
                    color: SavColors.navy,
                    alignment: Alignment.center,
                    child: const Text(
                      'S',
                      style: TextStyle(
                        fontFamily: SavFonts.serif,
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: SavSpace.x12),
            Expanded(
              child: Text(
                firstName.isEmpty
                    ? greeting
                    : '$greeting, $firstName.',
                style: const TextStyle(
                  fontFamily: SavFonts.serif,
                  fontSize: 21,
                  height: 1.15,
                  color: SavColors.navy,
                ),
              ),
            ),
            const SizedBox(width: SavSpace.x12),
            _NotifButton(
              unread: unread,
              onTap: () => Get.toNamed(Routes.notifications),
            ),
          ],
        ),
        if (memberLine.isNotEmpty) ...[
          const SizedBox(height: SavSpace.x8),
          Text(
            memberLine,
            style: const TextStyle(
              fontFamily: SavFonts.sans,
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: SavColors.txt2,
            ),
          ),
        ],
        if (orgLine.isNotEmpty) ...[
          const SizedBox(height: 2),
          Text(
            orgLine,
            style: const TextStyle(
              fontFamily: SavFonts.sans,
              fontSize: 12.5,
              fontWeight: FontWeight.w500,
              color: SavColors.txt3,
            ),
          ),
        ],
        const SizedBox(height: SavSpace.x8),
        // NOTE: member account approval isn't yet a field the backend
        // exposes on the profile — this always renders as approved, same
        // as the v56 reference. Swap in a real profile['approved'] check
        // (and the needs-update/pending states) once the backend adds it.
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: SavSpace.x10,
              vertical: 3,
            ),
            decoration: BoxDecoration(
              color: SavColors.greenLight,
              borderRadius: SavRadius.pill,
            ),
            child: Text(
              l.stApproved,
              style: const TextStyle(
                fontFamily: SavFonts.sans,
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: SavColors.pillGreenFg,
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Flat navy CTA row (v56): title + subtitle on the left, a green pill
  /// button on the right — replaces the earlier full-bleed photo hero now
  /// that the header carries the member/nonprofit context instead.
  Widget _ctaRow(BuildContext context, AppLocalizations l) {
    return Semantics(
      button: true,
      label: '${l.homeCtaTitle}. ${l.homeCtaBody}',
      excludeSemantics: true,
      child: Material(
        color: SavColors.navy,
        borderRadius: SavRadius.cardLg,
        child: InkWell(
          onTap: () => Get.toNamed(Routes.request),
          borderRadius: SavRadius.cardLg,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              SavSpace.x16,
              SavSpace.x16,
              SavSpace.x14,
              SavSpace.x16,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l.homeCtaTitle,
                        style: const TextStyle(
                          fontFamily: SavFonts.serif,
                          fontSize: 17,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        l.homeCtaBody,
                        style: const TextStyle(
                          fontFamily: SavFonts.sans,
                          fontSize: 12.5,
                          fontWeight: FontWeight.w500,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: SavSpace.x12),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: SavSpace.x16,
                    vertical: SavSpace.x10,
                  ),
                  decoration: BoxDecoration(
                    color: SavColors.green,
                    borderRadius: SavRadius.field,
                  ),
                  child: Text(
                    l.homeCtaBtn,
                    style: const TextStyle(
                      fontFamily: SavFonts.sans,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: SavColors.navy,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Photo tiles (v56): photo on top, title + subtitle on a white card body
  /// below it — a content-card treatment rather than text overlaid on the
  /// photo. "Events" opens the Events tab; "My Requests" opens Activity.
  Widget _tiles(AppLocalizations l) {
    return Row(
      children: [
        Expanded(
          child: _PhotoTile(
            image: SavImages.foodAccessAlert,
            icon: Icons.event_outlined,
            title: l.tileAlertsTitle,
            sub: l.tileAlertsSub,
            onTap: () => onSelectTab?.call(1),
          ),
        ),
        const SizedBox(width: SavSpace.x10),
        Expanded(
          child: _PhotoTile(
            image: SavImages.request,
            icon: Icons.receipt_long_outlined,
            title: l.tileReqTitle,
            sub: l.tileReqSub,
            onTap: () => onSelectTab?.call(2),
          ),
        ),
      ],
    );
  }

  Widget _emptyActive(BuildContext context, AppLocalizations l) {
    return Container(
      padding: const EdgeInsets.all(SavSpace.x20),
      decoration: BoxDecoration(
        color: SavColors.surface,
        borderRadius: SavRadius.card,
        border: Border.all(color: SavColors.border, width: 1.5),
      ),
      child: Column(
        children: [
          const Icon(Icons.inbox_outlined, size: 30, color: SavColors.txt4),
          const SizedBox(height: SavSpace.x8),
          Text(
            l.homeNoActive,
            style: const TextStyle(
              fontFamily: SavFonts.serif,
              fontSize: 16,
              color: SavColors.navy,
            ),
          ),
          const SizedBox(height: SavSpace.x4),
          Text(
            l.homeNoActiveBody,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: SavFonts.sans,
              fontSize: 12.5,
              height: 1.45,
              fontWeight: FontWeight.w500,
              color: SavColors.txt3,
            ),
          ),
          const SizedBox(height: SavSpace.x14),
          SizedBox(
            height: 44,
            child: FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: SavColors.navy,
                shape: RoundedRectangleBorder(borderRadius: SavRadius.field),
              ),
              onPressed: () => Get.toNamed(Routes.request),
              child: Text(
                l.homeCtaTitle,
                style: const TextStyle(
                  fontFamily: SavFonts.sans,
                  fontSize: 13.5,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Photo tile: image on top (rounded corners), title + subtitle below on a
/// white card body — matches the v56 reference's content-card tile style.
class _PhotoTile extends StatelessWidget {
  const _PhotoTile({
    required this.image,
    required this.icon,
    required this.title,
    required this.sub,
    required this.onTap,
  });

  final String image;
  final IconData icon;
  final String title;
  final String sub;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: '$title. $sub',
      excludeSemantics: true,
      child: Material(
        color: SavColors.surface,
        borderRadius: SavRadius.card,
        child: InkWell(
          onTap: onTap,
          borderRadius: SavRadius.card,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: SavRadius.card,
              border: Border.all(color: SavColors.border, width: 1.5),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(SavRadius.r14),
                  ),
                  child: SizedBox(
                    height: 84,
                    width: double.infinity,
                    child: Image.asset(
                      image,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stack) => Container(
                        color: SavColors.page,
                        child: Icon(icon, size: 24, color: SavColors.navy),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(SavSpace.x10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontFamily: SavFonts.sans,
                          fontSize: 13.5,
                          fontWeight: FontWeight.w700,
                          color: SavColors.navy,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        sub,
                        style: const TextStyle(
                          fontFamily: SavFonts.sans,
                          fontSize: 11,
                          height: 1.3,
                          fontWeight: FontWeight.w500,
                          color: SavColors.txt3,
                        ),
                      ),
                    ],
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
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: SavColors.surface,
                borderRadius: SavRadius.field,
                border: Border.all(color: SavColors.border, width: 1.5),
              ),
              child: const Icon(
                Icons.notifications_none,
                size: 19,
                color: SavColors.navy,
              ),
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
                    color: SavColors.red,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(9),
                    border: Border.all(color: SavColors.surface, width: 2),
                  ),
                  child: Center(
                    child: Text(
                      unread > 9 ? '9+' : '$unread',
                      style: const TextStyle(
                        fontFamily: SavFonts.sans,
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
