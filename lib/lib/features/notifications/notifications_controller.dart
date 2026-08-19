import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/network/savvi_api.dart';
import '../../core/state/providers.dart';
import '../../data/models/notification.dart';
import '../../shared/patterns/mutation.dart';

/// Notifications state: the loaded list plus a [mutating] flag so the UI can
/// disable actions and show a pending state while a backend mutation is in
/// flight (prevents duplicate taps).
// class NotificationsState {
//   const NotificationsState({required this.items, this.mutating = false});
//   final AsyncValue<List<MemberNotification>> items;
//   final bool mutating;
//
//   NotificationsState copyWith({
//     AsyncValue<List<MemberNotification>>? items,
//     bool? mutating,
//   }) =>
//       NotificationsState(
//         items: items ?? this.items,
//         mutating: mutating ?? this.mutating,
//       );
// }
//
// /// Loads and mutates the member's notifications. The backend is the source of
// /// truth: local state is patched only after the API confirms, and failures
// /// preserve the prior state and surface an error.
// class NotificationsController extends StateNotifier<NotificationsState> {
//   NotificationsController(this._ref)
//       : super(const NotificationsState(items: AsyncValue.loading())) {
//     load();
//   }
//   final Ref _ref;
//
//   Future<void> load() async {
//     state = state.copyWith(items: const AsyncValue.loading());
//     final res = await _ref.read(savviApiProvider).listNotifications();
//     state = state.copyWith(
//       items: res.when(
//         ok: (rows) => AsyncValue.data(
//             [for (final j in rows) MemberNotification.fromJson(j)]),
//         err: (f) => AsyncValue.error(f.messageKey, StackTrace.current),
//       ),
//     );
//   }
//
//   Future<void> refresh() async {
//     final res = await _ref.read(savviApiProvider).listNotifications();
//     res.when(
//       ok: (rows) => state = state.copyWith(
//           items: AsyncValue.data(
//               [for (final j in rows) MemberNotification.fromJson(j)])),
//       err: (_) {},
//     );
//   }
//
//   List<MemberNotification> get _list => state.items.value ?? const [];
//   int get unreadCount => _list.where((n) => !n.read).length;
//
//   /// Single mark-read — patches only on success (no toast, no pending gate).
//   Future<void> markRead(String id) async {
//     final res = await _ref.read(savviApiProvider).markNotificationRead(id);
//     res.when(
//       ok: (_) => state = state.copyWith(
//           items: AsyncValue.data([
//         for (final n in _list) n.id == id ? n.copyWith(read: true) : n
//       ])),
//       err: (_) {},
//     );
//   }
//
//   /// Mark all read. Non-optimistic: shows a pending state, awaits the API, and
//   /// patches only on success. Guarded against duplicate taps.
//   Future<MutationResult> markAll() async {
//     if (state.mutating) return const MutationResult.ok();
//     state = state.copyWith(mutating: true);
//     final res = await _ref.read(savviApiProvider).markAllNotificationsRead();
//     if (res.when(ok: (_) => true, err: (_) => false)) {
//       state = NotificationsState(
//           items: AsyncValue.data(
//               [for (final n in _list) n.copyWith(read: true)]),
//           mutating: false);
//       return const MutationResult.ok();
//     }
//     state = state.copyWith(mutating: false); // prior list preserved
//     return resultOf(res);
//   }
//
//   /// Clear all. Non-optimistic: pending → await → clear only on success. The
//   /// prior list is preserved on failure. Backend-confirmed (no local-only wipe).
//   Future<MutationResult> clearAll() async {
//     if (state.mutating) return const MutationResult.ok();
//     final prior = state.items;
//     state = state.copyWith(mutating: true);
//     final res = await _ref.read(savviApiProvider).clearNotifications();
//     if (res.when(ok: (_) => true, err: (_) => false)) {
//       state = const NotificationsState(items: AsyncValue.data([]));
//       return const MutationResult.ok();
//     }
//     state = NotificationsState(items: prior); // restore
//     return resultOf(res);
//   }
// }
//
// final notificationsControllerProvider = StateNotifierProvider.autoDispose<
//     NotificationsController, NotificationsState>(
//   (ref) => NotificationsController(ref),
// );
//
// /// Preference state: the channel values plus [savingKey] — the channel whose
// /// save is in flight, so its row can show pending and block re-taps.
// class NotifPrefsState {
//   const NotifPrefsState({required this.values, this.savingKey});
//   final Map<String, bool> values;
//   final String? savingKey;
// }

/// Channel preferences (In-app always on; Push + Email member-set). Toggles are
/// optimistic with rollback: the switch flips immediately, and reverts if the
/// backend rejects the change — the UI never disagrees with the backend.
/// Channels: In-app + Push + Email only (no SMS) — locked decision.
// class NotifPrefsController extends StateNotifier<NotifPrefsState> {
//   NotifPrefsController(this._ref)
//       : super(const NotifPrefsState(
//             values: {'inApp': true, 'push': true, 'email': true}));
//   final Ref _ref;
//
//   Future<MutationResult> toggle(String key) async {
//     if (key == 'inApp') return const MutationResult.ok(); // locked on
//     if (state.savingKey != null) return const MutationResult.ok(); // busy
//     final prev = state.values[key] ?? false;
//     final optimistic = {...state.values, key: !prev};
//     state = NotifPrefsState(values: optimistic, savingKey: key); // optimistic
//     final res =
//         await _ref.read(savviApiProvider).setNotificationPreferences(optimistic);
//     return res.when(
//       ok: (_) {
//         state = NotifPrefsState(values: optimistic); // keep, clear pending
//         return const MutationResult.ok();
//       },
//       err: (f) {
//         state = NotifPrefsState(values: {...optimistic, key: prev}); // rollback
//         return MutationResult.err(f.messageKey);
//       },
//     );
//   }
// }
//
// final notifPrefsProvider =
//     StateNotifierProvider<NotifPrefsController, NotifPrefsState>(
//   (ref) => NotifPrefsController(ref),
// );
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

  @override
  void onInit() {
    super.onInit();
    loadNotifications();
  }

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

    final result = await api.listNotifications();

    result.when(
      ok: (rows) {
        notifications.assignAll(
          rows
              .map<MemberNotification>(
                (e) => MemberNotification.fromJson(e),
          )
              .toList(),
        );
      },
      err: (_) {},
    );

    isLoading.value = false;
  }

  Future<void> refreshNotifications() async {
    final result = await api.listNotifications();

    result.when(
      ok: (rows) {
        notifications.assignAll(
          rows
              .map<MemberNotification>(
                (e) => MemberNotification.fromJson(e),
          )
              .toList(),
        );
      },
      err: (_) {},
    );
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