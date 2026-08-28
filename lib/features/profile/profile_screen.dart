import 'package:flutter/material.dart';
import 'package:get/get.dart';

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

/// True when the stored value was missing/invalid (a fallback was applied),
/// so the UI can prompt the member to confirm.
bool _householdNeedsConfirm(String? raw) {
  if (raw == null || raw.trim().isEmpty) return true;
  if (raw.trim() == '10+') return false;
  final n = int.tryParse(raw.trim());
  return n == null || n <= 0;
}

/// The member's profile: contact details, household, dietary/allergen
/// preferences, and account actions. Every save goes through the shared
/// mutation pattern (pending state, await-before-toast, rollback on
/// failure). Reached by pushing [Routes.profile] — e.g. from the "Personal
/// info" row on Settings — rather than as a bottom-nav tab (the v56 nav is
/// Home / Events / Request / Activity / Settings; Profile isn't a tab).
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _phone = TextEditingController();
  final _street = TextEditingController();
  final _city = TextEditingController();
  final _state = TextEditingController();
  final _zip = TextEditingController();

  late final AuthController _authController = Get.find<AuthController>();
  late final EditProfileController _controller =
      Get.find<EditProfileController>();
  late final ShellController _shellController = Get.find<ShellController>();

  @override
  void initState() {
    super.initState();
    final p = _profile;
    _email.text = (p['email'] as String?) ?? '';
    _phone.text = (p['phone'] as String?) ?? '';
    _street.text = (p['street'] as String?) ?? '';
    _city.text = (p['city'] as String?) ?? '';
    _state.text = (p['state'] as String?) ?? '';
    _zip.text = (p['zip'] as String?) ?? '';
  }

  @override
  void dispose() {
    for (final c in [_email, _phone, _street, _city, _state, _zip]) {
      c.dispose();
    }
    super.dispose();
  }

  Map<String, dynamic> get _profile => _authController.profile ?? const {};

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final p = _profile;
    final name = [p['firstName'], p['lastName']]
        .whereType<String>()
        .join(' ')
        .trim();

    return Scaffold(
      backgroundColor: SavColors.page,
      appBar: AppBar(
        backgroundColor: SavColors.surface,
        elevation: 0,
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        title: InkWell(
          borderRadius: SavRadius.field,
          onTap: () => Get.back(),
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: SavSpace.x8, vertical: SavSpace.x8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.arrow_back, size: 20, color: SavColors.navy),
                const SizedBox(width: SavSpace.x6),
                Text(
                  l.actionBack,
                  style: const TextStyle(
                    fontFamily: SavFonts.sans,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: SavColors.navy,
                  ),
                ),
              ],
            ),
          ),
        ),
        centerTitle: false,
      ),
      body: Obx(() {
        final st = _controller.state.value;

        return ListView(
          padding: const EdgeInsets.fromLTRB(
            SavSpace.x16,
            SavSpace.x16,
            SavSpace.x16,
            SavSpace.x24,
          ),
          children: [
            if (_shellController.requestReturn.value) _returnBanner(l),
            _heroCard(l, name),
            const SizedBox(height: SavSpace.x20),
            Text(
              l.personalInformation,
              style: const TextStyle(
                fontFamily: SavFonts.serif,
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: SavColors.navy,
              ),
            ),
            const SizedBox(height: SavSpace.x12),
            _householdSummaryCard(l, st),
            const SizedBox(height: SavSpace.x12),
            _contactCard(l, st),
            const SizedBox(height: SavSpace.x12),
            _householdCard(l, st),
            const SizedBox(height: SavSpace.x12),
            _dietCard(l, st),
            const SizedBox(height: SavSpace.x12),
            _allergenCard(l, st),
          ],
        );
      }),
    );
  }

  /// Full-width navy hero (v56): circular avatar, name, member id ·
  /// nonprofit, and an "Approved" dot-pill — replaces the old plain-text
  /// header that sat directly on the page background.
  Widget _heroCard(AppLocalizations l, String name) {
    final p = _profile;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: SavSpace.x20,
        vertical: SavSpace.x24,
      ),
      decoration: const BoxDecoration(
        color: SavColors.navy,
        borderRadius: SavRadius.card,
      ),
      child: Column(
        children: [
          Container(
            width: 88,
            height: 88,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0x33FFFFFF), width: 2),
            ),
            child: ClipOval(
              child: Image.asset(
                SavImages.logo,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stack) => Container(
                  color: const Color(0x1AFFFFFF),
                  child: const Icon(
                    Icons.person_outline,
                    size: 36,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: SavSpace.x14),
          Text(
            name.isEmpty ? l.profileTitle : name,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: SavFonts.serif,
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            '${(p['memberId'] as String?) ?? ''} · ${(p['nonprofit'] as String?) ?? ''}',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: SavFonts.sans,
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Color(0xAAFFFFFF),
            ),
          ),
          const SizedBox(height: SavSpace.x12),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: SavSpace.x10,
              vertical: SavSpace.x6,
            ),
            decoration:  BoxDecoration(
              color: SavColors.green.withOpacity(0.05),
              borderRadius: SavRadius.pill,
              border: Border.all(color: SavColors.greenDark)
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(
                    color: SavColors.greenDark,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: SavSpace.x6),
                Text(
                  l.stApproved,
                  style: const TextStyle(
                    fontFamily: SavFonts.sans,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: SavColors.greenDark,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// "Household of N" summary card (v56): a plain white card with a small
  /// photo thumbnail, household size, and an "Active" pill — distinct from
  /// the navy hero above and from the editable "Household size" card below.
  Widget _householdSummaryCard(AppLocalizations l, EditProfileState st) {
    return SavCard(
      child: Row(
        children: [
          ClipRRect(
            borderRadius: SavRadius.field,
            child: SizedBox(
              width: 44,
              height: 44,
              child: Image.asset(
                SavImages.approved,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stack) => Container(
                  color: SavColors.greenLight,
                  child: const Icon(
                    Icons.home_outlined,
                    size: 20,
                    color: SavColors.greenDark,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: SavSpace.x12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l.householdOf(_householdOption(st.household)),
                  style: const TextStyle(
                    fontFamily: SavFonts.sans,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: SavColors.navy,
                  ),
                ),
                Text(
                  l.usedInRequests,
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
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: SavSpace.x10,
              vertical: SavSpace.x4,
            ),
            decoration: BoxDecoration(
              color: SavColors.greenLight,
              borderRadius: SavRadius.pill,
            ),
            child: Text(
              l.activeLabel,
              style: const TextStyle(
                fontFamily: SavFonts.sans,
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: SavColors.pillGreenFg,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _returnBanner(AppLocalizations l) {
    return Padding(
      padding: const EdgeInsets.only(bottom: SavSpace.x14),
      child: Semantics(
        button: true,
        label: '${l.returnToRequest}. ${l.returnToRequestBody}',
        excludeSemantics: true,
        child: Material(
          color: SavColors.navy,
          borderRadius: SavRadius.card,
          child: InkWell(
            onTap: () {
              _shellController.setRequestReturn(false);
              Get.toNamed(Routes.request);
            },
            borderRadius: SavRadius.card,
            child: Padding(
              padding: const EdgeInsets.all(SavSpace.x14),
              child: Row(
                children: [
                  const Icon(Icons.arrow_back, color: Colors.white, size: 18),
                  const SizedBox(width: SavSpace.x12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l.returnToRequest,
                          style: const TextStyle(
                            fontFamily: SavFonts.sans,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          l.returnToRequestBody,
                          style: const TextStyle(
                            fontFamily: SavFonts.sans,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Color(0xCCFFFFFF),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.chevron_right, color: Colors.white),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _card({required String title, required List<Widget> children}) =>
      SavCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontFamily: SavFonts.serif,
                fontSize: 16,
                color: SavColors.navy,
              ),
            ),
            const SizedBox(height: SavSpace.x12),
            ...children,
          ],
        ),
      );

  Widget _contactCard(AppLocalizations l, EditProfileState st) {
    return _card(
      title: l.contactDetails,
      children: [
        Form(
          key: _formKey,
          child: Column(
            children: [
              SavField(
                required: true,
                label: l.fieldEmail,
                controller: _email,
                keyboardType: TextInputType.emailAddress,
                validator: Validators.email(l),
              ),
              const SizedBox(height: SavSpace.x10),
              SavField(
                required: true,
                label: l.fieldPhone,
                controller: _phone,
                keyboardType: TextInputType.phone,
                // helper: l.phoneNote,
                validator: Validators.phoneRequired(l),
              ),
              const SizedBox(height: SavSpace.x10),
              SavField(
                required: true,
                label: l.fieldStreet,
                controller: _street,
                validator: Validators.required(l),
              ),
              const SizedBox(height: SavSpace.x10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child:
                        SavField(label: l.fieldCity, controller: _city),
                  ),
                  const SizedBox(width: SavSpace.x10),
                  SizedBox(
                    width: 74,
                    child: SavField(label: l.fieldState, controller: _state),
                  ),
                ],
              ),
              const SizedBox(height: SavSpace.x10),
              SavField(
                required: true,
                label: l.fieldZip,
                controller: _zip,
                keyboardType: TextInputType.number,
                validator: Validators.zip(l),
              ),
            ],
          ),
        ),
        const SizedBox(height: SavSpace.x10),
        SavNotice(
          message: l.zipNote,
          tone: NoticeTone.blue,
          icon: Icons.info_outline,
        ),
        const SizedBox(height: SavSpace.x12),
        SavButton(
          label: l.saveContact,
          busy: st.savingContact,
          onPressed: () => _saveContact(l),
        ),
      ],
    );
  }

  Future<void> _saveContact(AppLocalizations l) async {
    if (!(_formKey.currentState?.validate() ?? false)) {
      SavFeedback.toast(context, l.errFix, tone: FeedbackTone.warning);
      return;
    }

    final r = await _controller.saveContact({
      'email': _email.text.trim(),
      'phone': _phone.text.trim(),
      'street': _street.text.trim(),
      'city': _city.text.trim(),
      'state': _state.text.trim(),
      'zip': _zip.text.trim(),
    });

    if (!mounted) return;

    SavFeedback.toast(
      context,
      r.ok ? l.contactSaved : errText(l, r.errorKey!),
      tone: r.ok ? FeedbackTone.success : FeedbackTone.error,
    );
  }

  Widget _householdCard(AppLocalizations l, EditProfileState st) {
    return _card(
      title: l.householdSize,
      children: [
        DropdownButtonFormField<String>(
          value: _householdOption(st.household),
          decoration: const InputDecoration(
            filled: true,
            fillColor: SavColors.page,
            border: OutlineInputBorder(
              borderRadius: SavRadius.field,
              borderSide: BorderSide(color: SavColors.border),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: SavRadius.field,
              borderSide: BorderSide(color: SavColors.border),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: SavSpace.x14,
              vertical: SavSpace.x12,
            ),
          ),
          items: [
            for (final o in _householdOptions)
              DropdownMenuItem(value: o, child: Text(o)),
          ],
          onChanged: st.savingHousehold
              ? null
              : (v) async {
                  if (v == null || v == _householdOption(st.household)) {
                    return;
                  }

                  final r = await _controller.setHousehold(v);

                  if (mounted) {
                    SavFeedback.toast(
                      context,
                      r.ok ? l.contactSaved : errText(l, r.errorKey!),
                      tone: r.ok ? FeedbackTone.success : FeedbackTone.error,
                    );
                  }
                },
        ),
        if (st.savingHousehold)
          Padding(
            padding: const EdgeInsets.only(top: SavSpace.x8),
            child: Row(
              children: [
                const SizedBox(
                  width: 14,
                  height: 14,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: SavColors.greenDark,
                  ),
                ),
                const SizedBox(width: SavSpace.x8),
                Text(
                  l.savingLabel,
                  style: const TextStyle(
                    fontFamily: SavFonts.sans,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: SavColors.txt3,
                  ),
                ),
              ],
            ),
          )
        else if (_householdNeedsConfirm(st.household))
          Padding(
            padding: const EdgeInsets.only(top: SavSpace.x8),
            child: Text(
              l.householdConfirm,
              style: const TextStyle(
                fontFamily: SavFonts.sans,
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: SavColors.pillAmberFg,
              ),
            ),
          ),
      ],
    );
  }

  Widget _dietCard(AppLocalizations l, EditProfileState st) {
    return _card(
      title: l.dietTitle,
      children: [
        Text(
          l.profileDietSub,
          style: const TextStyle(
            fontFamily: SavFonts.sans,
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: SavColors.txt3,
          ),
        ),
        const SizedBox(height: SavSpace.x10),
        Wrap(
          spacing: SavSpace.x8,
          runSpacing: SavSpace.x8,
          children: [
            for (final d in DietaryPref.values)
              _chip(
                label: Labels.diet(l, d),
                on: st.diet.contains(d),
                busy: st.savingChip == d.api,
                disabled: st.savingChip != null,
                onTap: () async {
                  final r = await _controller.toggleDiet(d);
                  if (!r.ok && mounted) {
                    SavFeedback.toast(
                      context,
                      errText(l, r.errorKey!),
                      tone: FeedbackTone.error,
                    );
                  }
                },
              ),
          ],
        ),
      ],
    );
  }

  Widget _allergenCard(AppLocalizations l, EditProfileState st) {
    return _card(
      title: l.allergensTitle,
      children: [
        Text(
          l.profileAlgSub,
          style: const TextStyle(
            fontFamily: SavFonts.sans,
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: SavColors.txt3,
          ),
        ),
        const SizedBox(height: SavSpace.x10),
        Wrap(
          spacing: SavSpace.x8,
          runSpacing: SavSpace.x8,
          children: [
            for (final a in Allergen.values)
              _chip(
                label: Labels.allergen(l, a),
                on: st.allergens.contains(a),
                busy: st.savingChip == a.api,
                disabled: st.savingChip != null,
                onTap: () async {
                  final r = await _controller.toggleAllergen(a);
                  if (!r.ok && mounted) {
                    SavFeedback.toast(
                      context,
                      errText(l, r.errorKey!),
                      tone: FeedbackTone.error,
                    );
                  }
                },
              ),
          ],
        ),
      ],
    );
  }

  Widget _chip({
    required String label,
    required bool on,
    required bool busy,
    required bool disabled,
    required VoidCallback onTap,
  }) {
    return Semantics(
      button: true,
      selected: on,
      label: label,
      excludeSemantics: true,
      child: Opacity(
        opacity: disabled && !busy ? 0.5 : 1,
        child: InkWell(
          onTap: disabled ? null : onTap,
          borderRadius: SavRadius.field,
          child: ConstrainedBox(
            // 48dp minimum tap target; the pill visual stays compact (v45).
            constraints: const BoxConstraints(minHeight: 48),
            child: Center(
              widthFactor: 1,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: SavSpace.x12,
                  vertical: SavSpace.x8,
                ),
                decoration: BoxDecoration(
                  color: on ? SavColors.navy : SavColors.surface,
                  borderRadius: SavRadius.field,
                  border: Border.all(
                    color: on ? SavColors.navy : SavColors.border,
                    width: 1.5,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (busy) ...[
                      SizedBox(
                        width: 12,
                        height: 12,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: on ? Colors.white : SavColors.navy,
                        ),
                      ),
                      const SizedBox(width: SavSpace.x6),
                    ],
                    Text(
                      label,
                      style: TextStyle(
                        fontFamily: SavFonts.sans,
                        fontSize: 12.5,
                        fontWeight: FontWeight.w600,
                        color: on ? Colors.white : SavColors.txt2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
