import 'api_result.dart';

/// The complete backend contract the Savvi member app depends on.
///
/// This is the single boundary between the Flutter frontend and the NestJS
/// backend. Every method here is a value the BACKEND owns and returns; the
/// client only reads and displays. In particular the backend — never the
/// client — issues and validates:
///   • member IDs, request IDs
///   • access-link tokens and their 48h expiry
///   • QR tokens, pickup codes
///   • request statuses and transitions
///   • notification events
///   • audit-log entries
///
/// Stage 1 ships this as an abstract interface plus a mock implementation
/// (see data/mock). Later stages back it with the real Dio calls. Screens
/// depend on the interface via a Riverpod provider, so swapping mock → live
/// requires no screen changes.
///
/// Types below use dynamic maps as placeholders; freezed request/response
/// models are introduced alongside the screens that consume them (Stages 2–4),
/// keeping Stage 1 free of generated code.
abstract interface class SavviApi {
  // ── Auth / session ─────────────────────────────────────────────────────────
  /// Exchange a signed-in Firebase user for a Savvi session + member profile.
  Future<ApiResult<Map<String, dynamic>>> session();

  /// Verify a nonprofit access link or code. Backend classifies it as
  /// ok / onsite / expired / used / invalid and enforces the 48h expiry.
  Future<ApiResult<Map<String, dynamic>>> verifyAccessLink(String tokenOrCode);

  /// Verify a scanned QR token (access or pickup). Backend decides validity.
  Future<ApiResult<Map<String, dynamic>>> verifyQr({
    required String token,
    required String purpose, // 'access' | 'pickup'
  });

  // ── Profile ────────────────────────────────────────────────────────────────
  Future<ApiResult<Map<String, dynamic>>> getProfile();

  /// Create the member profile (phone REQUIRED — validated server-side too).
  Future<ApiResult<Map<String, dynamic>>> createProfile(
      Map<String, dynamic> body);

  Future<ApiResult<Map<String, dynamic>>> updateProfile(
      Map<String, dynamic> body);

  /// Persist the member's language preference (en-US | es-US) server-side.
  Future<ApiResult<void>> setLanguagePreference(String localeTag);

  /// Requests a password reset link for [email] via the auth provider
  /// (Firebase Auth in production). The frontend never stores passwords.
  Future<ApiResult<void>> sendPasswordReset(String email);

  /// Persist notification channel preferences (in-app always on; push/email).
  Future<ApiResult<void>> setNotificationPreferences(Map<String, bool> prefs);

  // ── Requests ───────────────────────────────────────────────────────────────
  Future<ApiResult<List<Map<String, dynamic>>>> listRequests();
  Future<ApiResult<Map<String, dynamic>>> getRequest(String requestId);

  /// Submit a new food support request. Backend assigns the request ID and
  /// initial status; the client sends only member-entered content (categories,
  /// method, per-request household snapshot, dietary/allergen, notes).
  Future<ApiResult<Map<String, dynamic>>> createRequest(
      Map<String, dynamic> body);

  Future<ApiResult<Map<String, dynamic>>> editRequest(
      String requestId, Map<String, dynamic> body);

  Future<ApiResult<void>> cancelRequest(String requestId);

  // ── Alerts (Food Access) ───────────────────────────────────────────────────
  Future<ApiResult<List<Map<String, dynamic>>>> listAlerts();

  /// RSVP to a hot-meal / distribution alert (headcount capped at household).
  Future<ApiResult<Map<String, dynamic>>> rsvpAlert(
      String alertId, int headcount);
  Future<ApiResult<void>> cancelRsvp(String alertId);

  // ── Notifications ──────────────────────────────────────────────────────────
  Future<ApiResult<List<Map<String, dynamic>>>> listNotifications();
  Future<ApiResult<void>> markNotificationRead(String id);
  Future<ApiResult<void>> markAllNotificationsRead();
  Future<ApiResult<void>> clearNotifications();

  // ── Pickup / delivery (read-only member views) ──────────────────────────────
  /// Pickup details incl. backend-issued pickup code + QR token and window.
  Future<ApiResult<Map<String, dynamic>>> getPickup(String requestId);

  /// Live-ish delivery status incl. backend-provided ETA/distance (privacy-safe;
  /// no driver identity, route, or logistics internals).
  Future<ApiResult<Map<String, dynamic>>> getDeliveryStatus(String requestId);
}
