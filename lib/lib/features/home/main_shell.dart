import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/network/savvi_api.dart';
import '../../core/routing/app_router.dart';
import '../../core/state/shell_nav.dart';
import '../../core/theme/tokens.dart';
import '../../l10n/app_localizations.dart';
import '../activity/activity_screen.dart';
import '../alerts/alerts_screen.dart';
import '../auth/auth_controller.dart';
import '../request/request_controller.dart';
import '../settings/settings_screen.dart';
import 'home_screen.dart';

/// The signed-in shell.
///
/// Bottom navigation matches the v56 reference: Home, Events, Request,
/// Activity, Settings — 5 flat tabs, with Request rendered as a raised
/// rounded-square image tile (SavImages.navRequest) rather than a floating
/// action button or a circular badge. Tapping Request always starts a fresh
/// draft; it is not a persisted tab view, so it isn't part of the
/// IndexedStack — instead its "selected" look (green border) is driven by
/// [ShellController.isRequestActive], which this widget keeps in sync with
/// the wizard route via [RouteAware].
///
/// Other flows (like Edit Profile) can switch tabs through
/// [ShellController] without pushing duplicate screens.
class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> with RouteAware {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final route = ModalRoute.of(context);
    if (route is PageRoute) {
      shellRouteObserver.subscribe(this, route);
    }
  }

  @override
  void dispose() {
    shellRouteObserver.unsubscribe(this);
    super.dispose();
  }

  /// Called when a route pushed on top of this shell (the request wizard)
  /// is popped back to it — covers the back-arrow and cancel exits. The
  /// submit-success exit replaces the stack instead of popping, so that
  /// path clears the flag itself before navigating (see
  /// RequestWizardScreen).
  @override
  void didPopNext() {
    Get.find<ShellController>().setRequestActive(false);
  }

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
          ((profile?['household'] as String?) ?? '1').replaceAll('+', ''),
        ) ??
            1;

        return AlertsScreen(household: household);
      }),
      const ActivityScreen(),
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

      shellController.setRequestActive(true);
      Get.toNamed(Routes.request);
    }

    return Obx(() {
      final index = shellController.selectedTab.value;
      final requestActive = shellController.isRequestActive.value;

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
                  selected: requestActive,
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

/// Center "Request" tab: a raised rounded-square photo tile
/// (SavImages.navRequest), matching the v56 reference bottom bar — a
/// squircle, not a full circle. Always pushes a fresh request draft. Shows
/// a green selected ring while the wizard is the topmost route (driven by
/// [ShellController.isRequestActive] in [MainShell]).
class _RequestNavItem extends StatelessWidget {
  const _RequestNavItem({
    required this.label,
    required this.onTap,
    this.selected = false,
  });

  final String label;
  final VoidCallback onTap;
  final bool selected;

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
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(SavRadius.r16),
                    border: Border.all(
                      color: selected ? SavColors.green : SavColors.surface,
                      width: selected ? 2.5 : 3,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: selected
                            ? const Color(0x5529E050)
                            : const Color(0x33000000),
                        blurRadius: selected ? 10 : 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(SavRadius.r14),
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
                  style: TextStyle(
                    fontFamily: SavFonts.sans,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: selected ? SavColors.greenDk : SavColors.navy,
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
