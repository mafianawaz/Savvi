import 'package:get/get.dart';

import '../../core/network/savvi_api.dart';
import '../../data/models/member_request.dart';
import '../home/requests_controller.dart';

/// Per-instance controller for a single request's detail screen. Scoped with
/// `tag: requestId` (via [RequestDetailBinding]) so each open detail screen
/// has isolated load/cancel state and is disposed when the screen is popped.
///
/// [RequestsController]'s list is the source of truth shared by Home and
/// Activity; this controller resolves the one request from that list where
/// possible, falling back to a direct [SavviApi.getRequest] fetch (e.g. a
/// deep link opened before the list has loaded).
class RequestDetailController extends GetxController {
  RequestDetailController({
    required this.requestId,
    required this.api,
    required this.requestsController,
  });

  final String requestId;
  final SavviApi api;
  final RequestsController requestsController;

  final Rxn<MemberRequest> request = Rxn<MemberRequest>();
  final RxBool isLoading = false.obs;
  final RxBool isCancelling = false.obs;
  final Rxn<String> errorKey = Rxn<String>();

  @override
  void onInit() {
    super.onInit();
    load();
  }

  Future<void> load() async {
    final cached = _cached();
    if (cached != null) {
      request.value = cached;
      return;
    }

    isLoading.value = true;
    errorKey.value = null;

    final result = await api.getRequest(requestId);
    result.when(
      ok: (json) => request.value = MemberRequest.fromJson(json),
      err: (failure) => errorKey.value = failure.messageKey,
    );

    isLoading.value = false;
  }

  /// Cancels via the shared [RequestsController] (optimistic with rollback —
  /// same behaviour as Activity's cancel). Returns true on success so the
  /// screen can pop; false leaves the screen open with [errorKey] set so the
  /// caller can toast the localized message.
  Future<bool> cancel() async {
    isCancelling.value = true;
    final err = await requestsController.cancel(requestId);
    isCancelling.value = false;

    if (err == null) return true;

    errorKey.value = err;
    return false;
  }

  MemberRequest? _cached() {
    for (final r in requestsController.requests) {
      if (r.id == requestId) return r;
    }
    return null;
  }
}

/// Registers a [RequestDetailController] tagged with the pushed request id
/// (`Get.arguments`), so it lives for exactly the lifetime of this route.
class RequestDetailBinding extends Bindings {
  @override
  void dependencies() {
    final requestId = Get.arguments as String? ?? '';
    Get.lazyPut<RequestDetailController>(
      () => RequestDetailController(
        requestId: requestId,
        api: Get.find<SavviApi>(),
        requestsController: Get.find<RequestsController>(),
      ),
      tag: requestId,
    );
  }
}
