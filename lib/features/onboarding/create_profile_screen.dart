import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../core/routing/app_router.dart';
import '../../core/theme/tokens.dart';
import '../../core/utils/validators.dart';
import '../../data/models/onboarding.dart';
import '../../l10n/app_localizations.dart';
import '../../shared/widgets/auth_scaffold.dart';
import '../../shared/patterns/feedback.dart';
import '../../shared/widgets/password_field.dart';
import '../../shared/widgets/sav_button.dart';
import '../../shared/widgets/sav_inputs.dart';
import '../access/access_controller.dart';
import 'profile_controller.dart';

class CreateProfileScreen extends StatefulWidget {
  const CreateProfileScreen({super.key});

  @override
  State<CreateProfileScreen> createState() => _CreateProfileScreenState();
}

class _CreateProfileScreenState extends State<CreateProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _first = TextEditingController();
  final _last = TextEditingController();
  final _email = TextEditingController();
  final _phone = TextEditingController();
  final _street = TextEditingController();
  final _city = TextEditingController();
  final _state = TextEditingController();
  final _zip = TextEditingController();
  final _password = TextEditingController();

  late final AccessController accessController;
  late final ProfileController profileController;

  int _household = 3;
  bool _consent = false;
  bool _consentError = false;

  @override
  void initState() {
    super.initState();
    accessController = Get.find<AccessController>();
    profileController = Get.find<ProfileController>();
  }

  @override
  void dispose() {
    for (final c in [
      _first, _last, _email, _phone, _street, _city, _state, _zip, _password,
    ]) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _submit(AccessGrant grant) async {
    final l = AppLocalizations.of(context);

    final formOk = _formKey.currentState?.validate() ?? false;
    setState(() => _consentError = !_consent);

    if (!formOk || !_consent) return;
    if (profileController.isSubmitting.value) return;

    final householdSize = _household > 11 ? 11 : _household;

    final body = <String, dynamic>{
      'role': 'savvy',
      'inviteCode': grant.code,
      'source': grant.source ?? 'link',
      'firstName': _first.text.trim(),
      'lastName': _last.text.trim(),
      'email': _email.text.trim(),
      'phoneNumber': _phone.text.trim(),
      'street': _street.text.trim(),
      'city': _city.text.trim(),
      'state': _state.text.trim().toUpperCase(),
      'zip': _zip.text.trim(),
      'householdSize': householdSize,
      'password': _password.text,
      'privacyConsent': _consent,
      if (grant.coordinates != null) 'coordinates': grant.coordinates,
    };

    debugPrint('[SIGNUP] submitting signup request');
    debugPrint(
      '[SIGNUP] email=${body['email']} '
      'inviteCode=${body['inviteCode']} '
      'source=${body['source']} '
      'householdSize=${body['householdSize']}',
    );

    final approval = await profileController.submit(body);

    if (!mounted) return;

    if (approval != null) {
      // Replace the whole onboarding stack. This disposes the signup and
      // access controllers and prevents stale verified access from leaking
      // into a later registration attempt.
      Get.offAllNamed(
        Routes.approval,
        arguments: approval,
      );
      return;
    }

    SavFeedback.toast(
      context,
      profileController.error.value ?? l.accessErrInvalid,
      tone: FeedbackTone.error,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);

    return Obx(() {
      final grant = accessController.accessGrant.value;
      final submitting = profileController.isSubmitting.value;

      return AuthScaffold(
        title: l.signUpTitle,
        subtitle: l.signUpSubtitle,
        children: [
          if (grant == null)
            _accessRequiredBanner(l)
          else
            SavNotice(
              tone: NoticeTone.green,
              icon: Icons.check_circle_outline,
              title: l.signUpAccessVerifiedTitle,
              message: grant.message ?? l.signUpAccessVerifiedBody,
            ),
          const SizedBox(height: SavSpace.x20),
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: SavField(
                        label: l.fieldFirstName,
                        controller: _first,
                        required: true,
                        validator: Validators.required(l),
                      ),
                    ),
                    const SizedBox(width: SavSpace.x10),
                    Expanded(
                      child: SavField(
                        label: l.fieldLastName,
                        controller: _last,
                        required: true,
                        validator: Validators.required(l),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: SavSpace.x14),
                SavField(
                  label: l.fieldEmail,
                  controller: _email,
                  hint: l.hintEmail,
                  required: true,
                  keyboardType: TextInputType.emailAddress,
                  autofillHints: const [AutofillHints.email],
                  validator: Validators.email(l),
                ),
                const SizedBox(height: SavSpace.x14),
                SavField(
                  label: l.fieldPhone,
                  controller: _phone,
                  hint: l.hintPhone,
                  required: true,
                  keyboardType: TextInputType.phone,
                  autofillHints: const [AutofillHints.telephoneNumber],
                  validator: Validators.phoneRequired(l),
                  // helper: l.phoneHelp,
                ),
                const SizedBox(height: SavSpace.x14),
                SavField(
                  label: l.fieldStreet,
                  controller: _street,
                  hint: l.hintStreet,
                  required: true,
                  autofillHints: const [AutofillHints.streetAddressLine1],
                  validator: Validators.required(l),
                ),
                const SizedBox(height: SavSpace.x14),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 3,
                      child: SavField(
                        label: l.fieldCity,
                        controller: _city,
                        hint: l.hintCity,
                        autofillHints: const [AutofillHints.addressCity],
                      ),
                    ),
                    const SizedBox(width: SavSpace.x8),
                    Expanded(
                      flex: 1,
                      child: SavField(
                        label: l.fieldState,
                        controller: _state,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(2),
                          FilteringTextInputFormatter.allow(RegExp('[A-Za-z]')),
                        ],
                      ),
                    ),
                    const SizedBox(width: SavSpace.x8),
                    Expanded(
                      flex: 2,
                      child: SavField(
                        label: l.fieldZip,
                        controller: _zip,
                        hint: l.hintZip,
                        required: true,
                        keyboardType: TextInputType.number,
                        autofillHints: const [AutofillHints.postalCode],
                        validator: Validators.zip(l),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: SavSpace.x14),
                _householdField(l),
                const SizedBox(height: SavSpace.x14),
                PasswordField(controller: _password, label: l.fieldPassword),
                const SizedBox(height: SavSpace.x16),
                _consentRow(l),
                const SizedBox(height: SavSpace.x16),
                SavNotice(
                  tone: NoticeTone.blue,
                  icon: Icons.info_outline,
                  message: l.signUpApprovalNote,
                ),
                const SizedBox(height: SavSpace.x16),
                SavButton(
                  label: l.signUpSubmitBtn,
                  busy: submitting,
                  onPressed: grant == null ? null : () => _submit(grant),
                ),
                const SizedBox(height: SavSpace.x14),
                Center(
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Text(
                        '${l.haveAccountPrompt} ',
                        style: const TextStyle(
                          fontFamily: SavFonts.sans,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: SavColors.txt3,
                        ),
                      ),
                      InkWell(
                        onTap: () => Get.offNamed(Routes.signIn),
                        child: Text(
                          l.actionSignInShort,
                          style: const TextStyle(
                            fontFamily: SavFonts.sans,
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: SavColors.navy,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    });
  }

  Widget _accessRequiredBanner(AppLocalizations l) {
    return Container(
      padding: const EdgeInsets.all(SavSpace.x14),
      decoration: BoxDecoration(
        color: SavColors.amberLight,
        borderRadius: SavRadius.field,
        border: Border.all(color: const Color(0x4DF59E0B), width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.shield_outlined, size: 16, color: SavColors.pillAmberFg),
              const SizedBox(width: SavSpace.x8),
              Text(l.signUpAccessRequiredTitle, style: const TextStyle(fontFamily: SavFonts.sans, fontSize: 12.5, fontWeight: FontWeight.w700, color: SavColors.pillAmberFg)),
            ],
          ),
          const SizedBox(height: SavSpace.x8),
          Text(l.signUpAccessRequiredBody, style: const TextStyle(fontFamily: SavFonts.sans, fontSize: 12, height: 1.45, fontWeight: FontWeight.w500, color: SavColors.pillAmberFg)),
          const SizedBox(height: SavSpace.x10),
          SavButton(label: '${l.accessVerifyBtn} →', variant: SavButtonVariant.ghost, onPressed: () => Get.offNamed(Routes.accessLink)),
        ],
      ),
    );
  }

  Widget _householdField(AppLocalizations l) {
    String labelFor(int n) {
      if (n == 1) return l.householdPerson(1);
      if (n == 11) return l.householdPeopleMax;
      return l.householdPeople(n);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: SavSpace.x6, left: 2),
          child: Text(l.fieldHousehold, style: const TextStyle(fontFamily: SavFonts.sans, fontSize: 13, fontWeight: FontWeight.w700, color: SavColors.txt2)),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: SavSpace.x14),
          decoration: BoxDecoration(color: SavColors.surface, borderRadius: SavRadius.field, border: Border.all(color: SavColors.border, width: 1.5)),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<int>(
              value: _household,
              isExpanded: true,
              icon: const Icon(Icons.keyboard_arrow_down, color: SavColors.txt2),
              style: const TextStyle(fontFamily: SavFonts.sans, fontSize: 15, color: SavColors.txt),
              items: [for (var n = 1; n <= 11; n++) DropdownMenuItem(value: n, child: Text(labelFor(n)))],
              onChanged: (v) => setState(() => _household = v ?? 3),
            ),
          ),
        ),
      ],
    );
  }

  Widget _consentRow(AppLocalizations l) {
    void toggle() => setState(() {
          _consent = !_consent;
          if (_consent) _consentError = false;
        });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: toggle,
          borderRadius: SavRadius.field,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: SavSpace.x4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(width: 24, height: 24, child: Checkbox(value: _consent, activeColor: SavColors.navy, onChanged: (_) => toggle())),
                const SizedBox(width: SavSpace.x8),
                Expanded(child: Padding(padding: const EdgeInsets.only(top: 3), child: Text(l.consentText, style: const TextStyle(fontFamily: SavFonts.sans, fontSize: 12, height: 1.5, fontWeight: FontWeight.w500, color: SavColors.txt3)))),
              ],
            ),
          ),
        ),
        if (_consentError)
          Padding(padding: const EdgeInsets.only(top: SavSpace.x4, left: 2), child: Text(l.consentRequired, style: const TextStyle(fontFamily: SavFonts.sans, fontSize: 11.5, fontWeight: FontWeight.w600, color: SavColors.red))),
      ],
    );
  }
}
