
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/network/savvi_api.dart';
import '../../core/routing/app_router.dart';
import '../../l10n/app_localizations.dart';
import '../../shared/patterns/error_text.dart';
import '../../shared/patterns/feedback.dart';

class NewPasswordController extends GetxController {
  NewPasswordController({
    required this.api,
    required this.email,
    this.fromSecurity = false,
  });

  final SavviApi api;
  final String email;

  /// True when opened from Settings → Security & Password by a signed-in
  /// member. Same form, but success/cancel return to Settings instead of
  /// tearing down the stack to the recovery-complete / sign-in screens.
  final bool fromSecurity;

  final formKey = GlobalKey<FormState>();
  final oldPasswordController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();

  final RxBool isSubmitting = false.obs;
  final RxBool showBanner = false.obs;

  @override
  void onClose() {
    oldPasswordController.dispose();
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
      final result = fromSecurity
          ? await api.changePassword(
              oldPassword: oldPasswordController.text,
              newPassword: passwordController.text,
            )
          : await api.resetPassword(
              email: email,
              password: passwordController.text,
            );

      result.when(
        ok: (_) {
          if (fromSecurity) {
            SavFeedback.toast(
              context,
              l.passwordUpdatedTitle,
              tone: FeedbackTone.success,
            );
            Get.back();
            return;
          }
          // Remove the entire recovery stack. A successful reset should
          // never allow the user to navigate back into a stale OTP state.
          Get.offAllNamed(Routes.passwordUpdated);
        },
        err: (failure) {
          debugPrint(
            '[PASSWORD] reset failed status=${failure.status} '
            'detail=${failure.detail}',
          );
          if (context.mounted) {
            SavFeedback.toast(
              context,
              errText(l, failure.messageKey),
              tone: FeedbackTone.error,
            );
          }
        },
      );
    } finally {
      isSubmitting.value = false;
    }
  }

  void cancel() =>
      fromSecurity ? Get.back() : Get.offAllNamed(Routes.signIn);
}
