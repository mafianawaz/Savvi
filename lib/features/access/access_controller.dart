import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/network/savvi_api.dart';
import '../../core/routing/app_router.dart';
import '../../data/models/onboarding.dart';
import '../../l10n/app_localizations.dart';
import '../../shared/patterns/feedback.dart';

class AccessController extends GetxController {
  AccessController({required this.api});

  final SavviApi api;
  final accessCodeController = TextEditingController();
  final qrCodeController = TextEditingController();
  final RxBool isLoading = false.obs;
  final Rxn<AccessGrant> accessGrant = Rxn<AccessGrant>();

  bool get verified => accessGrant.value?.verified ?? false;

  @override
  void onClose() {
    accessCodeController.dispose();
    qrCodeController.dispose();
    super.onClose();
  }

  String _stateError(AppLocalizations l, AccessState state) {
    switch (state) {
      case AccessState.expired:
        return l.accessErrExpired;
      case AccessState.used:
        return l.accessErrUsed;
      default:
        return l.accessErrInvalid;
    }
  }

  Future<AccessGrant?> verifyAccess(BuildContext context) async {
    final l = AppLocalizations.of(context);
    final value = accessCodeController.text.trim();

    if (value.isEmpty) {
      SavFeedback.toast(
        context,
        l.accessErrEmpty,
        tone: FeedbackTone.warning,
      );
      return null;
    }

    if (isLoading.value) return accessGrant.value;

    isLoading.value = true;

    try {
      final result = await api.verifyAccessLink(value);

      final grant = result.when(
        ok: (data) => AccessGrant.fromJson({
          ...data,
          'source': 'link',
        }),

        err: (failure) {
          debugPrint('VERIFY ACCESS API ERROR: $failure');

          return AccessGrant(
            state: AccessState.invalid,
            message: failure.toString(),
          );
        },
      );

      accessGrant.value = grant.verified ? grant : null;

      if (!grant.verified) {
        final message = grant.message?.trim();

        SavFeedback.toast(
          context,
          message != null && message.isNotEmpty
              ? message
              : _stateError(l, grant.state),
          tone: FeedbackTone.error,
        );
      }

      return grant;
    } finally {
      isLoading.value = false;
    }
  }


  Future<AccessGrant?> verifyQr(
      BuildContext context,
      String token,
      ) async {
    final l = AppLocalizations.of(context);
    final value = token.trim();

    if (value.isEmpty) {
      SavFeedback.toast(
        context,
        l.accessErrEmpty,
        tone: FeedbackTone.warning,
      );
      return null;
    }

    if (isLoading.value) return accessGrant.value;

    isLoading.value = true;

    try {
      final result = await api.verifyQr(
        token: value,
        purpose: 'access',
      );

      final grant = result.when(
        ok: (data) => AccessGrant.fromJson({
          ...data,
          'source': 'qr',
        }),

        err: (failure) {
          debugPrint('VERIFY QR API ERROR: $failure');

          return AccessGrant(
            state: AccessState.invalid,
            message: failure.toString(),
          );
        },
      );

      accessGrant.value = grant.verified ? grant : null;

      if (!grant.verified) {
        final message = grant.message?.trim();

        SavFeedback.toast(
          context,
          message != null && message.isNotEmpty
              ? message
              : _stateError(l, grant.state),
          tone: FeedbackTone.error,
        );
      }

      return grant;
    } finally {
      isLoading.value = false;
    }
  }

  void continueSignup() {
    if (verified) Get.toNamed(Routes.signUp);
  }

  void openQrScreen() => Get.toNamed(Routes.qrAccess);

  void reset() {
    isLoading.value = false;
    accessGrant.value = null;
    accessCodeController.clear();
    qrCodeController.clear();
  }
}
