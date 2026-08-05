import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/routing/app_router.dart';
import '../../core/state/shell_nav.dart';
import '../../core/theme/tokens.dart';
import '../../core/utils/validators.dart';
import '../../data/models/labels.dart';
import '../../data/models/profile_prefs.dart';
import '../../data/models/request_status.dart';
import '../../l10n/app_localizations.dart';
import '../../shared/patterns/error_text.dart';
import '../../shared/patterns/feedback.dart';
import '../../shared/widgets/sav_button.dart';
import '../../shared/widgets/sav_cards.dart';
import '../../shared/widgets/sav_inputs.dart';
import '../auth/auth_controller.dart';
import 'profile_controller.dart';

const _householdOptions = <String>[
  '1', '2', '3', '4', '5', '6', '7', '8', '9', '10+'
];

/// Normalizes any stored household value to a valid dropdown option, so the
/// dropdown can never assert on an out-of-range value. 1–9 stay as-is; 10 or
/// more becomes '10+'; missing/invalid/non-numeric falls back to '1'.
String _householdOption(String? raw) {
  if (raw == null) return '1';
  final t = raw.trim();
  if (t == '10+') return '10+';
  final n = int.tryParse(t);
  if (n == null || n <= 0) return '1';
  return n >= 10 ? '10+' : '$n';
}

/// True when the stored value was missing/invalid (a fallback was applied), so
/// the UI can prompt the member to confirm.
bool _householdNeedsConfirm(String? raw) {
  if (raw == null || raw.trim().isEmpty) return true;
  if (raw.trim() == '10+') return false;
  final n = int.tryParse(raw.trim());
  return n == null || n <= 0;
}

/// The member's profile: contact details, household, dietary/allergen
/// preferences, and account actions. Every save goes through the shared
/// mutation pattern (pending state, await-before-toast, rollback on failure).
// class ProfileScreen extends ConsumerStatefulWidget {
//   const ProfileScreen({super.key});
//
//   @override
//   ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
// }
//
// class _ProfileScreenState extends ConsumerState<ProfileScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _email = TextEditingController();
//   final _phone = TextEditingController();
//   final _street = TextEditingController();
//   final _city = TextEditingController();
//   final _state = TextEditingController();
//   final _zip = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//     final p = _profile;
//     _email.text = (p['email'] as String?) ?? '';
//     _phone.text = (p['phone'] as String?) ?? '';
//     _street.text = (p['street'] as String?) ?? '';
//     _city.text = (p['city'] as String?) ?? '';
//     _state.text = (p['state'] as String?) ?? '';
//     _zip.text = (p['zip'] as String?) ?? '';
//   }
//
//   @override
//   void dispose() {
//     for (final c in [_email, _phone, _street, _city, _state, _zip]) {
//       c.dispose();
//     }
//     super.dispose();
//   }
//
//   Map<String, dynamic> get _profile {
//     final auth = ref.read(authControllerProvider);
//     return auth is AuthSignedIn ? auth.profile : const {};
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final l = AppLocalizations.of(context);
//     final p = _profile;
//     final st = ref.watch(editProfileControllerProvider);
//     final ctrl = ref.read(editProfileControllerProvider.notifier);
//     final name = [p['firstName'], p['lastName']]
//         .whereType<String>()
//         .join(' ')
//         .trim();
//
//     return Scaffold(
//       backgroundColor: SavColors.page,
//       appBar: AppBar(
//         backgroundColor: SavColors.surface,
//         elevation: 0,
//         scrolledUnderElevation: 0,
//         title: Text(l.profileTitle,
//             style: const TextStyle(
//                 fontFamily: SavFonts.serif, fontSize: 18, color: SavColors.navy)),
//         centerTitle: true,
//       ),
//       body: ListView(
//         padding: const EdgeInsets.fromLTRB(
//             SavSpace.x16, SavSpace.x16, SavSpace.x16, SavSpace.x24),
//         children: [
//           if (ref.watch(requestReturnProvider)) _returnBanner(context, l),
//           // Header
//           Text(name.isEmpty ? l.profileTitle : name,
//               style: const TextStyle(
//                   fontFamily: SavFonts.serif, fontSize: 24, color: SavColors.navy)),
//           const SizedBox(height: 2),
//           Text(
//               '${(p['memberId'] as String?) ?? ''} · ${(p['nonprofit'] as String?) ?? ''}',
//               style: const TextStyle(
//                   fontFamily: SavFonts.sans,
//                   fontSize: 13,
//                   fontWeight: FontWeight.w500,
//                   color: SavColors.txt3)),
//           const SizedBox(height: SavSpace.x8),
//           Align(
//             alignment: Alignment.centerLeft,
//             child: StatusPill(
//                 status: RequestStatus.approved, label: l.stApproved),
//           ),
//           const SizedBox(height: SavSpace.x16),
//           // Member bar
//           Container(
//             padding: const EdgeInsets.all(SavSpace.x16),
//             decoration: BoxDecoration(
//                 color: SavColors.navy, borderRadius: SavRadius.card),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(l.householdOf(_householdOption(st.household)),
//                           style: const TextStyle(
//                               fontFamily: SavFonts.sans,
//                               fontSize: 15,
//                               fontWeight: FontWeight.w700,
//                               color: Colors.white)),
//                       Text(l.usedInRequests,
//                           style: const TextStyle(
//                               fontFamily: SavFonts.sans,
//                               fontSize: 12,
//                               fontWeight: FontWeight.w500,
//                               color: Color(0xAAFFFFFF))),
//                     ],
//                   ),
//                 ),
//                 Container(
//                   padding: const EdgeInsets.symmetric(
//                       horizontal: SavSpace.x10, vertical: SavSpace.x4),
//                   decoration: BoxDecoration(
//                       color: SavColors.green, borderRadius: SavRadius.pill),
//                   child: Text(l.activeLabel,
//                       style: const TextStyle(
//                           fontFamily: SavFonts.sans,
//                           fontSize: 11,
//                           fontWeight: FontWeight.w700,
//                           color: SavColors.navy)),
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(height: SavSpace.x12),
//           _contactCard(l, ctrl, st),
//           const SizedBox(height: SavSpace.x12),
//           _householdCard(l, ctrl, st),
//           const SizedBox(height: SavSpace.x12),
//           _dietCard(l, ctrl, st),
//           const SizedBox(height: SavSpace.x12),
//           _allergenCard(l, ctrl, st),
//           const SizedBox(height: SavSpace.x12),
//           _accountCard(context, l),
//         ],
//       ),
//     );
//   }
//
//   Widget _returnBanner(BuildContext context, AppLocalizations l) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: SavSpace.x14),
//       child: Semantics(
//         button: true,
//         label: '${l.returnToRequest}. ${l.returnToRequestBody}',
//         excludeSemantics: true,
//         child: Material(
//         color: SavColors.navy,
//         borderRadius: SavRadius.card,
//         child: InkWell(
//           onTap: () {
//             ref.read(requestReturnProvider.notifier).state = false;
//             context.push(Routes.request);
//           },
//           borderRadius: SavRadius.card,
//           child: Padding(
//             padding: const EdgeInsets.all(SavSpace.x14),
//             child: Row(
//               children: [
//                 const Icon(Icons.arrow_back, color: Colors.white, size: 18),
//                 const SizedBox(width: SavSpace.x12),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(l.returnToRequest,
//                           style: const TextStyle(
//                               fontFamily: SavFonts.sans,
//                               fontSize: 14,
//                               fontWeight: FontWeight.w700,
//                               color: Colors.white)),
//                       Text(l.returnToRequestBody,
//                           style: const TextStyle(
//                               fontFamily: SavFonts.sans,
//                               fontSize: 12,
//                               fontWeight: FontWeight.w500,
//                               color: Color(0xCCFFFFFF))),
//                     ],
//                   ),
//                 ),
//                 const Icon(Icons.chevron_right, color: Colors.white),
//               ],
//             ),
//           ),
//         ),
//       )),
//     );
//   }
//
//   Widget _card({required String title, required List<Widget> children}) =>
//       SavCard(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(title,
//                 style: const TextStyle(
//                     fontFamily: SavFonts.serif,
//                     fontSize: 16,
//                     color: SavColors.navy)),
//             const SizedBox(height: SavSpace.x12),
//             ...children,
//           ],
//         ),
//       );
//
//   Widget _contactCard(
//       AppLocalizations l, EditProfileController ctrl, EditProfileState st) {
//     return _card(title: l.contactDetails, children: [
//       Form(
//         key: _formKey,
//         child: Column(
//           children: [
//             SavField(
//                 label: l.fieldEmail,
//                 controller: _email,
//                 keyboardType: TextInputType.emailAddress,
//                 validator: Validators.email(l)),
//             const SizedBox(height: SavSpace.x10),
//             SavField(
//                 label: l.fieldPhone,
//                 controller: _phone,
//                 keyboardType: TextInputType.phone,
//                 helper: l.phoneNote,
//                 validator: Validators.phoneRequired(l)),
//             const SizedBox(height: SavSpace.x10),
//             SavField(
//                 label: l.fieldStreet,
//                 controller: _street,
//                 validator: Validators.required(l)),
//             const SizedBox(height: SavSpace.x10),
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Expanded(child: SavField(label: l.fieldCity, controller: _city)),
//                 const SizedBox(width: SavSpace.x10),
//                 SizedBox(
//                     width: 74,
//                     child: SavField(label: l.fieldState, controller: _state)),
//               ],
//             ),
//             const SizedBox(height: SavSpace.x10),
//             SavField(
//                 label: l.fieldZip,
//                 controller: _zip,
//                 keyboardType: TextInputType.number,
//                 validator: Validators.zip(l)),
//           ],
//         ),
//       ),
//       const SizedBox(height: SavSpace.x10),
//       SavNotice(
//           message: l.zipNote, tone: NoticeTone.blue, icon: Icons.info_outline),
//       const SizedBox(height: SavSpace.x12),
//       SavButton(
//           label: l.saveContact,
//           busy: st.savingContact,
//           onPressed: () => _saveContact(l, ctrl)),
//     ]);
//   }
//
//   Future<void> _saveContact(AppLocalizations l, EditProfileController ctrl) async {
//     if (!(_formKey.currentState?.validate() ?? false)) {
//       SavFeedback.toast(context, l.errFix, tone: FeedbackTone.warning);
//       return;
//     }
//     final r = await ctrl.saveContact({
//       'email': _email.text.trim(),
//       'phone': _phone.text.trim(),
//       'street': _street.text.trim(),
//       'city': _city.text.trim(),
//       'state': _state.text.trim(),
//       'zip': _zip.text.trim(),
//     });
//     if (!mounted) return;
//     SavFeedback.toast(context, r.ok ? l.contactSaved : errText(l, r.errorKey!),
//         tone: r.ok ? FeedbackTone.success : FeedbackTone.error);
//   }
//
//   Widget _householdCard(
//       AppLocalizations l, EditProfileController ctrl, EditProfileState st) {
//     return _card(title: l.householdSize, children: [
//       DropdownButtonFormField<String>(
//         value: _householdOption(st.household),
//         decoration: InputDecoration(
//           filled: true,
//           fillColor: SavColors.page,
//           border: OutlineInputBorder(
//               borderRadius: SavRadius.field,
//               borderSide: const BorderSide(color: SavColors.border)),
//           enabledBorder: OutlineInputBorder(
//               borderRadius: SavRadius.field,
//               borderSide: const BorderSide(color: SavColors.border)),
//           contentPadding: const EdgeInsets.symmetric(
//               horizontal: SavSpace.x14, vertical: SavSpace.x12),
//         ),
//         items: [
//           for (final o in _householdOptions)
//             DropdownMenuItem(value: o, child: Text(o))
//         ],
//         onChanged: st.savingHousehold
//             ? null
//             : (v) async {
//                 if (v == null || v == _householdOption(st.household)) return;
//                 final r = await ctrl.setHousehold(v);
//                 if (mounted) {
//                   SavFeedback.toast(
//                       context,
//                       r.ok ? l.contactSaved : errText(l, r.errorKey!),
//                       tone:
//                           r.ok ? FeedbackTone.success : FeedbackTone.error);
//                 }
//               },
//       ),
//       if (st.savingHousehold)
//         Padding(
//           padding: const EdgeInsets.only(top: SavSpace.x8),
//           child: Row(
//             children: [
//               const SizedBox(
//                   width: 14,
//                   height: 14,
//                   child: CircularProgressIndicator(
//                       strokeWidth: 2, color: SavColors.greenDk)),
//               const SizedBox(width: SavSpace.x8),
//               Text(l.savingLabel,
//                   style: const TextStyle(
//                       fontFamily: SavFonts.sans,
//                       fontSize: 12,
//                       fontWeight: FontWeight.w600,
//                       color: SavColors.txt3)),
//             ],
//           ),
//         )
//       else if (_householdNeedsConfirm(st.household))
//         Padding(
//           padding: const EdgeInsets.only(top: SavSpace.x8),
//           child: Text(l.householdConfirm,
//               style: const TextStyle(
//                   fontFamily: SavFonts.sans,
//                   fontSize: 12,
//                   fontWeight: FontWeight.w600,
//                   color: SavColors.pillAmberFg)),
//         ),
//     ]);
//   }
//
//   Widget _dietCard(
//       AppLocalizations l, EditProfileController ctrl, EditProfileState st) {
//     return _card(title: l.dietTitle, children: [
//       Text(l.profileDietSub,
//           style: const TextStyle(
//               fontFamily: SavFonts.sans,
//               fontSize: 12,
//               fontWeight: FontWeight.w500,
//               color: SavColors.txt3)),
//       const SizedBox(height: SavSpace.x10),
//       Wrap(
//         spacing: SavSpace.x8,
//         runSpacing: SavSpace.x8,
//         children: [
//           for (final d in DietaryPref.values)
//             _chip(
//               label: Labels.diet(l, d),
//               on: st.diet.contains(d),
//               busy: st.savingChip == d.api,
//               disabled: st.savingChip != null,
//               onTap: () async {
//                 final r = await ctrl.toggleDiet(d);
//                 if (!r.ok && mounted) {
//                   SavFeedback.toast(context, errText(l, r.errorKey!),
//                       tone: FeedbackTone.error);
//                 }
//               },
//             ),
//         ],
//       ),
//     ]);
//   }
//
//   Widget _allergenCard(
//       AppLocalizations l, EditProfileController ctrl, EditProfileState st) {
//     return _card(title: l.allergensTitle, children: [
//       Text(l.profileAlgSub,
//           style: const TextStyle(
//               fontFamily: SavFonts.sans,
//               fontSize: 12,
//               fontWeight: FontWeight.w500,
//               color: SavColors.txt3)),
//       const SizedBox(height: SavSpace.x10),
//       Wrap(
//         spacing: SavSpace.x8,
//         runSpacing: SavSpace.x8,
//         children: [
//           for (final a in Allergen.values)
//             _chip(
//               label: Labels.allergen(l, a),
//               on: st.allergens.contains(a),
//               busy: st.savingChip == a.api,
//               disabled: st.savingChip != null,
//               onTap: () async {
//                 final r = await ctrl.toggleAllergen(a);
//                 if (!r.ok && mounted) {
//                   SavFeedback.toast(context, errText(l, r.errorKey!),
//                       tone: FeedbackTone.error);
//                 }
//               },
//             ),
//         ],
//       ),
//     ]);
//   }
//
//   Widget _chip(
//       {required String label,
//       required bool on,
//       required bool busy,
//       required bool disabled,
//       required VoidCallback onTap}) {
//     return Semantics(
//       button: true,
//       selected: on,
//       label: label,
//       excludeSemantics: true,
//       child: Opacity(
//         opacity: disabled && !busy ? 0.5 : 1,
//         child: InkWell(
//           onTap: disabled ? null : onTap,
//           borderRadius: SavRadius.field,
//           child: ConstrainedBox(
//             // 48dp minimum tap target; the pill visual stays compact (v45).
//             constraints: const BoxConstraints(minHeight: 48),
//             child: Center(
//               widthFactor: 1,
//               child: Container(
//                 padding: const EdgeInsets.symmetric(
//                     horizontal: SavSpace.x12, vertical: SavSpace.x8),
//                 decoration: BoxDecoration(
//                     color: on ? SavColors.navy : SavColors.surface,
//                     borderRadius: SavRadius.field,
//                     border: Border.all(
//                         color: on ? SavColors.navy : SavColors.border,
//                         width: 1.5)),
//                 child: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     if (busy) ...[
//                       SizedBox(
//                           width: 12,
//                           height: 12,
//                           child: CircularProgressIndicator(
//                               strokeWidth: 2,
//                               color: on ? Colors.white : SavColors.navy)),
//                       const SizedBox(width: SavSpace.x6),
//                     ],
//                     Text(label,
//                         style: TextStyle(
//                             fontFamily: SavFonts.sans,
//                             fontSize: 12.5,
//                             fontWeight: FontWeight.w600,
//                             color: on ? Colors.white : SavColors.txt2)),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _accountCard(BuildContext context, AppLocalizations l) {
//     return _card(title: l.settingsHelp, children: [
//       SavButton(
//           label: l.openSettings,
//           variant: SavButtonVariant.ghost,
//           icon: Icons.settings_outlined,
//           onPressed: () => context.push(Routes.settings)),
//       const SizedBox(height: SavSpace.x10),
//       SavButton(
//           label: l.signOut,
//           variant: SavButtonVariant.danger,
//           onPressed: () => _confirmSignOut(context, l)),
//     ]);
//   }
//
//   Future<void> _confirmSignOut(BuildContext context, AppLocalizations l) async {
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
