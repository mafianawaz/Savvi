import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/routing/app_router.dart';
import '../../core/theme/tokens.dart';
import '../../l10n/app_localizations.dart';
import '../../shared/patterns/error_text.dart';
import '../../shared/patterns/feedback.dart';
import '../../shared/patterns/state_views.dart';
import '../../shared/widgets/sav_button.dart';
import '../auth/auth_controller.dart';
import '../home/request_card.dart';
import '../home/requests_controller.dart';
import 'activity_controller.dart';

/// My Requests (v56): a tabbed list (Active / History / All) of the
/// member's requests, each row showing pickup codes / delivery status via
/// [RequestListTile]. Tabs filter by status group via [ActivityController],
/// not label strings.
class ActivityScreen extends StatelessWidget {
  const ActivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final nonprofit =
        (Get.find<AuthController>().profile?['nonprofit'] as String?) ?? '';

    return GetBuilder<ActivityController>(
      init: ActivityController(
        requestsController: Get.find<RequestsController>(),
      ),
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
                    l.actTitle,
                    style: const TextStyle(
                      fontFamily: SavFonts.serif,
                      fontSize: 21,
                      color: SavColors.navy,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    l.actSub,
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
            Padding(
              padding: const EdgeInsets.fromLTRB(
                SavSpace.x16,
                SavSpace.x12,
                SavSpace.x16,
                SavSpace.x4,
              ),
              child: _TabBar(l: l, controller: controller),
            ),
            Expanded(
              child: Obx(() {
                if (controller.isLoading) {
                  return StateViews.loading();
                }

                if (controller.errorKey != null &&
                    controller.requestsController.requests.isEmpty) {
                  return StateViews.error(
                    title: l.stateErrorTitle,
                    message: l.errUnknown,
                    retryLabel: l.tryAgain,
                    onRetry: controller.requestsController.load,
                  );
                }

                final list = controller.filtered;

                if (list.isEmpty) {
                  return StateViews.empty(
                    title: l.actEmptyTitle,
                    message: l.actEmptyBody,
                    icon: Icons.receipt_long_outlined,
                    action: SavButton(
                      label: l.homeCtaTitle,
                      expand: false,
                      onPressed: () => Get.toNamed(Routes.request),
                    ),
                  );
                }

                return RefreshIndicator(
                  onRefresh: controller.refresh,
                  child: ListView.separated(
                    padding: const EdgeInsets.fromLTRB(
                      SavSpace.x16,
                      SavSpace.x10,
                      SavSpace.x16,
                      SavSpace.x24,
                    ),
                    itemCount: list.length,
                    separatorBuilder: (_, __) =>
                        const SizedBox(height: SavSpace.x12),
                    itemBuilder: (_, i) {
                      final r = list[i];

                      return RequestListTile(
                        request: r,
                        nonprofit: nonprofit,
                        onTap: () => Get.toNamed(
                          Routes.requestDetail,
                          arguments: r.id,
                        ),
                        onDelete: r.isActive
                            ? () => _confirmCancel(context, l, controller, r.id)
                            : null,
                      );
                    },
                  ),
                );
              }),
            ),
          ],
        );
      },
    );
  }

  Future<void> _confirmCancel(
    BuildContext context,
    AppLocalizations l,
    ActivityController controller,
    String requestId,
  ) async {
    final ok = await SavFeedback.confirm(
      context,
      title: l.cancelConfirmTitle,
      message: l.cancelConfirmBody,
      confirmLabel: l.cancelRequest,
      cancelLabel: l.cancelAction,
      destructive: true,
    );

    if (!ok) return;

    final err = await controller.cancel(requestId);

    if (!context.mounted) return;

    SavFeedback.toast(
      context,
      err == null ? l.requestCancelled : errText(l, err),
      tone: err == null ? FeedbackTone.info : FeedbackTone.error,
    );
  }
}

class _TabBar extends StatelessWidget {
  const _TabBar({required this.l, required this.controller});

  final AppLocalizations l;
  final ActivityController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: SavColors.page,
        borderRadius: SavRadius.field,
        border: Border.all(color: SavColors.border, width: 1.5),
      ),
      child: Row(
        children: [
          _tabBtn(l.tabActive, ActivityTab.active),
          _tabBtn(l.tabHistory, ActivityTab.history),
          _tabBtn(l.tabAll, ActivityTab.all),
        ],
      ),
    );
  }

  Widget _tabBtn(String label, ActivityTab tab) {
    return Expanded(
      child: Obx(() {
        final on = controller.tab.value == tab;

        return Semantics(
          button: true,
          selected: on,
          label: label,
          excludeSemantics: true,
          child: InkWell(
            onTap: () => controller.setTab(tab),
            borderRadius: SavRadius.field,
            child: Container(
              height: 38,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: on ? SavColors.surface : Colors.transparent,
                borderRadius: SavRadius.field,
                boxShadow: on
                    ? [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.06),
                          blurRadius: 4,
                          offset: const Offset(0, 1),
                        ),
                      ]
                    : null,
              ),
              child: Text(
                label,
                style: TextStyle(
                  fontFamily: SavFonts.sans,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: on ? SavColors.navy : SavColors.txt3,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
