import 'package:get/get.dart';

import '../../core/network/savvi_api.dart';
import '../auth/auth_controller.dart';
import 'request_controller.dart';

class RequestWizardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RequestController>(
      () => RequestController(
        api: Get.find<SavviApi>(),
        authController: Get.find<AuthController>(),
      ),
    );
  }
}
