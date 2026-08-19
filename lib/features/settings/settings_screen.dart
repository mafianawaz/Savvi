import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/localization/locale_controller.dart';
import '../../core/routing/app_router.dart';
import '../../core/theme/tokens.dart';
import '../../l10n/app_localizations.dart';
import '../../l10n/app_localizations_en.dart';
import '../../l10n/app_localizations_es.dart';
import '../../shared/patterns/feedback.dart';
import '../../shared/widgets/sav_button.dart';
import '../auth/auth_controller.dart';

/// Account settings: personal info, language, notification preferences,
/// security, help, and sign-out. Language is a client setting (handled by
/// [LocaleController]); the other rows navigate to their own screens.
// class SettingsScreen extends StatelessWidget {
//   const SettingsScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final l = AppLocalizations.of(context);
//     final localeController = Get.find<LocaleController>();
//     final authController = Get.find<AuthController>();
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: const EdgeInsets.fromLTRB(
//             SavSpace.x16,
//             SavSpace.x14,
//             SavSpace.x16,
//             SavSpace.x4,
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 l.settingsTitle,
//                 style: const TextStyle(
//                   fontFamily: SavFonts.serif,
//                   fontSize: 21,
//                   color: SavColors.navy,
//                 ),
//               ),
//               const SizedBox(height: 2),
//               Text(
//                 l.settingsSub,
//                 style: const TextStyle(
//                   fontFamily: SavFonts.sans,
//                   fontSize: 13,
//                   fontWeight: FontWeight.w500,
//                   color: SavColors.txt3,
//                 ),
//               ),
//             ],
//           ),
//         ),
//         Expanded(
//           child: ListView(
//             padding: const EdgeInsets.fromLTRB(
//               SavSpace.x16,
//               SavSpace.x12,
//               SavSpace.x16,
//               SavSpace.x24,
//             ),
//             children: [
//               _linkRow(
//                 l.sPersonal,
//                 l.sPersonalDesc,
//                 Icons.person_outline,
//                 () => Get.toNamed(Routes.profile),
//               ),
//               const SizedBox(height: SavSpace.x10),
//               _languageCard(context, l, localeController),
//               const SizedBox(height: SavSpace.x10),
//               _linkRow(
//                 l.sNotif,
//                 l.sNotifDesc,
//                 Icons.notifications_none,
//                 () => Get.toNamed(Routes.notifPrefs),
//               ),
//               const SizedBox(height: SavSpace.x10),
//               _linkRow(
//                 l.sSecurity,
//                 l.sSecurityDesc,
//                 Icons.lock_outline,
//                 () => Get.toNamed(Routes.security),
//               ),
//               const SizedBox(height: SavSpace.x10),
//               _linkRow(
//                 l.sHelp,
//                 l.sHelpDesc,
//                 Icons.help_outline,
//                 () => _helpSheet(context, l, authController),
//               ),
//               const SizedBox(height: SavSpace.x16),
//               SavButton(
//                 label: l.signOut,
//                 variant: SavButtonVariant.danger,
//                 onPressed: () => _confirmSignOut(context, l, authController),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _linkRow(
//     String title,
//     String desc,
//     IconData icon,
//     VoidCallback onTap,
//   ) {
//     return Semantics(
//       button: true,
//       label: '$title. $desc',
//       excludeSemantics: true,
//       child: Material(
//         color: SavColors.surface,
//         borderRadius: SavRadius.card,
//         child: InkWell(
//           onTap: onTap,
//           borderRadius: SavRadius.card,
//           child: Container(
//             padding: const EdgeInsets.all(SavSpace.x16),
//             decoration: BoxDecoration(
//               borderRadius: SavRadius.card,
//               border: Border.all(color: SavColors.border, width: 1.5),
//             ),
//             child: Row(
//               children: [
//                 Icon(icon, size: 18, color: SavColors.navy),
//                 const SizedBox(width: SavSpace.x12),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         title,
//                         style: const TextStyle(
//                           fontFamily: SavFonts.sans,
//                           fontSize: 14,
//                           fontWeight: FontWeight.w700,
//                           color: SavColors.navy,
//                         ),
//                       ),
//                       Text(
//                         desc,
//                         style: const TextStyle(
//                           fontFamily: SavFonts.sans,
//                           fontSize: 12,
//                           fontWeight: FontWeight.w500,
//                           color: SavColors.txt3,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const Icon(Icons.chevron_right, color: SavColors.txt4),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _languageCard(
//     BuildContext context,
//     AppLocalizations l,
//     LocaleController localeController,
//   ) {
//     Widget option(String label, Locale value) {
//       return Obx(() {
//         final on = localeController.locale.value.languageCode ==
//             value.languageCode;
//
//         return Expanded(
//           child: Semantics(
//             button: true,
//             selected: on,
//             label: label,
//             excludeSemantics: true,
//             child: InkWell(
//               onTap: on
//                   ? null
//                   : () async {
//                       await localeController.setLocale(value);
//
//                       if (context.mounted) {
//                         // Toast in the newly selected language, not the
//                         // prior one.
//                         final nl = value.languageCode == 'es'
//                             ? AppLocalizationsEs()
//                             : AppLocalizationsEn();
//
//                         SavFeedback.toast(
//                           context,
//                           nl.langSaved,
//                           tone: FeedbackTone.success,
//                         );
//                       }
//                     },
//               borderRadius: SavRadius.field,
//               child: Container(
//                 height: 48,
//                 alignment: Alignment.center,
//                 decoration: BoxDecoration(
//                   color: on ? SavColors.navy : SavColors.page,
//                   borderRadius: SavRadius.field,
//                   border: Border.all(
//                     color: on ? SavColors.navy : SavColors.border,
//                     width: 1.5,
//                   ),
//                 ),
//                 child: Text(
//                   label,
//                   style: TextStyle(
//                     fontFamily: SavFonts.sans,
//                     fontSize: 13.5,
//                     fontWeight: FontWeight.w700,
//                     color: on ? Colors.white : SavColors.txt2,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         );
//       });
//     }
//
//     return Container(
//       padding: const EdgeInsets.all(SavSpace.x16),
//       decoration: BoxDecoration(
//         color: SavColors.surface,
//         borderRadius: SavRadius.card,
//         border: Border.all(color: SavColors.border, width: 1.5),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             l.sLang,
//             style: const TextStyle(
//               fontFamily: SavFonts.sans,
//               fontSize: 14,
//               fontWeight: FontWeight.w700,
//               color: SavColors.navy,
//             ),
//           ),
//           const SizedBox(height: SavSpace.x10),
//           Row(
//             children: [
//               option(l.langEnglish, SavviLocales.enUS),
//               const SizedBox(width: SavSpace.x10),
//               option(l.langSpanish, SavviLocales.esUS),
//             ],
//           ),
//           const SizedBox(height: SavSpace.x10),
//           Text(
//             l.langHelp,
//             style: const TextStyle(
//               fontFamily: SavFonts.sans,
//               fontSize: 12,
//               height: 1.45,
//               fontWeight: FontWeight.w500,
//               color: SavColors.txt3,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void _helpSheet(
//     BuildContext context,
//     AppLocalizations l,
//     AuthController authController,
//   ) {
//     final nonprofit = (authController.profile?['nonprofit'] as String?) ?? '—';
//
//     SavFeedback.sheet(
//       context,
//       builder: (ctx) => Padding(
//         padding: const EdgeInsets.fromLTRB(
//           SavSpace.x20,
//           SavSpace.x20,
//           SavSpace.x20,
//           SavSpace.x24,
//         ),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               l.sHelp,
//               style: const TextStyle(
//                 fontFamily: SavFonts.serif,
//                 fontSize: 18,
//                 color: SavColors.navy,
//               ),
//             ),
//             const SizedBox(height: SavSpace.x6),
//             Text(
//               l.sHelpDesc,
//               style: const TextStyle(
//                 fontFamily: SavFonts.sans,
//                 fontSize: 13,
//                 fontWeight: FontWeight.w500,
//                 color: SavColors.txt3,
//               ),
//             ),
//             const SizedBox(height: SavSpace.x16),
//             Container(
//               padding: const EdgeInsets.all(SavSpace.x14),
//               decoration: BoxDecoration(
//                 color: SavColors.page,
//                 borderRadius: SavRadius.card,
//               ),
//               child: Row(
//                 children: [
//                   const Icon(
//                     Icons.handshake_outlined,
//                     size: 18,
//                     color: SavColors.navy,
//                   ),
//                   const SizedBox(width: SavSpace.x10),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           nonprofit,
//                           style: const TextStyle(
//                             fontFamily: SavFonts.sans,
//                             fontSize: 14,
//                             fontWeight: FontWeight.w700,
//                             color: SavColors.navy,
//                           ),
//                         ),
//                         const SizedBox(height: 2),
//                         // Backend to expose nonprofit support phone / hours /
//                         // address; placeholder until wired (never the
//                         // member's own contact info).
//                         Text(
//                           l.helpContactPlaceholder,
//                           style: const TextStyle(
//                             fontFamily: SavFonts.sans,
//                             fontSize: 12,
//                             fontWeight: FontWeight.w500,
//                             color: SavColors.txt3,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: SavSpace.x16),
//             SavButton(
//               label: l.closeAction,
//               variant: SavButtonVariant.ghost,
//               onPressed: () => Navigator.of(ctx).pop(),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Future<void> _confirmSignOut(
//     BuildContext context,
//     AppLocalizations l,
//     AuthController authController,
//   ) async {
//     final ok = await SavFeedback.confirm(
//       context,
//       title: l.signOutConfirm,
//       message: l.signOutBody,
//       confirmLabel: l.signOut,
//       cancelLabel: l.cancelAction,
//       destructive: true,
//     );
//
//     if (ok) {
//       authController.signOut();
//
//       if (context.mounted) {
//         SavFeedback.toast(context, l.signedOut, tone: FeedbackTone.info);
//         Get.offAllNamed(Routes.signIn);
//       }
//     }
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/localization/locale_controller.dart';
import '../../core/routing/app_router.dart';
import '../../core/theme/tokens.dart';
import '../../l10n/app_localizations.dart';
import '../../l10n/app_localizations_en.dart';
import '../../l10n/app_localizations_es.dart';
import '../../shared/patterns/feedback.dart';
import '../../shared/widgets/sav_button.dart';
import '../auth/auth_controller.dart';

/// Account settings: personal info, language, notification preferences,
/// security, help, and sign-out. Language is a client setting (handled by
/// [LocaleController]); the other rows navigate to their own screens.
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final localeController = Get.find<LocaleController>();
    final authController = Get.find<AuthController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
            SavSpace.x16,
            SavSpace.x14,
            SavSpace.x16,
            SavSpace.x4,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l.settingsTitle,
                style: const TextStyle(
                  fontFamily: SavFonts.serif,
                  fontSize: 21,
                  color: SavColors.navy,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                l.settingsSub,
                style: const TextStyle(
                  fontFamily: SavFonts.sans,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: SavColors.txt3,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(
              SavSpace.x16,
              SavSpace.x12,
              SavSpace.x16,
              SavSpace.x24,
            ),
            children: [
              _linkRow(
                l.sPersonal,
                l.sPersonalDesc,
                Icons.person_outline,
                    () => Get.toNamed(Routes.profile),
              ),
              const SizedBox(height: SavSpace.x10),
              _languageCard(context, l, localeController),
              const SizedBox(height: SavSpace.x10),
              _linkRow(
                l.sNotif,
                l.sNotifDesc,
                Icons.notifications_none,
                    () => Get.toNamed(Routes.notifPrefs),
              ),
              const SizedBox(height: SavSpace.x10),
              _linkRow(
                l.sSecurity,
                l.sSecurityDesc,
                Icons.lock_outline,
                    () => Get.toNamed(Routes.security),
              ),
              const SizedBox(height: SavSpace.x10),
              _linkRow(
                l.sHelp,
                l.sHelpDesc,
                Icons.help_outline,
                    () => _helpSheet(context, l, authController),
              ),
              const SizedBox(height: SavSpace.x16),
              SavButton(
                label: l.signOut,
                variant: SavButtonVariant.danger,
                onPressed: () => _confirmSignOut(context, l, authController),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _linkRow(
      String title,
      String desc,
      IconData icon,
      VoidCallback onTap,
      ) {
    return Semantics(
      button: true,
      label: '$title. $desc',
      excludeSemantics: true,
      child: Material(
        color: SavColors.surface,
        borderRadius: SavRadius.card,
        child: InkWell(
          onTap: onTap,
          borderRadius: SavRadius.card,
          child: Container(
            padding: const EdgeInsets.all(SavSpace.x16),
            decoration: BoxDecoration(
              borderRadius: SavRadius.card,
              border: Border.all(color: SavColors.border, width: 1.5),
            ),
            child: Row(
              children: [
                Icon(icon, size: 18, color: SavColors.navy),
                const SizedBox(width: SavSpace.x12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontFamily: SavFonts.sans,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: SavColors.navy,
                        ),
                      ),
                      Text(
                        desc,
                        style: const TextStyle(
                          fontFamily: SavFonts.sans,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: SavColors.txt3,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right, color: SavColors.txt4),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _languageCard(
      BuildContext context,
      AppLocalizations l,
      LocaleController localeController,
      ) {
    // Language code -> display label. Keyed by code (not Locale) so the
    // dropdown's value type stays simple and equality just works.
    final options = <String, String>{
      SavviLocales.enUS.languageCode: l.langEnglish,
      SavviLocales.esUS.languageCode: l.langSpanish,
    };

    Future<void> onSelect(String? code) async {
      if (code == null) return;
      final value =
      code == 'es' ? SavviLocales.esUS : SavviLocales.enUS;

      if (localeController.locale.value.languageCode == code) return;

      await localeController.setLocale(value);

      if (context.mounted) {
        // Toast in the newly selected language, not the prior one.
        final nl = code == 'es' ? AppLocalizationsEs() : AppLocalizationsEn();

        SavFeedback.toast(
          context,
          nl.langSaved,
          tone: FeedbackTone.success,
        );
      }
    }

    return Container(
      padding: const EdgeInsets.all(SavSpace.x16),
      decoration: BoxDecoration(
        color: SavColors.surface,
        borderRadius: SavRadius.card,
        border: Border.all(color: SavColors.border, width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l.sLang,
            style: const TextStyle(
              fontFamily: SavFonts.sans,
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: SavColors.navy,
            ),
          ),
          const SizedBox(height: SavSpace.x10),
          Obx(() {
            final current = localeController.locale.value.languageCode;

            return Semantics(
              label: l.sLang,
              child: DropdownButtonFormField<String>(
                value: options.containsKey(current) ? current : null,
                icon: const Icon(Icons.keyboard_arrow_down,
                    color: SavColors.txt3),
                dropdownColor: SavColors.surface,
                borderRadius: SavRadius.field,
                style: const TextStyle(
                  fontFamily: SavFonts.sans,
                  fontSize: 13.5,
                  fontWeight: FontWeight.w700,
                  color: SavColors.navy,
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: SavColors.page,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: SavSpace.x14,
                    vertical: SavSpace.x12,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: SavRadius.field,
                    borderSide:
                    const BorderSide(color: SavColors.border, width: 1.5),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: SavRadius.field,
                    borderSide:
                    const BorderSide(color: SavColors.border, width: 1.5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: SavRadius.field,
                    borderSide:
                    const BorderSide(color: SavColors.navy, width: 1.5),
                  ),
                ),
                items: [
                  for (final entry in options.entries)
                    DropdownMenuItem(
                      value: entry.key,
                      child: Text(entry.value),
                    ),
                ],
                onChanged: onSelect,
              ),
            );
          }),
          const SizedBox(height: SavSpace.x10),
          Text(
            l.langHelp,
            style: const TextStyle(
              fontFamily: SavFonts.sans,
              fontSize: 12,
              height: 1.45,
              fontWeight: FontWeight.w500,
              color: SavColors.txt3,
            ),
          ),
        ],
      ),
    );
  }

  void _helpSheet(
      BuildContext context,
      AppLocalizations l,
      AuthController authController,
      ) {
    final nonprofit = (authController.profile?['nonprofit'] as String?) ?? '—';

    SavFeedback.sheet(
      context,
      builder: (ctx) => Padding(
        padding: const EdgeInsets.fromLTRB(
          SavSpace.x20,
          SavSpace.x20,
          SavSpace.x20,
          SavSpace.x24,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l.sHelp,
              style: const TextStyle(
                fontFamily: SavFonts.serif,
                fontSize: 18,
                color: SavColors.navy,
              ),
            ),
            const SizedBox(height: SavSpace.x6),
            Text(
              l.sHelpDesc,
              style: const TextStyle(
                fontFamily: SavFonts.sans,
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: SavColors.txt3,
              ),
            ),
            const SizedBox(height: SavSpace.x16),
            Container(
              padding: const EdgeInsets.all(SavSpace.x14),
              decoration: BoxDecoration(
                color: SavColors.page,
                borderRadius: SavRadius.card,
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.handshake_outlined,
                    size: 18,
                    color: SavColors.navy,
                  ),
                  const SizedBox(width: SavSpace.x10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          nonprofit,
                          style: const TextStyle(
                            fontFamily: SavFonts.sans,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: SavColors.navy,
                          ),
                        ),
                        const SizedBox(height: 2),
                        // Backend to expose nonprofit support phone / hours /
                        // address; placeholder until wired (never the
                        // member's own contact info).
                        Text(
                          l.helpContactPlaceholder,
                          style: const TextStyle(
                            fontFamily: SavFonts.sans,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: SavColors.txt3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: SavSpace.x16),
            SavButton(
              label: l.closeAction,
              variant: SavButtonVariant.ghost,
              onPressed: () => Navigator.of(ctx).pop(),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _confirmSignOut(
      BuildContext context,
      AppLocalizations l,
      AuthController authController,
      ) async {
    final ok = await SavFeedback.confirm(
      context,
      title: l.signOutConfirm,
      message: l.signOutBody,
      confirmLabel: l.signOut,
      cancelLabel: l.cancelAction,
      destructive: true,
    );

    if (ok) {
      authController.signOut();

      if (context.mounted) {
        SavFeedback.toast(context, l.signedOut, tone: FeedbackTone.info);
        Get.offAllNamed(Routes.signIn);
      }
    }
  }
}