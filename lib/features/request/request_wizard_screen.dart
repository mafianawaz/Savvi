import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/routing/app_router.dart';
import '../../core/state/shell_nav.dart';
import '../../core/theme/tokens.dart';
import '../../data/models/enums.dart';
import '../../data/models/labels.dart';
import '../../data/models/profile_prefs.dart';
import '../../l10n/app_localizations.dart';
import '../../shared/patterns/error_text.dart';
import '../../shared/patterns/feedback.dart';
import '../../shared/widgets/sav_button.dart';
import '../../shared/widgets/sav_inputs.dart';
import '../auth/auth_controller.dart';
import 'request_controller.dart';


/// Multi-step request wizard: categories → method → household & contact →
/// dietary & allergens → review → submit. The backend assigns the request id
/// and status; Infant Formula is a controlled item requiring acknowledgment.
class RequestWizardScreen extends ConsumerStatefulWidget {
  const RequestWizardScreen({super.key});

  @override
  ConsumerState<RequestWizardScreen> createState() =>
      _RequestWizardScreenState();
}

class _RequestWizardScreenState extends ConsumerState<RequestWizardScreen> {
  final _notes = TextEditingController();
  String? _submittedId;
  bool _submitting = false;

  @override
  void initState() {
    super.initState();
    _notes.text = ref.read(requestControllerProvider).notes;
  }

  @override
  void dispose() {
    _notes.dispose();
    super.dispose();
  }

  Map<String, dynamic> get _profile {
    final auth = ref.read(authControllerProvider);
    return auth is AuthSignedIn ? auth.profile : const {};
  }

  /// Sync the notes field into the draft on step transitions / submit, instead
  /// of on every keystroke (avoids rebuilding the whole wizard while typing).
  void _captureNotes() =>
      ref.read(requestControllerProvider.notifier).setNotes(_notes.text);

  void _back() {
    _captureNotes();
    ref.read(requestControllerProvider.notifier).back();
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final d = ref.watch(requestControllerProvider);

    if (_submittedId != null) return _confirmation(context, l);

    return Scaffold(
      backgroundColor: SavColors.page,
      appBar: AppBar(
        backgroundColor: SavColors.surface,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: SavColors.navy),
          onPressed: () =>
              d.step == 1 ? context.pop() : _back(),
        ),
        title: Text(l.reqTitle,
            style: const TextStyle(
                fontFamily: SavFonts.serif, fontSize: 18, color: SavColors.navy)),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(30),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
                SavSpace.x16, 0, SavSpace.x16, SavSpace.x10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l.reqStep(d.step, kWizardSteps),
                    style: const TextStyle(
                        fontFamily: SavFonts.sans,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.4,
                        color: SavColors.txt3)),
                const SizedBox(height: SavSpace.x6),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: d.step / kWizardSteps,
                    minHeight: 5,
                    backgroundColor: SavColors.border,
                    valueColor:
                        const AlwaysStoppedAnimation(SavColors.green),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(
                    SavSpace.x16, SavSpace.x16, SavSpace.x16, SavSpace.x24),
                children: [_stepBody(context, l, d)],
              ),
            ),
            _footer(context, l, d),
          ],
        ),
      ),
    );
  }

  Widget _stepBody(BuildContext c, AppLocalizations l, RequestDraft d) =>
      switch (d.step) {
        1 => _stepCategories(c, l, d),
        2 => _stepMethod(c, l, d),
        3 => _stepHousehold(c, l, d),
        4 => _stepDietary(c, l, d),
        _ => _stepReview(c, l, d),
      };

  Widget _heading(String title, String sub) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                  fontFamily: SavFonts.serif,
                  fontSize: 22,
                  color: SavColors.navy)),
          const SizedBox(height: SavSpace.x4),
          Text(sub,
              style: const TextStyle(
                  fontFamily: SavFonts.sans,
                  fontSize: 13.5,
                  height: 1.4,
                  fontWeight: FontWeight.w500,
                  color: SavColors.txt3)),
          const SizedBox(height: SavSpace.x16),
        ],
      );

  // ── Step 1: categories ─────────────────────────────────────────────────────
  Widget _stepCategories(BuildContext c, AppLocalizations l, RequestDraft d) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _heading(l.s1Title, l.s1Sub),
        for (final cat in FoodCategory.values)
          Padding(
            padding: const EdgeInsets.only(bottom: SavSpace.x8),
            child: _CategoryTile(
              label: Labels.category(l, cat),
              controlledLabel: cat.controlled ? l.controlledItem : null,
              selected: d.categories.contains(cat),
              onTap: () {
                if (cat == FoodCategory.infantFormula && !d.ackFormula) {
                  _showFormulaSheet(c, l);
                } else {
                  ref
                      .read(requestControllerProvider.notifier)
                      .toggleCategory(cat);
                }
              },
            ),
          ),
      ],
    );
  }

  void _showFormulaSheet(BuildContext c, AppLocalizations l) {
    showModalBottomSheet<void>(
      context: c,
      backgroundColor: SavColors.surface,
      shape: const RoundedRectangleBorder(borderRadius: SavRadius.sheet),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.fromLTRB(
            SavSpace.x20, SavSpace.x20, SavSpace.x20, SavSpace.x24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.lock_outline,
                    size: 18, color: SavColors.pillAmberFg),
                const SizedBox(width: SavSpace.x8),
                Text(l.catInfantFormula,
                    style: const TextStyle(
                        fontFamily: SavFonts.serif,
                        fontSize: 18,
                        color: SavColors.navy)),
              ],
            ),
            const SizedBox(height: SavSpace.x12),
            Text(l.formulaNote,
                style: const TextStyle(
                    fontFamily: SavFonts.sans,
                    fontSize: 13,
                    height: 1.5,
                    fontWeight: FontWeight.w500,
                    color: SavColors.txt2)),
            const SizedBox(height: SavSpace.x20),
            SavButton(
              label: l.formulaAck,
              onPressed: () {
                ref.read(requestControllerProvider.notifier).ackInfantFormula();
                Navigator.of(ctx).pop();
              },
            ),
          ],
        ),
      ),
    );
  }

  // ── Step 2: method ─────────────────────────────────────────────────────────
  Widget _stepMethod(BuildContext c, AppLocalizations l, RequestDraft d) {
    final avail = ref.watch(deliveryAvailabilityProvider);
    final deliveryEnabled = avail == DeliveryAvailability.available;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _heading(l.s2Title, l.s2Sub),
        _MethodTile(
          icon: Icons.storefront_outlined,
          title: l.methodPickup,
          desc: l.pickupDesc,
          selected: d.method == RequestMethod.pickup,
          onTap: () => ref
              .read(requestControllerProvider.notifier)
              .setMethod(RequestMethod.pickup),
        ),
        const SizedBox(height: SavSpace.x10),
        _MethodTile(
          icon: Icons.local_shipping_outlined,
          title: l.methodDelivery,
          desc: l.deliveryDesc,
          selected: d.method == RequestMethod.delivery,
          enabled: deliveryEnabled,
          onTap: () => ref
              .read(requestControllerProvider.notifier)
              .setMethod(RequestMethod.delivery),
        ),
        // Availability note — the backend owns the decision; the UI only renders.
        if (avail == DeliveryAvailability.unavailable)
          _availNote(l.deliveryUnavail, tone: SavColors.pillAmberFg)
        else if (avail == DeliveryAvailability.checking)
          _availNote(l.deliveryChecking, tone: SavColors.txt3)
        else if (avail == DeliveryAvailability.error)
          _availNote(l.deliveryAvailError,
              tone: SavColors.red,
              onRetry: () => ref.invalidate(deliveryAvailabilityProvider)),
      ],
    );
  }

  Widget _availNote(String text, {required Color tone, VoidCallback? onRetry}) {
    return Padding(
      padding: const EdgeInsets.only(top: SavSpace.x10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline, size: 14, color: tone),
          const SizedBox(width: SavSpace.x6),
          Expanded(
            child: Text(text,
                style: TextStyle(
                    fontFamily: SavFonts.sans,
                    fontSize: 12,
                    height: 1.4,
                    fontWeight: FontWeight.w600,
                    color: tone)),
          ),
          if (onRetry != null)
            TextButton(
              onPressed: onRetry,
              child: Text(AppLocalizations.of(context).tryAgain),
            ),
        ],
      ),
    );
  }

  // ── Step 3: household & contact + notes ────────────────────────────────────
  Widget _stepHousehold(BuildContext c, AppLocalizations l, RequestDraft d) {
    final p = _profile;
    final name = [p['firstName'], p['lastName']]
        .whereType<String>()
        .join(' ')
        .trim();
    final address = [p['street'], p['city'], p['state'], p['zip']]
        .whereType<String>()
        .where((s) => s.isNotEmpty)
        .join(', ');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _heading(l.s3Title, l.s3Sub),
        _ProfileBox(l: l, rows: [
          (l.rvHousehold, (p['household'] as String?) ?? '—'),
          (l.rvContact, name.isEmpty ? '—' : name),
          (l.fieldPhone, (p['phone'] as String?) ?? '—'),
          (l.rvAddress, address.isEmpty ? '—' : address),
        ]),
        Align(
          alignment: Alignment.centerLeft,
          child: TextButton.icon(
            onPressed: () {
              // Switch to the existing Profile tab instead of pushing a
              // duplicate ProfileScreen; the draft is preserved for return.
              ref.read(requestReturnProvider.notifier).state = true;
              ref.read(shellTabProvider.notifier).state = kTabProfile;
              context.pop();
            },
            icon: const Icon(Icons.edit_outlined, size: 15),
            label: Text(l.editInProfile),
            style: TextButton.styleFrom(
                foregroundColor: SavColors.navy,
                padding: const EdgeInsets.symmetric(vertical: SavSpace.x4),
                textStyle: const TextStyle(
                    fontFamily: SavFonts.sans,
                    fontSize: 12.5,
                    fontWeight: FontWeight.w700)),
          ),
        ),
        const SizedBox(height: SavSpace.x16),
        SavField(
          label: l.notesLabel,
          controller: _notes,
          hint: l.notesHint,
          maxLines: 3,
        ),
      ],
    );
  }

  // ── Step 4: dietary & allergens ────────────────────────────────────────────
  Widget _stepDietary(BuildContext c, AppLocalizations l, RequestDraft d) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _heading(l.s4Title, l.s4Sub),
        Text(l.dietTitle,
            style: const TextStyle(
                fontFamily: SavFonts.sans,
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: SavColors.txt2)),
        const SizedBox(height: SavSpace.x8),
        Wrap(
          spacing: SavSpace.x8,
          runSpacing: SavSpace.x8,
          children: [
            for (final v in DietaryPref.values)
              _ChoiceChip(
                label: Labels.diet(l, v),
                selected: d.diet.contains(v),
                onTap: () =>
                    ref.read(requestControllerProvider.notifier).toggleDiet(v),
              ),
          ],
        ),
        const SizedBox(height: SavSpace.x20),
        Text(l.allergensTitle,
            style: const TextStyle(
                fontFamily: SavFonts.sans,
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: SavColors.txt2)),
        const SizedBox(height: SavSpace.x8),
        Wrap(
          spacing: SavSpace.x8,
          runSpacing: SavSpace.x8,
          children: [
            for (final v in Allergen.values)
              _ChoiceChip(
                label: Labels.allergen(l, v),
                selected: d.allergens.contains(v),
                onTap: () => ref
                    .read(requestControllerProvider.notifier)
                    .toggleAllergen(v),
              ),
          ],
        ),
      ],
    );
  }

  // ── Step 5: review ─────────────────────────────────────────────────────────
  Widget _stepReview(BuildContext c, AppLocalizations l, RequestDraft d) {
    final p = _profile;
    final cats = d.categories.map((e) => Labels.category(l, e)).join(', ');
    final diet = d.diet.map((e) => Labels.diet(l, e)).join(', ');
    final alg = d.allergens.map((e) => Labels.allergen(l, e)).join(', ');
    final name =
        [p['firstName'], p['lastName']].whereType<String>().join(' ').trim();
    final address = [p['street'], p['city'], p['state'], p['zip']]
        .whereType<String>()
        .where((s) => s.isNotEmpty)
        .join(', ');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _heading(l.s5Title, l.s5Sub),
        _ReviewRow(l.rvCats, cats.isEmpty ? l.rvNone : cats),
        _ReviewRow(l.rvMethod,
            d.method == null ? l.rvNone : Labels.method(l, d.method!)),
        _ReviewRow(l.rvHousehold, (p['household'] as String?) ?? '—'),
        _ReviewRow(l.rvContact, name.isEmpty ? '—' : name),
        _ReviewRow(l.rvAddress, address.isEmpty ? '—' : address),
        _ReviewRow(l.rvDiet, diet.isEmpty ? l.rvNone : diet),
        _ReviewRow(l.rvAlg, alg.isEmpty ? l.rvNone : alg),
        _ReviewRow(l.rvNotes, d.notes.trim().isEmpty ? l.rvNone : d.notes.trim()),
      ],
    );
  }

  // ── Footer (Back / Next / Submit) ──────────────────────────────────────────
  Widget _footer(BuildContext c, AppLocalizations l, RequestDraft d) {
    final isLast = d.step == kWizardSteps;
    return Container(
      padding: const EdgeInsets.fromLTRB(
          SavSpace.x16, SavSpace.x12, SavSpace.x16, SavSpace.x16),
      decoration: const BoxDecoration(
        color: SavColors.surface,
        border: Border(top: BorderSide(color: SavColors.border)),
      ),
      child: Row(
        children: [
          if (d.step > 1) ...[
            Expanded(
              child: SavButton(
                label: l.stepBack,
                variant: SavButtonVariant.ghost,
                onPressed: _back,
              ),
            ),
            const SizedBox(width: SavSpace.x10),
          ],
          Expanded(
            flex: 2,
            child: SavButton(
              label: isLast ? l.submitRequest : l.stepNext,
              busy: _submitting,
              onPressed: () => isLast ? _submit(l) : _next(l, d),
            ),
          ),
        ],
      ),
    );
  }

  void _next(AppLocalizations l, RequestDraft d) {
    _captureNotes();
    if (d.step == 1 && d.categories.isEmpty) {
      SavFeedback.toast(context, l.errNoCat, tone: FeedbackTone.warning);
      return;
    }
    if (d.step == 2 && d.method == null) {
      SavFeedback.toast(context, l.errNoMethod, tone: FeedbackTone.warning);
      return;
    }
    ref.read(requestControllerProvider.notifier).next();
  }

  Future<void> _submit(AppLocalizations l) async {
    _captureNotes();
    setState(() => _submitting = true);
    final res = await ref.read(requestControllerProvider.notifier).submit();
    if (!mounted) return;
    setState(() => _submitting = false);
    if (res.ok) {
      setState(() => _submittedId = res.requestId);
    } else {
      SavFeedback.toast(context, errText(l, res.errorKey ?? 'err_unknown'),
          tone: FeedbackTone.error);
    }
  }

  // ── Confirmation ───────────────────────────────────────────────────────────
  Widget _confirmation(BuildContext context, AppLocalizations l) {
    final nonprofit = (_profile['nonprofit'] as String?) ?? '';
    return Scaffold(
      backgroundColor: SavColors.page,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(SavSpace.x24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(Icons.check_circle,
                  size: 56, color: SavColors.greenDk),
              const SizedBox(height: SavSpace.x16),
              Text(l.reqOkTitle,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontFamily: SavFonts.serif,
                      fontSize: 24,
                      color: SavColors.navy)),
              const SizedBox(height: SavSpace.x8),
              Text(l.reqOkBody(nonprofit),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontFamily: SavFonts.sans,
                      fontSize: 13.5,
                      height: 1.5,
                      fontWeight: FontWeight.w500,
                      color: SavColors.txt3)),
              const SizedBox(height: SavSpace.x8),
              Text(_submittedId ?? '',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontFamily: SavFonts.sans,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: SavColors.txt2)),
              const SizedBox(height: SavSpace.x24),
              SavButton(
                label: l.viewRequest,
                onPressed: () => context
                    .pushReplacement('/request/${_submittedId ?? ''}'),
              ),
              const SizedBox(height: SavSpace.x10),
              SavButton(
                label: l.backHome,
                variant: SavButtonVariant.ghost,
                onPressed: () => context.go(Routes.home),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Small tile widgets ───────────────────────────────────────────────────────
class _CategoryTile extends StatelessWidget {
  const _CategoryTile(
      {required this.label,
      required this.selected,
      required this.onTap,
      this.controlledLabel});
  final String label;
  final bool selected;
  final VoidCallback onTap;
  final String? controlledLabel;

  @override
  Widget build(BuildContext context) {
    final controlled = controlledLabel != null;
    return Semantics(
      button: true,
      selected: selected,
      label: controlled ? '$label, $controlledLabel' : label,
      excludeSemantics: true,
      child: InkWell(
      onTap: onTap,
      borderRadius: SavRadius.card,
      child: Container(
        padding: const EdgeInsets.all(SavSpace.x14),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFFEAF9EE) : SavColors.surface,
          borderRadius: SavRadius.card,
          border: Border.all(
              color: selected ? SavColors.green : SavColors.border,
              width: selected ? 2 : 1.5),
        ),
        child: Row(
          children: [
            Icon(
                controlled ? Icons.lock_outline : Icons.restaurant_outlined,
                size: 18,
                color: controlled ? SavColors.pillAmberFg : SavColors.navy),
            const SizedBox(width: SavSpace.x12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label,
                      style: const TextStyle(
                          fontFamily: SavFonts.sans,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: SavColors.navy)),
                  if (controlled)
                    Text(controlledLabel!,
                        style: const TextStyle(
                            fontFamily: SavFonts.sans,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: SavColors.pillAmberFg)),
                ],
              ),
            ),
            Icon(
                selected
                    ? Icons.check_circle
                    : Icons.radio_button_unchecked,
                size: 22,
                color: selected ? SavColors.green : SavColors.txt4),
          ],
        ),
      ),
    ),
  );
  }
}

class _MethodTile extends StatelessWidget {
  const _MethodTile(
      {required this.icon,
      required this.title,
      required this.desc,
      required this.selected,
      required this.onTap,
      this.enabled = true});
  final IconData icon;
  final String title;
  final String desc;
  final bool selected;
  final VoidCallback onTap;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final fg = enabled ? SavColors.navy : SavColors.txt4;
    return Semantics(
      button: true,
      enabled: enabled,
      selected: selected,
      label: '$title. $desc',
      excludeSemantics: true,
      child: Opacity(
        opacity: enabled ? 1 : 0.5,
        child: InkWell(
          onTap: enabled ? onTap : null,
          borderRadius: SavRadius.card,
          child: Container(
            padding: const EdgeInsets.all(SavSpace.x16),
            decoration: BoxDecoration(
              color: selected ? const Color(0xFFEAF9EE) : SavColors.surface,
              borderRadius: SavRadius.card,
              border: Border.all(
                  color: selected ? SavColors.green : SavColors.border,
                  width: selected ? 2 : 1.5),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(icon, size: 22, color: fg),
                const SizedBox(width: SavSpace.x12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title,
                          style: TextStyle(
                              fontFamily: SavFonts.sans,
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: fg)),
                      const SizedBox(height: 2),
                      Text(desc,
                          style: const TextStyle(
                              fontFamily: SavFonts.sans,
                              fontSize: 12.5,
                              height: 1.4,
                              fontWeight: FontWeight.w500,
                              color: SavColors.txt3)),
                    ],
                  ),
                ),
                if (enabled)
                  Icon(
                      selected
                          ? Icons.check_circle
                          : Icons.radio_button_unchecked,
                      size: 22,
                      color: selected ? SavColors.green : SavColors.txt4),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ChoiceChip extends StatelessWidget {
  const _ChoiceChip(
      {required this.label, required this.selected, required this.onTap});
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: selected,
      label: label,
      excludeSemantics: true,
      child: InkWell(
        onTap: onTap,
        borderRadius: SavRadius.field,
        child: Container(
          padding: const EdgeInsets.symmetric(
              horizontal: SavSpace.x12, vertical: SavSpace.x8),
          decoration: BoxDecoration(
            color: selected ? SavColors.navy : SavColors.surface,
            borderRadius: SavRadius.field,
            border: Border.all(
                color: selected ? SavColors.navy : SavColors.border,
                width: 1.5),
          ),
          child: Text(label,
              style: TextStyle(
                  fontFamily: SavFonts.sans,
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                  color: selected ? Colors.white : SavColors.txt2)),
        ),
      ),
    );
  }
}

class _ProfileBox extends StatelessWidget {
  const _ProfileBox({required this.l, required this.rows});
  final AppLocalizations l;
  final List<(String, String)> rows;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(SavSpace.x16),
      decoration: BoxDecoration(
        color: SavColors.surface,
        borderRadius: SavRadius.card,
        border: Border.all(color: SavColors.border, width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.badge_outlined,
                  size: 14, color: SavColors.txt3),
              const SizedBox(width: SavSpace.x6),
              Text(l.fromProfile,
                  style: const TextStyle(
                      fontFamily: SavFonts.sans,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.3,
                      color: SavColors.txt3)),
            ],
          ),
          const SizedBox(height: SavSpace.x10),
          for (final (label, value) in rows)
            Padding(
              padding: const EdgeInsets.only(bottom: SavSpace.x8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 92,
                    child: Text(label,
                        style: const TextStyle(
                            fontFamily: SavFonts.sans,
                            fontSize: 12.5,
                            fontWeight: FontWeight.w600,
                            color: SavColors.txt3)),
                  ),
                  Expanded(
                    child: Text(value,
                        style: const TextStyle(
                            fontFamily: SavFonts.sans,
                            fontSize: 12.5,
                            fontWeight: FontWeight.w600,
                            color: SavColors.txt)),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _ReviewRow extends StatelessWidget {
  const _ReviewRow(this.label, this.value);
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: SavSpace.x12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: const TextStyle(
                  fontFamily: SavFonts.sans,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.3,
                  color: SavColors.txt3)),
          const SizedBox(height: 2),
          Text(value,
              style: const TextStyle(
                  fontFamily: SavFonts.sans,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  height: 1.4,
                  color: SavColors.navy)),
        ],
      ),
    );
  }
}
