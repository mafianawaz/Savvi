import 'package:flutter/material.dart';
import '../../core/network/savvi_api.dart';
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
import 'package:get/get.dart';



/// Multi-step request wizard: categories → method → household & contact →
/// dietary & allergens → review → submit. The backend assigns the request id
/// and status; Infant Formula is a controlled item requiring acknowledgment.

/// Formats a raw stored household value ("1"–"9", "10+", or missing/invalid)
/// as a display string like "3 people", matching the v56 wizard copy.
String _formatHouseholdPeople(AppLocalizations l, String? raw) {
  final t = raw?.trim() ?? '';
  if (t.isEmpty) return l.rvNone;
  if (t == '10+') return l.householdPeopleMax;
  final n = int.tryParse(t);
  if (n == null || n <= 0) return l.rvNone;
  return l.householdPeople(n);
}
class RequestWizardScreen extends StatelessWidget {
   RequestWizardScreen({super.key});

   RequestController get controller => Get.find<RequestController>();

   @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);

    return Obx(() {
      // If a request was successfully submitted, show the confirmation screen.
      if (controller.submittedId.value != null) {
        return _confirmation(context, l);
      }

      final d = controller.draft.value;

      return Scaffold(
        backgroundColor: SavColors.page,
        appBar: AppBar(
          backgroundColor: SavColors.surface,
          elevation: 0,
          scrolledUnderElevation: 0,
          automaticallyImplyLeading: false,
          titleSpacing: SavSpace.x4,
          title: InkWell(
            onTap: () => d.step == 1 ? Get.back() : controller.back(),
            borderRadius: SavRadius.field,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: SavSpace.x8, vertical: SavSpace.x4),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.arrow_back, size: 18, color: SavColors.navy),
                  const SizedBox(width: SavSpace.x6),
                  Text(
                    d.step == 1 ? l.actionCancel : l.stepBack,
                    style: const TextStyle(
                        fontFamily: SavFonts.sans,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: SavColors.navy),
                  ),
                ],
              ),
            ),
          ),
          centerTitle: false,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(78),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                  SavSpace.x16, 0, SavSpace.x16, SavSpace.x14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(l.reqTitle,
                      style: const TextStyle(
                          fontFamily: SavFonts.serif,
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: SavColors.navy)),
                  const SizedBox(height: SavSpace.x4),
                  Text(l.reqStep(d.step, kWizardSteps).toUpperCase(),
                      style: const TextStyle(
                          fontFamily: SavFonts.sans,
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.4,
                          color: SavColors.txt3)),
                  const SizedBox(height: SavSpace.x8),
                  _StepProgress(step: d.step, total: kWizardSteps),
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
    });
  }

  Widget _stepBody(BuildContext c, AppLocalizations l, RequestDraft d) =>
      switch (d.step) {
        1 => _stepCategories(c, l, d),
        2 => _stepMethod(c, l, d),
        3 => _stepHousehold(c, l, d),
        4 => _stepDietary(c, l, d),
        _ => _stepReview(c, l, d),
      };

  Widget _heading(String title, String sub) =>
      Column(
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
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: FoodCategory.values.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: .9,
          ),
          itemBuilder: (_, index) {
            final cat = FoodCategory.values[index];

            return Obx(() => _CategoryTile(
              category: cat,
              label: Labels.category(l, cat),
              selected: controller.draft.value.categories.contains(cat),
              controlledLabel:
              cat.controlled ? l.controlledItem : null,
              onTap: () {
                if (cat == FoodCategory.infantFormula && !d.ackFormula) {
                  _showFormulaSheet(c, l);
                } else {
                  controller.toggleCategory(cat);
                }
              },
            ));
          },
        )
      ],
    );
  }

  void _showFormulaSheet(BuildContext c, AppLocalizations l) {
    showModalBottomSheet<void>(
      context: c,
      backgroundColor: SavColors.surface,
      shape: const RoundedRectangleBorder(borderRadius: SavRadius.sheet),
      builder: (ctx) =>
          Padding(
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
                    controller.ackInfantFormula();
                    Get.back();
                  },
                ),
              ],
            ),
          ),
    );
  }

  // ── Step 2: method ─────────────────────────────────────────────────────────
  Widget _stepMethod(BuildContext c, AppLocalizations l, RequestDraft d) {
    final avail = controller.deliveryAvailability.value;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _heading(l.s2Title, l.s2Sub),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _MethodTile(
                method: RequestMethod.pickup,
                title: l.methodPickup,
                desc: l.pickupDesc,
                selected: d.method == RequestMethod.pickup,
                onTap: () => controller.setMethod(RequestMethod.pickup),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _MethodTile(
                method: RequestMethod.delivery,
                title: l.methodDelivery,
                desc: l.deliveryDesc,
                selected: d.method == RequestMethod.delivery,
                onTap: () => controller.setMethod(RequestMethod.delivery),
              ),
            ),
          ],
        ),
        if (avail == DeliveryAvailability.unavailable)
          _availNote(l.deliveryUnavail, tone: SavColors.pillAmberFg)
        else if (avail == DeliveryAvailability.checking)
          _availNote(l.deliveryChecking, tone: SavColors.txt3)
        else if (avail == DeliveryAvailability.error)
          _availNote(l.deliveryAvailError, tone: SavColors.red),
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
              child: Text(AppLocalizations
                  .of(Get.context!)
                  .tryAgain),
            ),
        ],
      ),
    );
  }

  // ── Step 3: household & contact + dietary preferences ──────────────────────
  /// Detours to Profile without losing wizard state — RequestController
  /// stays registered underneath, so returning (via Profile's return
  /// banner) lands back exactly where the member left off.
  void _goEditProfile() {
    if (Get.isRegistered<ShellController>()) {
      Get.find<ShellController>().setRequestReturn(true);
    }
    Get.toNamed(Routes.profile);
  }

  Widget _stepHousehold(
      BuildContext context,
      AppLocalizations l,
      RequestDraft d,
      ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        _SavSectionCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _heading(l.s3Title, l.s3Sub),
              _SectionLabel(l.fromProfile.toUpperCase()),

              const SizedBox(height: 12),

              _InfoRow(
                title: l.rvHousehold,
                value: controller.household.isEmpty ? l.rvNone : controller.household,
              ),
              _InfoRow(
                title: l.fieldPhone,
                value: controller.phone.isEmpty ? l.rvNone : controller.phone,
              ),
              _InfoRow(
                title: l.rvAddress,
                value: controller.address.isEmpty ? l.rvNone : controller.address,
              ),

              const SizedBox(height: 16),

              SavButton(label: l.edit, onPressed: _goEditProfile, variant: SavButtonVariant.ghost,),

              const SizedBox(height: 24),

              const _SectionLabel("HOUSEHOLD SIZE"),

              const SizedBox(height: 12),

              _InfoRow(
                title: l.householdSize,
                value: _formatHouseholdPeople(l, controller.household),
              ),

              const SizedBox(height: 8),

              Text(
                l.householdSizeNote,
                style: const TextStyle(
                  color: SavColors.txt3,
                ),
              ),

              const SizedBox(height: 16),
              SavButton(label: "${l.editInSettings} →", onPressed: _goEditProfile, variant: SavButtonVariant.ghost,),
              const SizedBox(height: 24),

              Text(
                l.notesLabel,
              ),

              const SizedBox(height: 10),

              TextField(
                controller: controller.notesController,
                minLines: 3,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: l.notesHint,
                ),
              ),

              const SizedBox(height: 14),

              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xffF8F9FB),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: const Color(0xffE6E8EC),
                  ),
                ),
                child: Row(
                  children: [

                    const Icon(
                      Icons.info_outline,
                      size: 18,
                      color: Color(0xff667085),
                    ),

                    const SizedBox(width: 10),

                    Expanded(
                      child: Text(l.s4Sub),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ── Step 4: dietary & allergens ─────────────────────────────────────────
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
                onTap: () => controller.toggleDiet(v),
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
                onTap: () => controller.toggleAllergen(v),
              ),
          ],
        ),
      ],
    );
  }

  // ── Step 5: review ─────────────────────────────────────────────────────────
  Widget _stepReview(BuildContext c, AppLocalizations l, RequestDraft d) {
    final cats = d.categories.map((e) => Labels.category(l, e)).join(', ');
    final diet = d.diet.map((e) => Labels.diet(l, e)).join(', ');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _heading(l.s5Title, l.s5Sub),
        _ReviewRow(l.rvCats, cats.isEmpty ? l.rvNone : cats),
        _ReviewRow(l.rvMethod,
            d.method == null ? l.rvNone : Labels.method(l, d.method!)),
        _ReviewRow(l.rvHousehold, controller.household.isEmpty ? l.rvNone : controller.household),
        _ReviewRow(l.rvAddress, controller.address.isEmpty ? l.rvNone : controller.address),
        _ReviewRow(l.rvDiet, diet.isEmpty ? l.rvNone : diet),
        _ReviewRow(l.rvNotes, d.notes
            .trim()
            .isEmpty ? l.rvNone : d.notes.trim()),
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
                onPressed: () => controller.back(),
              ),
            ),
            const SizedBox(width: SavSpace.x10),
          ],
          Expanded(
            child: Obx(() => SavButton(
              label: isLast ? l.submitRequest : l.stepNext,
              busy: controller.isSubmitting.value,
              onPressed: controller.isSubmitting.value
                  ? null
                  : () {
                      if (isLast) {
                        _handleSubmit(c, l);
                      } else {
                        controller.next();
                      }
                    },
            )),
          ),
        ],
      ),
    );
  }

  Future<void> _handleSubmit(BuildContext c, AppLocalizations l) async {
    final result = await controller.submit();
    if (!result.ok && c.mounted) {
      SavFeedback.toast(
        c,
        errText(l, result.errorKey ?? 'errUnknown'),
        tone: FeedbackTone.error,
      );
    }
    // On success, controller.submittedId is now set — the Obx wrapping
    // this whole screen swaps to _confirmation() on its own.
  }

  // ── Confirmation ───────────────────────────────────────────────────────────
  Widget _confirmation(BuildContext context, AppLocalizations l) {
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
              Text(l.reqOkBody(controller.nonprofit),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontFamily: SavFonts.sans,
                      fontSize: 13.5,
                      height: 1.5,
                      fontWeight: FontWeight.w500,
                      color: SavColors.txt3)),
              const SizedBox(height: SavSpace.x8),
              Text(
                  controller.submittedId.value ?? '',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontFamily: SavFonts.sans,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: SavColors.txt2)),
              const SizedBox(height: SavSpace.x24),
              SavButton(
                label: l.viewRequest,
                onPressed: () {
                  final id = controller.submittedId.value;
                  controller.resetDraft();
                  if (Get.isRegistered<ShellController>()) {
                    Get.find<ShellController>().setRequestActive(false);
                  }
                  if (id != null) {
                    Get.offAllNamed(Routes.home);
                    Get.toNamed(Routes.requestDetail, arguments: id);
                  } else {
                    Get.offAllNamed(Routes.home);
                  }
                },
              ),
              const SizedBox(height: SavSpace.x10),
              SavButton(
                label: l.backHome,
                variant: SavButtonVariant.ghost,
                onPressed: () {
                  controller.resetDraft();
                  if (Get.isRegistered<ShellController>()) {
                    Get.find<ShellController>().setRequestActive(false);
                  }
                  Get.offAllNamed(Routes.home);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Supporting UI Components (Private) ───────────────────────────────────────

/// v56-style segmented step indicator: one bar per step, filled green for
/// completed steps, navy for the current step, and left as a light track
/// for steps still ahead — replacing the old single continuous
/// [LinearProgressIndicator].
class _StepProgress extends StatelessWidget {
  const _StepProgress({required this.step, required this.total});

  final int step;
  final int total;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (var i = 1; i <= total; i++) ...[
          if (i > 1) const SizedBox(width: SavSpace.x6),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Container(
                height: 5,
                color: i < step
                    ? SavColors.green
                    : i == step
                        ? SavColors.navy
                        : SavColors.border,
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class _CategoryTile extends StatelessWidget {
  const _CategoryTile({
    super.key,
    required this.category,
    required this.label,
    required this.selected,
    required this.onTap,
    this.controlledLabel,
  });

  final FoodCategory category;
  final String label;
  final bool selected;
  final VoidCallback onTap;
  final String? controlledLabel;

  bool get isControlled => controlledLabel != null;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: selected ? const Color(0xff22C55E) : Colors.transparent,
            width: selected ? 3 : 2,
          ),
          boxShadow: [
            if (selected)
              BoxShadow(
                color: const Color(0xff22C55E).withOpacity(.25),
                blurRadius: 12,
                spreadRadius: 1,
              ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(13),
          child: AspectRatio(
            aspectRatio: .95,
            child: Stack(
              fit: StackFit.expand,
              children: [

                /// Background image
                Image.asset(
                  SavImages.category(category),
                  fit: BoxFit.cover,
                ),

                /// Dark overlay
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(.15),
                        Colors.transparent,
                        Colors.black.withOpacity(.75),
                      ],
                    ),
                  ),
                ),

                /// Selected check
                if (selected)
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration: const BoxDecoration(
                        color: Color(0xff22C55E),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.check,
                        size: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),

                /// Controlled badge
                if (isControlled)
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xffF59E0B),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Icon(
                        Icons.priority_high,
                        size: 12,
                        color: Colors.white,
                      ),
                    ),
                  ),

                /// Title
                Positioned(
                  left: 8,
                  right: 8,
                  bottom: 8,
                  child: Text(
                    label,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                      height: 1.1,
                      shadows: [
                        Shadow(
                          color: Colors.black54,
                          blurRadius: 4,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
class _MethodTile extends StatelessWidget {
  const _MethodTile({
    super.key,
    required this.method,
    required this.title,
    required this.desc,
    required this.selected,
    required this.onTap,
    this.enabled = true,
  });

  final RequestMethod method;
  final String title;
  final String desc;
  final bool selected;
  final bool enabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: enabled ? 1 : .45,
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: enabled ? onTap : null,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: selected
                  ? SavColors.green
                  : const Color(0xffE5E7EB),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.04),
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// IMAGE
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: AspectRatio(
                      aspectRatio: 1.2,
                      child: Image.asset(
                        SavImages.method(method),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  Positioned.fill(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(.65),
                          ],
                        ),
                      ),
                    ),
                  ),

                  Positioned(
                    left: 10,
                    bottom: 10,
                    child: Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: SavFonts.serif,
                        fontWeight: FontWeight.w700,
                        shadows: [
                          Shadow(
                            blurRadius: 4,
                            color: Colors.black45,
                          ),
                        ],
                      ),
                    ),
                  ),

                  if (selected)
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        width: 26,
                        height: 26,
                        decoration: const BoxDecoration(
                          color: Color(0xff22C55E),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                ],
              ),

              const SizedBox(height: 12),

              Text(
                desc,
                style: const TextStyle(
                  fontSize: 13,
                  height: 1.45,
                  color: Color(0xff475467),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class _ChoiceChip extends StatelessWidget {
  const _ChoiceChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: SavRadius.field,
      child: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: SavSpace.x12, vertical: SavSpace.x8),
        decoration: BoxDecoration(
          color: selected ? SavColors.navy : SavColors.surface,
          borderRadius: SavRadius.field,
          border: Border.all(
              color: selected ? SavColors.navy : SavColors.border, width: 1.5),
        ),
        child: Text(label,
            style: TextStyle(
                fontFamily: SavFonts.sans,
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
                color: selected ? Colors.white : SavColors.txt2)),
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
              const Icon(Icons.badge_outlined, size: 14, color: SavColors.txt3),
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

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
        style: const TextStyle(
            fontFamily: SavFonts.sans,
            fontSize: 12,
            color: SavColors.txt3),
    );
  }
}
class _SavSectionCard extends StatelessWidget {
  const _SavSectionCard({
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xffE5E7EB),
        ),
      ),
      child: child,
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.title,
    required this.value,
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(0xffEAECF0),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          Expanded(
            child: Text(
              title,
                style: const TextStyle(
              fontFamily: SavFonts.sans,
              fontSize: 12,
              color: SavColors.txt3)
            ),
          ),

          Expanded(
            child: Text(
              value,
                style: const TextStyle(
                    fontFamily: SavFonts.sans,
                    fontSize: 13,
                    color: SavColors.navy)
            ),
          ),
        ],
      ),
    );
  }
}
