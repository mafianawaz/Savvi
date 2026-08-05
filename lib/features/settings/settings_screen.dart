import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/localization/locale_controller.dart';
import '../../core/routing/app_router.dart';
import '../../core/state/shell_nav.dart';
import '../../core/theme/tokens.dart';
import '../../l10n/app_localizations.dart';
import '../../l10n/app_localizations_en.dart';
import '../../l10n/app_localizations_es.dart';
import '../../shared/patterns/feedback.dart';
import '../../shared/widgets/sav_button.dart';
import '../auth/auth_controller.dart';

/// Account settings: personal info, language, notification preferences, security,
/// help, and sign-out. Language is a client setting (locale controller); the
/// other rows navigate to their features.
// class SettingsScreen extends ConsumerWidget {
//   const SettingsScreen({super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final l = AppLocalizations.of(context);
//     final locale = ref.watch(localeControllerProvider);
//
//     return Scaffold(
//       backgroundColor: SavColors.page,
//       appBar: AppBar(
//         backgroundColor: SavColors.surface,
//         elevation: 0,
//         scrolledUnderElevation: 0,
//         leading: IconButton(
//             icon: const Icon(Icons.arrow_back, color: SavColors.navy),
//             onPressed: () => context.pop()),
//         title: Text(l.settingsTitle,
//             style: const TextStyle(
//                 fontFamily: SavFonts.serif, fontSize: 18, color: SavColors.navy)),
//         centerTitle: true,
//       ),
//       body: ListView(
//         padding: const EdgeInsets.fromLTRB(
//             SavSpace.x16, SavSpace.x12, SavSpace.x16, SavSpace.x24),
//         children: [
//           Text(l.settingsSub,
//               style: const TextStyle(
//                   fontFamily: SavFonts.sans,
//                   fontSize: 13,
//                   fontWeight: FontWeight.w500,
//                   color: SavColors.txt3)),
//           const SizedBox(height: SavSpace.x14),
//           _linkRow(l.sPersonal, l.sPersonalDesc, Icons.person_outline, () {
//             // Personal info lives in the Profile tab (single instance).
//             ref.read(shellTabProvider.notifier).state = kTabProfile;
//             context.pop();
//           }),
//           const SizedBox(height: SavSpace.x10),
//           _languageCard(context, ref, l, locale),
//           const SizedBox(height: SavSpace.x10),
//           _linkRow(l.sNotif, l.sNotifDesc, Icons.notifications_none,
//               () => context.push(Routes.notifPrefs)),
//           const SizedBox(height: SavSpace.x10),
//           _linkRow(l.sSecurity, l.sSecurityDesc, Icons.lock_outline,
//               () => context.push(Routes.security)),
//           const SizedBox(height: SavSpace.x10),
//           _linkRow(l.sHelp, l.sHelpDesc, Icons.help_outline,
//               () => _helpSheet(context, ref, l)),
//           const SizedBox(height: SavSpace.x16),
//           SavButton(
//               label: l.signOut,
//               variant: SavButtonVariant.danger,
//               onPressed: () => _confirmSignOut(context, ref, l)),
//         ],
//       ),
//     );
//   }
//
//   Widget _linkRow(String title, String desc, IconData icon, VoidCallback onTap) {
//     return Semantics(
//       button: true,
//       label: '$title. $desc',
//       excludeSemantics: true,
//       child: Material(
//       color: SavColors.surface,
//       borderRadius: SavRadius.card,
//       child: InkWell(
//         onTap: onTap,
//         borderRadius: SavRadius.card,
//         child: Container(
//           padding: const EdgeInsets.all(SavSpace.x16),
//           decoration: BoxDecoration(
//               borderRadius: SavRadius.card,
//               border: Border.all(color: SavColors.border, width: 1.5)),
//           child: Row(
//             children: [
//               Icon(icon, size: 18, color: SavColors.navy),
//               const SizedBox(width: SavSpace.x12),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(title,
//                         style: const TextStyle(
//                             fontFamily: SavFonts.sans,
//                             fontSize: 14,
//                             fontWeight: FontWeight.w700,
//                             color: SavColors.navy)),
//                     Text(desc,
//                         style: const TextStyle(
//                             fontFamily: SavFonts.sans,
//                             fontSize: 12,
//                             fontWeight: FontWeight.w500,
//                             color: SavColors.txt3)),
//                   ],
//                 ),
//               ),
//               const Icon(Icons.chevron_right, color: SavColors.txt4),
//             ],
//           ),
//         ),
//       ),
//     ));
//   }
//
//   Widget _languageCard(
//       BuildContext context, WidgetRef ref, AppLocalizations l, Locale locale) {
//     Widget option(String label, Locale value) {
//       final on = locale.languageCode == value.languageCode;
//       return Expanded(
//         child: Semantics(
//           button: true,
//           selected: on,
//           label: label,
//           excludeSemantics: true,
//           child: InkWell(
//             onTap: on
//                 ? null
//                 : () async {
//                     await ref
//                         .read(localeControllerProvider.notifier)
//                         .setLocale(value);
//                     if (context.mounted) {
//                       // Toast in the newly selected language, not the prior one.
//                       final nl = value.languageCode == 'es'
//                           ? AppLocalizationsEs()
//                           : AppLocalizationsEn();
//                       SavFeedback.toast(context, nl.langSaved,
//                           tone: FeedbackTone.success);
//                     }
//                   },
//             borderRadius: SavRadius.field,
//             child: Container(
//               height: 48,
//               alignment: Alignment.center,
//               decoration: BoxDecoration(
//                   color: on ? SavColors.navy : SavColors.page,
//                   borderRadius: SavRadius.field,
//                   border: Border.all(
//                       color: on ? SavColors.navy : SavColors.border,
//                       width: 1.5)),
//               child: Text(label,
//                   style: TextStyle(
//                       fontFamily: SavFonts.sans,
//                       fontSize: 13.5,
//                       fontWeight: FontWeight.w700,
//                       color: on ? Colors.white : SavColors.txt2)),
//             ),
//           ),
//         ),
//       );
//     }
//
//     return Container(
//       padding: const EdgeInsets.all(SavSpace.x16),
//       decoration: BoxDecoration(
//           color: SavColors.surface,
//           borderRadius: SavRadius.card,
//           border: Border.all(color: SavColors.border, width: 1.5)),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(l.sLang,
//               style: const TextStyle(
//                   fontFamily: SavFonts.sans,
//                   fontSize: 14,
//                   fontWeight: FontWeight.w700,
//                   color: SavColors.navy)),
//           const SizedBox(height: SavSpace.x10),
//           Row(
//             children: [
//               option(l.langEnglish, SavviLocales.enUS),
//               const SizedBox(width: SavSpace.x10),
//               option(l.langSpanish, SavviLocales.esUS),
//             ],
//           ),
//           const SizedBox(height: SavSpace.x10),
//           Text(l.langHelp,
//               style: const TextStyle(
//                   fontFamily: SavFonts.sans,
//                   fontSize: 12,
//                   height: 1.45,
//                   fontWeight: FontWeight.w500,
//                   color: SavColors.txt3)),
//         ],
//       ),
//     );
//   }
//
//   void _helpSheet(BuildContext context, WidgetRef ref, AppLocalizations l) {
//     final auth = ref.read(authControllerProvider);
//     final nonprofit =
//         auth is AuthSignedIn ? (auth.profile['nonprofit'] as String? ?? '—') : '—';
//     showModalBottomSheet<void>(
//       context: context,
//       backgroundColor: SavColors.surface,
//       shape: const RoundedRectangleBorder(borderRadius: SavRadius.sheet),
//       builder: (ctx) => Padding(
//         padding: const EdgeInsets.fromLTRB(
//             SavSpace.x20, SavSpace.x20, SavSpace.x20, SavSpace.x24),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(l.sHelp,
//                 style: const TextStyle(
//                     fontFamily: SavFonts.serif,
//                     fontSize: 18,
//                     color: SavColors.navy)),
//             const SizedBox(height: SavSpace.x6),
//             Text(l.sHelpDesc,
//                 style: const TextStyle(
//                     fontFamily: SavFonts.sans,
//                     fontSize: 13,
//                     fontWeight: FontWeight.w500,
//                     color: SavColors.txt3)),
//             const SizedBox(height: SavSpace.x16),
//             Container(
//               padding: const EdgeInsets.all(SavSpace.x14),
//               decoration: BoxDecoration(
//                   color: SavColors.page, borderRadius: SavRadius.card),
//               child: Row(
//                 children: [
//                   const Icon(Icons.handshake_outlined,
//                       size: 18, color: SavColors.navy),
//                   const SizedBox(width: SavSpace.x10),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(nonprofit,
//                             style: const TextStyle(
//                                 fontFamily: SavFonts.sans,
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.w700,
//                                 color: SavColors.navy)),
//                         const SizedBox(height: 2),
//                         // Backend to expose nonprofit support phone / hours /
//                         // address; placeholder until wired (never the member's).
//                         Text(l.helpContactPlaceholder,
//                             style: const TextStyle(
//                                 fontFamily: SavFonts.sans,
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.w500,
//                                 color: SavColors.txt3)),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: SavSpace.x16),
//             SavButton(
//                 label: l.closeAction,
//                 variant: SavButtonVariant.ghost,
//                 onPressed: () => Navigator.of(ctx).pop()),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Future<void> _confirmSignOut(
//       BuildContext context, WidgetRef ref, AppLocalizations l) async {
//     final ok = await showDialog<bool>(
//       context: context,
//       builder: (ctx) => AlertDialog(
//         backgroundColor: SavColors.surface,
//         title: Text(l.signOutConfirm,
//             style: const TextStyle(
//                 fontFamily: SavFonts.serif, fontSize: 18, color: SavColors.navy)),
//         content: Text(l.signOutBody,
//             style: const TextStyle(
//                 fontFamily: SavFonts.sans, fontSize: 13.5, color: SavColors.txt2)),
//         actions: [
//           TextButton(
//               onPressed: () => Navigator.pop(ctx, false),
//               child: Text(l.cancelAction,
//                   style: const TextStyle(
//                       fontFamily: SavFonts.sans,
//                       fontWeight: FontWeight.w700,
//                       color: SavColors.navy))),
//           TextButton(
//               onPressed: () => Navigator.pop(ctx, true),
//               child: Text(l.signOut,
//                   style: const TextStyle(
//                       fontFamily: SavFonts.sans,
//                       fontWeight: FontWeight.w700,
//                       color: SavColors.red))),
//         ],
//       ),
//     );
//     if (ok == true) {
//       ref.read(authControllerProvider.notifier).signOut();
//       if (context.mounted) {
//         SavFeedback.toast(context, l.signedOut, tone: FeedbackTone.info);
//         context.go(Routes.signIn);
//       }
//     }
//   }
// }
