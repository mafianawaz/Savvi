import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/theme/tokens.dart';
import '../../l10n/app_localizations.dart';
import '../../shared/widgets/password_field.dart';
import '../../shared/widgets/sav_button.dart';
import '../../shared/widgets/sav_inputs.dart';
import 'new_password_controller.dart';
import '../../core/network/savvi_api.dart';

class NewPasswordScreen extends StatelessWidget {
  const NewPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final args = Get.arguments as Map? ?? {};
    final email = args['email'] as String? ?? '';
    return GetBuilder<NewPasswordController>(
      init: NewPasswordController(
        api: Get.find<SavviApi>(),
        email: email,
      ),
      builder: (controller) {
        return Scaffold(
          backgroundColor: SavColors.page,
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(SavSpace.x24),
              child: Form(
                key: controller.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Obx(() {
                      if (!controller.showBanner.value) return const SizedBox.shrink();
                      return Container(
                        margin: const EdgeInsets.only(bottom: SavSpace.x14),
                        padding: const EdgeInsets.symmetric(vertical: SavSpace.x10, horizontal: SavSpace.x14),
                        decoration: BoxDecoration(color: SavColors.red, borderRadius: SavRadius.field),
                        child: Text(
                          l.errFix,
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 13),
                        ),
                      );
                    }),
                    Center(
                      child: Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: SavColors.page,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: SavColors.border),
                        ),
                        alignment: Alignment.center,
                        child: const Icon(Icons.lock_outline, color: SavColors.navy),
                      ),
                    ),
                    const SizedBox(height: SavSpace.x14),
                    Text(
                      l.newPasswordTitle,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontFamily: SavFonts.serif, fontSize: 22, color: SavColors.navy),
                    ),
                    const SizedBox(height: SavSpace.x6),
                    Text(
                      l.newPasswordSubtitle,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontFamily: SavFonts.sans, fontSize: 12.5, color: SavColors.txt3, height: 1.4),
                    ),
                    const SizedBox(height: SavSpace.x20),

                    // Handles obscure toggle, live strength bar, and the 4
                    // requirement chips already — no need to rebuild any of that.
                    PasswordField(
                      controller: controller.passwordController,
                      label: l.fieldNewPassword,
                    ),

                    const SizedBox(height: SavSpace.x16),
                    SavField(
                      label: l.fieldConfirmPassword,
                      required: true,
                      controller: controller.confirmController,
                      hint: l.hintReenterPassword,
                      obscure: true,
                      validator: (v) => controller.confirmValidator(v, l),
                    ),

                    const SizedBox(height: SavSpace.x20),
                    Obx(
                          () => SavButton(
                        label: l.updatePasswordBtn,
                        busy: controller.isSubmitting.value,
                        onPressed: () => controller.updatePassword(context),
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