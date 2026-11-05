import 'package:get/get.dart';

import '../../core/network/savvi_api.dart';
import '../../data/models/member_request.dart';
import '../home/requests_controller.dart';

enum ActivityTab { active, history, all }

/// My Requests uses the backend's tab query so History is fetched from
/// `savi-support-requests?tab=history`, while preserving the shared Home list.
class ActivityController extends GetxController {
  ActivityController({
    required this.requestsController,
    required this.api,
  });

  final RequestsController requestsController;
  final SavviApi api;

  final Rx<ActivityTab> tab = ActivityTab.active.obs;
  final RxList<MemberRequest> tabRequests = <MemberRequest>[].obs;
  final RxBool tabLoading = false.obs;
  final Rxn<String> tabErrorKey = Rxn<String>();

  bool get isLoading => tabLoading.value;
  String? get errorKey => tabErrorKey.value;

  List<MemberRequest> get filtered => tabRequests.toList();

  @override
  void onInit() {
    super.onInit();
    loadTab(ActivityTab.active);
  }

  Future<void> setTab(ActivityTab next) async {
    if (tab.value == next && tabRequests.isNotEmpty) return;
    tab.value = next;
    await loadTab(next);
  }

  Future<void> loadTab(ActivityTab selected) async {
    tabLoading.value = true;
    tabErrorKey.value = null;
    final queryTab = switch (selected) {
      ActivityTab.active => 'active',
      ActivityTab.history => 'history',
      ActivityTab.all => 'all',
    };
    final result = await api.listRequests(tab: queryTab);
    result.when(
      ok: (rows) {
        final parsed = rows.map(MemberRequest.fromJson).toList()
          ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
        tabRequests.assignAll(parsed);
        // Keep the shared cache useful for detail actions and Home, but don't
        // replace it with History-only rows.
        if (selected != ActivityTab.history) {
          requestsController.requests.assignAll(parsed);
        }
      },
      err: (failure) => tabErrorKey.value = failure.messageKey,
    );
    tabLoading.value = false;
  }

  Future<void> refresh() => loadTab(tab.value);

  Future<String?> cancel(String requestId) async {
    final error = await requestsController.cancel(requestId);
    if (error == null) await refresh();
    return error;
  }
}
