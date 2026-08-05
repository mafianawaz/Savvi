import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/localization/locale_controller.dart';
import '../../core/routing/app_router.dart';
import '../../core/theme/tokens.dart';
import '../../core/utils/validators.dart';
import '../../l10n/app_localizations.dart';
import '../../shared/patterns/error_text.dart';
import '../../shared/patterns/feedback.dart';
import '../../shared/widgets/sav_button.dart';
import '../../shared/widgets/sav_inputs.dart';
import '../access/access_controller.dart';
import '../onboarding/profile_controller.dart';
import '../profile/profile_controller.dart';
import 'auth_controller.dart';

/// RiverPod
/// Sign-in entry screen. Returning members sign in with email + password; new
/// members are routed to the nonprofit access-link flow. Firebase Auth is wired
/// in a later stage; the auth controller currently drives the flow via the
/// mock session call so navigation and states are real.
// class SignInScreen extends ConsumerStatefulWidget {
//   const SignInScreen({super.key});
//
//   @override
//   ConsumerState<SignInScreen> createState() => _SignInScreenState();
// }
//
// class _SignInScreenState extends ConsumerState<SignInScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _email = TextEditingController();
//   final _password = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//     // Landing on sign-in is the entry point; clear any in-progress onboarding
//     // state so a prior, abandoned attempt can't leave a stale verified grant.
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       if (!mounted) return;
//       ref.read(accessControllerProvider.notifier).reset();
//       ref.read(profileControllerProvider.notifier).reset();
//     });
//   }
//
//   @override
//   void dispose() {
//     _email.dispose();
//     _password.dispose();
//     super.dispose();
//   }
//
//   Future<void> _signIn() async {
//     final l = AppLocalizations.of(context);
//     if (!_formKey.currentState!.validate()) return;
//     final result = await ref.read(authControllerProvider.notifier).signIn(
//           email: _email.text,
//           password: _password.text,
//         );
//     if (!mounted) return;
//     switch (result) {
//       case AuthSignedIn():
//         context.go(Routes.home);
//       case AuthFailed(:final messageKey):
//         SavFeedback.toast(context, errText(l, messageKey),
//             tone: FeedbackTone.error);
//       default:
//         break;
//     }
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     final l = AppLocalizations.of(context);
//     final auth = ref.watch(authControllerProvider);
//     final busy = auth is AuthBusy;
//
//     return Scaffold(
//       backgroundColor: SavColors.surface,
//       body: Column(
//         children: [
//           // Brand header
//           Container(
//             width: double.infinity,
//             color: SavColors.navy,
//             padding: EdgeInsets.fromLTRB(SavSpace.x24,
//                 MediaQuery.of(context).padding.top + SavSpace.x16, SavSpace.x24, SavSpace.x14),
//             child: Image.asset(SavImages.banner),
//           ),
//           Expanded(
//             child: SingleChildScrollView(
//               padding: const EdgeInsets.fromLTRB(
//                   SavSpace.x24, SavSpace.x24, SavSpace.x24, SavSpace.x24),
//               child: Form(
//                 key: _formKey,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: [
//                     Text(l.signInTagline,
//                         textAlign: TextAlign.center,
//                         style: const TextStyle(
//                             fontFamily: SavFonts.serif,
//                             fontSize: 24,
//                             height: 1.25,
//                             color: SavColors.navy)),
//                     const SizedBox(height: SavSpace.x6),
//                     Text(l.signInSubtitle,
//                         textAlign: TextAlign.center,
//                         style: const TextStyle(
//                             fontFamily: SavFonts.sans,
//                             fontSize: 13,
//                             height: 1.45,
//                             fontWeight: FontWeight.w500,
//                             color: SavColors.txt3)),
//                     const SizedBox(height: SavSpace.x24),
//                     SavField(
//                       label: l.fieldEmail,
//                       controller: _email,
//                       hint: l.hintEmail,
//                       keyboardType: TextInputType.emailAddress,
//                       autofillHints: const [AutofillHints.email],
//                       validator: Validators.email(l),
//                     ),
//                     const SizedBox(height: SavSpace.x14),
//                     SavField(
//                       label: l.fieldPassword,
//                       controller: _password,
//                       hint: l.hintPassword,
//                       obscure: true,
//                       autofillHints: const [AutofillHints.password],
//                       validator: Validators.required(l),
//                     ),
//                     const SizedBox(height: SavSpace.x10),
//                     Align(
//                       alignment: Alignment.centerRight,
//                       child: TextButton(
//                         onPressed: () {},
//                         child: Text(l.forgotPassword,
//                             style: const TextStyle(
//                                 fontFamily: SavFonts.sans,
//                                 fontSize: 12.5,
//                                 fontWeight: FontWeight.w700,
//                                 color: SavColors.navy)),
//                       ),
//                     ),
//                     const SizedBox(height: SavSpace.x14),
//                     SavButton(
//                       label: l.actionSignIn,
//                       busy: busy,
//                       onPressed: _signIn,
//                     ),
//                     const SizedBox(height: SavSpace.x20),
//                     // New member → access link
//                     Wrap(
//                       alignment: WrapAlignment.center,
//                       crossAxisAlignment: WrapCrossAlignment.center,
//                       children: [
//                         Text('${l.newMemberPrompt} ',
//                             style: const TextStyle(
//                                 fontFamily: SavFonts.sans,
//                                 fontSize: 13.5,
//                                 fontWeight: FontWeight.w500,
//                                 color: SavColors.txt3)),
//                         InkWell(
//                           onTap: () => context.push(Routes.accessLink),
//                           child: Text('${l.createWithAccessLink} →',
//                               style: const TextStyle(
//                                   fontFamily: SavFonts.sans,
//                                   fontSize: 13.5,
//                                   fontWeight: FontWeight.w700,
//                                   color: SavColors.navy)),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: SavSpace.x20),
//                     _LanguageToggle(),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// /// Small language switch (en-US / es-US), consistent with the app-wide locale.
// class _LanguageToggle extends ConsumerWidget {
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final locale = ref.watch(localeControllerProvider);
//     final isEn = locale == SavviLocales.enUS;
//     return Center(
//       child: TextButton.icon(
//         icon: const Icon(Icons.language, size: 16, color: SavColors.txt3),
//         label: Text(isEn ? 'English · US' : 'Español · US',
//             style: const TextStyle(
//                 fontFamily: SavFonts.sans,
//                 fontSize: 12.5,
//                 fontWeight: FontWeight.w600,
//                 color: SavColors.txt3)),
//         onPressed: () => ref
//             .read(localeControllerProvider.notifier)
//             .setLocale(isEn ? SavviLocales.esUS : SavviLocales.enUS),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Sign-in entry screen.
///
/// Returning members sign in with email + password; new members are routed to
/// the nonprofit access-link flow.
///
/// Firebase Auth is wired in a later stage; the auth controller currently
/// drives the flow via the mock session call so navigation and states are real.
// class SignInScreen extends StatefulWidget {
//   const SignInScreen({super.key});
//
//   @override
//   State<SignInScreen> createState() => _SignInScreenState();
// }
//
// class _SignInScreenState extends State<SignInScreen> {
//   final _formKey = GlobalKey<FormState>();
//
//   final _email = TextEditingController();
//   final _password = TextEditingController();
//
//   late final AuthController authController;
//   late final AccessController accessController;
//   late final EditProfileController profileController;
//   late final LocaleController localeController;
//
//   @override
//   void initState() {
//     super.initState();
//
//     authController = Get.find<AuthController>();
//     accessController = Get.find<AccessController>();
//     profileController = Get.find<EditProfileController>();
//     localeController = Get.find<LocaleController>();
//
//     /// Landing on sign-in is the entry point; clear any in-progress onboarding
//     /// state so a prior, abandoned attempt can't leave a stale verified grant.
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       if (!mounted) return;
//
//       accessController.reset();
//       profileController.refreshFromProfile();
//     });
//   }
//
//   @override
//   void dispose() {
//     _email.dispose();
//     _password.dispose();
//     super.dispose();
//   }
//
//   Future<void> _signIn() async {
//     final l = AppLocalizations.of(context);
//
//     if (!_formKey.currentState!.validate()) {
//       return;
//     }
//
//     final result = await authController.signIn(
//       email: _email.text.trim(),
//       password: _password.text,
//     );
//
//     if (!mounted) {
//       return;
//     }
//
//     switch (result) {
//       case AuthSignedIn():
//         Get.offAllNamed(Routes.home);
//
//       case AuthFailed(:final messageKey):
//         SavFeedback.toast(
//           context,
//           errText(l, messageKey),
//           tone: FeedbackTone.error,
//         );
//
//       default:
//         break;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final l = AppLocalizations.of(context);
//
//     return Obx(() {
//       final busy = authController.state.value is AuthBusy;
//
//       return Scaffold(
//         backgroundColor: SavColors.surface,
//         body: Column(
//           children: [
//             /// Brand Header
//             Container(
//               width: double.infinity,
//               color: SavColors.navy,
//               padding: EdgeInsets.fromLTRB(
//                 SavSpace.x24,
//                 MediaQuery.of(context).padding.top + SavSpace.x16,
//                 SavSpace.x24,
//                 SavSpace.x14,
//               ),
//               child: Image.asset(
//                 SavImages.banner,
//               ),
//             ),
//
//             Expanded(
//               child: SingleChildScrollView(
//                 padding: const EdgeInsets.fromLTRB(
//                   SavSpace.x24,
//                   SavSpace.x24,
//                   SavSpace.x24,
//                   SavSpace.x24,
//                 ),
//                 child: Form(
//                   key: _formKey,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: [
//                       Text(
//                         l.signInTagline,
//                         textAlign: TextAlign.center,
//                         style: const TextStyle(
//                           fontFamily: SavFonts.serif,
//                           fontSize: 24,
//                           height: 1.25,
//                           color: SavColors.navy,
//                         ),
//                       ),
//
//                       const SizedBox(height: SavSpace.x6),
//
//                       Text(
//                         l.signInSubtitle,
//                         textAlign: TextAlign.center,
//                         style: const TextStyle(
//                           fontFamily: SavFonts.sans,
//                           fontSize: 13,
//                           height: 1.45,
//                           fontWeight: FontWeight.w500,
//                           color: SavColors.txt3,
//                         ),
//                       ),
//
//                       const SizedBox(height: SavSpace.x24),
//
//                       SavField(
//                         label: l.fieldEmail,
//                         controller: _email,
//                         hint: l.hintEmail,
//                         keyboardType: TextInputType.emailAddress,
//                         autofillHints: const [
//                           AutofillHints.email,
//                         ],
//                         validator: Validators.email(l),
//                       ),
//
//                       const SizedBox(height: SavSpace.x14),
//
//                       SavField(
//                         label: l.fieldPassword,
//                         controller: _password,
//                         hint: l.hintPassword,
//                         obscure: true,
//                         autofillHints: const [
//                           AutofillHints.password,
//                         ],
//                         validator: Validators.required(l),
//                       ),
//
//                       const SizedBox(height: SavSpace.x10),
//
//                       Align(
//                         alignment: Alignment.centerRight,
//                         child: TextButton(
//                           onPressed: () {},
//                           child: Text(
//                             l.forgotPassword,
//                             style: const TextStyle(
//                               fontFamily: SavFonts.sans,
//                               fontSize: 12.5,
//                               fontWeight: FontWeight.w700,
//                               color: SavColors.navy,
//                             ),
//                           ),
//                         ),
//                       ),
//
//                       const SizedBox(height: SavSpace.x14),
//
//                       SavButton(
//                         label: l.actionSignIn,
//                         busy: busy,
//                         onPressed: _signIn,
//                       ),
//                       const SizedBox(height: SavSpace.x20),
//
//                       /// New member → Access Link
//                       Wrap(
//                         alignment: WrapAlignment.center,
//                         crossAxisAlignment: WrapCrossAlignment.center,
//                         children: [
//                           Text(
//                             '${l.newMemberPrompt} ',
//                             style: const TextStyle(
//                               fontFamily: SavFonts.sans,
//                               fontSize: 13.5,
//                               fontWeight: FontWeight.w500,
//                               color: SavColors.txt3,
//                             ),
//                           ),
//                           InkWell(
//                             onTap: () {
//                               Get.toNamed(Routes.accessLink);
//                             },
//                             child: Text(
//                               '${l.createWithAccessLink} →',
//                               style: const TextStyle(
//                                 fontFamily: SavFonts.sans,
//                                 fontSize: 13.5,
//                                 fontWeight: FontWeight.w700,
//                                 color: SavColors.navy,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//
//                       const SizedBox(height: SavSpace.x20),
//
//                       const LanguageToggle(),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       );
//     });
//   }
// }
//
// ///
// /// Small language switch (en-US / es-US),
// /// consistent with the app-wide locale.
// ///
// class LanguageToggle extends StatelessWidget {
//   const LanguageToggle({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final localeController = Get.find<LocaleController>();
//
//     return Obx(() {
//       final locale = localeController.locale.value;
//
//       final isEnglish = locale == SavviLocales.enUS;
//
//       return Center(
//         child: TextButton.icon(
//           icon: const Icon(
//             Icons.language,
//             size: 16,
//             color: SavColors.txt3,
//           ),
//           label: Text(
//             isEnglish ? 'English · US' : 'Español · US',
//             style: const TextStyle(
//               fontFamily: SavFonts.sans,
//               fontSize: 12.5,
//               fontWeight: FontWeight.w600,
//               color: SavColors.txt3,
//             ),
//           ),
//           onPressed: () {
//             localeController.setLocale(
//               isEnglish ? SavviLocales.esUS : SavviLocales.enUS,
//             );
//           },
//         ),
//       );
//     });
//   }
// }

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);

    return GetBuilder<SignInController>(
      init: SignInController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: SavColors.surface,
          body: Column(
            children: [
              /// Brand Header
              Container(
                width: double.infinity,
                color: SavColors.navy,
                padding: EdgeInsets.fromLTRB(
                  SavSpace.x24,
                  MediaQuery.of(context).padding.top + SavSpace.x16,
                  SavSpace.x24,
                  SavSpace.x14,
                ),
                child: Image.asset(SavImages.banner),
              ),

              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(
                    SavSpace.x24,
                    SavSpace.x24,
                    SavSpace.x24,
                    SavSpace.x24,
                  ),
                  child: Form(
                    key: controller.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          l.signInTagline,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontFamily: SavFonts.serif,
                            fontSize: 24,
                            height: 1.25,
                            color: SavColors.navy,
                          ),
                        ),

                        const SizedBox(height: SavSpace.x6),

                        Text(
                          l.signInSubtitle,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontFamily: SavFonts.sans,
                            fontSize: 13,
                            height: 1.45,
                            fontWeight: FontWeight.w500,
                            color: SavColors.txt3,
                          ),
                        ),

                        const SizedBox(height: SavSpace.x24),

                        SavField(
                          label: l.fieldEmail,
                          controller: controller.emailController,
                          hint: l.hintEmail,
                          keyboardType: TextInputType.emailAddress,
                          autofillHints: const [AutofillHints.email],
                          validator: Validators.email(l),
                        ),

                        const SizedBox(height: SavSpace.x14),

                        SavField(
                          label: l.fieldPassword,
                          controller: controller.passwordController,
                          hint: l.hintPassword,
                          obscure: true,
                          autofillHints: const [AutofillHints.password],
                          validator: Validators.required(l),
                        ),

                        const SizedBox(height: SavSpace.x10),

                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () => Get.toNamed(Routes.resetPassword),
                            child: Text(
                              l.forgotPassword,
                              style: const TextStyle(
                                fontFamily: SavFonts.sans,
                                fontSize: 12.5,
                                fontWeight: FontWeight.w700,
                                color: SavColors.navy,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: SavSpace.x14),

                        /// Only the button needs to react to auth-busy state.
                        Obx(
                              () => SavButton(
                            label: l.actionSignIn,
                            busy: controller.isBusy,
                            onPressed: () => controller.signIn(context),
                          ),
                        ),
                        const SizedBox(height: SavSpace.x20),

                        /// New member → Access Link
                        Wrap(
                          alignment: WrapAlignment.center,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Text(
                              '${l.newMemberPrompt} ',
                              style: const TextStyle(
                                fontFamily: SavFonts.sans,
                                fontSize: 13.5,
                                fontWeight: FontWeight.w500,
                                color: SavColors.txt3,
                              ),
                            ),
                            InkWell(
                              onTap: controller.goToAccessLink,
                              child: Text(
                                '${l.createWithAccessLink} →',
                                style: const TextStyle(
                                  fontFamily: SavFonts.sans,
                                  fontSize: 13.5,
                                  fontWeight: FontWeight.w700,
                                  color: SavColors.navy,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: SavSpace.x20),

                        const LanguageToggle(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

/// Small language switch (en-US / es-US), consistent with the app-wide locale.
/// Already logic-free — reads the controller's Rx locale directly via Obx.
class LanguageToggle extends StatelessWidget {
  const LanguageToggle({super.key});

  @override
  Widget build(BuildContext context) {
    final localeController = Get.find<LocaleController>();

    return Obx(() {
      final isEnglish = localeController.locale.value == SavviLocales.enUS;

      return Center(
        child: TextButton.icon(
          icon: const Icon(Icons.language, size: 16, color: SavColors.txt3),
          label: Text(
            isEnglish ? 'English · US' : 'Español · US',
            style: const TextStyle(
              fontFamily: SavFonts.sans,
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
              color: SavColors.txt3,
            ),
          ),
          onPressed: () {
            localeController.setLocale(
              isEnglish ? SavviLocales.esUS : SavviLocales.enUS,
            );
          },
        ),
      );
    });
  }
}