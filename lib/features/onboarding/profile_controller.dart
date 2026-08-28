import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/network/savvi_api.dart';
import '../../data/models/onboarding.dart';

class ProfileController extends GetxController {
  ProfileController({required this.api});

  final SavviApi api;
  final RxBool isSubmitting = false.obs;
  final Rxn<ApprovalState> submittedApproval = Rxn<ApprovalState>();
  final RxnString error = RxnString();

  Future<ApprovalState?> submit(Map<String, dynamic> body) async {
    if (isSubmitting.value) return null;

    isSubmitting.value = true;
    error.value = null;
    debugPrint('[SIGNUP] ProfileController.submit started');
    try {
      final result = await api.createProfile(body);
      return result.when(
        ok: (data) {
          final approval = ApprovalState.fromApi(
            data['approval']?.toString() ??
                (data['status']?.toString() == 'approved' ? 'approved' : 'pending'),
          );
          submittedApproval.value = approval;
          return approval;
        },
        err: (failure) {
          debugPrint(
            '[SIGNUP] failed status=${failure.status} '
            'kind=${failure.kind} detail=${failure.detail}',
          );
          error.value = failure.messageKey;
          return null;
        },
      );
    } finally {
      isSubmitting.value = false;
    }
  }

  void reset() {
    submittedApproval.value = null;
    error.value = null;
    isSubmitting.value = false;
  }
}
