import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/formatting/formatters.dart';
import '../../core/theme/tokens.dart';
import '../../data/models/enums.dart';
import '../../data/models/labels.dart';
import '../../data/models/member_request.dart';
import '../../l10n/app_localizations.dart';
import '../../shared/widgets/sav_cards.dart';

/// Compact summary of a member request: photo method badge, id, status
/// pill, category photo chips, and (when present) weight in lbs/kg and
/// delivery ETA/distance. Used on Home (in-progress) and Activity.
class RequestCard extends StatelessWidget {
  const RequestCard({super.key, required this.request, this.onTap});

  final MemberRequest request;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final fmt = Get.find<Fmt>();
    final isDelivery = request.method == RequestMethod.delivery;

    return SavCard(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: SavRadius.field,
                child: SizedBox(
                  width: 42,
                  height: 42,
                  child: Image.asset(
                    SavImages.method(request.method),
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stack) =>
                        _methodFallback(isDelivery),
                  ),
                ),
              ),
              const SizedBox(width: SavSpace.x12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      request.id,
                      style: const TextStyle(
                        fontFamily: SavFonts.sans,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: SavColors.navy,
                      ),
                    ),
                    Text(
                      fmt.timestamp(request.createdAt),
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
              StatusPill(
                status: request.status,
                label: Labels.status(l, request.status),
              ),
            ],
          ),
          const SizedBox(height: SavSpace.x10),
          Wrap(
            spacing: SavSpace.x6,
            runSpacing: SavSpace.x6,
            children: [
              for (final c in request.categories)
                _CatChip(
                  image: SavImages.category(c),
                  label: Labels.category(l, c),
                  controlled: c.controlled,
                ),
            ],
          ),
          if (request.weightLb != null ||
              (isDelivery && request.etaHi != null))
            Padding(
              padding: const EdgeInsets.only(top: SavSpace.x10),
              child: Row(
                children: [
                  if (request.weightLb != null) ...[
                    const Icon(
                      Icons.scale_outlined,
                      size: 14,
                      color: SavColors.txt3,
                    ),
                    const SizedBox(width: SavSpace.x4),
                    Text(
                      fmt.weight(lbs: request.weightLb),
                      style: const TextStyle(
                        fontFamily: SavFonts.sans,
                        fontSize: 12.5,
                        fontWeight: FontWeight.w600,
                        color: SavColors.txt2,
                      ),
                    ),
                  ],
                  if (request.weightLb != null &&
                      isDelivery &&
                      request.etaHi != null)
                    const SizedBox(width: SavSpace.x14),
                  if (isDelivery && request.etaHi != null) ...[
                    const Icon(
                      Icons.schedule,
                      size: 14,
                      color: SavColors.txt3,
                    ),
                    const SizedBox(width: SavSpace.x4),
                    Text(
                      l.etaAway(
                        fmt.eta(lo: request.etaLo, hi: request.etaHi!),
                      ),
                      style: const TextStyle(
                        fontFamily: SavFonts.sans,
                        fontSize: 12.5,
                        fontWeight: FontWeight.w600,
                        color: SavColors.txt2,
                      ),
                    ),
                  ],
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _methodFallback(bool isDelivery) {
    return Container(
      color: isDelivery ? SavColors.blueLight : SavColors.greenLight,
      child: Icon(
        isDelivery ? Icons.local_shipping_outlined : Icons.storefront_outlined,
        size: 20,
        color: isDelivery ? SavColors.blue : SavColors.greenDark,
      ),
    );
  }
}

/// Category chip with a small round photo thumbnail (instead of the
/// previous text-only chip) so requests read consistently with the
/// photo-forward v56 design used elsewhere on Home.
class _CatChip extends StatelessWidget {
  const _CatChip({
    required this.image,
    required this.label,
    required this.controlled,
  });

  final String image;
  final String label;
  final bool controlled;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 4,
        right: SavSpace.x10,
        top: 4,
        bottom: 4,
      ),
      decoration: BoxDecoration(
        color: controlled ? SavColors.amberLight : SavColors.page,
        borderRadius: SavRadius.pill,
        border: Border.all(
          color: controlled ? const Color(0x33F59E0B) : SavColors.border,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(9),
            child: SizedBox(
              width: 18,
              height: 18,
              child: Image.asset(
                image,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stack) => Container(
                  color: SavColors.border,
                ),
              ),
            ),
          ),
          const SizedBox(width: SavSpace.x6),
          if (controlled) ...[
            const Icon(Icons.lock_outline, size: 11, color: SavColors.pillAmberFg),
            const SizedBox(width: 3),
          ],
          Text(
            label,
            style: TextStyle(
              fontFamily: SavFonts.sans,
              fontSize: 11.5,
              fontWeight: FontWeight.w600,
              color: controlled ? SavColors.pillAmberFg : SavColors.txt2,
            ),
          ),
        ],
      ),
    );
  }
}
/// Home's single "Active Request" preview (v56 design): thumbnail, id +
/// status pill, method + relative day, and a plain-text category list — a
/// deliberately lighter card than [RequestCard]'s full detail view. The
/// navy left accent marks it as the one request currently in progress.
class ActiveRequestCard extends StatelessWidget {
  const ActiveRequestCard({super.key, required this.request, this.onTap});

  final MemberRequest request;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final fmt = Get.find<Fmt>();
    final isDelivery = request.method == RequestMethod.delivery;

    final methodLabel = isDelivery ? l.methodDelivery : l.methodPickup;

    final dateLabel = fmt.date(
      request.createdAt,
      relativeWords: RelativeDayWords(
        today: l.relToday,
        yesterday: l.relYesterday,
        tomorrow: l.relTomorrow,
      ),
    );

    final catLabel = request.categories.isEmpty
        ? null
        : request.categories.map((c) => Labels.category(l, c)).join(', ');

    return Semantics(
      button: onTap != null,
      label: '${request.id}. ${Labels.status(l, request.status)}. '
          '$methodLabel \u00b7 $dateLabel'
          '${catLabel != null ? '. $catLabel' : ''}',
      excludeSemantics: true,
      child: Material(
        color: SavColors.surface,
        borderRadius: SavRadius.card,
        child: InkWell(
          onTap: onTap,
          borderRadius: SavRadius.card,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: SavRadius.card,
              border: Border(
                left: const BorderSide(color: SavColors.navy, width: 3),
                top: const BorderSide(color: SavColors.border, width: 1.5),
                right: const BorderSide(color: SavColors.border, width: 1.5),
                bottom: const BorderSide(color: SavColors.border, width: 1.5),
              ),
            ),
            padding: const EdgeInsets.all(SavSpace.x14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: SavRadius.field,
                      child: SizedBox(
                        width: 40,
                        height: 40,
                        child: Image.asset(
                          SavImages.method(request.method),
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stack) => Container(
                            color: isDelivery
                                ? SavColors.blueLight
                                : SavColors.greenLight,
                            child: Icon(
                              isDelivery
                                  ? Icons.local_shipping_outlined
                                  : Icons.storefront_outlined,
                              size: 18,
                              color: isDelivery
                                  ? SavColors.blue
                                  : SavColors.greenDark,
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
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  request.id,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontFamily: SavFonts.sans,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: SavColors.navy,
                                  ),
                                ),
                              ),
                              const SizedBox(width: SavSpace.x8),
                              StatusPill(
                                status: request.status,
                                label: Labels.status(l, request.status),
                              ),
                            ],
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '$methodLabel \u00b7 $dateLabel',
                            style: const TextStyle(
                              fontFamily: SavFonts.sans,
                              fontSize: 12.5,
                              fontWeight: FontWeight.w500,
                              color: SavColors.txt3,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                if (catLabel != null) ...[
                  const SizedBox(height: SavSpace.x10),
                  Text(
                    catLabel,
                    style: const TextStyle(
                      fontFamily: SavFonts.sans,
                      fontSize: 12.5,
                      fontWeight: FontWeight.w600,
                      color: SavColors.pillBlueFg,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Activity ("My Requests") list row (v56 design): thumbnail, "Method ·
/// Nonprofit" title, "ID · relative day · time" subtitle, status pill, and a
/// delete action. [nonprofit] comes from the signed-in profile (it's the
/// member's own nonprofit partner, not a per-request field).
class RequestListTile extends StatelessWidget {
  const RequestListTile({
    super.key,
    required this.request,
    required this.nonprofit,
    this.onTap,
    this.onDelete,
  });

  final MemberRequest request;
  final String nonprofit;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final fmt = Get.find<Fmt>();
    final isDelivery = request.method == RequestMethod.delivery;
    final methodLabel = isDelivery ? l.methodDelivery : l.methodPickup;

    final rw = RelativeDayWords(
      today: l.relToday,
      yesterday: l.relYesterday,
      tomorrow: l.relTomorrow,
    );

    final title =
        nonprofit.isEmpty ? methodLabel : '$methodLabel \u00b7 $nonprofit';

    final subtitle =
        '${request.id} \u00b7 ${fmt.dateTime(request.createdAt, relativeWords: rw)}';

    return SavCard(
      onTap: onTap,
      padding: const EdgeInsets.all(SavSpace.x12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: SavRadius.field,
            child: SizedBox(
              width: 44,
              height: 44,
              child: Image.asset(
                SavImages.method(request.method),
                fit: BoxFit.cover,
                errorBuilder: (context, error, stack) => Container(
                  color:
                      isDelivery ? SavColors.blueLight : SavColors.greenLight,
                  child: Icon(
                    isDelivery
                        ? Icons.local_shipping_outlined
                        : Icons.storefront_outlined,
                    size: 18,
                    color: isDelivery ? SavColors.blue : SavColors.greenDark,
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
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontFamily: SavFonts.sans,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: SavColors.navy,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
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
          const SizedBox(width: SavSpace.x8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              StatusPill(
                status: request.status,
                label: Labels.status(l, request.status),
              ),
              if (onDelete != null) ...[
                const SizedBox(height: SavSpace.x6),
                Semantics(
                  button: true,
                  label: l.cancelRequest,
                  excludeSemantics: true,
                  child: InkWell(
                    onTap: onDelete,
                    borderRadius: SavRadius.field,
                    child: Container(
                      width: 28,
                      height: 28,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: SavColors.page,
                        borderRadius: SavRadius.field,
                        border: Border.all(color: SavColors.border),
                      ),
                      child: const Icon(
                        Icons.delete_outline,
                        size: 15,
                        color: SavColors.txt3,
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
