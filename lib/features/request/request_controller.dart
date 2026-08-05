import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../core/network/savvi_api.dart';
import '../../core/state/providers.dart';
import '../../data/models/enums.dart';
import '../../data/models/member_request.dart';
import '../../data/models/profile_prefs.dart';
import '../auth/auth_controller.dart';

// const int kWizardSteps = 5;
//
// /// Delivery availability for a request. In production the **backend** determines
// /// this from member ZIP, nonprofit service area, nonprofit status, delivery
// /// capacity, Delivery Credit availability, pickup/delivery rules, and request
// /// cutoff. The frontend only renders what the backend returns — it must not
// /// compute availability itself. Stubbed to [available] until the endpoint
// /// exists; the state pattern is here so the UI is ready to honor it.
// enum DeliveryAvailability { available, unavailable, checking, error }
//
// final deliveryAvailabilityProvider =
//     Provider.autoDispose<DeliveryAvailability>((ref) {
//   // TODO(backend): replace with the backend-returned availability.
//   return DeliveryAvailability.available;
// });
//
// /// Mutable draft for the request wizard. The backend assigns the request id and
// /// status on submit — the draft only carries member selections.
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
//   RequestDraft copy() => RequestDraft(
//         step: step,
//         categories: {...categories},
//         method: method,
//         notes: notes,
//         diet: {...diet},
//         allergens: {...allergens},
//         ackFormula: ackFormula,
//       );
// }
//
// /// Result of a submit attempt: the backend-assigned request id, or an error key.
// class SubmitResult {
//   const SubmitResult({this.requestId, this.errorKey});
//   final String? requestId;
//   final String? errorKey;
//   bool get ok => requestId != null;
// }
//
// class RequestController extends StateNotifier<RequestDraft> {
//   RequestController(this._ref) : super(RequestDraft()) {
//     // Seed dietary/allergen selections from the member profile.
//     final auth = _ref.read(authControllerProvider);
//     if (auth is AuthSignedIn) {
//       final p = auth.profile;
//       for (final d in (p['diet'] as List? ?? const [])) {
//         final v = DietaryPref.tryFromApi(d as String);
//         if (v != null) state.diet.add(v);
//       }
//       for (final a in (p['allergens'] as List? ?? const [])) {
//         final v = Allergen.tryFromApi(a as String);
//         if (v != null) state.allergens.add(v);
//       }
//     }
//   }
//   final Ref _ref;
//
//   void _emit(void Function(RequestDraft d) mutate) {
//     final next = state.copy();
//     mutate(next);
//     state = next;
//   }
//
//   void toggleCategory(FoodCategory c) =>
//       _emit((d) => d.categories.contains(c)
//           ? d.categories.remove(c)
//           : d.categories.add(c));
//
//   void ackInfantFormula() => _emit((d) {
//         d.ackFormula = true;
//         d.categories.add(FoodCategory.infantFormula);
//       });
//
//   void setMethod(RequestMethod m) => _emit((d) => d.method = m);
//   void setNotes(String v) => _emit((d) => d.notes = v);
//   void toggleDiet(DietaryPref v) => _emit((d) =>
//       d.diet.contains(v) ? d.diet.remove(v) : d.diet.add(v));
//   void toggleAllergen(Allergen v) => _emit((d) =>
//       d.allergens.contains(v) ? d.allergens.remove(v) : d.allergens.add(v));
//
//   void next() => _emit((d) => d.step = (d.step + 1).clamp(1, kWizardSteps));
//   void back() => _emit((d) => d.step = (d.step - 1).clamp(1, kWizardSteps));
//
//   Future<SubmitResult> submit() async {
//     final api = _ref.read(savviApiProvider);
//     final body = <String, dynamic>{
//       'cats': [for (final c in state.categories) c.api],
//       'method': state.method?.api,
//       'notes': state.notes,
//       'diet': [for (final d in state.diet) d.api],
//       'allergens': [for (final a in state.allergens) a.api],
//     };
//     final res = await api.createRequest(body);
//     return res.when(
//       ok: (data) => SubmitResult(requestId: data['id'] as String?),
//       err: (f) => SubmitResult(errorKey: f.messageKey),
//     );
//   }
// }
//
// /// Kept alive (not autoDispose) so a detour to edit the profile mid-request
// /// preserves the draft. Fresh starts invalidate it (see the shell's request
// /// action); returning from a profile edit resumes the preserved draft.
// final requestControllerProvider =
//     StateNotifierProvider<RequestController, RequestDraft>(
//   (ref) => RequestController(ref),
// );
/// Delivery availability returned by the backend.
///
/// The frontend never computes this itself.
enum DeliveryAvailability {
  available,
  unavailable,
  checking,
  error,
}

/// Mutable request draft.
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

/// Submit result.
class SubmitResult {
  const SubmitResult({
    this.requestId,
    this.errorKey,
  });

  final String? requestId;
  final String? errorKey;

  bool get ok => requestId != null;
}

/// GetX controller replacing RequestController.
// class RequestController extends GetxController {
//   RequestController({
//     required this.api,
//     required this.authController,
//   });
//
//   final SavviApi api;
//   final AuthController authController;
//
//   /// Current draft.
//   final Rx<RequestDraft> draft = RequestDraft().obs;
//
//   /// Backend delivery availability.
//   final Rx<DeliveryAvailability> deliveryAvailability =
//       DeliveryAvailability.available.obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     _seedProfile();
//   }
//
//   void _seedProfile() {
//     final profile = authController.profile;
//
//     if (profile == null) return;
//
//     for (final item in (profile['diet'] as List? ?? const [])) {
//       final value = DietaryPref.tryFromApi(item as String);
//
//       if (value != null) {
//         draft.value.diet.add(value);
//       }
//     }
//
//     for (final item in (profile['allergens'] as List? ?? const [])) {
//       final value = Allergen.tryFromApi(item as String);
//
//       if (value != null) {
//         draft.value.allergens.add(value);
//       }
//     }
//
//     draft.refresh();
//   }
//
//   void _update(void Function(RequestDraft value) action) {
//     final copy = draft.value.copy();
//
//     action(copy);
//
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
//   void setNotes(String value) {
//     _update((d) => d.notes = value);
//   }
//
//   void toggleDiet(DietaryPref value) {
//     _update((d) {
//       if (d.diet.contains(value)) {
//         d.diet.remove(value);
//       } else {
//         d.diet.add(value);
//       }
//     });
//   }
//
//   void toggleAllergen(Allergen value) {
//     _update((d) {
//       if (d.allergens.contains(value)) {
//         d.allergens.remove(value);
//       } else {
//         d.allergens.add(value);
//       }
//     });
//   }
//
//   // void next() {
//   //   _update((d) {
//   //     d.step = (d.step + 1).clamp(1, kWizardSteps);
//   //   });
//   // }
//   //
//   // void back() {
//   //   _update((d) {
//   //     d.step = (d.step - 1).clamp(1, kWizardSteps);
//   //   });
//   // }
//
//   Future<SubmitResult> submit() async {
//     final body = <String, dynamic>{
//       'cats': [
//         for (final item in draft.value.categories) item.api,
//       ],
//       'method': draft.value.method?.api,
//       'notes': draft.value.notes,
//       'diet': [
//         for (final item in draft.value.diet) item.api,
//       ],
//       'allergens': [
//         for (final item in draft.value.allergens) item.api,
//       ],
//     };
//
//     final result = await api.createRequest(body);
//
//     return result.when(
//       ok: (data) => SubmitResult(
//         requestId: data['id'] as String?,
//       ),
//       err: (failure) => SubmitResult(
//         errorKey: failure.messageKey,
//       ),
//     );
//   }
//
//   /// Fresh request.
//   void resetDraft() {
//     draft.value = RequestDraft();
//     _seedProfile();
//   }
// }

class RequestsController extends GetxController {
  RequestsController({
    required this.api,
  });

  final SavviApi api;

  final RxBool isLoading = false.obs;

  final RxList<MemberRequest> requests = <MemberRequest>[].obs;

  final Rx<MemberRequest?> activeRequest = Rx<MemberRequest?>(null);

  final Rx<MemberRequest?> selectedRequest = Rx<MemberRequest?>(null);

  @override
  void onInit() {
    super.onInit();
    fetchRequests();
  }

  Future<void> fetchRequests() async {
    isLoading.value = true;

    final result = await api.listRequests();

    result.when(
      ok: (rows) {
        requests.assignAll(
          rows.map(MemberRequest.fromJson),
        );

        _calculateActiveRequest();
      },
      err: (_) {
        requests.clear();
        activeRequest.value = null;
      },
    );

    isLoading.value = false;
  }

  Future<MemberRequest?> getRequest(String id) async {
    isLoading.value = true;

    final result = await api.getRequest(id);

    MemberRequest? request;

    result.when(
      ok: (json) {
        request = MemberRequest.fromJson(json);
        selectedRequest.value = request;
      },
      err: (_) {
        selectedRequest.value = null;
      },
    );

    isLoading.value = false;

    return request;
  }

  void _calculateActiveRequest() {
    final active = requests
        .where((element) => element.isActive)
        .toList();

    if (active.isEmpty) {
      activeRequest.value = null;
      return;
    }

    active.sort((a, b) {
      final af = a.isInFlight ? 0 : 1;
      final bf = b.isInFlight ? 0 : 1;

      if (af != bf) {
        return af - bf;
      }

      return b.createdAt.compareTo(a.createdAt);
    });

    activeRequest.value = active.first;
  }

  Future<void> refresh() async {
    await fetchRequests();
  }

  void clearSelection() {
    selectedRequest.value = null;
  }
}