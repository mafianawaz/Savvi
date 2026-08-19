import '../../l10n/app_localizations.dart';
import '../models/enums.dart';
import '../models/profile_prefs.dart';
import '../models/request_status.dart';

/// Maps domain enums to their localized member-facing labels via a type-safe
/// switch (no dynamic string key lookup). Kept in one place so every screen
/// renders the same wording.
class Labels {
  const Labels._();

  static String status(AppLocalizations l, RequestStatus s) => switch (s) {
        RequestStatus.submitted => l.stSubmitted,
        RequestStatus.needsUpdate => l.stNeedsUpdate,
        RequestStatus.approved => l.stApproved,
        RequestStatus.scheduled => l.stScheduled,
        RequestStatus.preparing => l.stPreparing,
        RequestStatus.readyPickup => l.stReadyPickup,
        RequestStatus.pickupConfirmed => l.stPickupConfirmed,
        RequestStatus.outForDelivery => l.stOutForDelivery,
        RequestStatus.nearby => l.stNearby,
        RequestStatus.delivered => l.stDelivered,
        RequestStatus.delayed => l.stDelayed,
        RequestStatus.unavailable => l.stUnavailable,
        RequestStatus.completed => l.stCompleted,
        RequestStatus.missed => l.stMissed,
        RequestStatus.declined => l.stDeclined,
        RequestStatus.cancelled => l.stCancelled,
      };

  static String category(AppLocalizations l, FoodCategory c) => switch (c) {
        FoodCategory.produce => l.catProduce,
        FoodCategory.dairy => l.catDairy,
        FoodCategory.meatProtein => l.catMeatProtein,
        FoodCategory.preparedMeals => l.catPreparedMeals,
        FoodCategory.bakeryBread => l.catBakeryBread,
        FoodCategory.pantry => l.catPantry,
        FoodCategory.frozen => l.catFrozen,
        FoodCategory.snacksBeverages => l.catSnacksBeverages,
        FoodCategory.babyFood => l.catBabyFood,
        FoodCategory.infantFormula => l.catInfantFormula,
      };

  static String method(AppLocalizations l, RequestMethod m) => switch (m) {
        RequestMethod.pickup => l.methodPickup,
        RequestMethod.delivery => l.methodDelivery,
      };

  static String diet(AppLocalizations l, DietaryPref d) => switch (d) {
        DietaryPref.senior => l.dSenior,
        DietaryPref.lowSodium => l.dLowSodium,
        DietaryPref.diabetic => l.dDiabetic,
        DietaryPref.vegetarian => l.dVegetarian,
        DietaryPref.vegan => l.dVegan,
        DietaryPref.halal => l.dHalal,
        DietaryPref.noPork => l.dNoPork,
        DietaryPref.glutenFree => l.dGlutenFree,
      };

  static String allergen(AppLocalizations l, Allergen a) => switch (a) {
        Allergen.peanuts => l.gPeanuts,
        Allergen.treeNuts => l.gTreeNuts,
        Allergen.milk => l.gMilk,
        Allergen.eggs => l.gEggs,
        Allergen.soy => l.gSoy,
        Allergen.wheat => l.gWheat,
        Allergen.fish => l.gFish,
        Allergen.shellfish => l.gShellfish,
        Allergen.sesame => l.gSesame,
      };
}
