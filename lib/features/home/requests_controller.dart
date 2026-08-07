import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/network/savvi_api.dart';
import '../../core/state/providers.dart';
import '../../data/models/member_request.dart';

/// Loads the member's requests from the backend. Shared by Home (in-progress
/// preview) and Activity (full list, Stage 3B). Auto-disposes and refreshes on
/// invalidate after create/edit/cancel.
// final requestsProvider =
//     FutureProvider.autoDispose<List<MemberRequest>>((ref) async {
//   final api = ref.watch(savviApiProvider);
//   final res = await api.listRequests();
//   return res.when(
//     ok: (rows) => rows.map(MemberRequest.fromJson).toList(),
//     err: (f) => throw StateError(f.messageKey),
//   );
// });
//
// /// Fetches a single request by id for the detail screen.
// final requestDetailProvider =
//     FutureProvider.autoDispose.family<MemberRequest, String>((ref, id) async {
//   final api = ref.watch(savviApiProvider);
//   final res = await api.getRequest(id);
//   return res.when(
//     ok: MemberRequest.fromJson,
//     err: (f) => throw StateError(f.messageKey),
//   );
// });
//
// // / The single most relevant in-progress request for the Home hero, or null.
// // / Prefers an in-flight delivery, else the most recent active request.
// final activeRequestProvider = Provider.autoDispose<MemberRequest?>((ref) {
//   final async = ref.watch(requestsProvider);
//   return async.maybeWhen(
//     data: (list) {
//       final active = list.where((r) => r.isActive).toList();
//       if (active.isEmpty) return null;
//       active.sort((a, b) {
//         final af = a.isInFlight ? 0 : 1;
//         final bf = b.isInFlight ? 0 : 1;
//         if (af != bf) return af - bf;
//         return b.createdAt.compareTo(a.createdAt);
//       });
//       return active.first;
//     },
//     orElse: () => null,
//   );
// });

import 'package:get/get.dart';

// class RequestsController extends GetxController {
//   RequestsController({
//     required this.api,
//   });
//
//   final SavviApi api;
//
//   /// Loading
//   final RxBool isLoading = false.obs;
//
//   /// All requests
//   final RxList<MemberRequest> requests = <MemberRequest>[].obs;
//
//   /// Currently opened request
//   final Rxn<MemberRequest> requestDetail = Rxn<MemberRequest>();
//
//   @override
//   void onInit() {
//     super.onInit();
//     loadRequests();
//   }
//
//   //----------------------------------------------------------------------
//   // API
//   //----------------------------------------------------------------------
//
//   Future<void> loadRequests() async {
//     isLoading.value = true;
//
//     final result = await api.listRequests();
//
//     result.when(
//       ok: (rows) {
//         requests.assignAll(
//           rows.map(MemberRequest.fromJson),
//         );
//       },
//       err: (_) {
//         requests.clear();
//       },
//     );
//
//     isLoading.value = false;
//   }
//
//   Future<void> refreshRequests() async {
//     await loadRequests();
//   }
//
//   Future<void> getRequestDetail(String id) async {
//     isLoading.value = true;
//
//     final result = await api.getRequest(id);
//
//     result.when(
//       ok: (json) {
//         requestDetail.value = MemberRequest.fromJson(json);
//       },
//       err: (_) {
//         requestDetail.value = null;
//       },
//     );
//
//     isLoading.value = false;
//   }
//
//   //----------------------------------------------------------------------
//   // Computed
//   //----------------------------------------------------------------------
//
//   MemberRequest? get activeRequest {
//     final active =
//     requests.where((e) => e.isActive).toList();
//
//     if (active.isEmpty) return null;
//
//     active.sort((a, b) {
//       final af = a.isInFlight ? 0 : 1;
//       final bf = b.isInFlight ? 0 : 1;
//
//       if (af != bf) {
//         return af - bf;
//       }
//
//       return b.createdAt.compareTo(a.createdAt);
//     });
//
//     return active.first;
//   }
// }

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
}