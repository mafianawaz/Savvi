import 'package:get/get.dart';

import '../../core/network/savvi_api.dart';
import '../../data/models/member_request.dart';
import '../home/requests_controller.dart';

/// Per-instance controller for the pickup screen. Starts from the request
/// already held by [RequestsController] (or fetches it directly if opened
/// before that list has loaded). If no pickup code is on the request yet,
/// fetches one from [SavviApi.getPickup] — codes/QR are backend-issued, so
/// until one exists the screen shows a waiting state rather than fabricating
/// one (locked decision).
class PickupController extends GetxController {
  PickupController({
    required this.requestId,
    required this.api,
    required this.requestsController,
  });

  final String requestId;
  final SavviApi api;
  final RequestsController requestsController;

  final Rxn<MemberRequest> request = Rxn<MemberRequest>();
  final RxBool isLoading = false.obs;
  final Rxn<String> errorKey = Rxn<String>();

  @override
  void onInit() {
    super.onInit();
    load();
  }

  Future<void> load() async {
    isLoading.value = true;
    errorKey.value = null;

    var base = _cached();
    if (base == null) {
      final result = await api.getRequest(requestId);
      result.when(
        ok: (json) => base = MemberRequest.fromJson(json),
        err: (failure) => errorKey.value = failure.messageKey,
      );
    }

    final resolved = base;
    if (resolved == null) {
      isLoading.value = false;
      return;
    }

    if (resolved.pickupCode != null) {
      request.value = resolved;
      isLoading.value = false;
      return;
    }

    // No code yet on the snapshot — ask the backend directly (it issues the
    // code once the request is ready, at its own pace).
    final pk = await api.getPickup(requestId);
    request.value = pk.when(
      ok: (json) => _withPickupCode(resolved, json['pickupCode'] as String?),
      err: (_) => resolved,
    );

    isLoading.value = false;
  }

  MemberRequest _withPickupCode(MemberRequest r, String? code) =>
      MemberRequest(
        id: r.id,
        method: r.method,
        status: r.status,
        createdAt: r.createdAt,
        categories: r.categories,
        household: r.household,
        weightLb: r.weightLb,
        etaLo: r.etaLo,
        etaHi: r.etaHi,
        distanceMi: r.distanceMi,
        diet: r.diet,
        allergens: r.allergens,
        notes: r.notes,
        pickupCode: code ?? r.pickupCode,
      );

  MemberRequest? _cached() {
    for (final r in requestsController.requests) {
      if (r.id == requestId) return r;
    }
    return null;
  }
}

/// Registers a [PickupController] tagged with the pushed request id
/// (`Get.arguments`), so it lives for exactly the lifetime of this route.
class PickupBinding extends Bindings {
  @override
  void dependencies() {
    final requestId = Get.arguments as String? ?? '';
    Get.lazyPut<PickupController>(
      () => PickupController(
        requestId: requestId,
        api: Get.find<SavviApi>(),
        requestsController: Get.find<RequestsController>(),
      ),
      tag: requestId,
    );
  }
}
