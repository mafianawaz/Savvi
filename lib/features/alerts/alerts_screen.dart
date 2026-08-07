import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/theme/tokens.dart';
import '../../data/models/member_request.dart';
import '../../l10n/app_localizations.dart';
import '../../shared/patterns/error_text.dart';
import '../../shared/patterns/feedback.dart';
import '../../shared/patterns/state_views.dart';
import 'alerts_controller.dart';
import 'package:get/get.dart';
import '../../core/formatting/formatters.dart';
import '../../core/network/savvi_api.dart';

/// Opens Google Maps with directions to [address]. Uses a text-search deep
/// link rather than lat/lng since [FoodAlert.where] is a free-text address —
/// Maps geocodes it on the other end. Falls back to a toast if no maps app
/// or browser can handle the link (e.g. unsupported platform/simulator).
Future<void> _openDirections(BuildContext context, AppLocalizations l, String address) async {
  final uri = Uri.https(
    'www.google.com',
    '/maps/search/',
    {'api': '1', 'query': address},
  );

  final launched = await launchUrl(uri, mode: LaunchMode.externalApplication);

  if (!launched && context.mounted) {
    SavFeedback.toast(context, l.errUnknown, tone: FeedbackTone.error);
  }
}

/// Food Access Alerts / "Events" (v56 label; v45 fidelity for the
/// interaction): hot meals and distributions nearby, each with an editable
/// RSVP. The stepper starts at 0 and the member must select at least 1
/// before confirming; the count is capped at min(household, remaining).
/// The backend validates the final count — the frontend is guidance only.
///
class AlertsScreen extends StatelessWidget {
  const AlertsScreen({super.key, required this.household});

  /// Passed down from the signed-in profile (see MainShell), rather than
  /// read here, since AuthController isn't otherwise a dependency of this
  /// screen.
  final int household;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);

    return GetBuilder<AlertsController>(
      init: AlertsController(api: Get.find<SavviApi>()),
      builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                SavSpace.x16,
                SavSpace.x14,
                SavSpace.x16,
                SavSpace.x4,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l.alertsTitle,
                    style: const TextStyle(
                      fontFamily: SavFonts.serif,
                      fontSize: 21,
                      color: SavColors.navy,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    l.alertsSubtitle,
                    style: const TextStyle(
                      fontFamily: SavFonts.sans,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: SavColors.txt3,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return StateViews.loading();
                }

                if (controller.errorKey.value != null &&
                    controller.alerts.isEmpty) {
                  return StateViews.error(
                    title: l.errUnknown,
                    retryLabel: l.tryAgain,
                    onRetry: controller.load,
                  );
                }

                if (controller.alerts.isEmpty) {
                  return StateViews.empty(
                    title: l.alertsEmpty,
                    message: l.alertsEmptyBody,
                    icon: Icons.event_outlined,
                  );
                }

                return RefreshIndicator(
                  onRefresh: controller.refresh,
                  child: ListView.separated(
                    padding: const EdgeInsets.fromLTRB(
                      SavSpace.x16,
                      SavSpace.x12,
                      SavSpace.x16,
                      SavSpace.x24,
                    ),
                    itemCount: controller.alerts.length,
                    separatorBuilder: (_, __) =>
                    const SizedBox(height: SavSpace.x12),
                    itemBuilder: (_, i) => _AlertCard(
                      alert: controller.alerts[i],
                      household: household,
                      controller: controller,
                    ),
                  ),
                );
              }),
            ),
          ],
        );
      },
    );
  }
}

class _AlertCard extends StatefulWidget {
  const _AlertCard({
    required this.alert,
    required this.household,
    required this.controller,
  });

  final FoodAlert alert;
  final int household;
  final AlertsController controller;

  @override
  State<_AlertCard> createState() => _AlertCardState();
}

class _AlertCardState extends State<_AlertCard> {
  int _count = 0; // starts at 0 — member must actively select
  bool _editing = false;

  bool get _confirmed => widget.alert.rsvp > 0;
  int get _max =>
      widget.household < widget.alert.left ? widget.household : widget.alert.left;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final fmt = Get.find<Fmt>();
    final a = widget.alert;
    final isHot = a.type == AlertType.hot;
    final accent = isHot ? SavColors.amber : SavColors.greenDark;
    final accentBg = isHot ? SavColors.amberLight : SavColors.greenLight;

    return ClipRRect(
      borderRadius: SavRadius.card,
      child: Container(
        decoration: BoxDecoration(
          color: SavColors.surface,
          borderRadius: SavRadius.card,
          border: Border.all(color: SavColors.border, width: 1.5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Photo strip — hot meals and distributions get distinct
            // photography, matching the photo-led treatment used on Home.
            SizedBox(
              height: 84,
              width: double.infinity,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    isHot ? SavImages.actCard1 : SavImages.actCard2,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stack) => Container(
                      color: accentBg,
                    ),
                  ),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.05),
                          Colors.black.withOpacity(0.45),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(SavSpace.x10),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: SavSpace.x10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: accentBg,
                            borderRadius: SavRadius.pill,
                          ),
                          child: Text(
                            isHot ? l.alertTypeHot : l.alertTypeDist,
                            style: TextStyle(
                              fontFamily: SavFonts.sans,
                              fontSize: 10.5,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.3,
                              color: accent,
                            ),
                          ),
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: SavSpace.x8,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.35),
                            borderRadius: SavRadius.pill,
                          ),
                          child: Text(
                            l.alertSpotsLeft(a.left),
                            style: const TextStyle(
                              fontFamily: SavFonts.sans,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(SavSpace.x16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    a.title,
                    style: const TextStyle(
                      fontFamily: SavFonts.serif,
                      fontSize: 17,
                      color: SavColors.navy,
                    ),
                  ),
                  const SizedBox(height: SavSpace.x4),
                  Text(
                    a.host,
                    style: const TextStyle(
                      fontFamily: SavFonts.sans,
                      fontSize: 12.5,
                      fontWeight: FontWeight.w600,
                      color: SavColors.txt2,
                    ),
                  ),
                  const SizedBox(height: SavSpace.x10),
                  _metaRow(
                    Icons.schedule,
                    fmt.window(a.windowStart, a.windowEnd),
                  ),
                  const SizedBox(height: SavSpace.x6),
                  _directionsRow(context, l, a.where),
                  const SizedBox(height: SavSpace.x14),
                  if (!_confirmed || _editing)
                    _rsvpRow(l, a)
                  else
                    _confirmedRow(l),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _metaRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 14, color: SavColors.txt3),
        const SizedBox(width: SavSpace.x6),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontFamily: SavFonts.sans,
              fontSize: 12.5,
              fontWeight: FontWeight.w500,
              color: SavColors.txt2,
            ),
          ),
        ),
      ],
    );
  }

  /// Location row that opens Google Maps with directions on tap, matching
  /// the v56 reference. Underlined + navy to read as a link rather than
  /// plain metadata like the time row above it.
  Widget _directionsRow(BuildContext context, AppLocalizations l, String where) {
    return Semantics(
      button: true,
      label: '$where. ${l.directions}',
      excludeSemantics: true,
      child: InkWell(
        onTap: () => _openDirections(context, l, where),
        borderRadius: BorderRadius.circular(4),
        child: Row(
          children: [
            const Icon(Icons.place_outlined, size: 14, color: SavColors.navy),
            const SizedBox(width: SavSpace.x6),
            Expanded(
              child: Text(
                where,
                style: const TextStyle(
                  fontFamily: SavFonts.sans,
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                  color: SavColors.navy,
                  decoration: TextDecoration.underline,
                  decorationColor: SavColors.navy,
                ),
              ),
            ),
            const SizedBox(width: SavSpace.x4),
            const Icon(Icons.chevron_right, size: 16, color: SavColors.navy),
          ],
        ),
      ),
    );
  }

  Widget _rsvpRow(AppLocalizations l, FoodAlert a) {
    final canConfirm = _count >= 1;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l.alertRsvpPrompt,
          style: const TextStyle(
            fontFamily: SavFonts.sans,
            fontSize: 12.5,
            fontWeight: FontWeight.w700,
            color: SavColors.txt2,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          l.alertRsvpMax(widget.household),
          style: const TextStyle(
            fontFamily: SavFonts.sans,
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: SavColors.txt3,
          ),
        ),
        const SizedBox(height: SavSpace.x8),
        Row(
          children: [
            _stepBtn(Icons.remove, _count > 0, () => setState(() => _count--)),
            SizedBox(
              width: 48,
              child: Text(
                '$_count',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: SavFonts.sans,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: SavColors.navy,
                ),
              ),
            ),
            _stepBtn(
              Icons.add,
              _count < _max,
                  () => setState(() => _count++),
            ),
            const SizedBox(width: SavSpace.x12),
            Expanded(
              child: SizedBox(
                height: 44,
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: SavColors.navy,
                    disabledBackgroundColor: SavColors.border,
                    shape:
                    RoundedRectangleBorder(borderRadius: SavRadius.field),
                  ),
                  onPressed: canConfirm
                      ? () async {
                    final err = await widget.controller.rsvp(
                      a.id,
                      _count,
                    );

                    if (!mounted) return;

                    if (err == null) {
                      setState(() => _editing = false);

                      if (context.mounted) {
                        SavFeedback.toast(
                          context,
                          l.alertRsvpConfirmed(_count),
                          tone: FeedbackTone.success,
                        );
                      }
                    } else if (context.mounted) {
                      SavFeedback.toast(
                        context,
                        errText(l, err),
                        tone: FeedbackTone.error,
                      );
                    }
                  }
                      : null,
                  child: Text(
                    l.alertRsvpConfirm,
                    style: const TextStyle(
                      fontFamily: SavFonts.sans,
                      fontSize: 13.5,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        if (!canConfirm)
          Padding(
            padding: const EdgeInsets.only(top: SavSpace.x8),
            child: Text(
              l.alertRsvpSelectFirst,
              style: const TextStyle(
                fontFamily: SavFonts.sans,
                fontSize: 11.5,
                fontWeight: FontWeight.w600,
                color: SavColors.pillAmberFg,
              ),
            ),
          ),
      ],
    );
  }

  Widget _confirmedRow(AppLocalizations l) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.all(SavSpace.x12),
          decoration: BoxDecoration(
            color: SavColors.greenLight,
            borderRadius: SavRadius.field,
            border: Border.all(color: const Color(0xFFA7D7A8)),
          ),
          child: Row(
            children: [
              const Icon(
                Icons.check_circle,
                size: 18,
                color: SavColors.greenDark,
              ),
              const SizedBox(width: SavSpace.x8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l.alertRsvpConfirmed(widget.alert.rsvp),
                      style: const TextStyle(
                        fontFamily: SavFonts.sans,
                        fontSize: 12.5,
                        fontWeight: FontWeight.w700,
                        color: SavColors.pillGreenFg,
                      ),
                    ),
                    Text(
                      l.alertRsvpSeeYou,
                      style: const TextStyle(
                        fontFamily: SavFonts.sans,
                        fontSize: 11.5,
                        fontWeight: FontWeight.w500,
                        color: SavColors.pillGreenFg,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: SavSpace.x8),
        Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 44,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: SavColors.navy,
                    side: const BorderSide(
                      color: SavColors.border,
                      width: 1.5,
                    ),
                    shape:
                    RoundedRectangleBorder(borderRadius: SavRadius.field),
                  ),
                  onPressed: () => setState(() {
                    _count = widget.alert.rsvp;
                    _editing = true;
                  }),
                  child: Text(
                    l.alertRsvpChange,
                    style: const TextStyle(
                      fontFamily: SavFonts.sans,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: SavSpace.x10),
            Expanded(
              child: SizedBox(
                height: 44,
                child: TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: SavColors.red,
                    shape:
                    RoundedRectangleBorder(borderRadius: SavRadius.field),
                  ),
                  onPressed: () async {
                    final err = await widget.controller.cancel(
                      widget.alert.id,
                    );

                    if (!mounted) return;

                    if (err == null) {
                      setState(() => _count = 0);

                      if (context.mounted) {
                        SavFeedback.toast(
                          context,
                          l.alertRsvpCancelled,
                          tone: FeedbackTone.info,
                        );
                      }
                    } else if (context.mounted) {
                      SavFeedback.toast(
                        context,
                        errText(l, err),
                        tone: FeedbackTone.error,
                      );
                    }
                  },
                  child: Text(
                    l.alertRsvpCancel,
                    style: const TextStyle(
                      fontFamily: SavFonts.sans,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _stepBtn(IconData icon, bool enabled, VoidCallback onTap) {
    return SizedBox(
      width: 44,
      height: 44,
      child: IconButton(
        onPressed: enabled ? onTap : null,
        icon: Icon(icon, size: 20),
        style: IconButton.styleFrom(
          backgroundColor: SavColors.page,
          foregroundColor: SavColors.navy,
          disabledForegroundColor: SavColors.txt4,
          shape: const RoundedRectangleBorder(
            borderRadius: SavRadius.field,
            side: BorderSide(color: SavColors.border, width: 1.5),
          ),
        ),
      ),
    );
  }
}
