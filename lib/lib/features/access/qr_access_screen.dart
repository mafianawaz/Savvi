import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

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
/// QR access. The scan/verify FLOW and its result states are fully built here
/// and run against the backend verifyQr contract. The actual camera capture is
/// wired during device setup (like Firebase and fonts) — until then the member
/// can enter the code beneath the QR code manually, which exercises the exact
/// same verification path. Nothing about validity is decided on-device.
// class QrAccessScreen extends ConsumerStatefulWidget {
//   const QrAccessScreen({super.key});
//
//   @override
//   ConsumerState<QrAccessScreen> createState() => _QrAccessScreenState();
// }
//
// class _QrAccessScreenState extends ConsumerState<QrAccessScreen> {
//   final _code = TextEditingController();
//
//   @override
//   void dispose() {
//     _code.dispose();
//     super.dispose();
//   }
//
//   Future<void> _verify(String token) async {
//     final l = AppLocalizations.of(context);
//     if (token.trim().isEmpty) {
//       SavFeedback.toast(context, l.accessErrEmpty, tone: FeedbackTone.warning);
//       return;
//     }
//     final grant = await ref.read(accessControllerProvider.notifier).verifyQr(token);
//     if (!mounted) return;
//     if (grant.verified) {
//       context.push(Routes.signUp);
//     } else {
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
//     final verifying = ref.watch(accessControllerProvider).isLoading;
//
//     return AuthScaffold(
//       title: l.qrTitle,
//       subtitle: l.qrSubtitle,
//       children: [
//         // Camera viewfinder placeholder (scanner attached at device setup).
//         AspectRatio(
//           aspectRatio: 1,
//           child: Container(
//             decoration: BoxDecoration(
//               color: SavColors.navy,
//               borderRadius: SavRadius.card,
//             ),
//             child: Stack(
//               alignment: Alignment.center,
//               children: [
//                 const Icon(Icons.qr_code_scanner,
//                     size: 64, color: Colors.white24),
//                 Positioned(
//                   bottom: SavSpace.x12,
//                   left: SavSpace.x12,
//                   right: SavSpace.x12,
//                   child: Text(l.qrCameraStaged,
//                       textAlign: TextAlign.center,
//                       style: const TextStyle(
//                           fontFamily: SavFonts.sans,
//                           fontSize: 11.5,
//                           height: 1.4,
//                           fontWeight: FontWeight.w500,
//                           color: Colors.white70)),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         const SizedBox(height: SavSpace.x16),
//         SavButton(
//           label: l.qrScanBtn,
//           variant: SavButtonVariant.ghost,
//           icon: Icons.photo_camera_outlined,
//           // Camera opens once the scanner package is wired at device setup.
//           onPressed: null,
//         ),
//         const SizedBox(height: SavSpace.x20),
//         SavField(
//           label: l.qrEnterLabel,
//           controller: _code,
//           hint: 'SVVI-2026-XXXX',
//         ),
//         const SizedBox(height: SavSpace.x14),
//         SavButton(
//           label: l.accessVerifyBtn,
//           busy: verifying,
//           onPressed: () => _verify(_code.text),
//         ),
//       ],
//     );
//   }
// }


/// GetX

import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// QR access.
///
/// The scan/verify FLOW and its result states are fully built here and run
/// against the backend verifyQr contract.
///
/// The actual camera capture is wired during device setup (like Firebase and
/// fonts). Until then the member can enter the QR code manually, which
/// exercises the exact same verification path.
// class QrAccessScreen extends StatefulWidget {
//   const QrAccessScreen({super.key});
//
//   @override
//   State<QrAccessScreen> createState() => _QrAccessScreenState();
// }
//
// class _QrAccessScreenState extends State<QrAccessScreen> {
//   final _code = TextEditingController();
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
//     _code.dispose();
//     super.dispose();
//   }
//
//   Future<void> _verify(String token) async {
//     final l = AppLocalizations.of(context);
//
//     if (token.trim().isEmpty) {
//       SavFeedback.toast(
//         context,
//         l.accessErrEmpty,
//         tone: FeedbackTone.warning,
//       );
//       return;
//     }
//
//     final grant = await accessController.verifyQr(token);
//
//     if (!mounted) return;
//
//     if (grant.verified) {
//       Get.offNamed(Routes.signUp);
//     } else {
//       SavFeedback.toast(
//         context,
//         _stateErr(l, grant.state),
//         tone: FeedbackTone.error,
//       );
//     }
//   }
//
//   String _stateErr(
//       AppLocalizations l,
//       AccessState state,
//       ) {
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
//
//       return AuthScaffold(
//         title: l.qrTitle,
//         subtitle: l.qrSubtitle,
//         children: [
//           /// Camera placeholder
//           AspectRatio(
//             aspectRatio: 1,
//             child: Container(
//               decoration: BoxDecoration(
//                 color: SavColors.navy,
//                 borderRadius: SavRadius.card,
//               ),
//               child: Stack(
//                 alignment: Alignment.center,
//                 children: [
//                   const Icon(
//                     Icons.qr_code_scanner,
//                     size: 64,
//                     color: Colors.white24,
//                   ),
//                   Positioned(
//                     left: SavSpace.x12,
//                     right: SavSpace.x12,
//                     bottom: SavSpace.x12,
//                     child: Text(
//                       l.qrCameraStaged,
//                       textAlign: TextAlign.center,
//                       style: const TextStyle(
//                         fontFamily: SavFonts.sans,
//                         fontSize: 11.5,
//                         height: 1.4,
//                         fontWeight: FontWeight.w500,
//                         color: Colors.white70,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//
//           const SizedBox(height: SavSpace.x16),
//
//           SavButton(
//             label: l.qrScanBtn,
//             variant: SavButtonVariant.ghost,
//             icon: Icons.photo_camera_outlined,
//
//             // Camera implementation will be added later.
//             onPressed: null,
//           ),
//
//           const SizedBox(height: SavSpace.x20),
//
//           SavField(
//             label: l.qrEnterLabel,
//             controller: _code,
//             hint: 'SVVI-2026-XXXX',
//           ),
//
//           const SizedBox(height: SavSpace.x14),
//
//           SavButton(
//             label: l.accessVerifyBtn,
//             busy: verifying,
//             onPressed: () => _verify(
//               _code.text,
//             ),
//           ),
//         ],
//       );
//     });
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QrAccessScreen extends StatelessWidget {
  QrAccessScreen({super.key});

  final AccessController controller = Get.find<AccessController>();

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);

    return Obx(
          () => AuthScaffold(
        title: l.qrTitle,
        subtitle: l.qrSubtitle,
        children: [
          /// Camera Placeholder
          AspectRatio(
            aspectRatio: 1,
            child: Container(
              decoration: const BoxDecoration(
                color: SavColors.navy,
                borderRadius: SavRadius.card,
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  const Icon(
                    Icons.qr_code_scanner,
                    size: 64,
                    color: Colors.white24,
                  ),
                  Positioned(
                    left: SavSpace.x12,
                    right: SavSpace.x12,
                    bottom: SavSpace.x12,
                    child: Text(
                      l.qrCameraStaged,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontFamily: SavFonts.sans,
                        fontSize: 11.5,
                        height: 1.4,
                        fontWeight: FontWeight.w500,
                        color: Colors.white70,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: SavSpace.x16),

          SavButton(
            label: l.qrScanBtn,
            variant: SavButtonVariant.ghost,
            icon: Icons.photo_camera_outlined,

            /// Camera implementation later
            onPressed: null,
          ),

          const SizedBox(height: SavSpace.x20),

          SavField(
            label: l.qrEnterLabel,
            controller: controller.qrCodeController,
            hint: 'SVVI-2026-XXXX',
          ),

          const SizedBox(height: SavSpace.x14),

          SavButton(
            label: l.accessVerifyBtn,
            busy: controller.isLoading.value,
            onPressed: () => controller.verifyQr(context),
          ),
        ],
      ),
    );
  }
}