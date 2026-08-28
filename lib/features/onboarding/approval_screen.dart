import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/routing/app_router.dart';
import '../../core/theme/tokens.dart';
import '../../l10n/app_localizations.dart';
import '../../data/models/onboarding.dart';
import '../../shared/widgets/sav_button.dart';
import '../../shared/widgets/step_tracker.dart';

/// Post-submission approval screen. Renders one of four backend-determined
/// states: pending (the rich tracker hero), approved, declined, or needs
/// additional review. The state is passed in via GetX route arguments; if absent
/// it defaults to pending. The client never decides the outcome.
///
/// [isStatusRoute] is true when this is reached via the "Track Approval Status"
/// route, in which case the pending view hides its own Track button (which
/// would otherwise re-push the same route onto itself).
class ApprovalScreen extends StatelessWidget {
  const ApprovalScreen({super.key, this.state, this.isStatusRoute = false});

  final ApprovalState? state;
  final bool isStatusRoute;

  @override
  Widget build(BuildContext context) {
    final s = state ?? ApprovalState.pending;
    return switch (s) {
      ApprovalState.pending => _PendingView(showTrackButton: !isStatusRoute),
      ApprovalState.approved => _ResultView(
          tone: _ResultTone.approved,
          icon: Icons.check_circle,
        ),
      ApprovalState.declined => _ResultView(
          tone: _ResultTone.declined,
          icon: Icons.cancel_outlined,
        ),
      ApprovalState.needsReview => _ResultView(
          tone: _ResultTone.review,
          icon: Icons.pause_circle_outline,
        ),
    };
  }
}

class _PendingView extends StatelessWidget {
  const _PendingView({this.showTrackButton = true});
  final bool showTrackButton;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: SavColors.navy,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Navy hero
              Padding(
                padding: const EdgeInsets.fromLTRB(
                    SavSpace.x24, SavSpace.x24, SavSpace.x24, SavSpace.x24),
                child: Column(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [SavColors.green, SavColors.blue],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.check,
                          size: 36, color: SavColors.navy),
                    ),
                    const SizedBox(height: SavSpace.x20),
                    Text(l.approvalHeroTitle,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontFamily: SavFonts.serif,
                            fontSize: 26,
                            color: Colors.white)),
                    const SizedBox(height: SavSpace.x8),
                    Text(l.approvalHeroBody,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontFamily: SavFonts.sans,
                            fontSize: 14,
                            height: 1.55,
                            fontWeight: FontWeight.w500,
                            color: Colors.white70)),
                  ],
                ),
              ),
              // White sheet
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: SavColors.page,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                padding: const EdgeInsets.fromLTRB(
                    SavSpace.x20, SavSpace.x24, SavSpace.x20, SavSpace.x24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    StepTracker(
                      current: OnboardingStep.review,
                      submittedLabel: l.stepSubmitted,
                      reviewLabel: l.stepReview,
                      approvedLabel: l.stepApproved,
                    ),
                    const SizedBox(height: SavSpace.x20),
                    _statusCard(l),
                    const SizedBox(height: SavSpace.x14),
                    _motivNote(l),
                    const SizedBox(height: SavSpace.x16),
                    if (showTrackButton) ...[
                      SavButton(
                        label: l.trackApprovalBtn,
                        onPressed: () => Get.toNamed(Routes.approvalStatus),
                      ),
                      const SizedBox(height: SavSpace.x10),
                    ],
                    SavButton(
                      label: l.backToSignIn,
                      variant: SavButtonVariant.ghost,
                      onPressed: () => Get.offAllNamed(Routes.signIn),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _statusCard(AppLocalizations l) {
    return Container(
      decoration: BoxDecoration(
        color: SavColors.surface,
        borderRadius: SavRadius.card,
        border: Border.all(color: SavColors.border, width: 1.5),
      ),
      padding: const EdgeInsets.all(SavSpace.x16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(l.approvalStatusLabel.toUpperCase(),
                  style: const TextStyle(
                      fontFamily: SavFonts.sans,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.6,
                      color: SavColors.txt4)),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: SavSpace.x10, vertical: 4),
                decoration: BoxDecoration(
                    color: SavColors.amberLight,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: const Color(0x33F59E0B))),
                child: Text(l.approvalPendingBadge,
                    style: const TextStyle(
                        fontFamily: SavFonts.sans,
                        fontSize: 10.5,
                        fontWeight: FontWeight.w700,
                        color: SavColors.pillAmberFg)),
              ),
            ],
          ),
          const SizedBox(height: SavSpace.x12),
          _row(SavColors.greenLight, SavColors.greenDark, Icons.check,
              l.approvalRow1Title, l.approvalRow1Body,
              done: true),
          _row(SavColors.amberLight, SavColors.amber, Icons.schedule,
              l.approvalRow2Title, l.approvalRow2Body),
          _row(SavColors.blueLight, SavColors.blue, Icons.notifications_none,
              l.approvalRow3Title, l.approvalRow3Body,
              muted: true),
        ],
      ),
    );
  }

  Widget _row(Color bg, Color fg, IconData icon, String title, String body,
      {bool done = false, bool muted = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: SavSpace.x8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(color: bg, borderRadius: SavRadius.field),
            child: Icon(icon, size: 16, color: fg),
          ),
          const SizedBox(width: SavSpace.x12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: TextStyle(
                        fontFamily: SavFonts.sans,
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: muted ? SavColors.txt4 : SavColors.navy)),
                Text(body,
                    style: const TextStyle(
                        fontFamily: SavFonts.sans,
                        fontSize: 11.5,
                        height: 1.4,
                        fontWeight: FontWeight.w500,
                        color: SavColors.txt3)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _motivNote(AppLocalizations l) {
    return Container(
      padding: const EdgeInsets.all(SavSpace.x14),
      decoration: BoxDecoration(
        color: SavColors.greenLight,
        borderRadius: SavRadius.field,
        border: Border.all(color: const Color(0x3329E050), width: 1.5),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.eco_outlined, size: 18, color: SavColors.greenDark),
          const SizedBox(width: SavSpace.x10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l.approvalMotivTitle,
                    style: const TextStyle(
                        fontFamily: SavFonts.sans,
                        fontSize: 12.5,
                        fontWeight: FontWeight.w700,
                        color: SavColors.navy)),
                const SizedBox(height: 2),
                Text(l.approvalMotivBody,
                    style: const TextStyle(
                        fontFamily: SavFonts.sans,
                        fontSize: 12,
                        height: 1.5,
                        fontWeight: FontWeight.w500,
                        color: SavColors.txt3)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

enum _ResultTone { approved, declined, review }

class _ResultView extends StatelessWidget {
  const _ResultView({required this.tone, required this.icon});
  final _ResultTone tone;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final (bg, fg, title, body) = switch (tone) {
      _ResultTone.approved => (
          SavColors.greenLight,
          SavColors.greenDark,
          l.approvedTitle,
          l.approvedBody
        ),
      _ResultTone.declined => (
          SavColors.redLight,
          SavColors.red,
          l.declinedTitle,
          l.declinedBody
        ),
      _ResultTone.review => (
          SavColors.amberLight,
          SavColors.amber,
          l.needsReviewTitle,
          l.needsReviewBody
        ),
    };

    return Scaffold(
      backgroundColor: SavColors.surface,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(SavSpace.x24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration:
                      BoxDecoration(color: bg, borderRadius: SavRadius.card),
                  child: Icon(icon, size: 30, color: fg),
                ),
                const SizedBox(height: SavSpace.x16),
                Text(title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontFamily: SavFonts.serif,
                        fontSize: 24,
                        color: SavColors.navy)),
                const SizedBox(height: SavSpace.x8),
                Text(body,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontFamily: SavFonts.sans,
                        fontSize: 13.5,
                        height: 1.55,
                        fontWeight: FontWeight.w500,
                        color: SavColors.txt3)),
                const SizedBox(height: SavSpace.x24),
                if (tone == _ResultTone.approved)
                  SavButton(
                    label: l.trackApprovalBtn,
                    onPressed: () => Get.toNamed(Routes.approvalStatus),
                  )
                else
                  SavButton(
                    label: l.backToSignIn,
                    variant: SavButtonVariant.ghost,
                    onPressed: () => Get.offAllNamed(Routes.signIn),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
