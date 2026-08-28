
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../core/theme/tokens.dart';
import '../../l10n/app_localizations.dart';
import '../../shared/widgets/sav_button.dart';
import '../../shared/widgets/sav_inputs.dart';
import 'forgot_password_controller.dart';

class CheckInboxScreen extends StatelessWidget {
  const CheckInboxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final email = Get.arguments as String? ?? '';

    return GetBuilder<ForgotPasswordController>(
      init: ForgotPasswordController(api: Get.find()),
      builder: (controller) {
        return Scaffold(
          backgroundColor: SavColors.page,
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: SavSpace.x24,
                vertical: SavSpace.x24,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
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
                  SavField(
                    label: 'Verification code',
                    controller: controller.otpController,
                    hint: 'Enter the code from your email',
                    keyboardType: TextInputType.number,
                    inputFormatters:  [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(8),
                    ],
                  ),
                  const SizedBox(height: SavSpace.x16),
                  Obx(
                    () => SavButton(
                      label: 'Verify code',
                      busy: controller.isSubmitting.value,
                      onPressed: () => controller.verifyOtp(context, email),
                    ),
                  ),
                  const SizedBox(height: SavSpace.x10),
                  Obx(
                    () {
                      final cooldown = controller.resendCooldown.value;

                      return SavButton(
                        label: cooldown > 0
                            ? l.resendInSeconds(cooldown)
                            : l.resendLink,
                        variant: SavButtonVariant.ghost,
                        busy: controller.isSubmitting.value,
                        onPressed: controller.canResend
                            ? () => controller.resendLink(context, email)
                            : null,
                      );
                    },
                  ),
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
