import 'package:flutter/material.dart' hide Feedback;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/network/savvi_api.dart';
import '../../core/routing/app_router.dart';
import '../../core/theme/tokens.dart';
import '../../l10n/app_localizations.dart';
import '../../data/models/onboarding.dart';
import '../../shared/patterns/feedback.dart';
import '../../shared/widgets/auth_scaffold.dart';
import '../../shared/widgets/sav_button.dart';
import '../../shared/widgets/sav_inputs.dart';
import 'access_controller.dart';
/// RiverPod
/// "Verify your access" — paste an access link/code or scan a QR to prove a
/// nonprofit invited this household. The backend classifies the token; the
/// Continue button unlocks only once a verified (ok/onsite) grant comes back.
// class AccessLinkScreen extends ConsumerStatefulWidget {
//   const AccessLinkScreen({super.key});
//
//   @override
//   ConsumerState<AccessLinkScreen> createState() => _AccessLinkScreenState();
// }
//
// class _AccessLinkScreenState extends ConsumerState<AccessLinkScreen> {
//   final _input = TextEditingController();
//
//   @override
//   void dispose() {
//     _input.dispose();
//     super.dispose();
//   }
//
//   Future<void> _verify() async {
//     final l = AppLocalizations.of(context);
//     final value = _input.text.trim();
//     if (value.isEmpty) {
//       SavFeedback.toast(context, l.accessErrEmpty, tone: FeedbackTone.warning);
//       return;
//     }
//     final grant = await ref.read(accessControllerProvider.notifier).verifyLink(value);
//     if (!mounted) return;
//     if (!grant.verified) {
//       SavFeedback.toast(context, _stateErr(l, grant.state), tone: FeedbackTone.error);
//     }
//   }
//
//   String _stateErr(AppLocalizations l, AccessState s) => switch (s) {
//         AccessState.expired => l.accessErrExpired,
//         AccessState.used => l.accessErrUsed,
//         _ => l.accessErrInvalid,
//       };
//
//   @override
//   Widget build(BuildContext context) {
//     final l = AppLocalizations.of(context);
//     final async = ref.watch(accessControllerProvider);
//     final grant = async.valueOrNull;
//     final verifying = async.isLoading;
//     final verified = grant?.verified ?? false;
//
//     return AuthScaffold(
//       title: l.accessTitle,
//       subtitle: l.accessSubtitle,
//       children: [
//         SavNotice(
//           message: l.accessInviteNote,
//           tone: NoticeTone.blue,
//           icon: Icons.shield_outlined,
//         ),
//         const SizedBox(height: SavSpace.x20),
//         SavField(
//           label: l.accessPasteLabel,
//           controller: _input,
//           hint: l.accessPasteHint,
//         ),
//         const SizedBox(height: SavSpace.x14),
//         SavButton(
//           label: l.accessVerifyBtn,
//           busy: verifying,
//           onPressed: _verify,
//         ),
//         const SizedBox(height: SavSpace.x16),
//         _OrDivider(label: l.orDivider),
//         const SizedBox(height: SavSpace.x16),
//         // QR entry point (scanner wired at device-setup stage).
//         InkWell(
//           onTap: () => context.push(Routes.qrAccess),
//           borderRadius: SavRadius.card,
//           child: Container(
//             padding: const EdgeInsets.all(SavSpace.x20),
//             decoration: BoxDecoration(
//               color: SavColors.page,
//               borderRadius: SavRadius.card,
//               border: Border.all(
//                   color: SavColors.border,
//                   width: 2,
//                   style: BorderStyle.solid),
//             ),
//             child: Column(
//               children: [
//                 Container(
//                   width: 56,
//                   height: 56,
//                   decoration: BoxDecoration(
//                       color: SavColors.surface,
//                       borderRadius: SavRadius.field,
//                       border: Border.all(color: SavColors.border, width: 1.5)),
//                   child: const Icon(Icons.qr_code_2,
//                       size: 30, color: SavColors.navy),
//                 ),
//                 const SizedBox(height: SavSpace.x10),
//                 Text(l.accessScanTitle,
//                     textAlign: TextAlign.center,
//                     style: const TextStyle(
//                         fontFamily: SavFonts.sans,
//                         fontSize: 13.5,
//                         fontWeight: FontWeight.w700,
//                         color: SavColors.navy)),
//                 const SizedBox(height: 2),
//                 Text(l.accessScanSubtitle,
//                     textAlign: TextAlign.center,
//                     style: const TextStyle(
//                         fontFamily: SavFonts.sans,
//                         fontSize: 12,
//                         fontWeight: FontWeight.w500,
//                         color: SavColors.txt3)),
//               ],
//             ),
//           ),
//         ),
//         const SizedBox(height: SavSpace.x16),
//         if (verified) _verifiedNotice(l, grant!),
//         if (verified) const SizedBox(height: SavSpace.x16),
//         SavButton(
//           label: l.accessContinueBtn,
//           variant: verified ? SavButtonVariant.primary : SavButtonVariant.ghost,
//           onPressed: verified ? () => context.push(Routes.signUp) : null,
//         ),
//         if (!verified) ...[
//           const SizedBox(height: SavSpace.x8),
//           Text(l.accessContinueHint,
//               textAlign: TextAlign.center,
//               style: const TextStyle(
//                   fontFamily: SavFonts.sans,
//                   fontSize: 12,
//                   fontWeight: FontWeight.w500,
//                   color: SavColors.txt4)),
//         ],
//       ],
//     );
//   }
//
//   Widget _verifiedNotice(AppLocalizations l, AccessGrant grant) {
//     final onsite = grant.onsite;
//     return SavNotice(
//       tone: onsite ? NoticeTone.blue : NoticeTone.green,
//       icon: onsite ? Icons.shield_outlined : Icons.check_circle_outline,
//       title: onsite ? l.accessOnsiteTitle : l.accessVerifiedTitle,
//       message: onsite ? l.accessOnsiteBody : l.accessVerifiedBody,
//     );
//   }
// }
//
// class _OrDivider extends StatelessWidget {
//   const _OrDivider({required this.label});
//   final String label;
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         const Expanded(child: Divider(color: SavColors.border)),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: SavSpace.x12),
//           child: Text('— $label —',
//               style: const TextStyle(
//                   fontFamily: SavFonts.sans,
//                   fontSize: 13,
//                   fontWeight: FontWeight.w500,
//                   color: SavColors.txt3)),
//         ),
//         const Expanded(child: Divider(color: SavColors.border)),
//       ],
//     );
//   }
// }

/// GetX

import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// "Verify your access" — paste an access link/code or scan a QR to prove a
/// nonprofit invited this household.
// class AccessLinkScreen extends StatefulWidget {
//   const AccessLinkScreen({super.key});
//
//   @override
//   State<AccessLinkScreen> createState() => _AccessLinkScreenState();
// }
//
// class _AccessLinkScreenState extends State<AccessLinkScreen> {
//   final _input = TextEditingController();
//
//   late final AccessController accessController;
//
//   @override
//   void initState() {
//     super.initState();
//     accessController = Get.find<AccessController>();
//   }
//
//   @override
//   void dispose() {
//     _input.dispose();
//     super.dispose();
//   }
//
//   Future<void> _verify() async {
//     final l = AppLocalizations.of(context);
//
//     final value = _input.text.trim();
//
//     if (value.isEmpty) {
//       SavFeedback.toast(
//         context,
//         l.accessErrEmpty,
//         tone: FeedbackTone.warning,
//       );
//       return;
//     }
//
//     final grant = await accessController.verifyLink(value);
//
//     if (!mounted) return;
//
//     if (!grant.verified) {
//       SavFeedback.toast(
//         context,
//         _stateErr(l, grant.state),
//         tone: FeedbackTone.error,
//       );
//     }
//   }
//
//   String _stateErr(AppLocalizations l, AccessState state) {
//     switch (state) {
//       case AccessState.expired:
//         return l.accessErrExpired;
//
//       case AccessState.used:
//         return l.accessErrUsed;
//
//       default:
//         return l.accessErrInvalid;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final l = AppLocalizations.of(context);
//
//     return Obx(() {
//       final verifying = accessController.isLoading.value;
//       final grant = accessController.accessGrant.value;
//       final verified = grant?.verified ?? false;
//
//       return AuthScaffold(
//         title: l.accessTitle,
//         subtitle: l.accessSubtitle,
//         children: [
//           SavNotice(
//             message: l.accessInviteNote,
//             tone: NoticeTone.blue,
//             icon: Icons.shield_outlined,
//           ),
//
//           const SizedBox(height: SavSpace.x20),
//
//           SavField(
//             label: l.accessPasteLabel,
//             controller: _input,
//             hint: l.accessPasteHint,
//           ),
//
//           const SizedBox(height: SavSpace.x14),
//
//           SavButton(
//             label: l.accessVerifyBtn,
//             busy: verifying,
//             onPressed: _verify,
//           ),
//
//           const SizedBox(height: SavSpace.x16),
//
//           _OrDivider(
//             label: l.orDivider,
//           ),
//
//           const SizedBox(height: SavSpace.x16),
//
//           InkWell(
//             onTap: () => Get.toNamed(Routes.qrAccess),
//             borderRadius: SavRadius.card,
//             child: Container(
//               padding: const EdgeInsets.all(SavSpace.x20),
//               decoration: BoxDecoration(
//                 color: SavColors.page,
//                 borderRadius: SavRadius.card,
//                 border: Border.all(
//                   color: SavColors.border,
//                   width: 2,
//                 ),
//               ),
//               child: Column(
//                 children: [
//                   Container(
//                     width: 56,
//                     height: 56,
//                     decoration: BoxDecoration(
//                       color: SavColors.surface,
//                       borderRadius: SavRadius.field,
//                       border: Border.all(
//                         color: SavColors.border,
//                         width: 1.5,
//                       ),
//                     ),
//                     child: const Icon(
//                       Icons.qr_code_2,
//                       size: 30,
//                       color: SavColors.navy,
//                     ),
//                   ),
//
//                   const SizedBox(height: SavSpace.x10),
//
//                   Text(
//                     l.accessScanTitle,
//                     textAlign: TextAlign.center,
//                     style: const TextStyle(
//                       fontFamily: SavFonts.sans,
//                       fontSize: 13.5,
//                       fontWeight: FontWeight.w700,
//                       color: SavColors.navy,
//                     ),
//                   ),
//
//                   const SizedBox(height: 2),
//
//                   Text(
//                     l.accessScanSubtitle,
//                     textAlign: TextAlign.center,
//                     style: const TextStyle(
//                       fontFamily: SavFonts.sans,
//                       fontSize: 12,
//                       fontWeight: FontWeight.w500,
//                       color: SavColors.txt3,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//
//           const SizedBox(height: SavSpace.x16),
//
//           if (verified) _verifiedNotice(l, grant!),
//
//           if (verified)
//             const SizedBox(height: SavSpace.x16),
//
//           SavButton(
//             label: l.accessContinueBtn,
//             variant: verified
//                 ? SavButtonVariant.primary
//                 : SavButtonVariant.ghost,
//             onPressed: verified
//                 ? () => Get.toNamed(Routes.signUp)
//                 : null,
//           ),
//
//           if (!verified) ...[
//             const SizedBox(height: SavSpace.x8),
//             Text(
//               l.accessContinueHint,
//               textAlign: TextAlign.center,
//               style: const TextStyle(
//                 fontFamily: SavFonts.sans,
//                 fontSize: 12,
//                 fontWeight: FontWeight.w500,
//                 color: SavColors.txt4,
//               ),
//             ),
//           ],
//         ],
//       );
//     });
//   }
//
//   Widget _verifiedNotice(
//       AppLocalizations l,
//       AccessGrant grant,
//       ) {
//     final onsite = grant.onsite;
//
//     return SavNotice(
//       tone: onsite
//           ? NoticeTone.blue
//           : NoticeTone.green,
//       icon: onsite
//           ? Icons.shield_outlined
//           : Icons.check_circle_outline,
//       title: onsite
//           ? l.accessOnsiteTitle
//           : l.accessVerifiedTitle,
//       message: onsite
//           ? l.accessOnsiteBody
//           : l.accessVerifiedBody,
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

// class AccessLinkScreen extends StatelessWidget {
//   AccessLinkScreen({super.key});
//
//   final AccessController controller = Get.put(
//     AccessController(
//       api: Get.find<SavviApi>(),
//     ),
//   );
//
//   @override
//   Widget build(BuildContext context) {
//     final l = AppLocalizations.of(context);
//
//     return Obx(() {
//       final grant = controller.accessGrant.value;
//       final verified = controller.verified;
//
//       return AuthScaffold(
//         title: l.accessTitle,
//         subtitle: l.accessSubtitle,
//         children: [
//           SavNotice(
//             message: l.accessInviteNote,
//             tone: NoticeTone.blue,
//             icon: Icons.shield_outlined,
//           ),
//
//           const SizedBox(height: SavSpace.x20),
//
//           SavField(
//             label: l.accessPasteLabel,
//             controller: controller.accessCodeController,
//             hint: l.accessPasteHint,
//           ),
//
//           const SizedBox(height: SavSpace.x14),
//
//           SavButton(
//             label: l.accessVerifyBtn,
//             busy: controller.isLoading.value,
//             onPressed: () => controller.verifyAccess(context),
//           ),
//
//           const SizedBox(height: SavSpace.x16),
//
//           _OrDivider(
//             label: l.orDivider,
//           ),
//
//           const SizedBox(height: SavSpace.x16),
//
//           InkWell(
//             onTap: controller.openQrScreen,
//             borderRadius: SavRadius.card,
//             child: Container(
//               padding: const EdgeInsets.all(SavSpace.x20),
//               decoration: BoxDecoration(
//                 color: SavColors.page,
//                 borderRadius: SavRadius.card,
//                 border: Border.all(
//                   color: SavColors.border,
//                   width: 2,
//                 ),
//               ),
//               child: Column(
//                 children: [
//                   Container(
//                     width: 56,
//                     height: 56,
//                     decoration: BoxDecoration(
//                       color: SavColors.surface,
//                       borderRadius: SavRadius.field,
//                       border: Border.all(
//                         color: SavColors.border,
//                         width: 1.5,
//                       ),
//                     ),
//                     child: const Icon(
//                       Icons.qr_code_2,
//                       size: 30,
//                       color: SavColors.navy,
//                     ),
//                   ),
//
//                   const SizedBox(height: SavSpace.x10),
//
//                   Text(
//                     l.accessScanTitle,
//                     textAlign: TextAlign.center,
//                     style: const TextStyle(
//                       fontFamily: SavFonts.sans,
//                       fontSize: 13.5,
//                       fontWeight: FontWeight.w700,
//                       color: SavColors.navy,
//                     ),
//                   ),
//
//                   const SizedBox(height: 2),
//
//                   Text(
//                     l.accessScanSubtitle,
//                     textAlign: TextAlign.center,
//                     style: const TextStyle(
//                       fontFamily: SavFonts.sans,
//                       fontSize: 12,
//                       fontWeight: FontWeight.w500,
//                       color: SavColors.txt3,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//
//           const SizedBox(height: SavSpace.x16),
//
//           if (verified)
//             _VerifiedNotice(
//               grant: grant!,
//             ),
//
//           if (verified)
//             const SizedBox(height: SavSpace.x16),
//
//           SavButton(
//             label: l.accessContinueBtn,
//             variant: verified
//                 ? SavButtonVariant.primary
//                 : SavButtonVariant.ghost,
//             onPressed: verified
//                 ? controller.continueSignup
//                 : null,
//           ),
//
//           if (!verified) ...[
//             const SizedBox(height: SavSpace.x8),
//
//             Text(
//               l.accessContinueHint,
//               textAlign: TextAlign.center,
//               style: const TextStyle(
//                 fontFamily: SavFonts.sans,
//                 fontSize: 12,
//                 fontWeight: FontWeight.w500,
//                 color: SavColors.txt4,
//               ),
//             ),
//           ],
//         ],
//       );
//     });
//   }
// }
//
// class _VerifiedNotice extends StatelessWidget {
//   const _VerifiedNotice({
//     required this.grant,
//   });
//
//   final AccessGrant grant;
//
//   @override
//   Widget build(BuildContext context) {
//     final l = AppLocalizations.of(context);
//
//     return SavNotice(
//       tone: grant.onsite
//           ? NoticeTone.blue
//           : NoticeTone.green,
//       icon: grant.onsite
//           ? Icons.shield_outlined
//           : Icons.check_circle_outline,
//       title: grant.onsite
//           ? l.accessOnsiteTitle
//           : l.accessVerifiedTitle,
//       message: grant.onsite
//           ? l.accessOnsiteBody
//           : l.accessVerifiedBody,
//     );
//   }
// }
//
// class _OrDivider extends StatelessWidget {
//   const _OrDivider({
//     required this.label,
//   });
//
//   final String label;
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         const Expanded(
//           child: Divider(
//             color: SavColors.border,
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.symmetric(
//             horizontal: SavSpace.x12,
//           ),
//           child: Text(
//             '— $label —',
//             style: const TextStyle(
//               fontFamily: SavFonts.sans,
//               fontSize: 13,
//               fontWeight: FontWeight.w500,
//               color: SavColors.txt3,
//             ),
//           ),
//         ),
//         const Expanded(
//           child: Divider(
//             color: SavColors.border,
//           ),
//         ),
//       ],
//     );
//   }
// }





class AccessLinkScreen extends StatelessWidget {
  AccessLinkScreen({super.key});

  // FIX: AccessController is now registered as a permanent singleton in
  // main.dart (alongside AuthController). Re-instantiating it here with
  // Get.put would silently replace that shared instance, losing whatever
  // state SignInController.onReady() had just reset it to, and diverging
  // from the same instance QrAccessScreen reads via Get.find. Get.find
  // keeps every screen on the one shared controller.
  final AccessController controller = Get.find<AccessController>();

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);

    return Obx(() {
      final grant = controller.accessGrant.value;
      final verified = controller.verified;

      return AuthScaffold(
        title: l.accessTitle,
        subtitle: l.accessSubtitle,
        children: [
          SavNotice(
            message: l.accessInviteNote,
            tone: NoticeTone.blue,
            icon: Icons.shield_outlined,
          ),

          const SizedBox(height: SavSpace.x20),

          SavField(
            label: l.accessPasteLabel,
            controller: controller.accessCodeController,
            hint: l.accessPasteHint,
          ),

          const SizedBox(height: SavSpace.x14),

          // SavButton(
          //   label: l.accessVerifyBtn,
          //   busy: controller.isLoading.value,
          //   onPressed: () => controller.verifyAccess(context),
          // ),
          SavButton(
            label: l.accessVerifyBtn,
            busy: controller.isLoading.value,
            onPressed: () async {
              final grant = await controller.verifyAccess(context);

              if (!context.mounted) return;

              if (grant?.verified == true) {
                Get.offNamed(Routes.signUp);
              }
            },
          ),
          const SizedBox(height: SavSpace.x16),

          _OrDivider(
            label: l.orDivider,
          ),

          const SizedBox(height: SavSpace.x16),

          InkWell(
            onTap: controller.openQrScreen,
            borderRadius: SavRadius.card,
            child: Container(
              padding: const EdgeInsets.all(SavSpace.x20),
              decoration: BoxDecoration(
                color: SavColors.page,
                borderRadius: SavRadius.card,
                border: Border.all(
                  color: SavColors.border,
                  width: 2,
                ),
              ),
              child: Column(
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: SavColors.surface,
                      borderRadius: SavRadius.field,
                      border: Border.all(
                        color: SavColors.border,
                        width: 1.5,
                      ),
                    ),
                    child: const Icon(
                      Icons.qr_code_2,
                      size: 30,
                      color: SavColors.navy,
                    ),
                  ),

                  const SizedBox(height: SavSpace.x10),

                  Text(
                    l.accessScanTitle,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: SavFonts.sans,
                      fontSize: 13.5,
                      fontWeight: FontWeight.w700,
                      color: SavColors.navy,
                    ),
                  ),

                  const SizedBox(height: 2),

                  Text(
                    l.accessScanSubtitle,
                    textAlign: TextAlign.center,
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
          ),

          const SizedBox(height: SavSpace.x16),

          // if (verified)
          //   _VerifiedNotice(
          //     grant: grant!,
          //   ),
          //
          // if (verified)
          //   const SizedBox(height: SavSpace.x16),

          // SavButton(
          //   label: l.accessContinueBtn,
          //   variant: verified
          //       ? SavButtonVariant.primary
          //       : SavButtonVariant.ghost,
          //   onPressed: verified
          //       ? controller.continueSignup
          //       : null,
          // ),

          if (!verified) ...[
            const SizedBox(height: SavSpace.x8),

            Text(
              l.accessContinueHint,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: SavFonts.sans,
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: SavColors.txt4,
              ),
            ),
          ],
        ],
      );
    });
  }
}

class _VerifiedNotice extends StatelessWidget {
  const _VerifiedNotice({
    required this.grant,
  });

  final AccessGrant grant;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);

    return SavNotice(
      tone: grant.onsite
          ? NoticeTone.blue
          : NoticeTone.green,
      icon: grant.onsite
          ? Icons.shield_outlined
          : Icons.check_circle_outline,
      title: grant.onsite
          ? l.accessOnsiteTitle
          : l.accessVerifiedTitle,
      message: grant.onsite
          ? l.accessOnsiteBody
          : l.accessVerifiedBody,
    );
  }
}

class _OrDivider extends StatelessWidget {
  const _OrDivider({
    required this.label,
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Divider(
            color: SavColors.border,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: SavSpace.x12,
          ),
          child: Text(
            '— $label —',
            style: const TextStyle(
              fontFamily: SavFonts.sans,
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: SavColors.txt3,
            ),
          ),
        ),
        const Expanded(
          child: Divider(
            color: SavColors.border,
          ),
        ),
      ],
    );
  }
}
