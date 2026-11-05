import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/network/savvi_api.dart';
import '../../data/models/enums.dart';
import '../../data/models/profile_prefs.dart';
import '../auth/auth_controller.dart';
import '../home/requests_controller.dart';

const int kWizardSteps = 4;

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

  /// Categories returned by the backend. The API owns the available taxonomy.
  final RxList<FoodCategory> availableCategories = <FoodCategory>[].obs;
  final RxBool isLoadingCategories = false.obs;
  final Rxn<String> categoriesError = Rxn<String>();

  /// Backend delivery availability.
  final Rx<DeliveryAvailability> deliveryAvailability =
      DeliveryAvailability.available.obs;

  /// True while [submit] is in flight — drives the Submit button's busy
  /// state.
  final RxBool isSubmitting = false.obs;

  /// Backend-assigned id once a submit succeeds. Non-null is the wizard's
  /// signal to show the confirmation screen instead of the step content.
  final Rxn<String> submittedId = Rxn<String>();

  /// l10n key for the last submit failure, so the wizard can toast it.
  final Rxn<String> submitErrorKey = Rxn<String>();

  /// The member's nonprofit partner, for the confirmation screen's copy.
  String get nonprofit =>
      (authController.profile?['nonprofit'] as String?) ?? '';

  /// Backs the "Notes for the nonprofit" field on the household step. Lives
  /// here (not in the screen, which is a stateless GetView) so it survives
  /// the brief detour to edit the profile mid-wizard, same as the rest of
  /// the draft.
  final TextEditingController notesController = TextEditingController();

  /// Household size, phone, and a formatted mailing address — all read
  /// straight from the signed-in profile (never re-collected in the
  /// wizard). Editing any of these happens in Profile/Settings, not here.
  String get household => (authController.profile?['household'] as String?) ?? '';

  String get phone => (authController.profile?['phone'] as String?) ?? '';

  String get address {
    final profile = authController.profile;
    if (profile == null) return '';

    final parts = [
      profile['street'] as String?,
      profile['city'] as String?,
      profile['state'] as String?,
      profile['zip'] as String?,
    ].where((s) => s != null && s.isNotEmpty).join(', ');

    return parts;
  }

  @override
  void onInit() {
    super.onInit();
    _seedProfile();
    loadCategories();
    notesController.text = draft.value.notes;
    notesController.addListener(() {
      if (notesController.text != draft.value.notes) {
        setNotes(notesController.text);
      }
    });
  }

  @override
  void onClose() {
    notesController.dispose();
    super.onClose();
  }

  Future<void> loadCategories() async {
    isLoadingCategories.value = true;
    categoriesError.value = null;

    final result = await api.listRequestCategories();
    result.when(
      ok: (values) {
        final mapped = <FoodCategory>[];
        for (final value in values) {
          final category = FoodCategory.tryFromRequestApi(value);
          if (category != null && !mapped.contains(category)) {
            mapped.add(category);
          }
        }
        availableCategories.assignAll(mapped);
      },
      err: (failure) {
        categoriesError.value = failure.messageKey;
      },
    );

    isLoadingCategories.value = false;
  }

  DietaryPref? _dietFromProfileValue(String value) {
    for (final item in DietaryPref.values) {
      if (item.api == value || item.profileApi == value) return item;
    }
    return null;
  }

  Allergen? _allergenFromProfileValue(String value) {
    for (final item in Allergen.values) {
      if (item.api == value || item.profileApi == value) return item;
    }
    return null;
  }

  Set<DietaryPref> get profileDiet {
    final profile = authController.profile;
    return {
      for (final item in (profile?['diet'] as List? ?? const []))
        if (_dietFromProfileValue(item.toString()) case final value?) value,
    };
  }

  Set<Allergen> get profileAllergens {
    final profile = authController.profile;
    return {
      for (final item in (profile?['allergens'] as List? ?? const []))
        if (_allergenFromProfileValue(item.toString()) case final value?) value,
    };
  }

  void _seedProfile() {
    final profile = authController.profile;

    if (profile == null) return;

    for (final item in (profile['diet'] as List? ?? const [])) {
      final value = _dietFromProfileValue(item.toString());
      if (value != null) {
        draft.value.diet.add(value);
      }
    }

    for (final item in (profile['allergens'] as List? ?? const [])) {
      final value = _allergenFromProfileValue(item.toString());
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

  bool validateCurrentStep() {
    final current = draft.value.step;
    if (current == 1 && draft.value.categories.isEmpty) {
      return false;
    }
    if (current == 2 && draft.value.method == null) {
      return false;
    }
    return true;
  }

  void next() {
    if (!validateCurrentStep()) return;
    _update((d) {
      d.step = (d.step + 1).clamp(1, kWizardSteps);
    });
  }

  /// Jump to a specific wizard step from the Review screen.
  void goToStep(int step) {
    final target = step.clamp(1, kWizardSteps);
    _update((d) => d.step = target);
  }

  /// Re-read profile-owned dietary/allergen preferences after returning from
  /// Profile. The request always submits the latest saved profile values.
  void syncProfilePreferences() {
    final profile = authController.profile;
    if (profile == null) return;

    final diet = <DietaryPref>{};
    for (final item in (profile['diet'] as List? ?? const [])) {
      final value = _dietFromProfileValue(item.toString());
      if (value != null) diet.add(value);
    }

    final allergens = <Allergen>{};
    for (final item in (profile['allergens'] as List? ?? const [])) {
      final value = _allergenFromProfileValue(item.toString());
      if (value != null) allergens.add(value);
    }

    _update((d) {
      d.diet
        ..clear()
        ..addAll(diet);
      d.allergens
        ..clear()
        ..addAll(allergens);
    });
  }

  void back() {
    _update((d) {
      d.step = (d.step - 1).clamp(1, kWizardSteps);
    });
  }

  Future<SubmitResult> submit() async {
    isSubmitting.value = true;
    submitErrorKey.value = null;

    final householdSize = int.tryParse(authController.profile?['household']?.toString() ?? '');
    final body = <String, dynamic>{
      'categories': [
        for (final item in draft.value.categories) item.requestApi,
      ],
      'method': draft.value.method?.requestApi,
      'householdSize': householdSize ?? 0,
      'notes': draft.value.notes.trim(),
      'dietary': [
        for (final item in profileDiet) item.profileApi,
      ],
      'allergens': [
        for (final item in profileAllergens) item.profileApi,
      ],
    };

    final result = await api.createRequest(body);

    final outcome = result.when(
      ok: (data) => SubmitResult(
        requestId: data['id'] as String?,
      ),
      err: (failure) => SubmitResult(
        errorKey: failure.messageKey,
      ),
    );

    if (outcome.ok) {
      submittedId.value = outcome.requestId;
      // Home's Active Request card and Activity's list both read the
      // shared RequestsController — refresh it now so the just-submitted
      // request is there the moment the member returns to either screen.
      if (Get.isRegistered<RequestsController>()) {
        await Get.find<RequestsController>().refresh();
      }
    } else {
      submitErrorKey.value = outcome.errorKey;
    }

    isSubmitting.value = false;
    return outcome;
  }

  /// Fresh request.
  void resetDraft() {
    draft.value = RequestDraft();
    submittedId.value = null;
    submitErrorKey.value = null;
    isSubmitting.value = false;
    notesController.text = '';
    _seedProfile();
  }
}