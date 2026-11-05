import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../core/network/savvi_api.dart';
import '../../core/theme/tokens.dart';
import '../../l10n/app_localizations.dart';
import '../../shared/widgets/sav_button.dart';
import 'verify_otp_controller.dart';

/// 6-digit OTP entry. Email arrives via route arguments (a String).
class VerifyOtpScreen extends StatelessWidget {
  const VerifyOtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final email = Get.arguments as String? ?? '';

    return GetBuilder<VerifyOtpController>(
      init: VerifyOtpController(api: Get.find<SavviApi>(), email: email),
      builder: (controller) {
        return Scaffold(
          backgroundColor: SavColors.page,
          appBar: AppBar(
            backgroundColor: SavColors.page,
            elevation: 0,
            iconTheme: const IconThemeData(color: SavColors.navy),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: SavSpace.x24,
                vertical: SavSpace.x16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        color: SavColors.greenLight,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.verified_user_outlined,
                        color: SavColors.pillGreenFg,
                        size: 30,
                      ),
                    ),
                  ),
                  const SizedBox(height: SavSpace.x20),
                  Text(
                    l.checkInboxTitle,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: SavFonts.serif,
                      fontSize: 22,
                      color: SavColors.navy,
                    ),
                  ),
                  const SizedBox(height: SavSpace.x10),
                  Text(
                    l.checkInboxBody(email),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: SavFonts.sans,
                      fontSize: 13.5,
                      height: 1.45,
                      color: SavColors.txt3,
                    ),
                  ),
                  const SizedBox(height: SavSpace.x24),
                  _OtpBoxes(controller: controller),
                  const SizedBox(height: SavSpace.x24),
                  Obx(
                    () => SavButton(
                      label: l.otpVerifyBtn,
                      busy: controller.isVerifying.value,
                      onPressed: () => controller.verify(context),
                    ),
                  ),
                  const SizedBox(height: SavSpace.x10),
                  Obx(() {
                    final cooldown = controller.resendCooldown.value;
                    return SavButton(
                      label: cooldown > 0
                          ? l.resendInSeconds(cooldown)
                          : l.resendLink,
                      variant: SavButtonVariant.ghost,
                      busy: controller.isResending.value,
                      onPressed: controller.canResend
                          ? () => controller.resend(context)
                          : null,
                    );
                  }),
                  const SizedBox(height: SavSpace.x10),
                  SavButton(
                    label: l.backToSignIn,
                    variant: SavButtonVariant.ghost,
                    onPressed: controller.backToSignIn,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

/// Six digit boxes driven by one invisible TextField, so paste, SMS/email
/// autofill and the number pad all work with a single source of truth.
class _OtpBoxes extends StatelessWidget {
  const _OtpBoxes({required this.controller});

  final VerifyOtpController controller;

  @override
  Widget build(BuildContext context) {
    const length = VerifyOtpController.otpLength;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: controller.focusNode.requestFocus,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Invisible input that actually receives the keystrokes.
          Positioned.fill(
            child: Opacity(
              opacity: 0,
              child: TextField(
                controller: controller.otpController,
                focusNode: controller.focusNode,
                autofocus: true,
                keyboardType: TextInputType.number,
                autofillHints: const [AutofillHints.oneTimeCode],
                enableInteractiveSelection: false,
                showCursor: false,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(length),
                ],
                onChanged: (v) => controller.onOtpChanged(context, v),
              ),
            ),
          ),
          IgnorePointer(
            child: ListenableBuilder(
              listenable: Listenable.merge(
                [controller.otpController, controller.focusNode],
              ),
              builder: (context, _) {
                final text = controller.otpController.text;
                final focused = controller.focusNode.hasFocus;
                return Obx(() {
                  final error = controller.hasError.value;
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(length, (i) {
                      final filled = i < text.length;
                      final active = focused &&
                          (i == text.length ||
                              (i == length - 1 && text.length == length));
                      return _OtpBox(
                        char: filled ? text[i] : '',
                        active: active,
                        error: error,
                      );
                    }),
                  );
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _OtpBox extends StatelessWidget {
  const _OtpBox({
    required this.char,
    required this.active,
    required this.error,
  });

  final String char;
  final bool active;
  final bool error;

  @override
  Widget build(BuildContext context) {
    final borderColor = error
        ? SavColors.red
        : active
            ? SavColors.navy
            : SavColors.border;

    return Container(
      width: 46,
      height: 56,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: SavColors.surface,
        borderRadius: SavRadius.field,
        border: Border.all(color: borderColor, width: active || error ? 2 : 1),
      ),
      child: Text(
        char,
        style: const TextStyle(
          fontFamily: SavFonts.sans,
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: SavColors.navy,
        ),
      ),
    );
  }
}
