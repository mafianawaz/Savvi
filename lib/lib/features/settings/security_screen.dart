import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/network/savvi_api.dart';
import '../../core/theme/tokens.dart';
import '../../l10n/app_localizations.dart';
import '../../shared/patterns/feedback.dart';
import '../../shared/widgets/sav_button.dart';
import '../../shared/widgets/sav_cards.dart';
import '../../shared/widgets/sav_inputs.dart';
import '../auth/auth_controller.dart';
import 'security_controller.dart';

/// Security & password. The member can request a password reset link; the
/// reset itself is handled by the auth provider (Firebase Auth in
/// production). The app only calls the auth service and shows the result —
/// no custom password storage, no auth internals, no SMS reset.
class SecurityScreen extends StatelessWidget {
  const SecurityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);

    return GetBuilder<SecurityController>(
      init: SecurityController(
        api: Get.find<SavviApi>(),
        authController: Get.find<AuthController>(),
      ),
      builder: (controller) {
        return Scaffold(
          backgroundColor: SavColors.page,
          appBar: AppBar(
            backgroundColor: SavColors.surface,
            elevation: 0,
            scrolledUnderElevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: SavColors.navy),
              onPressed: Get.back,
            ),
            title: Text(
              l.sSecurity,
              style: const TextStyle(
                fontFamily: SavFonts.serif,
                fontSize: 18,
                color: SavColors.navy,
              ),
            ),
            centerTitle: true,
          ),
          body: ListView(
            padding: const EdgeInsets.fromLTRB(
              SavSpace.x16,
              SavSpace.x16,
              SavSpace.x16,
              SavSpace.x24,
            ),
            children: [
              Text(
                l.securityHelper,
                style: const TextStyle(
                  fontFamily: SavFonts.sans,
                  fontSize: 13,
                  height: 1.5,
                  fontWeight: FontWeight.w500,
                  color: SavColors.txt3,
                ),
              ),
              const SizedBox(height: SavSpace.x16),
              SavCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l.resetEmailLabel,
                      style: const TextStyle(
                        fontFamily: SavFonts.sans,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.4,
                        color: SavColors.txt4,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Obx(
                      () => Text(
                        controller.email.isEmpty ? '—' : controller.email,
                        style: const TextStyle(
                          fontFamily: SavFonts.sans,
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: SavColors.navy,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: SavSpace.x12),
              Obx(() {
                if (!controller.sent.value) return const SizedBox.shrink();

                return Padding(
                  padding: const EdgeInsets.only(bottom: SavSpace.x12),
                  child: SavNotice(
                    message: l.resetLinkSent,
                    tone: NoticeTone.green,
                    icon: Icons.mark_email_read_outlined,
                  ),
                );
              }),
              Obx(
                () => SavButton(
                  label: l.sendResetLink,
                  icon: Icons.lock_reset,
                  busy: controller.sending.value,
                  onPressed: () async {
                    final ok = await controller.sendResetLink();

                    if (!context.mounted) return;

                    SavFeedback.toast(
                      context,
                      ok ? l.resetLinkSent : l.resetLinkError,
                      tone: ok ? FeedbackTone.success : FeedbackTone.error,
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
