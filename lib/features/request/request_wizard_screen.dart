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



/// Multi-step request wizard matching the v56 flow: categories → method →
/// household & contact → review → submit. The backend assigns the request id
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
        bottomNavigationBar: const _RequestBottomNav(),
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
              if (d.step < kWizardSteps) _footer(context, l, d),
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
        4 => _stepReview(c, l, d),
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
        Obx(() {
          if (controller.isLoadingCategories.value) {
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 40),
              child: Center(child: CircularProgressIndicator()),
            );
          }

          if (controller.availableCategories.isEmpty) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Column(
                children: [
                  Text(
                    errText(l, controller.categoriesError.value ?? 'errUnknown'),
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: SavColors.txt3),
                  ),
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: controller.loadCategories,
                    child: Text(l.tryAgain),
                  ),
                ],
              ),
            );
          }

          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.availableCategories.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: .9,
            ),
            itemBuilder: (_, index) {
              final cat = controller.availableCategories[index];
              return _CategoryTile(
                category: cat,
                label: Labels.category(l, cat),
                selected: controller.draft.value.categories.contains(cat),
                controlledLabel: cat.controlled ? l.controlledItem : null,
                onTap: () {
                  if (cat == FoodCategory.infantFormula && !d.ackFormula) {
                    _showFormulaSheet(c, l);
                  } else {
                    controller.toggleCategory(cat);
                  }
                },
              );
            },
          );
        }),
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
                Text(l.catInfantFormula,
                    style: const TextStyle(
                        fontFamily: SavFonts.serif,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: SavColors.navy)),
                const SizedBox(height: SavSpace.x12),
                Text(l.formulaNote,
                    style: const TextStyle(
                        fontFamily: SavFonts.sans,
                        fontSize: 13,
                        height: 1.5,
                        fontWeight: FontWeight.w500,
                        color: SavColors.txt2)),
                const SizedBox(height: SavSpace.x16),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                      horizontal: SavSpace.x12, vertical: SavSpace.x10),
                  decoration: BoxDecoration(
                    color: SavColors.amberLight,
                    border: Border.all(color: const Color(0xFFFDE68A)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.warning_amber_rounded,
                          size: 16, color: SavColors.pillAmberFg),
                      const SizedBox(width: SavSpace.x8),
                      Text(l.controlledItem,
                          style: const TextStyle(
                              fontFamily: SavFonts.sans,
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: SavColors.pillAmberFg)),
                    ],
                  ),
                ),
                const SizedBox(height: SavSpace.x20),
                SavButton(
                  label: l.formulaAck,
                  onPressed: () {
                    controller.ackInfantFormula();
                    Get.back();
                  },
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
              SavButton(
                label: l.edit,
                onPressed: _goEditProfile,
                variant: SavButtonVariant.ghost,
              ),
              const SizedBox(height: 24),
              _InfoRow(
                title: l.householdSize,
                value: _formatHouseholdPeople(l, controller.household),
              ),
              const SizedBox(height: 20),
              Text(
                l.notesLabel,
                style: const TextStyle(
                  fontFamily: SavFonts.sans,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: SavColors.txt2,
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: controller.notesController,
                minLines: 3,
                maxLines: 3,
                decoration: InputDecoration(hintText: l.notesHint),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ── Step 4: review request ────────────────────────────────────────────────
  /// The fourth and final wizard step is the v56 Review screen. Dietary and
  /// allergen values are profile-owned; the member edits those from Profile
  /// (Settings > Profile) and returns here with the same draft intact.
  Widget _stepReview(BuildContext c, AppLocalizations l, RequestDraft d) {
    // Profile-owned preferences are always read from AuthController. This is
    // intentional: if the member changed dietary/allergen preferences in
    // Settings while this wizard was open, Review must immediately show the
    // latest server-backed session values instead of a stale wizard copy.
    final diet = controller.profileDiet
        .map((e) => Labels.diet(l, e))
        .join(', ');
    final allergens = controller.profileAllergens
        .map((e) => Labels.allergen(l, e))
        .join(', ');
    final cats = d.categories.map((e) => Labels.category(l, e)).join(', ');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SavSectionCard(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l.s4Title,
                  style: const TextStyle(
                    fontFamily: SavFonts.serif,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: SavColors.navy,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  l.s4Sub,
                  style: const TextStyle(
                    fontFamily: SavFonts.sans,
                    fontSize: 12.5,
                    color: SavColors.txt2,
                  ),
                ),
                const SizedBox(height: 14),
                _ReviewLine(l.rvCats, cats.isEmpty ? l.rvNone : cats),
                _ReviewLine(
                  l.rvMethod,
                  d.method == null ? l.rvNone : Labels.method(l, d.method!),
                ),
                _ReviewLine(
                  l.rvHousehold,
                  controller.household.isEmpty
                      ? l.rvNone
                      : _formatHouseholdPeople(l, controller.household),
                ),
                _ReviewLine(
                  l.rvContact,
                  controller.phone.isEmpty ? l.rvNone : controller.phone,
                ),
                _ReviewLine(
                  l.rvAddress,
                  controller.address.isEmpty ? l.rvNone : controller.address,
                ),
                _ReviewLine(l.rvDiet, diet.isEmpty ? l.rvNone : diet),
                _ReviewLine(
                  l.rvAlg,
                  allergens.isEmpty ? l.rvNone : allergens,
                ),
                const SizedBox(height: 2),
                Text(
                  l.rvDietNote,
                  style: const TextStyle(
                    fontFamily: SavFonts.sans,
                    fontSize: 11.5,
                    height: 1.35,
                    color: SavColors.txt3,
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: _goEditProfile,
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size.fromHeight(38),
                      side: const BorderSide(color: SavColors.border),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      '${l.editInProfile} →',
                      style: const TextStyle(
                        fontFamily: SavFonts.sans,
                        fontSize: 12.5,
                        fontWeight: FontWeight.w700,
                        color: SavColors.navy,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                _ReviewLine(
                  l.rvNotes,
                  d.notes.trim().isEmpty ? l.rvNone : d.notes.trim(),
                ),
                const SizedBox(height: 2),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () => controller.goToStep(1),
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size.fromHeight(38),
                      side: const BorderSide(color: SavColors.border),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      l.editRequest,
                      style: const TextStyle(
                        fontFamily: SavFonts.sans,
                        fontSize: 12.5,
                        fontWeight: FontWeight.w700,
                        color: SavColors.navy,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (d.categories.contains(FoodCategory.infantFormula)) ...[
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFFFFBEB),
              border: Border.all(color: const Color(0xFFFDE68A)),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.warning_amber_rounded,
                    size: 17, color: SavColors.pillAmberFg),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    l.formulaNote,
                    style: const TextStyle(
                      fontFamily: SavFonts.sans,
                      fontSize: 11.5,
                      height: 1.4,
                      color: SavColors.pillAmberFg,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
        const SizedBox(height: 14),
        SizedBox(
          width: double.infinity,
          child: SavButton(
            label: l.submitRequest,
            busy: controller.isSubmitting.value,
            onPressed: controller.isSubmitting.value
                ? null
                : () => _handleSubmit(c, l),
          ),
        ),
      ],
    );
  }

  // ── Footer (Back / Next / Submit) ───────────────────────────────────────
  Widget _footer(BuildContext c, AppLocalizations l, RequestDraft d) {
    final isLast = d.step == kWizardSteps;
    return Container(
      padding: const EdgeInsets.fromLTRB(
        SavSpace.x16, SavSpace.x10, SavSpace.x16, SavSpace.x12,
      ),
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
            flex: d.step > 1 ? 2 : 1,
            child: Obx(() => SavButton(
              label: isLast ? l.submitRequest : l.stepNext,
              busy: controller.isSubmitting.value,
              onPressed: controller.isSubmitting.value
                  ? null
                  : () {
                      if (isLast) {
                        _handleSubmit(c, l);
                        return;
                      }
                      if (d.step == 1 && d.categories.isEmpty) {
                        SavFeedback.toast(
                          c,
                          l.errNoCat,
                          tone: FeedbackTone.error,
                        );
                        return;
                      }
                      if (d.step == 2 && d.method == null) {
                        SavFeedback.toast(
                          c,
                          l.errNoMethod,
                          tone: FeedbackTone.error,
                        );
                        return;
                      }
                      controller.next();
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
                  ? SavColors.blue
                  : const Color(0xffE5E7EB),
              width: selected ? 1.5 : 1,
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

class _ReviewCard extends StatelessWidget {
  const _ReviewCard({
    required this.title,
    required this.icon,
    required this.children,
    required this.onEdit,
  });

  final String title;
  final IconData icon;
  final List<Widget> children;
  final VoidCallback onEdit;

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
              Icon(icon, size: 18, color: SavColors.navy),
              const SizedBox(width: SavSpace.x8),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontFamily: SavFonts.serif,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: SavColors.navy,
                  ),
                ),
              ),
              TextButton(
                onPressed: onEdit,
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  AppLocalizations.of(context).edit,
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
          const SizedBox(height: SavSpace.x14),
          ...children,
        ],
      ),
    );
  }
}

/// The request route is a full-screen wizard, but v56 keeps the five-item
/// application navigation visible beneath it. The Request item stays active
/// while the wizard is open. Tapping another item exits the draft and returns
/// to the shell tab, just like the reference app.
class _RequestBottomNav extends StatelessWidget {
  const _RequestBottomNav();

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final shell = Get.isRegistered<ShellController>()
        ? Get.find<ShellController>()
        : null;

    void goTo(int tab) {
      if (shell == null) return;
      shell.changeTab(tab);
      shell.setRequestActive(false);
      shell.setRequestReturn(false);
      Get.offAllNamed(Routes.home);
    }

    return SafeArea(
      top: false,
      child: Container(
        // minHeight (not a fixed height) so larger text scales / taller
        // labels grow the bar instead of overflowing it.
        constraints: const BoxConstraints(minHeight: 72),
        color: SavColors.surface,
        padding: const EdgeInsets.symmetric(horizontal: SavSpace.x8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _RequestNavItem(
              icon: Icons.home_outlined,
              selectedIcon: Icons.home,
              label: l.navHome,
              selected: false,
              onTap: () => goTo(kTabHome),
            ),
            _RequestNavItem(
              icon: Icons.event_outlined,
              selectedIcon: Icons.event,
              label: l.navEvents,
              selected: false,
              onTap: () => goTo(kTabAlerts),
            ),
            Expanded(
              child: InkWell(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: SavSpace.x6),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(SavRadius.r16),
                          border: Border.all(color: SavColors.green, width: 2.5),
                          color: SavColors.surface,
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x16000000),
                              blurRadius: 8,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(SavRadius.r16 - 2),
                          child: Image.asset(
                            SavImages.navRequest,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => const Icon(
                              Icons.volunteer_activism_outlined,
                              color: SavColors.navy,
                              size: 24,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        l.navRequest,
                        style: const TextStyle(
                          fontFamily: SavFonts.sans,
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: SavColors.navy,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            _RequestNavItem(
              icon: Icons.receipt_long_outlined,
              selectedIcon: Icons.receipt_long,
              label: l.navActivity,
              selected: false,
              onTap: () => goTo(kTabActivity),
            ),
            _RequestNavItem(
              icon: Icons.settings_outlined,
              selectedIcon: Icons.settings,
              label: l.navSettings,
              selected: false,
              onTap: () => goTo(kTabProfile),
            ),
          ],
        ),
      ),
    );
  }
}

class _RequestNavItem extends StatelessWidget {
  const _RequestNavItem({
    required this.icon,
    required this.selectedIcon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final IconData selectedIcon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = selected ? SavColors.navy : SavColors.txt4;
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: SavSpace.x6),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(selected ? selectedIcon : icon, size: 22, color: color),
              const SizedBox(height: 2),
              Text(
                label,
                style: TextStyle(
                  fontFamily: SavFonts.sans,
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ReviewLine extends StatelessWidget {
  const _ReviewLine(this.label, this.value);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: SavColors.border)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 4,
            child: Text(
              label,
              style: const TextStyle(
                fontFamily: SavFonts.sans,
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: SavColors.txt2,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 6,
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontFamily: SavFonts.sans,
                fontSize: 12,
                fontWeight: FontWeight.w700,
                height: 1.25,
                color: SavColors.navy,
              ),
            ),
          ),
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
