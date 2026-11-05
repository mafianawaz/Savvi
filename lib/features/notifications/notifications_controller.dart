
import '../../core/network/savvi_api.dart';
import '../../core/state/providers.dart';
import '../../data/models/notification.dart';
import '../../shared/patterns/mutation.dart';
import 'package:get/get.dart';

class NotificationsController extends GetxController {
  NotificationsController({
    required this.api,
  });

  final SavviApi api;

  /// ------------------------------
  /// Notifications
  /// ------------------------------

  final RxBool isLoading = true.obs;
  final RxBool isMutating = false.obs;
  final RxInt currentPage = 1.obs;
  final RxBool hasMore = true.obs;
  static const int pageSize = 10;

  final RxList<MemberNotification> notifications =
      <MemberNotification>[].obs;

  /// ------------------------------
  /// Preferences
  /// ------------------------------

  final RxMap<String, bool> prefs = <String, bool>{
    'inApp': true,
    'push': true,
    'email': true,
  }.obs;

  final RxnString savingKey = RxnString();

  //==========================================================
  // GETTERS
  //==========================================================

  int get unreadCount =>
      notifications.where((e) => !e.read).length;

  bool get mutating => isMutating.value;

  bool get loading => isLoading.value;

  //==========================================================
  // LOAD
  //==========================================================

  Future<void> loadNotifications() async {
    isLoading.value = true;

    final result = await api.listNotifications(page: 1, limit: pageSize);

    result.when(
      ok: (rows) {
        final parsed = rows
            .map<MemberNotification>((e) => MemberNotification.fromJson(e))
            .toList();
        notifications.assignAll(parsed);
        currentPage.value = 1;
        hasMore.value = parsed.length >= pageSize;
      },
      err: (_) {},
    );

    isLoading.value = false;
  }

  Future<void> refreshNotifications() async {
    final result = await api.listNotifications(page: 1, limit: pageSize);

    result.when(
      ok: (rows) {
        final parsed = rows
            .map<MemberNotification>((e) => MemberNotification.fromJson(e))
            .toList();
        notifications.assignAll(parsed);
        currentPage.value = 1;
        hasMore.value = parsed.length >= pageSize;
      },
      err: (_) {},
    );
  }

  Future<void> loadMoreNotifications() async {
    if (isLoading.value || !hasMore.value) return;
    final nextPage = currentPage.value + 1;
    isLoading.value = true;
    final result = await api.listNotifications(page: nextPage, limit: pageSize);
    result.when(
      ok: (rows) {
        final parsed = rows
            .map<MemberNotification>((e) => MemberNotification.fromJson(e))
            .toList();
        final knownIds = notifications.map((e) => e.id).toSet();
        notifications.addAll(parsed.where((e) => !knownIds.contains(e.id)));
        currentPage.value = nextPage;
        hasMore.value = parsed.length >= pageSize;
      },
      err: (_) {},
    );
    isLoading.value = false;
  }

  //==========================================================
  // MARK READ
  //==========================================================

  Future<void> markRead(String id) async {
    final result = await api.markNotificationRead(id);

    result.when(
      ok: (_) {
        final index =
        notifications.indexWhere((e) => e.id == id);

        if (index == -1) return;

        notifications[index] =
            notifications[index].copyWith(read: true);
      },
      err: (_) {},
    );
  }

  //==========================================================
  // MARK ALL
  //==========================================================

  Future<MutationResult> markAllRead() async {
    if (isMutating.value) {
      return const MutationResult.ok();
    }

    isMutating.value = true;

    final result = await api.markAllNotificationsRead();

    isMutating.value = false;

    return result.when(
      ok: (_) {
        for (int i = 0; i < notifications.length; i++) {
          notifications[i] =
              notifications[i].copyWith(read: true);
        }

        notifications.refresh();

        return const MutationResult.ok();
      },
      err: (f) {
        return MutationResult.err(f.messageKey);
      },
    );
  }

  Future<MutationResult> deleteNotification(String id) async {
    if (isMutating.value) return const MutationResult.ok();
    isMutating.value = true;
    final result = await api.deleteNotification(id);
    isMutating.value = false;
    return result.when(
      ok: (_) {
        notifications.removeWhere((item) => item.id == id);
        return const MutationResult.ok();
      },
      err: (failure) => MutationResult.err(failure.messageKey),
    );
  }

  //==========================================================
  // CLEAR
  //==========================================================

  Future<MutationResult> clearAll() async {
    if (isMutating.value) {
      return const MutationResult.ok();
    }

    isMutating.value = true;

    final result = await api.clearNotifications();

    isMutating.value = false;

    return result.when(
      ok: (_) {
        notifications.clear();
        return const MutationResult.ok();
      },
      err: (f) {
        return MutationResult.err(f.messageKey);
      },
    );
  }

  //==========================================================
  // PREFERENCES
  //==========================================================

  Future<MutationResult> togglePreference(
      String key,
      ) async {
    if (key == 'inApp') {
      return const MutationResult.ok();
    }

    if (savingKey.value != null) {
      return const MutationResult.ok();
    }

    savingKey.value = key;

    final previous = prefs[key] ?? false;

    prefs[key] = !previous;

    final result =
    await api.setNotificationPreferences(
      Map<String, bool>.from(prefs),
    );

    savingKey.value = null;

    return result.when(
      ok: (_) {
        return const MutationResult.ok();
      },
      err: (f) {
        prefs[key] = previous;
        return MutationResult.err(f.messageKey);
      },
    );
  }
}