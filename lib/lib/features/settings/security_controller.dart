import 'package:get/get.dart';

import '../../core/network/savvi_api.dart';
import '../auth/auth_controller.dart';

/// Security & password. The member can request a password reset link; the
/// reset itself is handled by the auth provider (Firebase Auth in
/// production). This only calls the auth service and reports the result —
/// no custom password storage, no auth internals, no SMS reset.
class SecurityController extends GetxController {
  SecurityController({required this.api, required this.authController});

  final SavviApi api;
  final AuthController authController;

  final RxBool sending = false.obs;
  final RxBool sent = false.obs;

  String get email => (authController.profile?['email'] as String?) ?? '';

  /// Sends the reset link. Returns true on success, false on failure — the
  /// screen maps that to the already-localised success/error toast copy.
  Future<bool> sendResetLink() async {
    if (sending.value) return false; // single-flight

    sending.value = true;

    final result = await api.sendPasswordReset(email);

    sending.value = false;

    return result.when(
      ok: (_) {
        sent.value = true;
        return true;
      },
      err: (_) => false,
    );
  }
}
