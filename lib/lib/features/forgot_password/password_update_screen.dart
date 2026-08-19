import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/routing/app_router.dart';
import '../../core/theme/tokens.dart';
import '../../l10n/app_localizations.dart';
import '../../shared/widgets/sav_button.dart';

class PasswordUpdatedScreen extends StatelessWidget {
  const PasswordUpdatedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: SavColors.page,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: SavSpace.x24, vertical: SavSpace.x24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(color: SavColors.greenLight, borderRadius: BorderRadius.circular(16)),
                  alignment: Alignment.center,
                  child: const Icon(Icons.check, color: SavColors.pillGreenFg, size: 30),
                ),
              ),
              const SizedBox(height: SavSpace.x20),
              Text(
                l.passwordUpdatedTitle,
                textAlign: TextAlign.center,
                style: const TextStyle(fontFamily: SavFonts.serif, fontSize: 22, color: SavColors.navy),
              ),
              const SizedBox(height: SavSpace.x10),
              Text(
                l.passwordUpdatedBody,
                textAlign: TextAlign.center,
                style: const TextStyle(fontFamily: SavFonts.sans, fontSize: 13.5, height: 1.45, color: SavColors.txt3),
              ),
              const SizedBox(height: SavSpace.x24),
              SavButton(
                label: l.goToSignIn,
                onPressed: () => Get.offAllNamed(Routes.signIn),
              ),
            ],
          ),
        ),
      ),
    );
  }
}