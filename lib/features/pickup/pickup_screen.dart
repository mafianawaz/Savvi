import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/formatting/formatters.dart';
import '../../core/theme/tokens.dart';
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
import '../auth/auth_controller.dart';
import 'pickup_controller.dart';

/// Pickup details: status chip, window/location, and the pickup code + QR.
/// Codes and QR are issued by the backend — the frontend only displays them,
/// and shows a waiting state until a code exists (locked decision). Reached
/// from Request Detail's "View Pickup" action, always via
/// `Get.toNamed(Routes.pickup, arguments: request.id)`.
class PickupScreen extends StatelessWidget {
  const PickupScreen({super.key, required this.requestId});

  final String requestId;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final controller = Get.find<PickupController>(tag: requestId);

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

        return _body(context, l, r);
      }),
    );
  }

  Widget _body(BuildContext context, AppLocalizations l, MemberRequest r) {
    final auth = Get.find<AuthController>();
    final fmt = Get.find<Fmt>();
    final authState = auth.state.value;
    final nonprofit = authState is AuthSignedIn
        ? (authState.profile['nonprofit'] as String? ?? '\u2014')
        : '\u2014';

    final windowLabel = r.pickupWindowStart == null
        ? l.naLabel
        : fmt.window(
      r.pickupWindowStart!,
      r.pickupWindowEnd,
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
        Text(
          l.pkTitle,
          style: const TextStyle(
              fontFamily: SavFonts.serif, fontSize: 24, color: SavColors.navy),
        ),
        const SizedBox(height: SavSpace.x4),
        Text(
          l.pkSub,
          style: const TextStyle(
            fontFamily: SavFonts.sans,
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: SavColors.txt3,
          ),
        ),
        const SizedBox(height: SavSpace.x16),
        _statusChip(l, r.status),
        const SizedBox(height: SavSpace.x12),
        SavCard(
          child: Column(
            children: [
              _row(l.requestIdLabel, r.id),
              _row(l.nonprofitLabel, nonprofit),
              _row(l.pkWindow, windowLabel),
              _row(l.pkLocation, r.pickupLocation ?? l.naLabel),
              _row(l.rvHousehold, r.household, last: true),
            ],
          ),
        ),
        const SizedBox(height: SavSpace.x12),
        SavButton(
          label: l.directions,
          variant: SavButtonVariant.ghost,
          onPressed: () => SavFeedback.toast(context, l.protoNote),
        ),
        const SizedBox(height: SavSpace.x12),
        _codeBlock(context, l, r),
        if (r.status == RequestStatus.missed) ...[
          const SizedBox(height: SavSpace.x12),
          SavButton(
            label: l.pkReschedule,
            onPressed: () => SavFeedback.toast(context, l.pkReschedSent,
                tone: FeedbackTone.success),
          ),
        ],
      ],
    );
  }

  /// Plain neutral status indicator — v56 dropped the old per-status
  /// title/body messaging in favour of a single outlined chip showing the
  /// current status label.
  Widget _statusChip(AppLocalizations l, RequestStatus st) {
    final icon = switch (st) {
      RequestStatus.readyPickup ||
      RequestStatus.pickupConfirmed ||
      RequestStatus.completed =>
      Icons.check_circle_outline,
      RequestStatus.missed => Icons.warning_amber_rounded,
      _ => Icons.access_time,
    };
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
          horizontal: SavSpace.x14, vertical: SavSpace.x12),
      decoration: BoxDecoration(
        color: SavColors.page,
        borderRadius: SavRadius.field,
        border: Border.all(color: SavColors.border, width: 1.5),
      ),
      child: Row(
        children: [
          Icon(icon, size: 16, color: SavColors.txt3),
          const SizedBox(width: SavSpace.x10),
          Text(
            Labels.status(l, st),
            style: const TextStyle(
              fontFamily: SavFonts.sans,
              fontSize: 13.5,
              fontWeight: FontWeight.w700,
              color: SavColors.txt2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _codeBlock(BuildContext context, AppLocalizations l, MemberRequest r) {
    // Codes/QR are backend-issued. Until one exists, show a waiting state.
    if (r.pickupCode == null) {
      return SavCard(
        child: Column(
          children: [
            Container(
              width: 150,
              height: 34,
              decoration: BoxDecoration(
                color: SavColors.border,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const SizedBox(height: SavSpace.x10),
            Text(
              l.pkReadyBody,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: SavFonts.sans,
                fontSize: 12.5,
                fontWeight: FontWeight.w500,
                color: SavColors.txt3,
              ),
            ),
          ],
        ),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.all(SavSpace.x20),
          decoration:
          BoxDecoration(color: SavColors.navy, borderRadius: SavRadius.cardLg),
          child: Column(
            children: [
              Text(
                l.pickupCodeLabel.toUpperCase(),
                style: const TextStyle(
                  fontFamily: SavFonts.sans,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.0,
                  color: Color(0xAAFFFFFF),
                ),
              ),
              const SizedBox(height: SavSpace.x8),
              Text(
                r.pickupCode!,
                style: const TextStyle(
                  fontFamily: SavFonts.serif,
                  fontSize: 32,
                  letterSpacing: 2,
                  color: SavColors.green,
                ),
              ),
              const SizedBox(height: SavSpace.x6),
              Text(
                l.pkCodeSub,
                style: const TextStyle(
                  fontFamily: SavFonts.sans,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Color(0xAAFFFFFF),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: SavSpace.x10),
        SavButton(
          label: l.pkShowQr,
          variant: SavButtonVariant.ghost,
          onPressed: () => _showQr(context, l, r),
        ),
        if (r.status == RequestStatus.readyPickup) ...[
          const SizedBox(height: SavSpace.x10),
          SavButton(
            label: l.scanAtCounter,
            onPressed: () => SavFeedback.toast(context, l.protoNote),
          ),
        ],
        const SizedBox(height: SavSpace.x12),
        SavNotice(message: l.pkWarn, tone: NoticeTone.amber, icon: Icons.warning_amber_rounded),
      ],
    );
  }

  void _showQr(BuildContext context, AppLocalizations l, MemberRequest r) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: SavColors.surface,
      shape: const RoundedRectangleBorder(borderRadius: SavRadius.sheet),
      builder: (ctx) => SafeArea(
        child: Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(
                SavSpace.x20, SavSpace.x12, SavSpace.x20, SavSpace.x20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
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
                  l.pkQrLabel,
                  style: const TextStyle(
                      fontFamily: SavFonts.serif, fontSize: 20, color: SavColors.navy),
                ),
                const SizedBox(height: SavSpace.x8),
                Text(
                  l.pkCodeSub,
                  style: const TextStyle(
                    fontFamily: SavFonts.sans,
                    fontSize: 13.5,
                    fontWeight: FontWeight.w500,
                    color: SavColors.txt3,
                  ),
                ),
                const SizedBox(height: SavSpace.x20),
                Center(
                  // Backend-issued QR renders here in production; the frontend
                  // never generates the code/QR itself.
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      color: SavColors.page,
                      borderRadius: SavRadius.card,
                      border: Border.all(color: SavColors.border, width: 1.5),
                    ),
                    child:
                    const Icon(Icons.qr_code_2, size: 120, color: SavColors.navy),
                  ),
                ),
                const SizedBox(height: SavSpace.x16),
                Center(
                  child: Text(
                    r.pickupCode!,
                    style: const TextStyle(
                      fontFamily: SavFonts.serif,
                      fontSize: 24,
                      letterSpacing: 2,
                      color: SavColors.navy,
                    ),
                  ),
                ),
                const SizedBox(height: SavSpace.x6),
                Center(
                  child: Text(
                    l.protoNote,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: SavFonts.sans,
                      fontSize: 11.5,
                      fontWeight: FontWeight.w500,
                      color: SavColors.txt4,
                    ),
                  ),
                ),
                const SizedBox(height: SavSpace.x16),
                SavNotice(
                    message: l.pkWarn,
                    tone: NoticeTone.amber,
                    icon: Icons.warning_amber_rounded),
                const SizedBox(height: SavSpace.x16),
                SavButton(
                  label: l.actionClose,
                  variant: SavButtonVariant.ghost,
                  onPressed: () => Navigator.of(ctx).pop(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _row(String label, String value, {bool last = false}) => Container(
    padding: const EdgeInsets.symmetric(vertical: SavSpace.x10),
    decoration: last
        ? null
        : const BoxDecoration(
      border:
      Border(bottom: BorderSide(color: SavColors.border, width: 1)),
    ),
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
