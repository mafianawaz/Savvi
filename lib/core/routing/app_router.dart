import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../features/app/stage_placeholder.dart';
import '../../features/auth/sign_in_screen.dart';
import '../../features/access/access_link_screen.dart';
import '../../features/access/qr_access_screen.dart';
import '../../features/forgot_password/check_email_screen.dart';
import '../../features/forgot_password/forgot_password_screen.dart';
import '../../features/forgot_password/new_password_screen.dart';
import '../../features/forgot_password/password_update_screen.dart';
import '../../features/onboarding/create_profile_screen.dart';
import '../../features/onboarding/approval_screen.dart';
import '../../features/home/main_shell.dart';
import '../../features/request/request_wizard_screen.dart';
import '../../features/activity/request_detail_screen.dart';
import '../../features/delivery/delivery_screen.dart';
import '../../features/pickup/pickup_screen.dart';
import '../../features/notifications/notifications_screen.dart';
import '../../features/notifications/notif_prefs_screen.dart';
import '../../features/profile/profile_screen.dart';
import '../../features/settings/settings_screen.dart';
import '../../features/settings/security_screen.dart';
import '../../data/models/onboarding.dart';

class Routes {
  Routes._();

  static const signIn = '/sign-in';
  static const accessLink = '/access';
  static const qrAccess = '/qr-access';
  static const signUp = '/sign-up';
  static const approval = '/approval';
  static const approvalStatus = '/approval-status';
  // Forgot-password flow
  static const resetPassword = '/reset-password';
  static const checkInbox = '/check-inbox';
  static const newPassword = '/new-password';
  static const passwordUpdated = '/password-updated';

  static const home = '/home';
  static const alerts = '/alerts';
  static const request = '/request';
  static const activity = '/activity';

  static const requestDetail = '/request-detail';

  static const delivery = '/delivery';

  static const pickup = '/pickup';

  static const notifications = '/notifications';
  static const notifPrefs = '/notif-prefs';
  static const profile = '/profile';
  static const settings = '/settings';
  static const security = '/security';
}

class AppPages {
  AppPages._();

  static final routes = <GetPage>[
    GetPage(
      name: Routes.signIn,
      page: () => const SignInScreen(),
    ),

    GetPage(
      name: Routes.accessLink,
      page: () =>  AccessLinkScreen(),
    ),

    GetPage(
      name: Routes.qrAccess,
      page: () =>  QrAccessScreen(),
    ),

    GetPage(
      name: Routes.signUp,
      page: () => QrAccessScreen(),
      // const CreateProfileScreen(),
    ),

    GetPage(
      name: Routes.approval,
      page: () => ApprovalScreen(
        state: Get.arguments ?? ApprovalState.pending,
      ),
    ),

    GetPage(
      name: Routes.approvalStatus,
      page: () => const ApprovalScreen(
        state: ApprovalState.pending,
        isStatusRoute: true,
      ),
    ),

    GetPage(
      name: Routes.home,
      page: () =>
      const MainShell(),
    ),

    GetPage(
      name: Routes.request,
      page: () => const RequestWizardScreen(),
    ),

    GetPage(
      name: Routes.requestDetail,
      page: () => QrAccessScreen(),
      //     RequestDetailScreen(
      //   requestId: Get.parameters['id'] ?? '',
      // ),
    ),

    GetPage(
      name: '/request-edit/:id',
      page: () => const StagePlaceholder(
        routeName: 'Edit request',
        stageNote: 'Stage 4',
      ),
    ),

    GetPage(
      name: Routes.delivery,
      page: () => QrAccessScreen(),
      //     DeliveryTrackingScreen(
      //   requestId: Get.parameters['id'] ?? '',
      // ),
    ),

    GetPage(
      name: Routes.pickup,
      page: ()=> QrAccessScreen(),
      //     PickupScreen(
      //   requestId: Get.parameters['id'] ?? '',
      // ),
    ),

    GetPage(
      name: Routes.notifications,
      page: () => NotificationsScreen(),
    ),

    GetPage(
      name: Routes.notifPrefs,
      page: () => NotifPrefsScreen(),
    ),

    GetPage(
      name: Routes.profile,
      page: () => const ProfileScreen(),
    ),

    // NOTE: Settings has no standalone push route — it's the 5th bottom-nav
    // tab in MainShell (SettingsScreen renders as a tab body, not a full
    // Scaffold/page), matching how Home/Events/Activity aren't pushable
    // routes either. Routes.settings stays defined for callers that need
    // the string, but isn't registered as a GetPage.

    GetPage(
      name: Routes.security,
      page: () => const SecurityScreen(),
    ),
    // Forgot-password flow
    GetPage(name: Routes.resetPassword, page: () => const ResetPasswordScreen()),
    GetPage(name: Routes.checkInbox, page: () => const CheckInboxScreen()),
    GetPage(name: Routes.newPassword, page: () => const NewPasswordScreen()),
    GetPage(name: Routes.passwordUpdated, page: () => const PasswordUpdatedScreen()),
  ];
}

