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
import 'delivery_controller.dart';

/// Delivery status for an active request. Read-only, backend-driven. No
/// driver portal: driver details and exact routes are never shown (locked
/// decision). Reached from Request Detail's "Track Delivery" action, always
/// via `Get.toNamed(Routes.delivery, arguments: request.id)`.
class DeliveryTrackingScreen extends StatelessWidget {
  const DeliveryTrackingScreen({super.key, required this.requestId});

  final String requestId;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final controller = Get.find<DeliveryTrackingController>(tag: requestId);

    return Scaffold(
      backgroundColor: SavColors.page,
      appBar: _bar(l.trackTitle),
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

  AppBar _bar(String title) => AppBar(
        backgroundColor: SavColors.surface,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: SavColors.navy),
          onPressed: () => Get.back(),
        ),
        title: Text(
          title,
          style: const TextStyle(
              fontFamily: SavFonts.serif, fontSize: 18, color: SavColors.navy),
        ),
        centerTitle: true,
      );

  Widget _body(BuildContext context, AppLocalizations l, MemberRequest r) {
    final fmt = Get.find<Fmt>();
    final st = r.status;
    final live =
        st == RequestStatus.outForDelivery || st == RequestStatus.nearby;

    return ListView(
      padding: const EdgeInsets.fromLTRB(
          SavSpace.x16, SavSpace.x16, SavSpace.x16, SavSpace.x24),
      children: [
        Text(
          l.trackSub,
          style: const TextStyle(
            fontFamily: SavFonts.sans,
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: SavColors.txt3,
          ),
        ),
        const SizedBox(height: SavSpace.x14),
        _statusCard(context, l, fmt, r, st, live),
        const SizedBox(height: SavSpace.x12),
        SavNotice(
          message: l.trackPrivacy,
          tone: NoticeTone.blue,
          icon: Icons.shield_outlined,
        ),
        const SizedBox(height: SavSpace.x12),
        SavCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l.requestIdLabel.toUpperCase(),
                style: const TextStyle(
                  fontFamily: SavFonts.sans,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.4,
                  color: SavColors.txt4,
                ),
              ),
              const SizedBox(height: SavSpace.x4),
              Text(
                r.id,
                style: const TextStyle(
                  fontFamily: SavFonts.sans,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: SavColors.navy,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                r.categories.map((c) => Labels.category(l, c)).join(', '),
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
        const SizedBox(height: SavSpace.x12),
        SavButton(
          label: l.viewDetails,
          variant: SavButtonVariant.ghost,
          onPressed: () => Get.back(),
        ),
      ],
    );
  }

  Widget _statusCard(BuildContext context, AppLocalizations l, Fmt fmt,
      MemberRequest r, RequestStatus st, bool live) {
    final label = Labels.status(l, st);
    if (st == RequestStatus.delayed) {
      return _card(
        bg: SavColors.navy,
        title: l.trackDelayedTitle,
        body: l.trackDelayedBody,
        badge: label,
        warn: true,
        child: _track(r, animateHint: false),
      );
    }
    if (st == RequestStatus.unavailable) {
      return Column(
        children: [
          _card(
            bg: const Color(0xFF7F1D1D),
            title: l.trackUnavailTitle,
            body: l.trackUnavailBody,
            badge: label,
            warn: true,
          ),
          const SizedBox(height: SavSpace.x10),
          SavButton(
            label: l.switchPickup,
            variant: SavButtonVariant.ghost,
            onPressed: () => SavFeedback.toast(context, l.protoNote),
          ),
        ],
      );
    }
    if (st == RequestStatus.delivered || st == RequestStatus.completed) {
      return _card(
        bg: SavColors.greenDk,
        title: l.trackDoneTitle,
        body: l.trackDoneBody,
        badge: label,
      );
    }
    if (live) {
      final near = st == RequestStatus.nearby;
      return _card(
        bg: SavColors.navy,
        title: near ? l.trackNear : l.trackWay,
        body: near ? l.trackEtaNear : l.trackEtaLine,
        badge: label,
        child: Column(
          children: [
            _track(r, animateHint: true),
            const SizedBox(height: SavSpace.x14),
            Row(
              children: [
                Expanded(
                  child: _etaItem(
                    r.etaHi != null ? fmt.eta(lo: r.etaLo, hi: r.etaHi!) : '',
                    l.trackEst,
                  ),
                ),
                Expanded(
                  child: _etaItem(
                    r.distanceMi != null ? fmt.distance(r.distanceMi!) : '',
                    l.trackDist,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }
    return _card(bg: SavColors.navy, title: label, body: l.trackSub, badge: label);
  }

  Widget _card({
    required Color bg,
    required String title,
    required String body,
    required String badge,
    bool warn = false,
    Widget? child,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(SavSpace.x20),
      decoration: BoxDecoration(color: bg, borderRadius: SavRadius.cardLg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
                fontFamily: SavFonts.serif, fontSize: 20, color: Colors.white),
          ),
          const SizedBox(height: SavSpace.x6),
          Text(
            body,
            style: const TextStyle(
              fontFamily: SavFonts.sans,
              fontSize: 13,
              height: 1.5,
              fontWeight: FontWeight.w500,
              color: Color(0xCCFFFFFF),
            ),
          ),
          const SizedBox(height: SavSpace.x12),
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: SavSpace.x10, vertical: SavSpace.x6),
            decoration: BoxDecoration(
              color:
                  warn ? const Color(0x33FFFFFF) : const Color(0x2229E050),
              borderRadius: SavRadius.pill,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: warn ? Colors.white : SavColors.green,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: SavSpace.x6),
                Text(
                  badge,
                  style: const TextStyle(
                    fontFamily: SavFonts.sans,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          if (child != null) ...[const SizedBox(height: SavSpace.x14), child],
        ],
      ),
    );
  }

  // Simple non-live route visual (a real map/animation is deferred).
  Widget _track(MemberRequest r, {required bool animateHint}) {
    final pos =
        r.status == RequestStatus.nearby ? 0.72 : 0.32; // static position
    return LayoutBuilder(builder: (context, c) {
      final w = c.maxWidth;
      return SizedBox(
        height: 40,
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            Container(
              height: 4,
              decoration: BoxDecoration(
                color: const Color(0x33FFFFFF),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Container(
              height: 4,
              width: w * pos,
              decoration: BoxDecoration(
                color: SavColors.greenDk,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Positioned(
              left: (w * pos - 14).clamp(0, w - 28),
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.local_shipping,
                    size: 16, color: SavColors.greenDk),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _etaItem(String value, String label) => Column(
        children: [
          Text(
            value.isEmpty ? '\u2014' : value,
            style: const TextStyle(
                fontFamily: SavFonts.serif, fontSize: 20, color: Colors.white),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: const TextStyle(
              fontFamily: SavFonts.sans,
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Color(0xAAFFFFFF),
            ),
          ),
        ],
      );
}
