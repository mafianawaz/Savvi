import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/network/savvi_api.dart';
import '../../data/models/enums.dart';
import '../../data/models/profile_prefs.dart';
import '../auth/auth_controller.dart';
import '../home/requests_controller.dart';

/// Four-step wizard: categories → method → household & contact → review.
// const int kWizardSteps = 4;
//
// /// Delivery availability returned by the backend.
// ///
// /// The frontend never computes this itself.
// enum DeliveryAvailability {
//   available,
//   unavailable,
//   checking,
//   error,
// }
//
// /// Mutable request draft.
// class RequestDraft {
//   RequestDraft({
//     this.step = 1,
//     Set<FoodCategory>? categories,
//     this.method,
//     this.notes = '',
//     Set<DietaryPref>? diet,
//     Set<Allergen>? allergens,
//     this.ackFormula = false,
//   })  : categories = categories ?? <FoodCategory>{},
//         diet = diet ?? <DietaryPref>{},
//         allergens = allergens ?? <Allergen>{};
//
//   int step;
//   final Set<FoodCategory> categories;
//   RequestMethod? method;
//   String notes;
//   final Set<DietaryPref> diet;
//   final Set<Allergen> allergens;
//   bool ackFormula;
//
//   RequestDraft copy() {
//     return RequestDraft(
//       step: step,
//       categories: {...categories},
//       method: method,
//       notes: notes,
//       diet: {...diet},
//       allergens: {...allergens},
//       ackFormula: ackFormula,
//     );
//   }
// }
//
// /// Submit result.
// class SubmitResult {
//   const SubmitResult({
//     this.requestId,
//     this.errorKey,
//   });
//
//   final String? requestId;
//   final String? errorKey;
//
//   bool get ok => requestId != null;
// }
//
// /// GetX controller for the multi-step request wizard.
// class RequestWizardController extends GetxController {
//   RequestWizardController({
//     required this.api,
//     required this.authController,
//   });
//
//   final SavviApi api;
//   final AuthController authController;
//
//   final Rx<RequestDraft> draft = RequestDraft().obs;
//   final Rx<DeliveryAvailability> deliveryAvailability =
//       DeliveryAvailability.available.obs;
//   final RxBool isSubmitting = false.obs;
//   final RxnString submittedId = RxnString();
//
//   final TextEditingController notesController = TextEditingController();
//
//   Map<String, dynamic> get profile => authController.profile ?? const {};
//
//   @override
//   void onInit() {
//     super.onInit();
//     notesController.text = draft.value.notes;
//     _seedProfile();
//     _checkDeliveryAvailability();
//   }
//
//   @override
//   void onClose() {
//     notesController.dispose();
//     super.onClose();
//   }
//
//   void _seedProfile() {
//     final p = profile;
//     if (p.isEmpty) return;
//
//     for (final item in (p['diet'] as List? ?? const [])) {
//       final value = DietaryPref.tryFromApi(item as String);
//       if (value != null) draft.value.diet.add(value);
//     }
//
//     for (final item in (p['allergens'] as List? ?? const [])) {
//       final value = Allergen.tryFromApi(item as String);
//       if (value != null) draft.value.allergens.add(value);
//     }
//
//     draft.refresh();
//   }
//
//   Future<void> _checkDeliveryAvailability() async {
//     // TODO(backend): replace with the backend-returned availability.
//     deliveryAvailability.value = DeliveryAvailability.available;
//   }
//
//   Future<void> retryDeliveryAvailability() => _checkDeliveryAvailability();
//
//   void _update(void Function(RequestDraft value) action) {
//     final copy = draft.value.copy();
//     action(copy);
//     draft.value = copy;
//   }
//
//   void toggleCategory(FoodCategory category) {
//     _update((d) {
//       if (d.categories.contains(category)) {
//         d.categories.remove(category);
//       } else {
//         d.categories.add(category);
//       }
//     });
//   }
//
//   void ackInfantFormula() {
//     _update((d) {
//       d.ackFormula = true;
//       d.categories.add(FoodCategory.infantFormula);
//     });
//   }
//
//   void setMethod(RequestMethod method) {
//     _update((d) => d.method = method);
//   }
//
//   void captureNotes() {
//     _update((d) => d.notes = notesController.text);
//   }
//
//   void next() {
//     _update((d) => d.step = (d.step + 1).clamp(1, kWizardSteps));
//   }
//
//   void back() {
//     captureNotes();
//     _update((d) => d.step = (d.step - 1).clamp(1, kWizardSteps));
//   }
//
//   void editRequest() {
//     captureNotes();
//     _update((d) => d.step = 1);
//   }
//
//   /// Returns an l10n error key when validation fails.
//   String? validateAndNext() {
//     captureNotes();
//     final d = draft.value;
//
//     if (d.step == 1 && d.categories.isEmpty) return 'errNoCat';
//     if (d.step == 2 && d.method == null) return 'errNoMethod';
//
//     next();
//     return null;
//   }
//
//   bool get deliveryEnabled =>
//       deliveryAvailability.value == DeliveryAvailability.available;
//
//   String get household =>
//       (profile['household'] as String?)?.trim().isNotEmpty == true
//           ? profile['household'] as String
//           : '—';
//
//   String get phone =>
//       (profile['phone'] as String?)?.trim().isNotEmpty == true
//           ? profile['phone'] as String
//           : '—';
//
//   String get address {
//     final parts = [profile['street'], profile['city'], profile['state'], profile['zip']]
//         .whereType<String>()
//         .where((s) => s.isNotEmpty)
//         .join(', ');
//     return parts.isEmpty ? '—' : parts;
//   }
//
//   String get nonprofit => (profile['nonprofit'] as String?) ?? '';
//
//   Future<String?> submit() async {
//     captureNotes();
//     isSubmitting.value = true;
//
//     final body = <String, dynamic>{
//       'cats': [for (final item in draft.value.categories) item.api],
//       'method': draft.value.method?.api,
//       'notes': draft.value.notes,
//       'diet': [for (final item in draft.value.diet) item.api],
//       'allergens': [for (final item in draft.value.allergens) item.api],
//     };
//
//     final result = await api.createRequest(body);
//     isSubmitting.value = false;
//
//     return result.when(
//       ok: (data) {
//         submittedId.value = data['id'] as String?;
//         if (Get.isRegistered<RequestsController>()) {
//           Get.find<RequestsController>().refreshRequests();
//         }
//         return null;
//       },
//       err: (failure) => failure.messageKey,
//     );
//   }
//
//   void resetDraft() {
//     submittedId.value = null;
//     draft.value = RequestDraft();
//     notesController.text = '';
//     _seedProfile();
//   }
// }


import 'package:get/get.dart';

import '../../core/network/savvi_api.dart';
import '../../data/models/enums.dart';
import '../../data/models/profile_prefs.dart';
import '../auth/auth_controller.dart';

const int kWizardSteps = 5;

/// Delivery availability for a request. In production the **backend**
/// determines this from member ZIP, nonprofit service area, nonprofit
/// status, delivery capacity, Delivery Credit availability, pickup/delivery
/// rules, and request cutoff. The frontend only renders what the backend
/// returns — it must not compute availability itself. Stubbed to
/// [available] until the endpoint exists; the state pattern is here so the
/// UI is ready to honor it.
enum DeliveryAvailability {
  available,
  unavailable,
  checking,
  error,
}

/// Mutable draft for the request wizard. The backend assigns the request id
/// and status on submit — the draft only carries member selections.
class RequestDraft {
  RequestDraft({
    this.step = 1,
    Set<FoodCategory>? categories,
    this.method,
    this.notes = '',
    Set<DietaryPref>? diet,
    Set<Allergen>? allergens,
    this.ackFormula = false,
  })  : categories = categories ?? <FoodCategory>{},
        diet = diet ?? <DietaryPref>{},
        allergens = allergens ?? <Allergen>{};

  int step;
  final Set<FoodCategory> categories;
  RequestMethod? method;
  String notes;
  final Set<DietaryPref> diet;
  final Set<Allergen> allergens;
  bool ackFormula;

  RequestDraft copy() {
    return RequestDraft(
      step: step,
      categories: {...categories},
      method: method,
      notes: notes,
      diet: {...diet},
      allergens: {...allergens},
      ackFormula: ackFormula,
    );
  }
}

/// Result of a submit attempt: the backend-assigned request id, or an error
/// key.
class SubmitResult {
  const SubmitResult({
    this.requestId,
    this.errorKey,
  });

  final String? requestId;
  final String? errorKey;

  bool get ok => requestId != null;
}

/// Drives the request wizard draft.
///
/// Not registered permanently: the shell's FAB deletes any existing
/// instance and pushes a fresh one on every "new request" tap, so a
/// half-finished draft never leaks into the next request. A brief detour
/// to edit the profile mid-wizard preserves the draft because the wizard
/// screen keeps its own instance alive via Get.put (see request_wizard
/// feature) rather than the shell recreating it.
class RequestController extends GetxController {
  RequestController({
    required this.api,
    required this.authController,
  });

  final SavviApi api;
  final AuthController authController;

  /// Current draft.
  final Rx<RequestDraft> draft = RequestDraft().obs;

  /// Backend delivery availability.
  final Rx<DeliveryAvailability> deliveryAvailability =
      DeliveryAvailability.available.obs;

  @override
  void onInit() {
    super.onInit();
    _seedProfile();
  }

  void _seedProfile() {
    final profile = authController.profile;

    if (profile == null) return;

    for (final item in (profile['diet'] as List? ?? const [])) {
      final value = DietaryPref.tryFromApi(item as String);

      if (value != null) {
        draft.value.diet.add(value);
      }
    }

    for (final item in (profile['allergens'] as List? ?? const [])) {
      final value = Allergen.tryFromApi(item as String);

      if (value != null) {
        draft.value.allergens.add(value);
      }
    }

    draft.refresh();
  }

  void _update(void Function(RequestDraft value) action) {
    final copy = draft.value.copy();

    action(copy);

    draft.value = copy;
  }

  void toggleCategory(FoodCategory category) {
    _update((d) {
      if (d.categories.contains(category)) {
        d.categories.remove(category);
      } else {
        d.categories.add(category);
      }
    });
  }

  void ackInfantFormula() {
    _update((d) {
      d.ackFormula = true;
      d.categories.add(FoodCategory.infantFormula);
    });
  }

  void setMethod(RequestMethod method) {
    _update((d) => d.method = method);
  }

  void setNotes(String value) {
    _update((d) => d.notes = value);
  }

  void toggleDiet(DietaryPref value) {
    _update((d) {
      if (d.diet.contains(value)) {
        d.diet.remove(value);
      } else {
        d.diet.add(value);
      }
    });
  }

  void toggleAllergen(Allergen value) {
    _update((d) {
      if (d.allergens.contains(value)) {
        d.allergens.remove(value);
      } else {
        d.allergens.add(value);
      }
    });
  }

  void next() {
    _update((d) {
      d.step = (d.step + 1).clamp(1, kWizardSteps);
    });
  }

  void back() {
    _update((d) {
      d.step = (d.step - 1).clamp(1, kWizardSteps);
    });
  }

  Future<SubmitResult> submit() async {
    final body = <String, dynamic>{
      'cats': [
        for (final item in draft.value.categories) item.api,
      ],
      'method': draft.value.method?.api,
      'notes': draft.value.notes,
      'diet': [
        for (final item in draft.value.diet) item.api,
      ],
      'allergens': [
        for (final item in draft.value.allergens) item.api,
      ],
    };

    final result = await api.createRequest(body);

    return result.when(
      ok: (data) => SubmitResult(
        requestId: data['id'] as String?,
      ),
      err: (failure) => SubmitResult(
        errorKey: failure.messageKey,
      ),
    );
  }

  /// Fresh request.
  void resetDraft() {
    draft.value = RequestDraft();
    _seedProfile();
  }
}