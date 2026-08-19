import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/formatting/formatters.dart';
import '../../core/routing/app_router.dart';
import '../../core/theme/tokens.dart';
import '../../data/models/enums.dart';
import '../../data/models/labels.dart';
import '../../data/models/member_request.dart';
import '../../data/models/request_status.dart';
import '../../l10n/app_localizations.dart';
import '../../shared/patterns/error_text.dart';
import '../../shared/patterns/feedback.dart';
import '../../shared/patterns/state_views.dart';
import '../../shared/widgets/sav_button.dart';
import '../../shared/widgets/sav_cards.dart';
import '../../shared/widgets/sav_inputs.dart';
import 'edit_request_sheet.dart';
import 'request_detail_controller.dart';

const _canEdit = <RequestStatus>{
  RequestStatus.submitted,
  RequestStatus.needsUpdate,
};
const _canCancel = <RequestStatus>{
  RequestStatus.submitted,
  RequestStatus.needsUpdate,
  RequestStatus.approved,
  RequestStatus.scheduled,
  RequestStatus.preparing,
  RequestStatus.readyPickup,
};
const _trackDelivery = <RequestStatus>{
  RequestStatus.scheduled,
  RequestStatus.preparing,
  RequestStatus.outForDelivery,
  RequestStatus.nearby,
  RequestStatus.delivered,
  RequestStatus.delayed,
  RequestStatus.unavailable,
};
const _viewPickup = <RequestStatus>{
  RequestStatus.approved,
  RequestStatus.preparing,
  RequestStatus.readyPickup,
  RequestStatus.pickupConfirmed,
  RequestStatus.completed,
  RequestStatus.missed,
};

/// Request detail: status, facts, categories/dietary/allergens/notes, a
/// per-method progress timeline, and edit/cancel actions. Reached from
/// Home's Active Request card and from Activity's request rows, always via
/// `Get.toNamed(Routes.requestDetail, arguments: request.id)`.
class RequestDetailScreen extends StatelessWidget {
  const RequestDetailScreen({super.key, required this.requestId});

  final String requestId;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final controller = Get.find<RequestDetailController>(tag: requestId);

    return Scaffold(
      backgroundColor: SavColors.page,
      appBar: AppBar(
        backgroundColor: SavColors.surface,
        elevation: 0,
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        titleSpacing: SavSpace.x8,
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
      ),
      body: Obx(() {
        final r = controller.request.value;
        final isLoading = controller.isLoading.value;
        final errorKey = controller.errorKey.value;

        if (r == null && isLoading) return StateViews.loading();

        if (r == null) {
          return StateViews.empty(
            title: l.notFoundTitle,
            message: errorKey != null ? errText(l, errorKey) : l.actEmptyBody,
            icon: Icons.search_off,
          );
        }

        return _Body(controller: controller, request: r);
      }),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({required this.controller, required this.request});

  final RequestDetailController controller;
  final MemberRequest request;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final fmt = Get.find<Fmt>();
    final r = request;

    final dateLabel = fmt.dateTime(
      r.createdAt,
      relativeWords: RelativeDayWords(
        today: l.relToday,
        yesterday: l.relYesterday,
        tomorrow: l.relTomorrow,
      ),
    );

    return ListView(
      padding: const EdgeInsets.fromLTRB(
          SavSpace.x16, SavSpace.x8, SavSpace.x16, SavSpace.x24),
      children: [
        // ── Heading ──
        Padding(
          padding: const EdgeInsets.only(bottom: SavSpace.x16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                r.id,
                style: const TextStyle(
                  fontFamily: SavFonts.serif,
                  fontSize: 22,
                  color: SavColors.navy,
                ),
              ),
              const SizedBox(height: SavSpace.x4),
              Text(
                '${Labels.method(l, r.method)} \u00b7 $dateLabel',
                style: const TextStyle(
                  fontFamily: SavFonts.sans,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: SavColors.txt3,
                ),
              ),
            ],
          ),
        ),
        // ── Facts card ──
        SavCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    l.statusLabel.toUpperCase(),
                    style: const TextStyle(
                      fontFamily: SavFonts.sans,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                      color: SavColors.txt4,
                    ),
                  ),
                  StatusPill(status: r.status, label: Labels.status(l, r.status)),
                ],
              ),
              const SizedBox(height: SavSpace.x14),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: SavFactBox(
                      label: l.rvMethod,
                      value: Labels.method(l, r.method),
                    ),
                  ),
                  const SizedBox(width: SavSpace.x10),
                  Expanded(
                    child: SavFactBox(
                      label: l.rvHousehold,
                      value: r.household,
                    ),
                  ),
                ],
              ),
              if (r.weightLb != null) ...[
                const SizedBox(height: SavSpace.x10),
                SavFactBox(
                  label: l.weightLabel,
                  value: fmt.weight(lbs: r.weightLb),
                ),
              ],
              const Divider(height: SavSpace.x24, color: SavColors.border),
              _row(l.rvCats,
                  r.categories.map((c) => Labels.category(l, c)).join(', ')),
              _row(
                l.rvDiet,
                r.diet.isEmpty
                    ? l.rvNone
                    : r.diet.map((d) => Labels.diet(l, d)).join(', '),
              ),
              _row(
                l.rvAlg,
                r.allergens.isEmpty
                    ? l.rvNone
                    : r.allergens.map((a) => Labels.allergen(l, a)).join(', '),
              ),
              if (r.notes != null) _row(l.rvNotes, r.notes!),
              if (r.pickupCode != null) _row(l.pickupCodeLabel, r.pickupCode!),
            ],
          ),
        ),
        if (r.categories.contains(FoodCategory.infantFormula))
          Padding(
            padding: const EdgeInsets.only(top: SavSpace.x12),
            child: SavNotice(
              message: l.formulaNote,
              tone: NoticeTone.amber,
              icon: Icons.lock_outline,
              title: l.catInfantFormula,
            ),
          ),
        const SizedBox(height: SavSpace.x12),
        // ── Timeline card ──
        SavCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l.statusLabel.toUpperCase(),
                style: const TextStyle(
                  fontFamily: SavFonts.sans,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                  color: SavColors.txt4,
                ),
              ),
              const SizedBox(height: SavSpace.x14),
              _Timeline(request: r, l: l, fmt: fmt),
            ],
          ),
        ),
        const SizedBox(height: SavSpace.x16),
        Obx(() => _actions(context, l, r)),
      ],
    );
  }

  Widget _actions(BuildContext context, AppLocalizations l, MemberRequest r) {
    final showTrack =
        r.method == RequestMethod.delivery && _trackDelivery.contains(r.status);
    final showPickup =
        r.method == RequestMethod.pickup && _viewPickup.contains(r.status);
    final canEdit = _canEdit.contains(r.status);
    final canCancel = _canCancel.contains(r.status);
    final isCancelling = controller.isCancelling.value;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (showTrack)
          SavButton(
            label: l.trackDelivery,
            icon: Icons.local_shipping_outlined,
            onPressed: () => Get.toNamed(Routes.delivery, arguments: r.id),
          )
        else if (showPickup)
          SavButton(
            label: l.viewPickup,
            icon: Icons.qr_code_2,
            onPressed: () => Get.toNamed(Routes.pickup, arguments: r.id),
          ),
        if (showTrack || showPickup) const SizedBox(height: SavSpace.x10),
        Row(
          children: [
            Expanded(
              child: SavButton(
                label: l.editRequest,
                variant: SavButtonVariant.ghost,
                onPressed:
                    canEdit ? () => EditRequestSheet.show(context, r) : null,
              ),
            ),
            const SizedBox(width: SavSpace.x10),
            Expanded(
              child: SavButton(
                label: l.cancelRequest,
                variant:
                    canCancel ? SavButtonVariant.danger : SavButtonVariant.ghost,
                busy: isCancelling,
                onPressed: canCancel && !isCancelling
                    ? () => _confirmCancel(context, l, r)
                    : null,
              ),
            ),
          ],
        ),
        if (!canEdit)
          Padding(
            padding: const EdgeInsets.only(top: SavSpace.x10),
            child: Text(
              l.editLocked,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: SavFonts.sans,
                fontSize: 11.5,
                height: 1.45,
                fontWeight: FontWeight.w500,
                color: SavColors.txt4,
              ),
            ),
          ),
      ],
    );
  }

  Future<void> _confirmCancel(
      BuildContext context, AppLocalizations l, MemberRequest r) async {
    final confirmed = await SavFeedback.confirm(
      context,
      title: l.cancelConfirmTitle,
      message: l.cancelConfirmBody,
      confirmLabel: l.cancelRequest,
      cancelLabel: l.keepRequest,
      destructive: true,
    );
    if (!confirmed) return;

    final ok = await controller.cancel();
    if (!context.mounted) return;

    if (ok) {
      SavFeedback.toast(context, l.requestCancelled, tone: FeedbackTone.info);
      Get.back();
    } else {
      final key = controller.errorKey.value;
      SavFeedback.toast(
        context,
        key != null ? errText(l, key) : l.errUnknown,
        tone: FeedbackTone.error,
      );
    }
  }

  Widget _row(String label, String value) => Padding(
        padding: const EdgeInsets.only(top: SavSpace.x10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontFamily: SavFonts.sans,
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
                color: SavColors.txt3,
              ),
            ),
            const SizedBox(width: SavSpace.x16),
            Flexible(
              child: Text(
                value,
                textAlign: TextAlign.right,
                style: const TextStyle(
                  fontFamily: SavFonts.sans,
                  fontSize: 12.5,
                  height: 1.4,
                  fontWeight: FontWeight.w700,
                  color: SavColors.navy,
                ),
              ),
            ),
          ],
        ),
      );
}

/// Per-method progress timeline. Step state is derived from the current
/// status's position in the flow. Timestamps come from
/// [MemberRequest.statusHistory] when the backend has provided them; a step
/// with no history entry renders without a time. Off-timeline statuses
/// render as a warn node.
class _Timeline extends StatelessWidget {
  const _Timeline({required this.request, required this.l, required this.fmt});
  final MemberRequest request;
  final AppLocalizations l;
  final Fmt fmt;

  @override
  Widget build(BuildContext context) {
    final flow = StatusFlow.forMethod(request.method);
    final off = StatusFlow.isOffTimeline(request.status);
    final currentIdx = flow.indexOf(request.status);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i = 0; i < flow.length; i++)
          _step(
            label: Labels.status(l, flow[i]),
            time: request.statusHistory[flow[i]],
            state: off
                ? (i == 0 ? _StepState.done : _StepState.upcoming)
                : (i < currentIdx
                    ? _StepState.done
                    : i == currentIdx
                        ? _StepState.active
                        : _StepState.upcoming),
            isLast: i == flow.length - 1 && !off,
          ),
        if (off)
          _step(
            label: Labels.status(l, request.status),
            time: request.statusHistory[request.status],
            state: _StepState.warn,
            isLast: true,
          ),
      ],
    );
  }

  Widget _step({
    required String label,
    required DateTime? time,
    required _StepState state,
    required bool isLast,
  }) {
    final (dot, txt) = switch (state) {
      _StepState.done => (SavColors.green, SavColors.txt2),
      _StepState.active => (SavColors.navy, SavColors.navy),
      _StepState.warn => (SavColors.red, SavColors.pillRedFg),
      _StepState.upcoming => (SavColors.border, SavColors.txt4),
    };
    final lineColor =
        state == _StepState.done ? SavColors.green : SavColors.border;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 12,
                height: 12,
                margin: const EdgeInsets.only(top: 2),
                decoration: BoxDecoration(
                  color: state == _StepState.upcoming ? SavColors.surface : dot,
                  shape: BoxShape.circle,
                  border: Border.all(color: dot, width: 2),
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(width: 2, color: lineColor),
                ),
            ],
          ),
          const SizedBox(width: SavSpace.x12),
          Padding(
            padding: EdgeInsets.only(bottom: isLast ? 0 : SavSpace.x14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: TextStyle(
                        fontFamily: SavFonts.sans,
                        fontSize: 13.5,
                        fontWeight: state == _StepState.active ||
                                state == _StepState.warn
                            ? FontWeight.w700
                            : FontWeight.w600,
                        color: txt)),
                if (time != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Text(
                      fmt.time(time),
                      style: const TextStyle(
                        fontFamily: SavFonts.sans,
                        fontSize: 11.5,
                        fontWeight: FontWeight.w600,
                        color: SavColors.txt4,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

enum _StepState { done, active, upcoming, warn }
