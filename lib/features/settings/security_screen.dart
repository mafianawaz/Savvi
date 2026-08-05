import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/state/providers.dart';
import '../../core/theme/tokens.dart';
import '../../l10n/app_localizations.dart';
import '../../shared/patterns/feedback.dart';
import '../../shared/widgets/sav_button.dart';
import '../../shared/widgets/sav_cards.dart';
import '../../shared/widgets/sav_inputs.dart';
import '../auth/auth_controller.dart';

/// Security & password. The member can request a password reset link; the reset
/// itself is handled by the auth provider (Firebase Auth in production). The app
/// only calls the auth service and shows the result — no custom password storage,
/// no auth internals, no SMS reset.
// class SecurityScreen extends ConsumerStatefulWidget {
//   const SecurityScreen({super.key});
//
//   @override
//   ConsumerState<SecurityScreen> createState() => _SecurityScreenState();
// }
//
// class _SecurityScreenState extends ConsumerState<SecurityScreen> {
//   bool _sending = false;
//   bool _sent = false;
//
//   String get _email {
//     final auth = ref.read(authControllerProvider);
//     return auth is AuthSignedIn ? (auth.profile['email'] as String? ?? '') : '';
//   }
//
//   Future<void> _send() async {
//     if (_sending) return; // single-flight
//     setState(() => _sending = true);
//     final res = await ref.read(savviApiProvider).sendPasswordReset(_email);
//     if (!mounted) return;
//     res.when(
//       ok: (_) {
//         setState(() {
//           _sending = false;
//           _sent = true;
//         });
//         SavFeedback.toast(context, AppLocalizations.of(context).resetLinkSent,
//             tone: FeedbackTone.success);
//       },
//       err: (_) {
//         setState(() => _sending = false);
//         // Approved reset-specific copy (not the generic error text).
//         SavFeedback.toast(context, AppLocalizations.of(context).resetLinkError,
//             tone: FeedbackTone.error);
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final l = AppLocalizations.of(context);
//     final email = _email;
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
//         title: Text(l.sSecurity,
//             style: const TextStyle(
//                 fontFamily: SavFonts.serif, fontSize: 18, color: SavColors.navy)),
//         centerTitle: true,
//       ),
//       body: ListView(
//         padding: const EdgeInsets.fromLTRB(
//             SavSpace.x16, SavSpace.x16, SavSpace.x16, SavSpace.x24),
//         children: [
//           Text(l.securityHelper,
//               style: const TextStyle(
//                   fontFamily: SavFonts.sans,
//                   fontSize: 13,
//                   height: 1.5,
//                   fontWeight: FontWeight.w500,
//                   color: SavColors.txt3)),
//           const SizedBox(height: SavSpace.x16),
//           SavCard(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(l.resetEmailLabel,
//                     style: const TextStyle(
//                         fontFamily: SavFonts.sans,
//                         fontSize: 11,
//                         fontWeight: FontWeight.w700,
//                         letterSpacing: 0.4,
//                         color: SavColors.txt4)),
//                 const SizedBox(height: 2),
//                 Text(email.isEmpty ? '—' : email,
//                     style: const TextStyle(
//                         fontFamily: SavFonts.sans,
//                         fontSize: 15,
//                         fontWeight: FontWeight.w700,
//                         color: SavColors.navy)),
//               ],
//             ),
//           ),
//           const SizedBox(height: SavSpace.x12),
//           if (_sent) ...[
//             SavNotice(
//                 message: l.resetLinkSent,
//                 tone: NoticeTone.green,
//                 icon: Icons.mark_email_read_outlined),
//             const SizedBox(height: SavSpace.x12),
//           ],
//           SavButton(
//               label: l.sendResetLink,
//               icon: Icons.lock_reset,
//               busy: _sending,
//               onPressed: _send),
//         ],
//       ),
//     );
//   }
// }
