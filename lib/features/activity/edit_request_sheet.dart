import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/network/savvi_api.dart';
import '../../core/routing/app_router.dart';
import '../../core/theme/tokens.dart';
import '../../data/models/enums.dart';
import '../../data/models/labels.dart';
import '../../data/models/member_request.dart';
import '../../data/models/request_status.dart';
import '../../l10n/app_localizations.dart';
import '../../shared/patterns/feedback.dart';
import '../../shared/widgets/sav_button.dart';
import '../../shared/widgets/sav_cards.dart';
import '../../shared/widgets/sav_inputs.dart';
import '../home/requests_controller.dart';

/// Edit-request bottom sheet (v56). While the request is still fully
/// editable (submitted / needs-update) the member can change categories,
/// method, and notes. Once approved, categories and method lock — the
/// sheet shows a notice instead and only contact/notes stay editable.
///
/// NOTE: Save calls [SavviApi.editRequest] and refreshes the shared
/// [RequestsController] list, matching the pattern used by cancel. The mock
/// backend doesn't persist edits (see mock_savvi_api.dart) — wiring the live
/// backend is a follow-up stage, same as elsewhere in this prototype.
// class EditRequestSheet extends StatefulWidget {
//   const EditRequestSheet({super.key, required this.request});
//
//   final MemberRequest request;
//
//   static Future<void> show(BuildContext context, MemberRequest request) {
//     return showModalBottomSheet<void>(
//       context: context,
//       isScrollControlled: true,
//       backgroundColor: SavColors.surface,
//       shape: const RoundedRectangleBorder(borderRadius: SavRadius.sheet),
//       builder: (_) => EditRequestSheet(request: request),
//     );
//   }
//
//   @override
//   State<EditRequestSheet> createState() => _EditRequestSheetState();
// }
//
// class _EditRequestSheetState extends State<EditRequestSheet> {
//   late Set<FoodCategory> _categories;
//   late RequestMethod _method;
//   late TextEditingController _notes;
//
//   String? _phone;
//   bool _saving = false;
//
//   bool get _locked => widget.request.status.edit == EditScope.limited;
//
//   @override
//   void initState() {
//     super.initState();
//     _categories = {...widget.request.categories};
//     _method = widget.request.method;
//     _notes = TextEditingController(text: widget.request.notes ?? '');
//
//     Get.find<SavviApi>().getProfile().then((res) {
//       if (!mounted) return;
//       res.when(
//         ok: (json) => setState(() => _phone = json['phone'] as String?),
//         err: (_) {},
//       );
//     });
//   }
//
//   @override
//   void dispose() {
//     _notes.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final l = AppLocalizations.of(context);
//     final r = widget.request;
//
//     return SafeArea(
//       child: Padding(
//         padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
//         child: DraggableScrollableSheet(
//           initialChildSize: 0.88,
//           minChildSize: 0.5,
//           maxChildSize: 0.95,
//           expand: false,
//           builder: (context, scrollController) => ListView(
//             controller: scrollController,
//             padding: const EdgeInsets.fromLTRB(
//                 SavSpace.x20, SavSpace.x12, SavSpace.x20, SavSpace.x24),
//             children: [
//               Center(
//                 child: Container(
//                   width: 36,
//                   height: 4,
//                   margin: const EdgeInsets.only(bottom: SavSpace.x20),
//                   decoration: BoxDecoration(
//                     color: SavColors.border,
//                     borderRadius: BorderRadius.circular(2),
//                   ),
//                 ),
//               ),
//               Text(
//                 l.editRequest,
//                 style: const TextStyle(
//                   fontFamily: SavFonts.serif,
//                   fontSize: 20,
//                   color: SavColors.navy,
//                 ),
//               ),
//               const SizedBox(height: SavSpace.x8),
//               Text(
//                 _locked ? l.editLocked : l.editLocked,
//                 style: const TextStyle(
//                   fontFamily: SavFonts.sans,
//                   fontSize: 13.5,
//                   height: 1.45,
//                   fontWeight: FontWeight.w500,
//                   color: SavColors.txt3,
//                 ),
//               ),
//               if (_locked) ...[
//                 const SizedBox(height: SavSpace.x14),
//                 SavNotice(
//                   message: l.editLocked,
//                   icon: Icons.access_time,
//                 ),
//               ] else ...[
//                 const SizedBox(height: SavSpace.x20),
//                 const _SectionLabel('CATEGORIES'),
//                 const SizedBox(height: SavSpace.x10),
//                 Wrap(
//                   spacing: SavSpace.x8,
//                   runSpacing: SavSpace.x8,
//                   children: [
//                     for (final cat in FoodCategory.values)
//                       SavChip(
//                         label: Labels.category(l, cat),
//                         selected: _categories.contains(cat),
//                         onTap: () => setState(() {
//                           if (!_categories.add(cat)) _categories.remove(cat);
//                         }),
//                       ),
//                   ],
//                 ),
//                 const SizedBox(height: SavSpace.x20),
//                 const _SectionLabel('METHOD'),
//                 const SizedBox(height: SavSpace.x10),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: _MethodToggle(
//                         label: l.methodPickup,
//                         selected: _method == RequestMethod.pickup,
//                         onTap: () =>
//                             setState(() => _method = RequestMethod.pickup),
//                       ),
//                     ),
//                     const SizedBox(width: SavSpace.x10),
//                     Expanded(
//                       child: _MethodToggle(
//                         label: l.methodDelivery,
//                         selected: _method == RequestMethod.delivery,
//                         onTap: () =>
//                             setState(() => _method = RequestMethod.delivery),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//               const SizedBox(height: SavSpace.x20),
//               _SectionLabel(l.fromProfile.toUpperCase()),
//               const SizedBox(height: SavSpace.x12),
//               SavCard(
//                 padding: const EdgeInsets.all(SavSpace.x14),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     _infoRow(l.householdSize, r.household),
//                     const Divider(height: SavSpace.x20, color: SavColors.border),
//                     _infoRow(l.fieldPhone, _phone ?? '\u2014'),
//                     const SizedBox(height: SavSpace.x14),
//                     SavButton(
//                       label: '${l.editInProfile} \u2192',
//                       variant: SavButtonVariant.ghost,
//                       onPressed: () {
//                         Get.back();
//                         Get.toNamed(Routes.profile);
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: SavSpace.x20),
//               const _SectionLabel('HOUSEHOLD SIZE'),
//               const SizedBox(height: SavSpace.x10),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(l.householdSize,
//                       style: const TextStyle(
//                           fontFamily: SavFonts.sans,
//                           fontSize: 13,
//                           fontWeight: FontWeight.w600,
//                           color: SavColors.txt3)),
//                   Text(r.household,
//                       style: const TextStyle(
//                           fontFamily: SavFonts.sans,
//                           fontSize: 14,
//                           fontWeight: FontWeight.w700,
//                           color: SavColors.navy)),
//                 ],
//               ),
//               const SizedBox(height: SavSpace.x8),
//               Text(
//                 l.householdSizeNote,
//                 style: const TextStyle(
//                   fontFamily: SavFonts.sans,
//                   fontSize: 11.5,
//                   height: 1.45,
//                   fontWeight: FontWeight.w500,
//                   color: SavColors.txt4,
//                 ),
//               ),
//               const SizedBox(height: SavSpace.x20),
//               Text(l.notesLabel,
//                   style: const TextStyle(
//                       fontFamily: SavFonts.sans,
//                       fontSize: 13,
//                       fontWeight: FontWeight.w700,
//                       color: SavColors.txt2)),
//               const SizedBox(height: SavSpace.x10),
//               TextField(
//                 controller: _notes,
//                 minLines: 3,
//                 maxLines: 3,
//                 decoration: InputDecoration(hintText: l.notesHint),
//               ),
//               const SizedBox(height: SavSpace.x24),
//               SavButton(
//                 label: l.actionSave,
//                 busy: _saving,
//                 onPressed: _saving ? null : () => _save(context, l),
//               ),
//               const SizedBox(height: SavSpace.x10),
//               SavButton(
//                 label: l.actionCancel,
//                 variant: SavButtonVariant.ghost,
//                 onPressed: () => Get.back(),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _infoRow(String label, String value) => Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(label,
//               style: const TextStyle(
//                   fontFamily: SavFonts.sans,
//                   fontSize: 13,
//                   fontWeight: FontWeight.w600,
//                   color: SavColors.txt3)),
//           Text(value,
//               style: const TextStyle(
//                   fontFamily: SavFonts.sans,
//                   fontSize: 14,
//                   fontWeight: FontWeight.w700,
//                   color: SavColors.navy)),
//         ],
//       );
//
//   Future<void> _save(BuildContext context, AppLocalizations l) async {
//     setState(() => _saving = true);
//
//     final body = <String, dynamic>{
//       'notes': _notes.text.trim(),
//       if (!_locked) 'cats': [for (final c in _categories) c.api],
//       if (!_locked) 'method': _method.api,
//     };
//
//     final result = await Get.find<SavviApi>().editRequest(widget.request.id, body);
//     if (Get.isRegistered<RequestsController>()) {
//       await Get.find<RequestsController>().refresh();
//     }
//
//     if (!mounted) return;
//     setState(() => _saving = false);
//
//     result.when(
//       ok: (_) {
//         Navigator.of(context).pop();
//         SavFeedback.toast(context, l.editRequest, tone: FeedbackTone.success);
//       },
//       err: (_) {
//         SavFeedback.toast(context, l.errUnknown, tone: FeedbackTone.error);
//       },
//     );
//   }
// }
//
// class _SectionLabel extends StatelessWidget {
//   const _SectionLabel(this.text);
//   final String text;
//
//   @override
//   Widget build(BuildContext context) => Text(
//         text,
//         style: const TextStyle(
//           fontFamily: SavFonts.sans,
//           fontSize: 11,
//           fontWeight: FontWeight.w700,
//           letterSpacing: 0.5,
//           color: SavColors.txt4,
//         ),
//       );
// }
//
// class _MethodToggle extends StatelessWidget {
//   const _MethodToggle({
//     required this.label,
//     required this.selected,
//     required this.onTap,
//   });
//
//   final String label;
//   final bool selected;
//   final VoidCallback onTap;
//
//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       color: selected ? SavColors.navy : Colors.white,
//       borderRadius: SavRadius.button,
//       child: InkWell(
//         borderRadius: SavRadius.button,
//         onTap: onTap,
//         child: Container(
//           constraints: const BoxConstraints(minHeight: SavSpace.minTouch),
//           alignment: Alignment.center,
//           decoration: BoxDecoration(
//             borderRadius: SavRadius.button,
//             border: Border.all(
//               color: selected ? SavColors.navy : SavColors.border,
//               width: 1.5,
//             ),
//           ),
//           child: Text(
//             label,
//             style: TextStyle(
//               fontFamily: SavFonts.sans,
//               fontSize: 14.5,
//               fontWeight: FontWeight.w700,
//               color: selected ? Colors.white : SavColors.txt2,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/network/savvi_api.dart';
import '../../core/routing/app_router.dart';
import '../../core/theme/tokens.dart';
import '../../data/models/enums.dart';
import '../../data/models/labels.dart';
import '../../data/models/member_request.dart';
import '../../data/models/request_status.dart';
import '../../l10n/app_localizations.dart';
import '../../shared/patterns/feedback.dart';
import '../../shared/widgets/sav_button.dart';
import '../../shared/widgets/sav_cards.dart';
import '../../shared/widgets/sav_inputs.dart';
import '../home/requests_controller.dart';

/// Edit-request bottom sheet (v56). While the request is still fully
/// editable (submitted / needs-update) the member can change categories,
/// method, and notes. Once approved, categories and method lock — the
/// sheet shows a notice instead and only contact/notes stay editable.
///
/// NOTE: Save calls [SavviApi.editRequest] and refreshes the shared
/// [RequestsController] list, matching the pattern used by cancel. The mock
/// backend doesn't persist edits (see mock_savvi_api.dart) — wiring the live
/// backend is a follow-up stage, same as elsewhere in this prototype.
class EditRequestSheet extends StatefulWidget {
  const EditRequestSheet({super.key, required this.request});

  final MemberRequest request;

  static Future<void> show(BuildContext context, MemberRequest request) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: SavColors.surface,
      shape: const RoundedRectangleBorder(borderRadius: SavRadius.sheet),
      builder: (_) => EditRequestSheet(request: request),
    );
  }

  @override
  State<EditRequestSheet> createState() => _EditRequestSheetState();
}

class _EditRequestSheetState extends State<EditRequestSheet> {
  late Set<FoodCategory> _categories;
  late RequestMethod _method;
  late TextEditingController _notes;

  String? _phone;
  bool _saving = false;

  bool get _locked => widget.request.status.edit == EditScope.limited;

  @override
  void initState() {
    super.initState();
    _categories = {...widget.request.categories};
    _method = widget.request.method;
    _notes = TextEditingController(text: widget.request.notes ?? '');

    Get.find<SavviApi>().getProfile().then((res) {
      if (!mounted) return;
      res.when(
        ok: (json) => setState(() => _phone = json['phone'] as String?),
        err: (_) {},
      );
    });
  }

  @override
  void dispose() {
    _notes.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final r = widget.request;

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: DraggableScrollableSheet(
          initialChildSize: 0.88,
          minChildSize: 0.5,
          maxChildSize: 0.95,
          expand: false,
          builder: (context, scrollController) => ListView(
            controller: scrollController,
            padding: const EdgeInsets.fromLTRB(
                SavSpace.x20, SavSpace.x12, SavSpace.x20, SavSpace.x24),
            children: [
              Center(
                child: Container(
                  width: 36,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: SavSpace.x20),
                  decoration: BoxDecoration(
                    color: SavColors.border,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              Text(
                l.editRequest,
                style: const TextStyle(
                  fontFamily: SavFonts.serif,
                  fontSize: 20,
                  color: SavColors.navy,
                ),
              ),
              const SizedBox(height: SavSpace.x8),
              Text(
                _locked ? l.editLocked : l.editRequest,
                style: const TextStyle(
                  fontFamily: SavFonts.sans,
                  fontSize: 13.5,
                  height: 1.45,
                  fontWeight: FontWeight.w500,
                  color: SavColors.txt3,
                ),
              ),
              if (_locked) ...[
                const SizedBox(height: SavSpace.x14),
                SavNotice(
                  message: l.editLocked,
                  icon: Icons.access_time,
                ),
              ] else ...[
                const SizedBox(height: SavSpace.x20),
                const _SectionLabel('CATEGORIES'),
                const SizedBox(height: SavSpace.x10),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Wrap(
                    spacing: SavSpace.x8,
                    runSpacing: SavSpace.x8,
                    children: [
                      for (final cat in FoodCategory.values)
                        SavChip(
                          label: Labels.category(l, cat),
                          selected: _categories.contains(cat),
                          onTap: () {
                            setState(() {
                              if (!_categories.add(cat)) {
                                _categories.remove(cat);
                              }
                            });
                          },
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: SavSpace.x20),
                const _SectionLabel('METHOD'),
                const SizedBox(height: SavSpace.x10),
                Row(
                  children: [
                    Expanded(
                      child: _MethodToggle(
                        label: l.methodPickup,
                        selected: _method == RequestMethod.pickup,
                        onTap: () =>
                            setState(() => _method = RequestMethod.pickup),
                      ),
                    ),
                    const SizedBox(width: SavSpace.x10),
                    Expanded(
                      child: _MethodToggle(
                        label: l.methodDelivery,
                        selected: _method == RequestMethod.delivery,
                        onTap: () =>
                            setState(() => _method = RequestMethod.delivery),
                      ),
                    ),
                  ],
                ),
              ],
              const SizedBox(height: SavSpace.x20),
              _SectionLabel(l.fromProfile.toUpperCase()),
              const SizedBox(height: SavSpace.x12),
              SavCard(
                padding: const EdgeInsets.all(SavSpace.x14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _infoRow(l.householdSize, r.household),
                    const Divider(height: SavSpace.x20, color: SavColors.border),
                    _infoRow(l.fieldPhone, _phone ?? '\u2014'),
                    const SizedBox(height: SavSpace.x14),
                    SavButton(
                      label: '${l.editInProfile} \u2192',
                      variant: SavButtonVariant.ghost,
                      onPressed: () {
                        Get.back();
                        Get.toNamed(Routes.profile);
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: SavSpace.x20),
              const _SectionLabel('HOUSEHOLD SIZE'),
              const SizedBox(height: SavSpace.x10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(l.householdSize,
                      style: const TextStyle(
                          fontFamily: SavFonts.sans,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: SavColors.txt3)),
                  Text(r.household,
                      style: const TextStyle(
                          fontFamily: SavFonts.sans,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: SavColors.navy)),
                ],
              ),
              const SizedBox(height: SavSpace.x8),
              Text(
                l.householdSizeNote,
                style: const TextStyle(
                  fontFamily: SavFonts.sans,
                  fontSize: 11.5,
                  height: 1.45,
                  fontWeight: FontWeight.w500,
                  color: SavColors.txt4,
                ),
              ),
              const SizedBox(height: SavSpace.x20),
              Text(l.notesLabel,
                  style: const TextStyle(
                      fontFamily: SavFonts.sans,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: SavColors.txt2)),
              const SizedBox(height: SavSpace.x10),
              TextField(
                controller: _notes,
                minLines: 3,
                maxLines: 3,
                decoration: InputDecoration(hintText: l.notesHint),
              ),
              const SizedBox(height: SavSpace.x24),
              SavButton(
                label: l.actionSave,
                busy: _saving,
                onPressed: _saving ? null : () => _save(context, l),
              ),
              const SizedBox(height: SavSpace.x10),
              SavButton(
                label: l.actionCancel,
                variant: SavButtonVariant.ghost,
                onPressed: () => Get.back(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(label,
          style: const TextStyle(
              fontFamily: SavFonts.sans,
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: SavColors.txt3)),
      Text(value,
          style: const TextStyle(
              fontFamily: SavFonts.sans,
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: SavColors.navy)),
    ],
  );

  Future<void> _save(BuildContext context, AppLocalizations l) async {
    setState(() => _saving = true);

    final body = <String, dynamic>{
      'notes': _notes.text.trim(),
      if (!_locked) 'cats': [for (final c in _categories) c.api],
      if (!_locked) 'method': _method.api,
    };

    final result = await Get.find<SavviApi>().editRequest(widget.request.id, body);
    if (Get.isRegistered<RequestsController>()) {
      await Get.find<RequestsController>().refresh();
    }

    if (!mounted) return;
    setState(() => _saving = false);

    result.when(
      ok: (_) {
        Navigator.of(context).pop();
        SavFeedback.toast(context, l.editRequest, tone: FeedbackTone.success);
      },
      err: (_) {
        SavFeedback.toast(context, l.errUnknown, tone: FeedbackTone.error);
      },
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text);
  final String text;

  @override
  Widget build(BuildContext context) => Text(
    text,
    style: const TextStyle(
      fontFamily: SavFonts.sans,
      fontSize: 11,
      fontWeight: FontWeight.w700,
      letterSpacing: 0.5,
      color: SavColors.txt4,
    ),
  );
}

class _MethodToggle extends StatelessWidget {
  const _MethodToggle({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? SavColors.navy : Colors.white,
      borderRadius: SavRadius.button,
      child: InkWell(
        borderRadius: SavRadius.button,
        onTap: onTap,
        child: Container(
          constraints: const BoxConstraints(minHeight: SavSpace.minTouch),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: SavRadius.button,
            border: Border.all(
              color: selected ? SavColors.navy : SavColors.border,
              width: 1.5,
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontFamily: SavFonts.sans,
              fontSize: 14.5,
              fontWeight: FontWeight.w700,
              color: selected ? Colors.white : SavColors.txt2,
            ),
          ),
        ),
      ),
    );
  }
}