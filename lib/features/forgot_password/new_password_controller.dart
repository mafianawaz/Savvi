
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/network/savvi_api.dart';
import '../../core/routing/app_router.dart';
import '../../l10n/app_localizations.dart';
import '../../shared/patterns/feedback.dart';

class NewPasswordController extends GetxController {
  NewPasswordController({
    required this.api,
    required this.email,
  });

  final SavviApi api;
  final String email;

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

  String? confirmValidator(String? value, AppLocalizations l) {
    if ((value ?? '').isEmpty) return l.valRequired;
    if (value != passwordController.text) {
      return l.confirmPasswordMismatch;
    }
    return null;
  }

  Future<void> updatePassword(BuildContext context) async {
    final l = AppLocalizations.of(context);

    final valid = formKey.currentState?.validate() ?? false;
    showBanner.value = !valid;

    if (!valid || isSubmitting.value) return;

    isSubmitting.value = true;

    try {
      debugPrint('[PASSWORD] reset password email=$email');

      final result = await api.resetPassword(
        email: email,
        password: passwordController.text,
      );

      result.when(
        ok: (_) {
          // Remove the entire recovery stack. A successful reset should
          // never allow the user to navigate back into a stale OTP state.
          Get.offAllNamed(Routes.passwordUpdated);
        },
        err: (failure) {
          debugPrint(
            '[PASSWORD] reset failed status=${failure.status} '
            'detail=${failure.detail}',
          );
        },
      );
    } finally {
      isSubmitting.value = false;
    }
  }

  void cancel() => Get.offAllNamed(Routes.signIn);
}
