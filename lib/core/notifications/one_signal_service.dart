import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import '../routing/app_router.dart';

/// Shared OneSignal integration for Android and iOS.
/// Configure the same OneSignal App ID for both platforms:
/// flutter run --dart-define=ONESIGNAL_APP_ID=YOUR_ONESIGNAL_APP_ID
class OneSignalService {
  OneSignalService._();

  static final OneSignalService instance = OneSignalService._();
  static const String _appId = '5eaceab5-c504-4f59-8859-d347d2cfb831';

  bool _initialized = false;
  bool _observerAttached = false;
  Future<void> Function(String playerId)? _playerIdHandler;
  String? _lastDeliveredPlayerId;

  bool get isConfigured => _appId.trim().isNotEmpty;
  bool get isInitialized => _initialized;

  /// Set after the API client and token storage are registered.
  /// The callback is invoked when OneSignal creates or rotates the push
  /// subscription ID, including after a permission decision.
  void setPlayerIdHandler(Future<void> Function(String playerId)? handler) {
    _playerIdHandler = handler;
    final id = playerId;
    if (id != null) _notifyPlayerId(id);
  }

  Future<void> initialize({bool requestPermission = true}) async {
    if (_initialized || !isConfigured) {
      if (!isConfigured) {
        debugPrint('[OneSignal] Missing ONESIGNAL_APP_ID; push setup skipped.');
      }
      return;
    }

    try {
      OneSignal.Debug.setLogLevel(
        kDebugMode ? OSLogLevel.verbose : OSLogLevel.none,
      );
      OneSignal.initialize(_appId.trim());
      _initialized = true;

      OneSignal.Notifications.addClickListener((event) {
        // The SDK may deliver a cold-start tap before GetMaterialApp mounts.
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (Get.key.currentState != null &&
              Get.currentRoute != Routes.notifications) {
            Get.toNamed(Routes.notifications);
          }
        });
      });

      if (!_observerAttached) {
        OneSignal.User.pushSubscription.addObserver((state) {
          final id = state.current.id;
          if (id != null && id.trim().isNotEmpty) {
            _notifyPlayerId(id.trim());
          }
        });
        _observerAttached = true;
      }

      if (requestPermission) {
        await OneSignal.Notifications.requestPermission(true);
      }

      // Subscription registration is asynchronous on both platforms. The
      // observer handles the eventual ID; login/signup also wait for it.
    } catch (error, stack) {
      debugPrint('[OneSignal] Initialization failed: $error');
      debugPrintStack(stackTrace: stack);
    }
  }


  /// Associate the authenticated Savvi member with this OneSignal subscription.
  /// This enables dashboard/API targeting by the member's stable backend ID.
  Future<void> identifyUser(String externalUserId) async {
    final id = externalUserId.trim();
    if (!_initialized || id.isEmpty) return;
    try {
      await OneSignal.login(id);
    } catch (error, stack) {
      debugPrint('[OneSignal] User identification failed: $error');
      debugPrintStack(stackTrace: stack);
    }
  }

  /// Clear the OneSignal user association when the member signs out.
  Future<void> clearUser() async {
    if (!_initialized) return;
    try {
      await OneSignal.logout();
      _lastDeliveredPlayerId = null;
    } catch (error, stack) {
      debugPrint('[OneSignal] User logout failed: $error');
      debugPrintStack(stackTrace: stack);
    }
  }

  /// OneSignal v5 push subscription ID. This is the value expected by the
  /// backend's `oneSignalPlayerId` property (not a legacy player ID).
  String? get playerId {
    if (!_initialized) return null;
    final id = OneSignal.User.pushSubscription.id;
    return id == null || id.trim().isEmpty ? null : id.trim();
  }

  Future<String?> waitForPlayerId({int attempts = 8}) async {
    for (var i = 0; i < attempts; i++) {
      final id = playerId;
      if (id != null) return id;
      await Future<void>.delayed(const Duration(milliseconds: 500));
    }
    return playerId;
  }

  void _notifyPlayerId(String id) {
    if (id.isEmpty || id == _lastDeliveredPlayerId) return;
    _lastDeliveredPlayerId = id;
    final handler = _playerIdHandler;
    if (handler == null) return;
    unawaited(handler(id).catchError((Object error, StackTrace stack) {
      debugPrint('[OneSignal] Backend player ID sync failed: $error');
      debugPrintStack(stackTrace: stack);
    }));
  }
}
