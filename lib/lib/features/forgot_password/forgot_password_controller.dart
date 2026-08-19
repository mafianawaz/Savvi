import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/auth/firebase_auth_gateaway.dart';
import '../../core/network/savvi_api.dart';
import '../../core/routing/app_router.dart';
import '../../l10n/app_localizations.dart';
import '../../shared/patterns/error_text.dart';
import '../../shared/patterns/feedback.dart';

/// Business logic for requesting + resending a password-reset email.
/// Backs the "Reset password" and "Check your inbox" screens.
/// Reset-request + check-inbox screens.
class ForgotPasswordController extends GetxController {
  ForgotPasswordController({required this.api});
  final SavviApi api;

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final RxBool isSubmitting = false.obs;
  final RxInt resendCooldown = 0.obs;
  Timer? _cooldownTimer;

  @override
  void onClose() {
    emailController.dispose();
    _cooldownTimer?.cancel();
    super.onClose();
  }

  bool get canResend => resendCooldown.value == 0 && !isSubmitting.value;

  Future<void> sendResetLink(BuildContext context) async {
    final l = AppLocalizations.of(context);
    if (!formKey.currentState!.validate()) return;
    if (isSubmitting.value) return;

    isSubmitting.value = true;
    final result = await api.sendPasswordReset(emailController.text.trim());
    isSubmitting.value = false;

    result.when(
      ok: (_) {
        _startCooldown();
        Get.toNamed(Routes.checkInbox, arguments: emailController.text.trim());
      },
      err: (f) => SavFeedback.toast(context, errText(l, f.messageKey), tone: FeedbackTone.error),
    );
  }

  Future<void> resendLink(BuildContext context, String email) async {
    final l = AppLocalizations.of(context);
    if (!canResend) return;

    isSubmitting.value = true;
    final result = await api.sendPasswordReset(email);
    isSubmitting.value = false;

    result.when(
      ok: (_) => _startCooldown(),
      err: (f) => SavFeedback.toast(context, errText(l, f.messageKey), tone: FeedbackTone.error),
    );
  }

  void _startCooldown([int seconds = 60]) {
    resendCooldown.value = seconds;
    _cooldownTimer?.cancel();
    _cooldownTimer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (resendCooldown.value <= 1) {
        resendCooldown.value = 0;
        t.cancel();
      } else {
        resendCooldown.value--;
      }
    });
  }

  void iHaveTheLink(String email) =>
      Get.toNamed(Routes.newPassword, arguments: {'email': email, 'oobCode': ''});
  void backToSignIn() => Get.offAllNamed(Routes.signIn);
  void cancel() => Get.back();
}

