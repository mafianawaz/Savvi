/// Onboarding domain types. Values are backend-owned.
enum AccessState {
  ok('ok'),
  onsite('onsite'),
  expired('expired'),
  used('used'),
  invalid('invalid');

  const AccessState(this.api);
  final String api;

  static AccessState fromApi(String? value) {
    for (final state in values) {
      if (state.api == value) return state;
    }
    return AccessState.invalid;
  }

  bool get isVerified => this == ok || this == onsite;
}

class AccessGrant {
  const AccessGrant({
    required this.state,
    this.nonprofitName,
    this.code,
    this.inviteType,
    this.locationId,
    this.source,
    this.coordinates,
    this.expiresAt,
    this.qrExpiresAt,
    this.message,
  });

  final AccessState state;
  final String? nonprofitName;
  final String? code;
  final String? inviteType;
  final String? locationId;
  final String? source;
  final List<double>? coordinates;
  final DateTime? expiresAt;
  final DateTime? qrExpiresAt;
  final String? message;

  bool get onsite => state == AccessState.onsite;
  bool get verified => state.isVerified;

  factory AccessGrant.fromJson(Map<String, dynamic> json) {
    final valid = json['valid'] == true;

    final stateValue = json['state']?.toString();

    return AccessGrant(
      state: valid
          ? AccessState.fromApi(stateValue ?? 'ok')
          : AccessState.fromApi(stateValue),

      nonprofitName:
      (json['locationName'] ?? json['nonprofit'])?.toString(),

      code: json['code']?.toString(),

      inviteType: json['inviteType']?.toString(),

      locationId: json['locationId']?.toString(),

      source: json['source']?.toString(),

      coordinates: _coordinates(json['coordinates']),

      expiresAt: _date(json['expiresAt']),

      qrExpiresAt: _date(json['qrExpiresAt']),

      message: json['message']?.toString(),
    );
  }

  static List<double>? _coordinates(dynamic value) {
    if (value is! List || value.length < 2) return null;

    final parsed = <double>[];
    for (final item in value) {
      final number = item is num ? item.toDouble() : double.tryParse(item.toString());
      if (number == null) return null;
      parsed.add(number);
    }
    return parsed;
  }

  static DateTime? _date(dynamic value) {
    if (value == null) return null;
    return DateTime.tryParse(value.toString());
  }
}

enum ApprovalState {
  pending('pending'),
  approved('approved'),
  declined('declined'),
  needsReview('needs_review');

  const ApprovalState(this.api);
  final String api;

  static ApprovalState fromApi(String? value) {
    for (final state in values) {
      if (state.api == value) return state;
    }
    return ApprovalState.pending;
  }
}

enum OnboardingStep { submitted, review, approved }
