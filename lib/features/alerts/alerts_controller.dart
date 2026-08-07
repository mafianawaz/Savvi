import '../../data/models/member_request.dart';
import 'package:get/get.dart';
import '../../core/network/savvi_api.dart';

/// Loads Food Access Alerts and manages RSVP state. RSVP is editable — a member
/// can confirm, change the count, or cancel — so nonprofit headcounts stay
/// accurate (addresses the v41 audit's RSVP-editability finding). The backend
/// owns the authoritative count; this holds optimistic local state.


/// Loads Food Access Alerts and manages RSVP state. RSVP is editable — a
/// member can confirm, change the count, or cancel — so nonprofit headcounts
/// stay accurate (addresses the v41 audit's RSVP-editability finding). The
/// backend owns the authoritative count; this holds optimistic local state.
class AlertsController extends GetxController {
  AlertsController({required this.api});

  final SavviApi api;

  final RxList<FoodAlert> alerts = <FoodAlert>[].obs;

  /// True while the initial load is in flight. Distinct from [isRefreshing]
  /// so pull-to-refresh doesn't flash a full-screen loading state over an
  /// already-populated list.
  final RxBool isLoading = false.obs;
  final RxBool isRefreshing = false.obs;

  /// Set when the last load failed and the list is still empty.
  final Rxn<String> errorKey = Rxn<String>();

  @override
  void onInit() {
    super.onInit();
    load();
  }

  Future<void> load() async {
    isLoading.value = true;
    errorKey.value = null;

    await _fetch();

    isLoading.value = false;
  }

  /// Reload without flipping to a loading state, so pull-to-refresh keeps
  /// the current list visible instead of flashing a full-screen spinner.
  Future<void> refresh() async {
    isRefreshing.value = true;
    await _fetch();
    isRefreshing.value = false;
  }

  Future<void> _fetch() async {
    final result = await api.listAlerts();

    result.when(
      ok: (rows) {
        alerts.assignAll(rows.map(FoodAlert.fromJson));
        errorKey.value = null;
      },
      err: (failure) {
        errorKey.value = failure.messageKey;
      },
    );
  }

  /// Confirm or change the RSVP headcount. The backend is the authority: it
  /// validates the count (rejecting <1, >household, >remaining, or closed
  /// events). Local state is patched only on success, from the backend's
  /// returned values. Returns null on success, or an l10n error key on
  /// failure.
  Future<String?> rsvp(String id, int count) async {
    final result = await api.rsvpAlert(id, count);

    return result.when(
      ok: (data) {
        final confirmed = (data['rsvp'] as num?)?.toInt() ?? count;
        final remaining = (data['left'] as num?)?.toInt();
        _patch(id, rsvp: confirmed, left: remaining);
        return null;
      },
      err: (failure) => failure.messageKey,
    );
  }

  /// Cancel an existing RSVP. Returns null on success, or an l10n error key.
  Future<String?> cancel(String id) async {
    final result = await api.cancelRsvp(id);

    return result.when(
      ok: (_) {
        _patch(id, rsvp: 0);
        return null;
      },
      err: (failure) => failure.messageKey,
    );
  }

  void _patch(String id, {required int rsvp, int? left}) {
    final index = alerts.indexWhere((a) => a.id == id);

    if (index == -1) return;

    final current = alerts[index];

    alerts[index] = current.copyWith(
      rsvp: rsvp,
      left: left ?? current.left,
    );
  }
}
