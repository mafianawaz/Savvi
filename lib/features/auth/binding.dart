import 'package:get/get.dart';

import '../../core/formatting/formatters.dart';
import '../../core/localization/locale_controller.dart';
import '../../core/network/savvi_api.dart';
import '../../core/state/shell_nav.dart';
import '../access/access_controller.dart';
import '../home/requests_controller.dart';
import '../notifications/notifications_controller.dart';
import '../profile/profile_controller.dart';
import 'auth_controller.dart';

class InitialBinding extends Bindings {
  void dependencies() {



    Get.put<AuthController>(
      AuthController(api: Get.find<SavviApi>(),),
      permanent: true,
    );

    Get.put<AccessController>(
      AccessController(
        api: Get.find<SavviApi>(),
      ),
      permanent: true,
    );

    Get.put<EditProfileController>(
      EditProfileController(api: Get.find<SavviApi>(),authController: Get.find<AuthController>()),
      permanent: true,
    );

    Get.put<LocaleController>(
      LocaleController(),
      permanent: true,
    );
    Get.put<ShellController>(
      ShellController(),
      permanent: true,
    );

    Get.put<FormatterService>(
      FormatterService(),
      permanent: true,
    );

    Get.put<RequestsController>(
      RequestsController(api: Get.find<SavviApi>()),
      permanent: true,
    );

    Get.put<NotificationsController>(
      NotificationsController(api: Get.find<SavviApi>()),
      permanent: true,
    );
  }


}