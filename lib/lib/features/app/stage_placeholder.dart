import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/localization/locale_controller.dart';
import '../../core/theme/tokens.dart';
import '../../shared/widgets/sav_button.dart';
import '../../shared/patterns/feedback.dart';

/// Temporary destination for routes whose screens arrive in Stages 2–4.
/// It exercises the shell, theme, routing, Riverpod, and the locale switch so
/// the whole foundation is demonstrably wired before any screen exists.
/// Riverpod
// class StagePlaceholder extends ConsumerWidget {
//   const StagePlaceholder({
//     super.key,
//     required this.routeName,
//     this.stageNote = '',
//     this.param,
//   });
//
//   final String routeName;
//   final String stageNote;
//   final String? param;
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final locale = ref.watch(localeControllerProvider);
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: SavColors.navy,
//         foregroundColor: Colors.white,
//         title: Text(routeName,
//             style: const TextStyle(
//                 fontFamily: SavFonts.serif, fontSize: 19, color: Colors.white)),
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(SavSpace.x24),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               const Icon(Icons.construction, size: 34, color: SavColors.txt4),
//               const SizedBox(height: SavSpace.x12),
//               Text(
//                 routeName,
//                 style: const TextStyle(
//                     fontFamily: SavFonts.serif,
//                     fontSize: 21,
//                     color: SavColors.navy),
//               ),
//               const SizedBox(height: SavSpace.x6),
//               Text(
//                 stageNote.isEmpty
//                     ? 'Screen arrives in a later stage.'
//                     : 'Planned for $stageNote.',
//                 style: const TextStyle(
//                     fontFamily: SavFonts.sans,
//                     fontSize: 13,
//                     fontWeight: FontWeight.w500,
//                     color: SavColors.txt3),
//               ),
//               if (param != null) ...[
//                 const SizedBox(height: SavSpace.x4),
//                 Text('id: $param',
//                     style: const TextStyle(
//                         fontFamily: SavFonts.sans,
//                         fontSize: 12,
//                         color: SavColors.txt4)),
//               ],
//               const SizedBox(height: SavSpace.x20),
//               // Live proof the locale switch + Riverpod + toast all work.
//               SavButton(
//                 label:
//                     'Language: ${SavviLocales.tag(locale)} — tap to toggle',
//                 variant: SavButtonVariant.ghost,
//                 expand: false,
//                 onPressed: () {
//                   final next = locale == SavviLocales.enUS
//                       ? SavviLocales.esUS
//                       : SavviLocales.enUS;
//                   ref.read(localeControllerProvider.notifier).setLocale(next);
//                   SavFeedback.toast(context, SavviLocales.tag(next),
//                       tone: FeedbackTone.success);
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

/// GetX

import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Temporary destination for routes whose screens arrive in Stages 2–4.
/// It exercises the shell, theme, routing, GetX, and the locale switch so
/// the whole foundation is demonstrably wired before any screen exists.
class StagePlaceholder extends StatelessWidget {
  const StagePlaceholder({
    super.key,
    required this.routeName,
    this.stageNote = '',
    this.param,
  });

  final String routeName;
  final String stageNote;
  final String? param;

  @override
  Widget build(BuildContext context) {
    final localeController = Get.find<LocaleController>();

    return Obx(() {
      final locale = localeController.locale.value;

      return Scaffold(
        appBar: AppBar(
          backgroundColor: SavColors.navy,
          foregroundColor: Colors.white,
          title: Text(
            routeName,
            style: const TextStyle(
              fontFamily: SavFonts.serif,
              fontSize: 19,
              color: Colors.white,
            ),
          ),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(SavSpace.x24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.construction,
                  size: 34,
                  color: SavColors.txt4,
                ),
                const SizedBox(height: SavSpace.x12),
                Text(
                  routeName,
                  style: const TextStyle(
                    fontFamily: SavFonts.serif,
                    fontSize: 21,
                    color: SavColors.navy,
                  ),
                ),
                const SizedBox(height: SavSpace.x6),
                Text(
                  stageNote.isEmpty
                      ? 'Screen arrives in a later stage.'
                      : 'Planned for $stageNote.',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: SavFonts.sans,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: SavColors.txt3,
                  ),
                ),
                if (param != null) ...[
                  const SizedBox(height: SavSpace.x4),
                  Text(
                    'id: $param',
                    style: const TextStyle(
                      fontFamily: SavFonts.sans,
                      fontSize: 12,
                      color: SavColors.txt4,
                    ),
                  ),
                ],
                const SizedBox(height: SavSpace.x20),

                /// Live proof the locale switch + GetX + toast all work.
                SavButton(
                  label:
                  'Language: ${SavviLocales.tag(locale)} — tap to toggle',
                  variant: SavButtonVariant.ghost,
                  expand: false,
                  onPressed: () async {
                    final next = locale == SavviLocales.enUS
                        ? SavviLocales.esUS
                        : SavviLocales.enUS;

                    await localeController.setLocale(next);

                    if (context.mounted) {
                      SavFeedback.toast(
                        context,
                        SavviLocales.tag(next),
                        tone: FeedbackTone.success,
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}