import 'package:get/get.dart';

import '../../core/routing/app_router.dart';
import '../../core/state/shell_nav.dart';
import '../../data/models/member_request.dart';
import '../auth/auth_controller.dart';
import '../request/request_controller.dart';

class HomeController extends GetxController {
  HomeController({
    required this.authController,
    required this.requestsController,
    // required this.notificationsController,
  });

  final AuthController authController;
  final RequestsController requestsController;
  // final NotificationsController notificationsController;

  Map<String, dynamic> get profile =>
      authController.profile ?? const {};

  String get firstName =>
      profile['firstName'] as String? ?? '';

  String get memberId =>
      profile['memberId'] as String? ?? '';

  String get household =>
      profile['household'] as String? ?? '';

  String get nonprofit =>
      profile['nonprofit'] as String? ?? '';

  MemberRequest? get activeRequest =>
      requestsController.activeRequest.value;

  // int get unreadCount {
  //   return notificationsController.items
  //       .where((e) => !e.read)
  //       .length;
  // }
  //
  // Future<void> refresh() async {
  //   await Future.wait([
  //     requestsController.fetchRequests(),
  //     notificationsController.fetchNotifications(),
  //   ]);
  // }

  void openRequest() {
    Get.toNamed(Routes.request);
  }

  void openNotifications() {
    Get.toNamed(Routes.notifications);
  }

  void openRequestDetail(MemberRequest request) {
    Get.toNamed(
      '/request/${request.id}',
    );
  }

  void goToAlerts() {
    Get.find<ShellController>().goToAlerts();
  }

  void goToActivity() {
    Get.find<ShellController>().goToActivity();
  }
}