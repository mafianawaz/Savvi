import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/network/savvi_api.dart';
import '../../core/state/providers.dart';
import '../../data/models/profile_prefs.dart';
import '../../shared/patterns/mutation.dart';
import '../auth/auth_controller.dart';
/// RiverPod
/// Editable profile state. Contact fields live in the screen's text controllers;
/// this holds the diet/allergen selections and household, plus per-action saving
/// flags so each control can show a pending state and block re-taps.
// class EditProfileState {
//   const EditProfileState({
//     required this.diet,
//     required this.allergens,
//     required this.household,
//     this.savingContact = false,
//     this.savingHousehold = false,
//     this.savingChip,
//   });
//
//   final Set<DietaryPref> diet;
//   final Set<Allergen> allergens;
//   final String household;
//   final bool savingContact;
//   final bool savingHousehold;
//
//   /// The diet/allergen api id whose save is in flight (optimistic), or null.
//   final String? savingChip;
//
//   EditProfileState copyWith({
//     Set<DietaryPref>? diet,
//     Set<Allergen>? allergens,
//     String? household,
//     bool? savingContact,
//     bool? savingHousehold,
//     String? savingChip,
//     bool clearChip = false,
//   }) =>
//       EditProfileState(
//         diet: diet ?? this.diet,
//         allergens: allergens ?? this.allergens,
//         household: household ?? this.household,
//         savingContact: savingContact ?? this.savingContact,
//         savingHousehold: savingHousehold ?? this.savingHousehold,
//         savingChip: clearChip ? null : (savingChip ?? this.savingChip),
//       );
// }
//
// class EditProfileController extends StateNotifier<EditProfileState> {
//   EditProfileController(this._ref) : super(_seed(_ref));
//   final Ref _ref;
//
//   static EditProfileState _seed(Ref ref) {
//     final auth = ref.read(authControllerProvider);
//     final p = auth is AuthSignedIn ? auth.profile : const {};
//     return EditProfileState(
//       diet: {
//         for (final d in (p['diet'] as List? ?? const []))
//           if (DietaryPref.tryFromApi(d as String) case final v?) v
//       },
//       allergens: {
//         for (final a in (p['allergens'] as List? ?? const []))
//           if (Allergen.tryFromApi(a as String) case final v?) v
//       },
//       household: (p['household'] as String?) ?? '1',
//     );
//   }
//
//   void _patchAuth(Map<String, dynamic> updates) =>
//       _ref.read(authControllerProvider.notifier).patchProfile(updates);
//
//   /// Save contact fields together. Non-optimistic: pending -> await -> patch the
//   /// session profile on success. Validation happens in the screen first.
//   Future<MutationResult> saveContact(Map<String, dynamic> fields) async {
//     if (state.savingContact) return const MutationResult.ok();
//     state = state.copyWith(savingContact: true);
//     final res = await _ref.read(savviApiProvider).updateProfile(fields);
//     return res.when(
//       ok: (_) {
//         _patchAuth(fields);
//         state = state.copyWith(savingContact: false);
//         return const MutationResult.ok();
//       },
//       err: (f) {
//         state = state.copyWith(savingContact: false);
//         return MutationResult.err(f.messageKey);
//       },
//     );
//   }
//
//   /// Household - optimistic with rollback.
//   Future<MutationResult> setHousehold(String v) async {
//     if (state.savingHousehold || v == state.household) {
//       return const MutationResult.ok();
//     }
//     final prev = state.household;
//     state = state.copyWith(household: v, savingHousehold: true);
//     final res =
//         await _ref.read(savviApiProvider).updateProfile({'household': v});
//     return res.when(
//       ok: (_) {
//         _patchAuth({'household': v});
//         state = state.copyWith(savingHousehold: false);
//         return const MutationResult.ok();
//       },
//       err: (f) {
//         state = state.copyWith(household: prev, savingHousehold: false);
//         return MutationResult.err(f.messageKey);
//       },
//     );
//   }
//
//   Future<MutationResult> toggleDiet(DietaryPref d) async {
//     if (state.savingChip != null) return const MutationResult.ok();
//     final had = state.diet.contains(d);
//     final next = {...state.diet};
//     had ? next.remove(d) : next.add(d);
//     state = state.copyWith(diet: next, savingChip: d.api); // optimistic
//     final res = await _ref
//         .read(savviApiProvider)
//         .updateProfile({'diet': [for (final x in next) x.api]});
//     return res.when(
//       ok: (_) {
//         _patchAuth({'diet': [for (final x in next) x.api]});
//         state = state.copyWith(clearChip: true);
//         return const MutationResult.ok();
//       },
//       err: (f) {
//         final revert = {...state.diet};
//         had ? revert.add(d) : revert.remove(d); // rollback
//         state = state.copyWith(diet: revert, clearChip: true);
//         return MutationResult.err(f.messageKey);
//       },
//     );
//   }
//
//   Future<MutationResult> toggleAllergen(Allergen a) async {
//     if (state.savingChip != null) return const MutationResult.ok();
//     final had = state.allergens.contains(a);
//     final next = {...state.allergens};
//     had ? next.remove(a) : next.add(a);
//     state = state.copyWith(allergens: next, savingChip: a.api); // optimistic
//     final res = await _ref
//         .read(savviApiProvider)
//         .updateProfile({'allergens': [for (final x in next) x.api]});
//     return res.when(
//       ok: (_) {
//         _patchAuth({'allergens': [for (final x in next) x.api]});
//         state = state.copyWith(clearChip: true);
//         return const MutationResult.ok();
//       },
//       err: (f) {
//         final revert = {...state.allergens};
//         had ? revert.add(a) : revert.remove(a); // rollback
//         state = state.copyWith(allergens: revert, clearChip: true);
//         return MutationResult.err(f.messageKey);
//       },
//     );
//   }
// }
//
// final editProfileControllerProvider =
//     StateNotifierProvider.autoDispose<EditProfileController, EditProfileState>(
//   (ref) => EditProfileController(ref),
// );


/// GetX

import 'package:get/get.dart';

/// Editable profile state.
///
/// Contact fields live in the screen's text controllers; this holds the
/// diet/allergen selections and household, plus per-action saving flags so
/// each control can show a pending state and block re-taps.
class EditProfileState {
  const EditProfileState({
    required this.diet,
    required this.allergens,
    required this.household,
    this.savingContact = false,
    this.savingHousehold = false,
    this.savingChip,
  });

  final Set<DietaryPref> diet;
  final Set<Allergen> allergens;
  final String household;

  final bool savingContact;
  final bool savingHousehold;

  /// The diet/allergen api id whose save is currently in-flight.
  final String? savingChip;

  EditProfileState copyWith({
    Set<DietaryPref>? diet,
    Set<Allergen>? allergens,
    String? household,
    bool? savingContact,
    bool? savingHousehold,
    String? savingChip,
    bool clearChip = false,
  }) {
    return EditProfileState(
      diet: diet ?? this.diet,
      allergens: allergens ?? this.allergens,
      household: household ?? this.household,
      savingContact: savingContact ?? this.savingContact,
      savingHousehold: savingHousehold ?? this.savingHousehold,
      savingChip: clearChip ? null : (savingChip ?? this.savingChip),
    );
  }
}

class EditProfileController extends GetxController {
  EditProfileController({
    required this.api,
    required this.authController,
  });

  final SavviApi api;
  final AuthController authController;

  late final Rx<EditProfileState> state;

  @override
  void onInit() {
    super.onInit();
    state = _seed().obs;
  }

  EditProfileState _seed() {
    final profile = authController.profile ?? {};

    return EditProfileState(
      diet: {
        for (final item in (profile['diet'] as List? ?? const []))
          if (DietaryPref.tryFromApi(item as String) case final value?) value,
      },
      allergens: {
        for (final item in (profile['allergens'] as List? ?? const []))
          if (Allergen.tryFromApi(item as String) case final value?) value,
      },
      household: (profile['household'] as String?) ?? '1',
    );
  }

  void _patchAuth(Map<String, dynamic> updates) {
    authController.patchProfile(updates);
  }

  /// Save contact fields.
  Future<MutationResult> saveContact(
      Map<String, dynamic> fields,
      ) async {
    if (state.value.savingContact) {
      return const MutationResult.ok();
    }

    state.value = state.value.copyWith(
      savingContact: true,
    );

    final result = await api.updateProfile(fields);

    return result.when(
      ok: (_) {
        _patchAuth(fields);

        state.value = state.value.copyWith(
          savingContact: false,
        );

        return const MutationResult.ok();
      },
      err: (failure) {
        state.value = state.value.copyWith(
          savingContact: false,
        );

        return MutationResult.err(
          failure.messageKey,
        );
      },
    );
  }

  /// Household (optimistic)
  Future<MutationResult> setHousehold(
      String value,
      ) async {
    if (state.value.savingHousehold ||
        value == state.value.household) {
      return const MutationResult.ok();
    }

    final previous = state.value.household;

    state.value = state.value.copyWith(
      household: value,
      savingHousehold: true,
    );

    final result = await api.updateProfile({
      'household': value,
    });

    return result.when(
      ok: (_) {
        _patchAuth({
          'household': value,
        });

        state.value = state.value.copyWith(
          savingHousehold: false,
        );

        return const MutationResult.ok();
      },
      err: (failure) {
        state.value = state.value.copyWith(
          household: previous,
          savingHousehold: false,
        );

        return MutationResult.err(
          failure.messageKey,
        );
      },
    );
  }

  /// Diet (optimistic)
  Future<MutationResult> toggleDiet(
      DietaryPref diet,
      ) async {
    if (state.value.savingChip != null) {
      return const MutationResult.ok();
    }

    final had = state.value.diet.contains(diet);

    final next = {...state.value.diet};

    had ? next.remove(diet) : next.add(diet);

    state.value = state.value.copyWith(
      diet: next,
      savingChip: diet.api,
    );

    final result = await api.updateProfile({
      'diet': [
        for (final item in next) item.api,
      ],
    });

    return result.when(
      ok: (_) {
        _patchAuth({
          'diet': [
            for (final item in next) item.api,
          ],
        });

        state.value = state.value.copyWith(
          clearChip: true,
        );

        return const MutationResult.ok();
      },
      err: (failure) {
        final rollback = {...state.value.diet};

        had
            ? rollback.add(diet)
            : rollback.remove(diet);

        state.value = state.value.copyWith(
          diet: rollback,
          clearChip: true,
        );

        return MutationResult.err(
          failure.messageKey,
        );
      },
    );
  }

  /// Allergens (optimistic)
  Future<MutationResult> toggleAllergen(
      Allergen allergen,
      ) async {
    if (state.value.savingChip != null) {
      return const MutationResult.ok();
    }

    final had = state.value.allergens.contains(allergen);

    final next = {...state.value.allergens};

    had
        ? next.remove(allergen)
        : next.add(allergen);

    state.value = state.value.copyWith(
      allergens: next,
      savingChip: allergen.api,
    );

    final result = await api.updateProfile({
      'allergens': [
        for (final item in next) item.api,
      ],
    });

    return result.when(
      ok: (_) {
        _patchAuth({
          'allergens': [
            for (final item in next) item.api,
          ],
        });

        state.value = state.value.copyWith(
          clearChip: true,
        );

        return const MutationResult.ok();
      },
      err: (failure) {
        final rollback = {...state.value.allergens};

        had
            ? rollback.add(allergen)
            : rollback.remove(allergen);

        state.value = state.value.copyWith(
          allergens: rollback,
          clearChip: true,
        );

        return MutationResult.err(
          failure.messageKey,
        );
      },
    );
  }

  /// Rebuild state from the current signed-in profile.
  void refreshFromProfile() {
    state.value = _seed();
  }
}