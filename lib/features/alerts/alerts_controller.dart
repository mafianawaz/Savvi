import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/state/providers.dart';
import '../../data/models/member_request.dart';

/// Loads Food Access Alerts and manages RSVP state. RSVP is editable — a member
/// can confirm, change the count, or cancel — so nonprofit headcounts stay
/// accurate (addresses the v41 audit's RSVP-editability finding). The backend
/// owns the authoritative count; this holds optimistic local state.
// class AlertsController extends StateNotifier<AsyncValue<List<FoodAlert>>> {
//   AlertsController(this._ref) : super(const AsyncLoading()) {
//     load();
//   }
//   final Ref _ref;
//
//   Future<void> load() async {
//     state = const AsyncLoading();
//     await _fetch();
//   }
//
//   /// Reload without flipping to a loading state, so pull-to-refresh keeps the
//   /// current list visible instead of flashing a full-screen spinner.
//   Future<void> refresh() => _fetch();
//
//   Future<void> _fetch() async {
//     final api = _ref.read(savviApiProvider);
//     final res = await api.listAlerts();
//     state = res.when(
//       ok: (rows) => AsyncData(rows.map(FoodAlert.fromJson).toList()),
//       err: (f) => AsyncError(StateError(f.messageKey), StackTrace.current),
//     );
//   }
//
//   /// Confirm or change the RSVP headcount. The backend is the authority: it
//   /// validates the count (rejecting <1, >household, >remaining, or closed
//   /// events). Local state is patched only on success, from the backend's
//   /// returned values. Returns null on success, or an l10n error key on failure.
//   Future<String?> rsvp(String id, int count) async {
//     final api = _ref.read(savviApiProvider);
//     final res = await api.rsvpAlert(id, count);
//     return res.when(
//       ok: (data) {
//         final confirmed = (data['rsvp'] as num?)?.toInt() ?? count;
//         final remaining = (data['left'] as num?)?.toInt();
//         _patch(id, rsvp: confirmed, left: remaining);
//         return null;
//       },
//       err: (f) => f.messageKey,
//     );
//   }
//
//   /// Cancel an existing RSVP. Returns null on success, or an l10n error key.
//   Future<String?> cancel(String id) async {
//     final api = _ref.read(savviApiProvider);
//     final res = await api.cancelRsvp(id);
//     return res.when(
//       ok: (_) {
//         _patch(id, rsvp: 0);
//         return null;
//       },
//       err: (f) => f.messageKey,
//     );
//   }
//
//   void _patch(String id, {required int rsvp, int? left}) {
//     final list = state.valueOrNull;
//     if (list == null) return;
//     state = AsyncData([
//       for (final a in list)
//         a.id == id ? a.copyWith(rsvp: rsvp, left: left ?? a.left) : a,
//     ]);
//   }
// }
//
// final alertsControllerProvider = StateNotifierProvider.autoDispose<
//     AlertsController, AsyncValue<List<FoodAlert>>>(
//   (ref) => AlertsController(ref),
// );
