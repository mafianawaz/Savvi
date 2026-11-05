import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/network/savvi_api.dart';
import '../../core/routing/app_router.dart';
import '../../l10n/app_localizations.dart';
import '../../shared/patterns/error_text.dart';
import '../../shared/patterns/feedback.dart';

/// Step 2 of password recovery: verify the 6-digit OTP emailed to [email],
/// then hand off to the new-password screen.
class VerifyOtpController extends GetxController {
  VerifyOtpController({required this.api, required this.email});

  static const int otpLength = 6;
  static const int resendSeconds = 60;

  final SavviApi api;
  final String email;

  final otpController = TextEditingController();
  final focusNode = FocusNode();

  final RxBool isVerifying = false.obs;
  final RxBool isResending = false.obs;
  final RxBool hasError = false.obs;
  final RxInt resendCooldown = 0.obs;
  Timer? _cooldownTimer;

  bool get canResend => resendCooldown.value == 0 && !isResending.value;

  @override
  void onInit() {
    super.onInit();
    // An OTP was just sent by the previous screen.
    _startCooldown();
  }

  @override
  void onClose() {
    _cooldownTimer?.cancel();
    otpController.dispose();
    focusNode.dispose();
    super.onClose();
  }

  void onOtpChanged(BuildContext context, String value) {
    if (hasError.value) hasError.value = false;
    if (value.length == otpLength) verify(context);
  }

  Future<void> verify(BuildContext context) async {
    final l = AppLocalizations.of(context);
    if (isVerifying.value) return;

    final raw = otpController.text.trim();
    final otp = int.tryParse(raw);
    if (raw.length != otpLength || otp == null) {
      SavFeedback.toast(context, l.otpIncomplete, tone: FeedbackTone.warning);
      return;
    }

    isVerifying.value = true;
    try {
      debugPrint('[PASSWORD] verify OTP email=$email');
      final result = await api.verifyPasswordResetOtp(email: email, otp: otp);

      result.when(
        ok: (data) {
          if (data['valid'] == false || data['verified'] == false) {
            _rejectCode(context, l.otpInvalid);
            return;
          }
          Get.toNamed(Routes.newPassword, arguments: {'email': email});
        },
        err: (failure) {
          debugPrint('[PASSWORD] verify OTP failed $failure');
          final status = failure.status ?? 0;
          // 4xx (except 401) = wrong / expired code; anything else is a
          // connectivity or server problem.
          final badCode = status >= 400 && status < 500 && status != 401;
          _rejectCode(
            context,
            badCode ? l.otpInvalid : errText(l, failure.messageKey),
            clear: badCode,
          );
        },
      );
    } finally {
      isVerifying.value = false;
    }
  }

  void _rejectCode(BuildContext context, String message, {bool clear = true}) {
    hasError.value = true;
    if (clear) otpController.clear();
    if (context.mounted) {
      SavFeedback.toast(context, message, tone: FeedbackTone.error);
    }
  }

  Future<void> resend(BuildContext context) async {
    final l = AppLocalizations.of(context);
    if (!canResend) return;

    isResending.value = true;
    try {
      final result = await api.sendPasswordReset(email);
      result.when(
        ok: (_) {
          otpController.clear();
          hasError.value = false;
          _startCooldown();
          if (context.mounted) {
            SavFeedback.toast(context, l.otpResent, tone: FeedbackTone.success);
          }
        },
        err: (failure) {
          debugPrint('[PASSWORD] resend OTP failed $failure');
          if (context.mounted) {
            SavFeedback.toast(context, l.otpSendFailed,
                tone: FeedbackTone.error);
          }
        },
      );
    } finally {
      isResending.value = false;
    }
  }

  void _startCooldown([int seconds = resendSeconds]) {
    resendCooldown.value = seconds;
    _cooldownTimer?.cancel();
    _cooldownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (resendCooldown.value <= 1) {
        resendCooldown.value = 0;
        timer.cancel();
      } else {
        resendCooldown.value--;
      }
    });
  }

  void backToSignIn() => Get.offAllNamed(Routes.signIn);
}
