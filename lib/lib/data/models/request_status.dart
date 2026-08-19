import 'enums.dart';

/// Which activity bucket a status belongs to.
enum StatusGroup { active, history }

/// Visual pill tone for a status (maps to shared StatusPill widget colours).
enum PillTone { navy, green, blue, amber, red, gray }

/// How much of a request a member may still edit in a given status.
enum EditScope {
  full, // any part of the request
  limited, // contact + notes only; food details and method locked
  none, // no edit
}

/// The Savvi member-facing request status machine — ported from the v45
/// prototype. This is the client's interpretation layer only; the backend is
/// the source of truth for a request's actual status and transitions.
///
/// Statuses are keyed by their backend string. Each carries its display group,
/// pill tone, edit scope, and whether cancel is offered. Localised labels are
/// resolved separately via the l10n key [l10nKey] (added to ARB in Stage 2/3).
enum RequestStatus {
  submitted('submitted',
      group: StatusGroup.active,
      tone: PillTone.navy,
      edit: EditScope.full,
      cancel: true),
  needsUpdate('needs_update',
      group: StatusGroup.active,
      tone: PillTone.amber,
      edit: EditScope.full,
      cancel: true),
  approved('approved',
      group: StatusGroup.active,
      tone: PillTone.green,
      edit: EditScope.limited,
      cancel: true),
  scheduled('scheduled',
      group: StatusGroup.active,
      tone: PillTone.blue,
      edit: EditScope.limited,
      cancel: true),
  preparing('preparing',
      group: StatusGroup.active,
      tone: PillTone.blue,
      edit: EditScope.limited,
      cancel: true),
  readyPickup('ready_pickup',
      group: StatusGroup.active,
      tone: PillTone.green,
      edit: EditScope.none,
      cancel: true),
  pickupConfirmed('pickup_confirmed',
      group: StatusGroup.active,
      tone: PillTone.green,
      edit: EditScope.none,
      cancel: false),
  outForDelivery('out_for_delivery',
      group: StatusGroup.active,
      tone: PillTone.blue,
      edit: EditScope.none,
      cancel: false),
  nearby('nearby',
      group: StatusGroup.active,
      tone: PillTone.blue,
      edit: EditScope.none,
      cancel: false),
  delivered('delivered',
      group: StatusGroup.active,
      tone: PillTone.green,
      edit: EditScope.none,
      cancel: false),
  delayed('delayed',
      group: StatusGroup.active,
      tone: PillTone.amber,
      edit: EditScope.none,
      cancel: true),
  unavailable('unavailable',
      group: StatusGroup.active,
      tone: PillTone.red,
      edit: EditScope.none,
      cancel: true),
  completed('completed',
      group: StatusGroup.history,
      tone: PillTone.gray,
      edit: EditScope.none,
      cancel: false),
  missed('missed',
      group: StatusGroup.history,
      tone: PillTone.amber,
      edit: EditScope.none,
      cancel: false),
  declined('declined',
      group: StatusGroup.history,
      tone: PillTone.red,
      edit: EditScope.none,
      cancel: false),
  cancelled('cancelled',
      group: StatusGroup.history,
      tone: PillTone.gray,
      edit: EditScope.none,
      cancel: false);

  const RequestStatus(
    this.api, {
    required this.group,
    required this.tone,
    required this.edit,
    required this.cancel,
  });

  final String api;
  final StatusGroup group;
  final PillTone tone;
  final EditScope edit;
  final bool cancel;

  bool get canEdit => edit != EditScope.none;
  bool get canCancel => cancel;

  /// l10n key for the member-facing label, e.g. `st_out_for_delivery`.
  String get l10nKey => 'st_$api';

  static RequestStatus fromApi(String v) => values.firstWhere(
        (e) => e.api == v,
        orElse: () => RequestStatus.submitted,
      );

  /// Nullable lookup — returns null for values that aren't request statuses
  /// (e.g. notification types like Food Access Alerts), so callers can tell
  /// "unknown" apart from a real `submitted`.
  static RequestStatus? tryFromApi(String v) {
    for (final e in values) {
      if (e.api == v) return e;
    }
    return null;
  }
}

/// Ordered member-facing timelines per method (ported from v45 FLOW).
/// Used to render the request-detail progress timeline. Off-timeline statuses
/// (delayed, unavailable, missed, cancelled, declined, needsUpdate) are shown
/// as a separate node, not as a step in these sequences.
class StatusFlow {
  StatusFlow._();

  static const pickup = <RequestStatus>[
    RequestStatus.submitted,
    RequestStatus.approved,
    RequestStatus.preparing,
    RequestStatus.readyPickup,
    RequestStatus.pickupConfirmed,
    RequestStatus.completed,
  ];

  static const delivery = <RequestStatus>[
    RequestStatus.submitted,
    RequestStatus.approved,
    RequestStatus.scheduled,
    RequestStatus.preparing,
    RequestStatus.outForDelivery,
    RequestStatus.nearby,
    RequestStatus.delivered,
    RequestStatus.completed,
  ];

  static List<RequestStatus> forMethod(RequestMethod m) =>
      m == RequestMethod.delivery ? delivery : pickup;

  static const offTimeline = <RequestStatus>{
    RequestStatus.delayed,
    RequestStatus.unavailable,
    RequestStatus.missed,
    RequestStatus.cancelled,
    RequestStatus.declined,
    RequestStatus.needsUpdate,
  };

  static bool isOffTimeline(RequestStatus s) => offTimeline.contains(s);
}
