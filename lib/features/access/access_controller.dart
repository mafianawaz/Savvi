import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/network/savvi_api.dart';
import '../../core/routing/app_router.dart';
import '../../core/state/providers.dart';
import '../../data/models/onboarding.dart';
/// RiverPod
/// Holds the current access-verification result during onboarding. The backend
/// decides the outcome (ok / onsite / expired / used / invalid) and enforces
/// the 48-hour expiry; this controller only stores and exposes it.
// class AccessController extends StateNotifier<AsyncValue<AccessGrant?>> {
//   AccessController(this._ref) : super(const AsyncData(null));
//   final Ref _ref;
//
//   /// Verify a pasted access link or code.
//   Future<AccessGrant> verifyLink(String tokenOrCode) async {
//     state = const AsyncLoading();
//     final api = _ref.read(savviApiProvider);
//     final res = await api.verifyAccessLink(tokenOrCode.trim());
//     final grant = res.when(
//       ok: (data) => AccessGrant.fromJson(data),
//       err: (_) => const AccessGrant(state: AccessState.invalid),
//     );
//     state = AsyncData(grant.verified ? grant : null);
//     return grant;
//   }
//
//   /// Verify a scanned QR token for access.
//   Future<AccessGrant> verifyQr(String token) async {
//     state = const AsyncLoading();
//     final api = _ref.read(savviApiProvider);
//     final res = await api.verifyQr(token: token.trim(), purpose: 'access');
//     final grant = res.when(
//       ok: (data) => AccessGrant.fromJson({...data, 'state': data['state']}),
//       err: (_) => const AccessGrant(state: AccessState.invalid),
//     );
//     state = AsyncData(grant.verified ? grant : null);
//     return grant;
//   }
//
//   void reset() => state = const AsyncData(null);
// }
//
// final accessControllerProvider =
//     StateNotifierProvider<AccessController, AsyncValue<AccessGrant?>>(
//         (ref) => AccessController(ref));
//
// /// The verified grant, or null if not yet verified. Read by the signup screen
// /// to gate profile creation on a verified access context.
// final accessGrantProvider = Provider<AccessGrant?>((ref) {
//   return ref.watch(accessControllerProvider).valueOrNull;
// });


/// GetX

import 'package:get/get.dart';

import '../../l10n/app_localizations.dart';
import '../../shared/patterns/feedback.dart';


class AccessController extends GetxController {
  AccessController({
    required this.api,
  });

  final SavviApi api;

  /// Text fields
  final accessCodeController = TextEditingController();
  final qrCodeController = TextEditingController();

  /// Loading
  final RxBool isLoading = false.obs;

  /// Current verified grant
  final Rxn<AccessGrant> accessGrant = Rxn<AccessGrant>();

  bool get verified => accessGrant.value?.verified ?? false;

  @override
  void onClose() {
    accessCodeController.dispose();
    qrCodeController.dispose();
    super.onClose();
  }

  //==============================================================
  // Helpers
  //==============================================================

  String _stateError(
      AppLocalizations l,
      AccessState state,
      ) {
    switch (state) {
      case AccessState.expired:
        return l.accessErrExpired;

      case AccessState.used:
        return l.accessErrUsed;

      default:
        return l.accessErrInvalid;
    }
  }

  //==============================================================
  // Verify Access Link
  //==============================================================

  Future<void> verifyAccess(BuildContext context) async {
    final l = AppLocalizations.of(context);

    final value = accessCodeController.text.trim();

    if (value.isEmpty) {
      SavFeedback.toast(
        context,
        l.accessErrEmpty,
        tone: FeedbackTone.warning,
      );
      return;
    }

    isLoading.value = true;

    try {
      final result = await api.verifyAccessLink(value);

      final grant = result.when(
        ok: (data) => AccessGrant.fromJson(data),
        err: (_) => const AccessGrant(
          state: AccessState.invalid,
        ),
      );

      accessGrant.value = grant.verified ? grant : null;

      if (!grant.verified) {
        SavFeedback.toast(
          context,
          _stateError(l, grant.state),
          tone: FeedbackTone.error,
        );
      }
    } finally {
      isLoading.value = false;
    }
  }

  //==============================================================
  // Verify QR
  //==============================================================

  Future<void> verifyQr(BuildContext context) async {
    final l = AppLocalizations.of(context);

    final token = qrCodeController.text.trim();

    if (token.isEmpty) {
      SavFeedback.toast(
        context,
        l.accessErrEmpty,
        tone: FeedbackTone.warning,
      );
      return;
    }

    isLoading.value = true;

    try {
      final result = await api.verifyQr(
        token: token,
        purpose: 'access',
      );

      final grant = result.when(
        ok: (data) => AccessGrant.fromJson({
          ...data,
          'state': data['state'],
        }),
        err: (_) => const AccessGrant(
          state: AccessState.invalid,
        ),
      );

      accessGrant.value = grant.verified ? grant : null;

      if (grant.verified) {
        Get.offNamed(Routes.signUp);
      } else {
        SavFeedback.toast(
          context,
          _stateError(l, grant.state),
          tone: FeedbackTone.error,
        );
      }
    } finally {
      isLoading.value = false;
    }
  }

  //==============================================================
  // Navigation
  //==============================================================

  void continueSignup() {
    if (verified) {
      Get.toNamed(Routes.signUp);
    }
  }

  void openQrScreen() {
    Get.toNamed(Routes.qrAccess);
  }

  //==============================================================
  // Reset
  //==============================================================

  void reset() {
    isLoading.value = false;

    accessGrant.value = null;

    accessCodeController.clear();

    qrCodeController.clear();
  }
}