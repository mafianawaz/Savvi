import 'package:get/get.dart';

import '../../data/models/member_request.dart';
import '../home/requests_controller.dart';

enum ActivityTab { active, history, all }

/// My Requests: filters the shared [RequestsController] list by tab
/// (Active / History / All) and forwards cancel actions to it. Tabs filter
/// by status group, not label strings, so localisation never breaks
/// filtering.
class ActivityController extends GetxController {
  ActivityController({required this.requestsController});

  final RequestsController requestsController;

  final Rx<ActivityTab> tab = ActivityTab.active.obs;

  bool get isLoading => requestsController.isLoading.value;

  String? get errorKey => requestsController.errorKey.value;

  List<MemberRequest> get filtered {
    final all = requestsController.requests;

    return switch (tab.value) {
      ActivityTab.active => all.where((r) => r.isActive).toList(),
      ActivityTab.history => all.where((r) => !r.isActive).toList(),
      ActivityTab.all => all.toList(),
    };
  }

  void setTab(ActivityTab next) => tab.value = next;

  Future<void> refresh() => requestsController.refresh();

  Future<String?> cancel(String requestId) =>
      requestsController.cancel(requestId);
}
