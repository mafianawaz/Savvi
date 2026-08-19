/// Onboarding domain types for Stage 2 (access verification + approval).
///
/// All of these are BACKEND-DETERMINED. The client sends a token/code or a
/// signed-in user and displays whatever state the backend returns; it never
/// decides validity, expiry, or approval outcome itself.

/// Result of verifying a nonprofit access link, code, or QR token.
enum AccessState {
  ok('ok'),
  onsite('onsite'), // trusted onsite enrollment → instant approval path
  expired('expired'),
  used('used'),
  invalid('invalid');

  const AccessState(this.api);
  final String api;

  static AccessState fromApi(String? v) {
    for (final s in values) {
      if (s.api == v) return s;
    }
    return AccessState.invalid;
  }

  bool get isVerified => this == ok || this == onsite;
}

/// A verified access context carried forward into profile creation.
class AccessGrant {
  const AccessGrant({required this.state, this.nonprofitName});
  final AccessState state;
  final String? nonprofitName;

  bool get onsite => state == AccessState.onsite;
  bool get verified => state.isVerified;

  factory AccessGrant.fromJson(Map<String, dynamic> j) => AccessGrant(
        state: AccessState.fromApi(j['state'] as String?),
        nonprofitName: j['nonprofit'] as String?,
      );
}

/// Approval outcome for a submitted member profile.
enum ApprovalState {
  pending('pending'),
  approved('approved'),
  declined('declined'),
  needsReview('needs_review'); // "Needs Additional Review"

  const ApprovalState(this.api);
  final String api;

  static ApprovalState fromApi(String? v) {
    for (final s in values) {
      if (s.api == v) return s;
    }
    return ApprovalState.pending;
  }
}

/// The three high-level onboarding progress steps shown in the tracker.
enum OnboardingStep { submitted, review, approved }
