import 'request_status.dart';

/// What a notification is about — drives its icon/tone and whether it deep-links
/// to a request. The backend sets this; unknown values fall back to [general].
enum NotificationKind {
  request('request'),
  alert('alert'),
  general('general');

  const NotificationKind(this.api);
  final String api;

  static NotificationKind fromApi(String? v) {
    for (final k in values) {
      if (k.api == v) return k;
    }
    return general;
  }
}

/// A member-facing notification.
///
/// The backend supplies the event and its localized [title]/[body]. For request
/// updates it may instead send a request [status] (and the frontend derives the
/// title from it). Non-request notifications (e.g. Food Access Alerts) carry
/// their own copy and are no longer forced through [RequestStatus].
class MemberNotification {
  const MemberNotification({
    required this.id,
    required this.kind,
    required this.at,
    required this.read,
    this.title,
    this.body,
    this.status,
    this.requestId,
  });

  final String id;
  final NotificationKind kind;
  final DateTime at;
  final bool read;

  /// Backend-provided localized copy (preferred when present).
  final String? title;
  final String? body;

  /// Set when the notification is a request-status change.
  final RequestStatus? status;

  /// Deep-link target, when the notification concerns a specific request.
  final String? requestId;

  MemberNotification copyWith({bool? read}) => MemberNotification(
        id: id,
        kind: kind,
        at: at,
        read: read ?? this.read,
        title: title,
        body: body,
        status: status,
        requestId: requestId,
      );

  factory MemberNotification.fromJson(Map<String, dynamic> j) {
    // `type` may be a request-status api id (request updates) or absent for
    // notifications that carry their own copy.
    final status = RequestStatus.tryFromApi(j['type']?.toString() ?? '');
    final kind = j['kind'] != null
        ? NotificationKind.fromApi(j['kind'] as String?)
        : (status != null || j['requestId'] != null
            ? NotificationKind.request
            : NotificationKind.general);
    return MemberNotification(
      id: j['id'] as String,
      kind: kind,
      at: DateTime.tryParse(j['at']?.toString() ?? '') ?? DateTime.now(),
      read: j['read'] == true,
      title: j['title'] as String?,
      body: j['body'] as String?,
      status: status,
      requestId: j['requestId'] as String?,
    );
  }
}
