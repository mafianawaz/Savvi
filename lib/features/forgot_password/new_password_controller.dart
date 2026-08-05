import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/auth/firebase_auth_gateaway.dart';
import '../../core/routing/app_router.dart';
import '../../l10n/app_localizations.dart';
import '../../shared/patterns/error_text.dart';
import '../../shared/patterns/feedback.dart';

/// New-password screen. Requirement checking is delegated entirely to the
/// existing PasswordField/PasswordChecks widget — this only tracks whether
/// the last submit attempt failed (for the red banner) and drives the
/// FirebaseAuthGateway call.
class NewPasswordController extends GetxController {
  NewPasswordController({
    required this.authGateway,
    required this.email,
    required this.oobCode,
  });

  final FirebaseAuthGateway authGateway;
  final String email;
  final String oobCode;

  final formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();

  final RxBool isSubmitting = false.obs;
  final RxBool showBanner = false.obs;

  @override
  void onClose() {
    passwordController.dispose();
    confirmController.dispose();
    super.onClose();
  }

  /// Validator for the confirm-password SavField.
  String? confirmValidator(String? v, AppLocalizations l) {
    if ((v ?? '').isEmpty) return l.valRequired;
    if (v != passwordController.text) return l.confirmPasswordMismatch;
    return null;
  }

  Future<void> updatePassword(BuildContext context) async {
    final l = AppLocalizations.of(context);
    final valid = formKey.currentState!.validate();
    showBanner.value = !valid;
    if (!valid || isSubmitting.value) return;

    isSubmitting.value = true;
    final result = await authGateway.confirmPasswordReset(
      oobCode: oobCode,
      newPassword: passwordController.text,
    );
    isSubmitting.value = false;

    result.when(
      ok: (_) => Get.offAllNamed(Routes.passwordUpdated),
      err: (f) => SavFeedback.toast(context, errText(l, f.messageKey), tone: FeedbackTone.error),
    );
  }

  void cancel() => Get.back();
}