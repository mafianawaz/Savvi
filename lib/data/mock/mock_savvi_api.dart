import '../../core/network/api_result.dart';
import '../../core/network/savvi_api.dart';

/// ⚠️ DEMO / PROTOTYPE ONLY — NOT FOR PRODUCTION.
///
/// In-memory [SavviApi] used to run the app before the NestJS backend exists.
/// It returns backend-SHAPED payloads so screens can be built against realistic
/// data, but every value here is fabricated for demonstration:
///   • the IDs, access tokens, QR tokens, pickup codes, statuses, and
///     notification events are STATIC MOCK DATA, not officially issued records.
/// Swap this for the live Dio-backed implementation before any real use. The
/// Riverpod provider is the only place that references a concrete impl, so the
/// swap touches one file.
///
/// This class deliberately performs NO official record generation. Where it
/// echoes an ID (e.g. after createRequest) it reuses a fixed demo string and is
/// annotated as such.
class MockSavviApi implements SavviApi {
  static const _delay = Duration(milliseconds: 450);

  Future<ApiResult<T>> _ok<T>(T data) async {
    await Future<void>.delayed(_delay);
    return ApiOk<T>(data);
  }

  // ── Auth / session ─────────────────────────────────────────────────────────
  @override
  Future<ApiResult<Map<String, dynamic>>> session() => _ok(_demoProfile);

  @override
  Future<ApiResult<Map<String, dynamic>>> verifyAccessLink(String t) {
    // Demo classifier mirrors v45 states; real validation is server-side.
    final s = t.toLowerCase();
    final state = s.contains('onsite')
        ? 'onsite'
        : s.contains('expired')
            ? 'expired'
            : s.contains('used')
                ? 'used'
                : (s.contains('svvi-') || s.contains('/access/'))
                    ? 'ok'
                    : 'invalid';
    return _ok({'state': state});
  }

  @override
  Future<ApiResult<Map<String, dynamic>>> verifyQr({
    required String token,
    required String purpose,
  }) {
    // Mirror the access-link classifier so all access states are reachable via
    // QR too; real validation is server-side.
    final s = token.toLowerCase();
    final state = s.contains('onsite')
        ? 'onsite'
        : s.contains('expired')
            ? 'expired'
            : s.contains('used')
                ? 'used'
                : 'ok';
    return _ok({'state': state, 'purpose': purpose});
  }

  // ── Profile ────────────────────────────────────────────────────────────────
  @override
  Future<ApiResult<Map<String, dynamic>>> getProfile() => _ok(_demoProfile);

  @override
  Future<ApiResult<Map<String, dynamic>>> createProfile(
          Map<String, dynamic> body) =>
      _ok({..._demoProfile, ...body, 'status': 'pending'});

  @override
  Future<ApiResult<Map<String, dynamic>>> updateProfile(
          Map<String, dynamic> body) =>
      _ok({..._demoProfile, ...body});

  @override
  Future<ApiResult<void>> setLanguagePreference(String localeTag) => _ok(null);

  @override
  Future<ApiResult<void>> sendPasswordReset(String email) => _ok(null);

  @override
  Future<ApiResult<void>> setNotificationPreferences(Map<String, bool> p) =>
      _ok(null);

  // ── Requests ───────────────────────────────────────────────────────────────
  @override
  Future<ApiResult<List<Map<String, dynamic>>>> listRequests() =>
      _ok(_demoRequests);

  @override
  Future<ApiResult<Map<String, dynamic>>> getRequest(String id) => _ok(
        _demoRequests.firstWhere((r) => r['id'] == id,
            orElse: () => _demoRequests.first),
      );

  @override
  Future<ApiResult<Map<String, dynamic>>> createRequest(
          Map<String, dynamic> body) =>
      // DEMO: backend would assign the real id + status. Fixed demo id here.
      _ok({
        'id': 'SAV-REQ-26-0099',
        'status': 'submitted',
        ...body,
      });

  @override
  Future<ApiResult<Map<String, dynamic>>> editRequest(
          String id, Map<String, dynamic> body) =>
      _ok({'id': id, ...body});

  @override
  Future<ApiResult<void>> cancelRequest(String id) => _ok(null);

  // ── Alerts ─────────────────────────────────────────────────────────────────
  @override
  Future<ApiResult<List<Map<String, dynamic>>>> listAlerts() => _ok(_demoAlerts);

  @override
  Future<ApiResult<Map<String, dynamic>>> rsvpAlert(String id, int n) =>
      _ok({'id': id, 'rsvp': n});

  @override
  Future<ApiResult<void>> cancelRsvp(String id) => _ok(null);

  // ── Notifications ──────────────────────────────────────────────────────────
  @override
  Future<ApiResult<List<Map<String, dynamic>>>> listNotifications() =>
      _ok(_demoNotifications);

  @override
  Future<ApiResult<void>> markNotificationRead(String id) => _ok(null);

  @override
  Future<ApiResult<void>> markAllNotificationsRead() => _ok(null);

  @override
  Future<ApiResult<void>> clearNotifications() => _ok(null);

  // ── Pickup / delivery ──────────────────────────────────────────────────────
  @override
  Future<ApiResult<Map<String, dynamic>>> getPickup(String id) => _ok({
        'requestId': id,
        // DEMO pickup code + QR token — backend-issued in production.
        'pickupCode': 'PKU-0006',
        'pickupQrToken': 'SVVI-PK-0006-8823',
        'windowStart': _at(13, 0, 2),
        'windowEnd': _at(16, 0, 2),
        'location': '2311 Canal St, Houston, TX 77003',
      });

  @override
  Future<ApiResult<Map<String, dynamic>>> getDeliveryStatus(String id) => _ok({
        'requestId': id,
        'status': 'out_for_delivery',
        'etaLo': 20,
        'etaHi': 30,
        'distanceMi': 3.2,
      });

  // ── demo seed (ISO timestamps, pounds; kg derived by the formatter) ─────────

  static String _at(int hh, int mm, [int dayOffset = 0]) {
    final d = DateTime.now().add(Duration(days: dayOffset));
    return DateTime(d.year, d.month, d.day, hh, mm).toIso8601String();
  }

  static final Map<String, dynamic> _demoProfile = {
    'firstName': 'Tasha',
    'lastName': 'Brown',
    'email': 'tasha.brown@example.com',
    'phone': '(713) 555-0142',
    'street': '1809 Elgin Street',
    'city': 'Houston',
    'state': 'TX',
    'zip': '77004',
    'household': '3',
    'memberId': 'SVVI-0117',
    'nonprofit': 'Houston Food Recovery',
    'status': 'approved',
    'diet': ['senior'],
    'allergens': <String>[],
  };

  static final List<Map<String, dynamic>> _demoRequests = [
    {
      'id': 'SAV-REQ-26-0021',
      'method': 'pickup',
      'status': 'submitted',
      'createdAt': _at(8, 40),
      'cats': ['produce', 'pantry', 'baby_food'],
      'household': '3',
      'weightLb': null,
      'statusHistory': {
        'submitted': _at(8, 40),
        'approved': _at(11, 52),
        'preparing': _at(11, 53),
      },
    },
    {
      'id': 'SAV-REQ-26-0013',
      'method': 'delivery',
      'status': 'out_for_delivery',
      'createdAt': _at(8, 0),
      'cats': ['produce', 'dairy', 'pantry'],
      'household': '3',
      'weightLb': 36,
      'etaLo': 20,
      'etaHi': 30,
      'distanceMi': 3.2,
      'statusHistory': {
        'submitted': _at(8, 0),
        'approved': _at(8, 45),
        'scheduled': _at(8, 52),
        'preparing': _at(9, 0),
        'out_for_delivery': _at(9, 32),
      },
    },
    {
      'id': 'SAV-REQ-26-0006',
      'method': 'pickup',
      'status': 'completed',
      'createdAt': _at(9, 10, -35),
      'cats': ['produce', 'bakery_bread', 'snacks_beverages'],
      'household': '3',
      'weightLb': 24,
      'statusHistory': {
        'submitted': _at(9, 10, -35),
        'approved': _at(10, 5, -35),
        'preparing': _at(11, 0, -35),
        'ready_pickup': _at(13, 15, -35),
        'pickup_confirmed': _at(15, 40, -35),
        'completed': _at(15, 41, -35),
      },
    },
  ];

  static final List<Map<String, dynamic>> _demoAlerts = [
    {
      'id': 'AL-1',
      'type': 'hot',
      'title': 'Hot meals available now',
      'host': 'Hope Community Kitchen',
      'windowStart': _at(12, 0),
      'windowEnd': _at(14, 0),
      'where': '4200 Lyons Ave',
      'left': 45,
      'rsvp': 0,
    },
    {
      'id': 'AL-2',
      'type': 'dist',
      'title': 'Fresh produce box pickup',
      'host': 'Hope Community Kitchen',
      'windowStart': _at(15, 0),
      'windowEnd': _at(17, 30),
      'where': 'Third Ward Community Center',
      'left': 38,
      'rsvp': 0,
    },
  ];

  static final List<Map<String, dynamic>> _demoNotifications = [
    {
      // Food Access Alert — carries its own copy (backend-localized in prod;
      // English here as mock demo data). Not a request-status notification.
      'id': 'N0',
      'kind': 'alert',
      'title': 'Hot meals available now',
      'body': 'Hope Community Kitchen · until 7:00 PM',
      'at': _at(10, 5),
      'read': false,
    },
    {
      'id': 'N1',
      'type': 'out_for_delivery',
      'requestId': 'SAV-REQ-26-0013',
      'at': _at(9, 32),
      'read': false,
    },
    {
      'id': 'N2',
      'type': 'approved',
      'requestId': 'SAV-REQ-26-0013',
      'at': _at(8, 45),
      'read': false,
    },
    {
      'id': 'N3',
      'type': 'submitted',
      'requestId': 'SAV-REQ-26-0021',
      'at': _at(8, 40),
      'read': true,
    },
  ];
}
