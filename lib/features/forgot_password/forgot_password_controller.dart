
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../core/network/savvi_api.dart';
import '../../core/routing/app_router.dart';
import '../../l10n/app_localizations.dart';
import '../../shared/patterns/feedback.dart';

class ForgotPasswordController extends GetxController {
  ForgotPasswordController({required this.api});

  final SavviApi api;

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final otpController = TextEditingController();

  final RxBool isSubmitting = false.obs;
  final RxInt resendCooldown = 0.obs;
  Timer? _cooldownTimer;

  String get email => emailController.text.trim();

  bool get canResend => resendCooldown.value == 0 && !isSubmitting.value;

  @override
  void onClose() {
    emailController.dispose();
    otpController.dispose();
    _cooldownTimer?.cancel();
    super.onClose();
  }

  Future<void> sendResetLink(BuildContext context) async {
    final l = AppLocalizations.of(context);

    if (!(formKey.currentState?.validate() ?? false)) return;
    if (isSubmitting.value) return;

    final targetEmail = email;
    if (targetEmail.isEmpty) return;

    await _requestOtp(context, targetEmail, navigate: true, l: l);
  }

  Future<void> resendLink(BuildContext context, String targetEmail) async {
    final l = AppLocalizations.of(context);

    if (!canResend) return;

    await _requestOtp(
      context,
      targetEmail.trim(),
      navigate: false,
      l: l,
    );
  }

  Future<void> _requestOtp(
    BuildContext context,
    String targetEmail, {
    required bool navigate,
    required AppLocalizations l,
  }) async {
    isSubmitting.value = true;

    try {
      debugPrint('[PASSWORD] request OTP email=$targetEmail');

      final result = await api.sendPasswordReset(targetEmail);

      result.when(
        ok: (_) {
          _startCooldown();

          if (navigate) {
            Get.toNamed(
              Routes.checkInbox,
              arguments: targetEmail,
            );
          }
        },
        err: (failure) {
          debugPrint(
            '[PASSWORD] request OTP failed status=${failure.status} '
            'detail=${failure.detail}',
          );
        },
      );
    } finally {
      isSubmitting.value = false;
    }
  }

  Future<void> verifyOtp(BuildContext context, String targetEmail) async {
    final l = AppLocalizations.of(context);

    if (isSubmitting.value) return;

    final raw = otpController.text.trim();
    final otp = int.tryParse(raw);

    if (otp == null || raw.length < 4) {
      SavFeedback.toast(
        context,
        'Enter the verification code.',
        tone: FeedbackTone.warning,
      );
      return;
    }

    isSubmitting.value = true;

    try {
      debugPrint('[PASSWORD] verify OTP email=$targetEmail otpLength=${raw.length}');

      final result = await api.verifyPasswordResetOtp(
        email: targetEmail.trim(),
        otp: otp,
      );

      result.when(
        ok: (data) {
          if (data['valid'] == false || data['verified'] == false) {
            SavFeedback.toast(
              context,
              'The verification code is invalid or expired.',
              tone: FeedbackTone.error,
            );
            return;
          }

          Get.toNamed(
            Routes.newPassword,
            arguments: {'email': targetEmail.trim()},
          );
        },
        err: (failure) {
          debugPrint(
            '[PASSWORD] verify OTP failed status=${failure.status} '
            'detail=${failure.detail}',
          );
        },
      );
    } finally {
      isSubmitting.value = false;
    }
  }

  void _startCooldown([int seconds = 60]) {
    resendCooldown.value = seconds;
    _cooldownTimer?.cancel();

    _cooldownTimer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (resendCooldown.value <= 1) {
          resendCooldown.value = 0;
          timer.cancel();
        } else {
          resendCooldown.value--;
        }
      },
    );
  }

  void backToSignIn() => Get.offAllNamed(Routes.signIn);
  void cancel() => Get.back();
}
