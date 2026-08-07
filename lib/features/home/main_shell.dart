import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/network/savvi_api.dart';
import '../../core/routing/app_router.dart';
import '../../core/state/shell_nav.dart';
import '../../core/theme/tokens.dart';
import '../../l10n/app_localizations.dart';
import '../alerts/alerts_screen.dart';
import '../app/stage_placeholder.dart';
import '../auth/auth_controller.dart';
import '../request/request_controller.dart';
import '../settings/settings_screen.dart';
import 'home_screen.dart';

// NOTE: Activity is still not migrated to GetX. StagePlaceholder stands in
// until it is — swap in the real screen + tab entry below when ready.

/// The signed-in shell.
///
/// Bottom navigation matches the v56 reference: Home, Events, Request,
/// Activity, Settings — 5 flat tabs, with Request rendered as a raised
/// image tile (SavImages.navRequest) rather than a floating action button.
/// Tapping Request always starts a fresh draft; it is not a persisted tab
/// view, so it isn't part of the IndexedStack.
///
/// Other flows (like Edit Profile) can switch tabs through
/// [ShellController] without pushing duplicate screens.
class MainShell extends StatelessWidget {
  const MainShell({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);

    final shellController = Get.find<ShellController>();
    final authController = Get.find<AuthController>();

    final tabs = [
      HomeScreen(
        onSelectTab: shellController.changeTab,
      ),
      Obx(() {
        final profile = authController.profile;
        final household = int.tryParse(
          ((profile?['household'] as String?) ?? '1')
              .replaceAll('+', ''),
        ) ??
            1;

        return AlertsScreen(household: household);
      }),
      const StagePlaceholder(
        routeName: 'Activity',
        stageNote: 'Activity feature migration',
      ),
      const SettingsScreen(),
    ];

    void startNewRequest() {
      /// Reset preserved request draft — a fresh request always starts
      /// clean, never resuming a stale one.
      if (Get.isRegistered<RequestController>()) {
        Get.delete<RequestController>();
      }

      Get.put<RequestController>(
        RequestController(
          api: Get.find<SavviApi>(),
          authController: Get.find<AuthController>(),
        ),
      );

      /// Clear return intent.
      shellController.setRequestReturn(false);

      Get.toNamed(Routes.request);
    }

    return Obx(() {
      final index = shellController.selectedTab.value;

      return Scaffold(
        backgroundColor: SavColors.page,
        body: SafeArea(
          bottom: false,
          child: IndexedStack(
            index: index,
            children: tabs,
          ),
        ),
        bottomNavigationBar: SafeArea(
          top: false,
          child: Container(
            height: 76,
            color: SavColors.surface,
            padding: const EdgeInsets.symmetric(horizontal: SavSpace.x8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _NavItem(
                  icon: Icons.home_outlined,
                  selectedIcon: Icons.home,
                  label: l.navHome,
                  selected: index == kTabHome,
                  onTap: shellController.goToHome,
                ),
                _NavItem(
                  icon: Icons.event_outlined,
                  selectedIcon: Icons.event,
                  label: l.navEvents,
                  selected: index == kTabAlerts,
                  onTap: shellController.goToAlerts,
                ),
                _RequestNavItem(
                  label: l.navRequest,
                  onTap: startNewRequest,
                ),
                _NavItem(
                  icon: Icons.receipt_long_outlined,
                  selectedIcon: Icons.receipt_long,
                  label: l.navActivity,
                  selected: index == kTabActivity,
                  onTap: shellController.goToActivity,
                ),
                _NavItem(
                  icon: Icons.settings_outlined,
                  selectedIcon: Icons.settings,
                  label: l.navSettings,
                  selected: index == kTabProfile,
                  onTap: shellController.goToProfile,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.selectedIcon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final IconData selectedIcon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = selected ? SavColors.navy : SavColors.txt4;

    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          height: 64,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                selected ? selectedIcon : icon,
                size: 22,
                color: color,
              ),
              const SizedBox(height: 2),
              Text(
                label,
                style: TextStyle(
                  fontFamily: SavFonts.sans,
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Center "Request" tab: a raised photo tile (SavImages.navRequest) rather
/// than a plain icon, matching the v56 reference bottom bar. Always pushes
/// a fresh request draft — it never highlights as "selected" since it's not
/// a persisted view.
class _RequestNavItem extends StatelessWidget {
  const _RequestNavItem({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          height: 64,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Transform.translate(
                offset: const Offset(0, -14),
                child: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: SavColors.surface, width: 3),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x33000000),
                        blurRadius: 8,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(21),
                    child: Image.asset(
                      SavImages.navRequest,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stack) => Container(
                        color: SavColors.navy,
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Transform.translate(
                offset: const Offset(0, -8),
                child: Text(
                  label,
                  style: const TextStyle(
                    fontFamily: SavFonts.sans,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: SavColors.navy,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}