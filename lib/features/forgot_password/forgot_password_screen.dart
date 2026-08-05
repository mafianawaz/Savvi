import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/network/savvi_api.dart';
import '../../core/theme/tokens.dart';
import '../../core/utils/validators.dart';
import '../../l10n/app_localizations.dart';
import '../../shared/widgets/sav_button.dart';
import '../../shared/widgets/sav_inputs.dart';
import 'forgot_password_controller.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);

    return GetBuilder<ForgotPasswordController>(
      init: ForgotPasswordController(api: Get.find<SavviApi>()),
      builder: (controller) {
        return Scaffold(
          backgroundColor: SavColors.surface,
          appBar: AppBar(backgroundColor: SavColors.navy,),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: SavSpace.x24, vertical: SavSpace.x24),
              child: Form(
                key: controller.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(color: SavColors.navy, borderRadius: BorderRadius.circular(16)),
                        alignment: Alignment.center,
                        child: const Text(
                          'S',
                          style: TextStyle(fontFamily: SavFonts.serif, fontSize: 28, fontWeight: FontWeight.w700, color: SavColors.green),
                        ),
                      ),
                    ),
                    const SizedBox(height: SavSpace.x20),
                    Text(
                      l.resetPasswordTitle,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontFamily: SavFonts.serif, fontSize: 24, color: SavColors.navy, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: SavSpace.x6),
                    Text(
                      l.resetPasswordSubtitle,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontFamily: SavFonts.sans, fontSize: 13.5, color: SavColors.txt3),
                    ),
                    const SizedBox(height: SavSpace.x24),
                    SavField(
                      label: l.fieldEmail,
                      required: true,
                      controller: controller.emailController,
                      hint: l.hintEmail,
                      keyboardType: TextInputType.emailAddress,
                      autofillHints: const [AutofillHints.email],
                      validator: Validators.email(l),
                    ),
                    const SizedBox(height: SavSpace.x20),
                    Obx(
                          () => SavButton(
                        label: l.sendResetLinkBtn,
                        busy: controller.isSubmitting.value,
                        onPressed: () => controller.sendResetLink(context),
                      ),
                    ),
                    const SizedBox(height: SavSpace.x10),
                    SavButton(
                      label: l.actionCancel,
                      variant: SavButtonVariant.ghost,
                      onPressed: controller.cancel,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}