import 'enums.dart';
import 'profile_prefs.dart';
import 'request_status.dart';

/// Typed view of a member food-support request as returned by the backend.
/// The backend owns the id, status, and all official fields; this only parses.
class MemberRequest {
  const MemberRequest({
    required this.id,
    required this.method,
    required this.status,
    required this.createdAt,
    required this.categories,
    required this.household,
    this.weightLb,
    this.etaLo,
    this.etaHi,
    this.distanceMi,
    this.diet = const [],
    this.allergens = const [],
    this.notes,
    this.pickupCode,
  });

  final String id;
  final RequestMethod method;
  final RequestStatus status;
  final DateTime createdAt;
  final List<FoodCategory> categories;
  final String household;
  final double? weightLb;
  final int? etaLo;
  final int? etaHi;
  final double? distanceMi;
  final List<DietaryPref> diet;
  final List<Allergen> allergens;
  final String? notes;
  final String? pickupCode;

  /// Statuses that represent a finished/closed request (no longer in progress).
  static const _closed = <RequestStatus>{
    RequestStatus.completed,
    RequestStatus.cancelled,
    RequestStatus.declined,
    RequestStatus.missed,
    RequestStatus.unavailable,
  };

  bool get isActive => !_closed.contains(status);
  bool get isInFlight =>
      status == RequestStatus.outForDelivery || status == RequestStatus.nearby;

  static MemberRequest fromJson(Map<String, dynamic> j) => MemberRequest(
        id: j['id'] as String,
        method: RequestMethod.fromApi(j['method'] as String? ?? 'pickup'),
        status: RequestStatus.fromApi(j['status'] as String? ?? 'submitted'),
        createdAt:
            DateTime.tryParse(j['createdAt']?.toString() ?? '') ?? DateTime.now(),
        categories: [
          for (final c in (j['cats'] as List? ?? const []))
            if (FoodCategory.tryFromApi(c as String) case final fc?) fc
        ],
        household: j['household']?.toString() ?? '1',
        weightLb: (j['weightLb'] as num?)?.toDouble(),
        etaLo: (j['etaLo'] as num?)?.toInt(),
        etaHi: (j['etaHi'] as num?)?.toInt(),
        distanceMi: (j['distanceMi'] as num?)?.toDouble(),
        diet: [
          for (final v in (j['diet'] as List? ?? const []))
            if (DietaryPref.tryFromApi(v as String) case final d?) d
        ],
        allergens: [
          for (final v in (j['allergens'] as List? ?? const []))
            if (Allergen.tryFromApi(v as String) case final a?) a
        ],
        notes: (j['notes'] as String?)?.trim().isNotEmpty == true
            ? (j['notes'] as String).trim()
            : null,
        pickupCode: j['pickupCode'] as String?,
      );
}

/// Food Access Alert (hot meal or distribution) a member can RSVP to.
enum AlertType {
  hot('hot'),
  distribution('dist');

  const AlertType(this.api);
  final String api;

  static AlertType fromApi(String? v) =>
      v == 'hot' ? AlertType.hot : AlertType.distribution;
}

class FoodAlert {
  const FoodAlert({
    required this.id,
    required this.type,
    required this.title,
    required this.host,
    required this.windowStart,
    required this.windowEnd,
    required this.where,
    required this.left,
    required this.rsvp,
  });

  final String id;
  final AlertType type;
  final String title;
  final String host;
  final DateTime windowStart;
  final DateTime? windowEnd;
  final String where;
  final int left;
  final int rsvp;

  FoodAlert copyWith({int? rsvp, int? left}) => FoodAlert(
        id: id,
        type: type,
        title: title,
        host: host,
        windowStart: windowStart,
        windowEnd: windowEnd,
        where: where,
        left: left ?? this.left,
        rsvp: rsvp ?? this.rsvp,
      );

  static FoodAlert fromJson(Map<String, dynamic> j) => FoodAlert(
        id: j['id'] as String,
        type: AlertType.fromApi(j['type'] as String?),
        title: j['title'] as String? ?? '',
        host: j['host'] as String? ?? '',
        windowStart:
            DateTime.tryParse(j['windowStart']?.toString() ?? '') ??
                DateTime.now(),
        windowEnd: DateTime.tryParse(j['windowEnd']?.toString() ?? ''),
        where: j['where'] as String? ?? '',
        left: (j['left'] as num?)?.toInt() ?? 0,
        rsvp: (j['rsvp'] as num?)?.toInt() ?? 0,
      );
}
