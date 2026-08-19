import 'package:get/get.dart';

import '../../core/network/savvi_api.dart';
import '../../data/models/member_request.dart';
import '../../data/models/request_status.dart';
import '../home/requests_controller.dart';

/// Per-instance controller for the delivery tracking screen. Starts from the
/// request already held by [RequestsController] (or fetches it directly if
/// opened before that list has loaded), then overlays a live status/ETA/
/// distance read from [SavviApi.getDeliveryStatus] — a dedicated,
/// backend-issued live-tracking endpoint separate from the request list
/// snapshot.
class DeliveryTrackingController extends GetxController {
  DeliveryTrackingController({
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
    if (resolved != null) {
      final live = await api.getDeliveryStatus(requestId);
      request.value = live.when(
        ok: (json) => _mergeLive(resolved, json),
        err: (_) => resolved, // fall back to the list/detail snapshot
      );
    }

    isLoading.value = false;
  }

  MemberRequest _mergeLive(MemberRequest r, Map<String, dynamic> j) =>
      MemberRequest(
        id: r.id,
        method: r.method,
        status: RequestStatus.tryFromApi(j['status'] as String? ?? '') ??
            r.status,
        createdAt: r.createdAt,
        categories: r.categories,
        household: r.household,
        weightLb: r.weightLb,
        etaLo: (j['etaLo'] as num?)?.toInt() ?? r.etaLo,
        etaHi: (j['etaHi'] as num?)?.toInt() ?? r.etaHi,
        distanceMi: (j['distanceMi'] as num?)?.toDouble() ?? r.distanceMi,
        diet: r.diet,
        allergens: r.allergens,
        notes: r.notes,
        pickupCode: r.pickupCode,
      );

  MemberRequest? _cached() {
    for (final r in requestsController.requests) {
      if (r.id == requestId) return r;
    }
    return null;
  }
}

/// Registers a [DeliveryTrackingController] tagged with the pushed request id
/// (`Get.arguments`), so it lives for exactly the lifetime of this route.
class DeliveryTrackingBinding extends Bindings {
  @override
  void dependencies() {
    final requestId = Get.arguments as String? ?? '';
    Get.lazyPut<DeliveryTrackingController>(
      () => DeliveryTrackingController(
        requestId: requestId,
        api: Get.find<SavviApi>(),
        requestsController: Get.find<RequestsController>(),
      ),
      tag: requestId,
    );
  }
}
