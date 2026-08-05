import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/routing/app_router.dart';
import '../../core/state/shell_nav.dart';
import '../../core/theme/tokens.dart';
import '../../l10n/app_localizations.dart';
import '../activity/activity_screen.dart';
import '../profile/profile_screen.dart';
import '../request/request_controller.dart';
import '../alerts/alerts_screen.dart';
import 'home_screen.dart';
/// RiverPod
/// The signed-in shell: bottom navigation over Home / Alerts / Activity /
/// Profile with a centered Request action that opens the request wizard. The
/// selected tab lives in [shellTabProvider] so other flows can switch to a tab
/// (e.g. the wizard's "Edit in profile") without pushing a duplicate screen.
// class MainShell extends ConsumerWidget {
//   const MainShell({super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final l = AppLocalizations.of(context);
//     final index = ref.watch(shellTabProvider);
//     void select(int i) => ref.read(shellTabProvider.notifier).state = i;
//
//     final tabs = [
//       HomeScreen(onSelectTab: select),
//       const AlertsScreen(),
//       const ActivityScreen(),
//       const ProfileScreen(),
//     ];
//
//     return Scaffold(
//       backgroundColor: SavColors.page,
//       body: SafeArea(
//           bottom: false, child: IndexedStack(index: index, children: tabs)),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: SavColors.navy,
//         elevation: 2,
//         tooltip: l.homeCtaBtn,
//         shape: RoundedRectangleBorder(borderRadius: SavRadius.field),
//         onPressed: () {
//           // Fresh request: reset any preserved draft and clear the return intent.
//           ref.invalidate(requestControllerProvider);
//           ref.read(requestReturnProvider.notifier).state = false;
//           context.push(Routes.request);
//         },
//         child: const Icon(Icons.add, color: Colors.white, size: 28),
//       ),
//       bottomNavigationBar: BottomAppBar(
//         color: SavColors.surface,
//         height: 64,
//         padding: EdgeInsets.zero,
//         shape: const CircularNotchedRectangle(),
//         notchMargin: 6,
//         child: Row(
//           children: [
//             _NavItem(
//                 icon: Icons.home_outlined,
//                 selectedIcon: Icons.home,
//                 label: l.navHome,
//                 selected: index == kTabHome,
//                 onTap: () => select(kTabHome)),
//             _NavItem(
//                 icon: Icons.notifications_none,
//                 selectedIcon: Icons.notifications,
//                 label: l.navAlerts,
//                 selected: index == kTabAlerts,
//                 onTap: () => select(kTabAlerts)),
//             const SizedBox(width: 56), // notch gap for the FAB
//             _NavItem(
//                 icon: Icons.receipt_long_outlined,
//                 selectedIcon: Icons.receipt_long,
//                 label: l.navActivity,
//                 selected: index == kTabActivity,
//                 onTap: () => select(kTabActivity)),
//             _NavItem(
//                 icon: Icons.person_outline,
//                 selectedIcon: Icons.person,
//                 label: l.navProfile,
//                 selected: index == kTabProfile,
//                 onTap: () => select(kTabProfile)),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class _NavItem extends StatelessWidget {
//   const _NavItem({
//     required this.icon,
//     required this.selectedIcon,
//     required this.label,
//     required this.selected,
//     required this.onTap,
//   });
//
//   final IconData icon;
//   final IconData selectedIcon;
//   final String label;
//   final bool selected;
//   final VoidCallback onTap;
//
//   @override
//   Widget build(BuildContext context) {
//     final color = selected ? SavColors.navy : SavColors.txt4;
//     return Expanded(
//       child: InkWell(
//         onTap: onTap,
//         child: SizedBox(
//           height: 64,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(selected ? selectedIcon : icon, size: 22, color: color),
//               const SizedBox(height: 2),
//               Text(label,
//                   style: TextStyle(
//                       fontFamily: SavFonts.sans,
//                       fontSize: 10,
//                       fontWeight: FontWeight.w700,
//                       color: color)),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }



/// GetX

import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// The signed-in shell.
///
/// Bottom navigation over:
/// - Home
/// - Alerts
/// - Activity
/// - Profile
///
/// with a centered Request action.
///
/// Other flows (like Edit Profile) can switch tabs through
/// [ShellController] without pushing duplicate screens.
class MainShell extends StatelessWidget {
  const MainShell({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);

    final shellController = Get.find<ShellController>();

    final tabs = [
      HomeScreen(
        onSelectTab: shellController.changeTab,
      ),
      const Text('Alerts'),
      const Text('Activity'),
      const Text('Profile'),
       // AlertsScreen(),
       // ActivityScreen(),
       // ProfileScreen(),
    ];

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
        floatingActionButtonLocation:
        FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          backgroundColor: SavColors.navy,
          elevation: 2,
          tooltip: l.homeCtaBtn,
          shape: RoundedRectangleBorder(
            borderRadius: SavRadius.field,
          ),
          onPressed: () {
            /// Reset preserved request draft.
            if (Get.isRegistered<RequestsController>()) {
              Get.delete<RequestsController>();
            }

            /// Clear return intent.
            shellController.setRequestReturn(false);

            Get.toNamed(Routes.request);
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
            size: 28,
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          color: SavColors.surface,
          height: 64,
          padding: EdgeInsets.zero,
          shape: const CircularNotchedRectangle(),
          notchMargin: 6,
          child: Row(
            children: [
              _NavItem(
                icon: Icons.home_outlined,
                selectedIcon: Icons.home,
                label: l.navHome,
                selected: index == kTabHome,
                onTap: shellController.goToHome,
              ),
              _NavItem(
                icon: Icons.calendar_month_outlined,
                selectedIcon: Icons.calendar_month,
                label: l.navAlerts,
                selected: index == kTabAlerts,
                onTap: shellController.goToAlerts,
              ),
              const SizedBox(width: 56),
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
                label: l.navProfile,
                selected: index == kTabProfile,
                onTap: shellController.goToProfile,
              ),
            ],
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