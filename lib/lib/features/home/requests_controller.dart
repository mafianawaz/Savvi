import 'package:get/get.dart';

import '../../core/network/savvi_api.dart';
import '../../data/models/member_request.dart';

/// Loads the member's requests from the backend. Shared by Home (in-progress
/// preview) and Activity (full list). Call [load] on init and [refresh] on
/// pull-to-refresh or after create/edit/cancel invalidates the list.
class RequestsController extends GetxController {
  RequestsController({required this.api});

  final SavviApi api;

  /// The full list, once loaded.
  final RxList<MemberRequest> requests = <MemberRequest>[].obs;

  /// True while the initial load or a refresh is in flight.
  final RxBool isLoading = false.obs;

  /// Set when the last load/refresh failed. Cleared on the next successful
  /// load. Home treats a failed load the same as "no active request" (no
  /// error surface on Home itself); Activity can read this to show a retry
  /// state.
  final Rxn<String> errorKey = Rxn<String>();

  @override
  void onInit() {
    super.onInit();
    load();
  }

  Future<void> load() async {
    isLoading.value = true;
    errorKey.value = null;

    final result = await api.listRequests();

    result.when(
      ok: (rows) {
        requests.assignAll(
          rows.map(MemberRequest.fromJson),
        );
      },
      err: (failure) {
        errorKey.value = failure.messageKey;
      },
    );

    isLoading.value = false;
  }

  /// Re-fetches without flipping [isLoading] to true (used for
  /// pull-to-refresh, where the UI already shows its own refresh spinner).
  Future<void> refresh() async {
    final result = await api.listRequests();

    result.when(
      ok: (rows) {
        requests.assignAll(
          rows.map(MemberRequest.fromJson),
        );
        errorKey.value = null;
      },
      err: (_) {
        // Preserve the prior list on a refresh failure.
      },
    );
  }

  /// The single most relevant in-progress request for the Home hero, or
  /// null. Prefers an in-flight delivery, else the most recent active
  /// request.
  MemberRequest? get activeRequest {
    final active = requests.where((r) => r.isActive).toList();

    if (active.isEmpty) return null;

    active.sort((a, b) {
      final af = a.isInFlight ? 0 : 1;
      final bf = b.isInFlight ? 0 : 1;

      if (af != bf) return af - bf;

      return b.createdAt.compareTo(a.createdAt);
    });

    return active.first;
  }

  /// Cancels [requestId] (optimistic with rollback — remove locally, restore
  /// on failure). Returns null on success or an error key on failure, so the
  /// caller (Activity) can toast the localized message.
  Future<String?> cancel(String requestId) async {
    final index = requests.indexWhere((r) => r.id == requestId);

    if (index == -1) return null;

    final removed = requests[index];
    requests.removeAt(index);

    final result = await api.cancelRequest(requestId);

    return result.when(
      ok: (_) => null,
      err: (failure) {
        requests.insert(index, removed); // rollback
        return failure.messageKey;
      },
    );
  }
}