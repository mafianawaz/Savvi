import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/tokens.dart';
import '../../l10n/app_localizations.dart';
import '../../shared/patterns/error_text.dart';
import '../../shared/patterns/feedback.dart';
import '../../shared/widgets/sav_inputs.dart';
import 'notifications_controller.dart';

/// Channel preferences. In-app is always on; push and email are member-set.
/// Toggles are optimistic with rollback and show a saving state — the UI never
/// disagrees with the backend. Channels: In-app + Push + Email only (no SMS).
// class NotifPrefsScreen extends ConsumerWidget {
//   const NotifPrefsScreen({super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final l = AppLocalizations.of(context);
//     final st = ref.watch(notifPrefsProvider);
//     final ctrl = ref.read(notifPrefsProvider.notifier);
//     final vals = st.values;
//     final saving = st.savingKey;
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
//         title: Text(l.prefsTitle,
//             style: const TextStyle(
//                 fontFamily: SavFonts.serif, fontSize: 18, color: SavColors.navy)),
//         centerTitle: true,
//       ),
//       body: ListView(
//         padding: const EdgeInsets.fromLTRB(
//             SavSpace.x16, SavSpace.x12, SavSpace.x16, SavSpace.x24),
//         children: [
//           Text(l.prefsSub,
//               style: const TextStyle(
//                   fontFamily: SavFonts.sans,
//                   fontSize: 13,
//                   fontWeight: FontWeight.w500,
//                   color: SavColors.txt3)),
//           const SizedBox(height: SavSpace.x14),
//           _row(context, l, ctrl,
//               key: 'inApp',
//               title: l.chInApp,
//               desc: l.chInAppDesc,
//               on: vals['inApp'] ?? true,
//               locked: true,
//               pending: false,
//               anySaving: saving != null),
//           const SizedBox(height: SavSpace.x10),
//           _row(context, l, ctrl,
//               key: 'push',
//               title: l.chPush,
//               desc: l.chPushDesc,
//               on: vals['push'] ?? false,
//               pending: saving == 'push',
//               anySaving: saving != null),
//           const SizedBox(height: SavSpace.x10),
//           _row(context, l, ctrl,
//               key: 'email',
//               title: l.chEmail,
//               desc: l.chEmailDesc,
//               on: vals['email'] ?? false,
//               pending: saving == 'email',
//               anySaving: saving != null),
//           const SizedBox(height: SavSpace.x14),
//           SavNotice(message: l.prefsChNote, tone: NoticeTone.neutral),
//         ],
//       ),
//     );
//   }
//
//   Widget _row(BuildContext context, AppLocalizations l,
//       NotifPrefsController ctrl,
//       {required String key,
//       required String title,
//       required String desc,
//       required bool on,
//       required bool pending,
//       required bool anySaving,
//       bool locked = false}) {
//     // Disable this row while any save is in flight (single-flight) or if locked.
//     final disabled = locked || anySaving;
//     return Opacity(
//       opacity: locked ? 0.6 : 1,
//       child: Container(
//         padding: const EdgeInsets.all(SavSpace.x16),
//         decoration: BoxDecoration(
//             color: SavColors.surface,
//             borderRadius: SavRadius.card,
//             border: Border.all(color: SavColors.border, width: 1.5)),
//         child: Row(
//           children: [
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(title,
//                       style: const TextStyle(
//                           fontFamily: SavFonts.sans,
//                           fontSize: 14,
//                           fontWeight: FontWeight.w700,
//                           color: SavColors.navy)),
//                   const SizedBox(height: 2),
//                   Text(desc,
//                       style: const TextStyle(
//                           fontFamily: SavFonts.sans,
//                           fontSize: 12,
//                           height: 1.4,
//                           fontWeight: FontWeight.w500,
//                           color: SavColors.txt3)),
//                 ],
//               ),
//             ),
//             const SizedBox(width: SavSpace.x12),
//             if (pending)
//               const SizedBox(
//                   width: 24,
//                   height: 24,
//                   child: CircularProgressIndicator(
//                       strokeWidth: 2.4, color: SavColors.greenDk))
//             else
//               Switch(
//                 value: on,
//                 activeColor: Colors.white,
//                 activeTrackColor: SavColors.green,
//                 onChanged: disabled
//                     ? null
//                     : (_) async {
//                         final r = await ctrl.toggle(key);
//                         if (context.mounted) {
//                           SavFeedback.toast(
//                               context,
//                               r.ok ? l.prefsSaved : errText(l, r.errorKey!),
//                               tone: r.ok
//                                   ? FeedbackTone.success
//                                   : FeedbackTone.error);
//                         }
//                       },
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }
class NotifPrefsScreen extends StatelessWidget {
  NotifPrefsScreen({super.key});

  final NotificationsController logic = Get.find<NotificationsController>();

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: SavColors.page,
      appBar: AppBar(
        backgroundColor: SavColors.surface,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: SavColors.navy,
          ),
          onPressed: Get.back,
        ),
        title: Text(
          l.prefsTitle,
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
            SavSpace.x12,
            SavSpace.x16,
            SavSpace.x24,
          ),
          children: [
            Text(
              l.prefsSub,
              style: const TextStyle(
                fontFamily: SavFonts.sans,
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: SavColors.txt3,
              ),
            ),

            const SizedBox(height: SavSpace.x14),

            _PreferenceTile(
              prefKey: "inApp",
              title: l.chInApp,
              description: l.chInAppDesc,
              locked: true,
            ),

            const SizedBox(height: SavSpace.x10),

            _PreferenceTile(
              prefKey: "push",
              title: l.chPush,
              description: l.chPushDesc,
            ),

            const SizedBox(height: SavSpace.x10),

            _PreferenceTile(
              prefKey: "email",
              title: l.chEmail,
              description: l.chEmailDesc,
            ),

            const SizedBox(height: SavSpace.x16),

            SavNotice(
              message: l.prefsChNote,
              tone: NoticeTone.neutral,
            ),
          ],
        )
    );
  }
}

class _PreferenceTile extends StatelessWidget {
  _PreferenceTile({
    required this.prefKey,
    required this.title,
    required this.description,
    this.locked = false,
  });

  final NotificationsController logic = Get.find<NotificationsController>();

  final String prefKey;
  final String title;
  final String description;
  final bool locked;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);

    return Obx(() {
      final value = logic.prefs[prefKey] ?? false;

      final saving =
          logic.savingKey.value == prefKey;

      final anySaving =
          logic.savingKey.value != null;

      final disabled = locked || anySaving;

      return Opacity(
        opacity: locked ? .6 : 1,
        child: Container(
          padding: const EdgeInsets.all(
            SavSpace.x16,
          ),
          decoration: BoxDecoration(
            color: SavColors.surface,
            borderRadius: SavRadius.card,
            border: Border.all(
              color: SavColors.border,
              width: 1.5,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
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
                    const SizedBox(height: 2),
                    Text(
                      description,
                      style: const TextStyle(
                        fontFamily: SavFonts.sans,
                        fontSize: 12,
                        height: 1.4,
                        fontWeight: FontWeight.w500,
                        color: SavColors.txt3,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 12),

              if (saving)
                const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                  ),
                )
              else
                Switch(
                  value: value,
                  activeColor: Colors.white,
                  activeTrackColor:
                  SavColors.green,
                  onChanged: disabled
                      ? null
                      : (_) async {
                    final result =
                    await logic.togglePreference(
                      prefKey,
                    );

                    if (!context.mounted) {
                      return;
                    }

                    SavFeedback.toast(
                      context,
                      result.ok
                          ? l.prefsSaved
                          : errText(
                        l,
                        result.errorKey!,
                      ),
                      tone: result.ok
                          ? FeedbackTone.success
                          : FeedbackTone.error,
                    );
                  },
                ),
            ],
          ),
        ),
      );
    });
  }
}