import 'package:flutter/material.dart';
import '../../core/theme/tokens.dart';
import '../../data/models/onboarding.dart';

/// Horizontal 3-step tracker pill (Submitted → Review → Approved), ported from
/// the v45 approval screen. [current] marks which step is active; earlier steps
/// render as done, later ones as pending.
class StepTracker extends StatelessWidget {
  const StepTracker({
    super.key,
    required this.current,
    required this.submittedLabel,
    required this.reviewLabel,
    required this.approvedLabel,
    this.allApproved = false,
  });

  final OnboardingStep current;
  final String submittedLabel;
  final String reviewLabel;
  final String approvedLabel;
  final bool allApproved;

  @override
  Widget build(BuildContext context) {
    int idx(OnboardingStep s) => OnboardingStep.values.indexOf(s);
    final curIdx = allApproved ? idx(OnboardingStep.approved) : idx(current);

    _StepState stateFor(OnboardingStep s) {
      final i = idx(s);
      if (allApproved) return _StepState.done;
      if (i < curIdx) return _StepState.done;
      if (i == curIdx) return _StepState.active;
      return _StepState.pending;
    }

    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: SavSpace.x16, vertical: SavSpace.x6),
      decoration: BoxDecoration(
        color: SavColors.surface,
        border: Border.all(color: SavColors.border, width: 1.5),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        children: [
          _step(submittedLabel, stateFor(OnboardingStep.submitted)),
          _connector(),
          _step(reviewLabel, stateFor(OnboardingStep.review)),
          _connector(),
          _step(approvedLabel, stateFor(OnboardingStep.approved)),
        ],
      ),
    );
  }

  Widget _connector() => Expanded(
        child: Container(
            height: 1.5,
            margin: const EdgeInsets.symmetric(horizontal: SavSpace.x8),
            color: SavColors.border),
      );

  Widget _step(String label, _StepState state) {
    final (dot, text) = switch (state) {
      _StepState.done => (SavColors.greenDark, SavColors.greenDark),
      _StepState.active => (SavColors.amber, SavColors.amber),
      _StepState.pending => (SavColors.border, SavColors.txt4),
    };
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(color: dot, shape: BoxShape.circle),
          alignment: Alignment.center,
          child: state == _StepState.done
              ? const Icon(Icons.check, size: 11, color: Colors.white)
              : Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                      color: state == _StepState.active
                          ? Colors.white
                          : SavColors.txt4,
                      shape: BoxShape.circle),
                ),
        ),
        const SizedBox(width: SavSpace.x6),
        Text(label,
            style: TextStyle(
                fontFamily: SavFonts.sans,
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: text)),
      ],
    );
  }
}

enum _StepState { done, active, pending }
