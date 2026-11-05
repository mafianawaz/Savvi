/// Locked domain enums for Savvi. Backend string values are authoritative;
/// these mirror them so the client can map API payloads to typed values.
///
/// NONE of these are generated client-side as official records — they are the
/// vocabulary the client uses to interpret backend-returned data.

/// Fulfilment method for a food support request.
enum RequestMethod {
  pickup('pickup'),
  delivery('delivery');

  const RequestMethod(this.api);
  final String api;

  String get requestApi => switch (this) {
        RequestMethod.pickup => 'Pickup',
        RequestMethod.delivery => 'Delivery',
      };

  static RequestMethod fromApi(String v) {
    final normalized = v.trim().toLowerCase();
    return values.firstWhere(
      (e) => e.api.toLowerCase() == normalized ||
          e.requestApi.toLowerCase() == normalized,
      orElse: () => RequestMethod.pickup,
    );
  }
}

/// Approved Savvi member-facing food categories (locked taxonomy).
///
/// "Snacks & Beverages" is the approved combined MVP category — never split.
/// Infant Formula is SEPARATE from Baby Food and is a controlled item.
enum FoodCategory {
  produce('produce', controlled: false),
  dairy('dairy', controlled: false),
  meatProtein('meat_protein', controlled: false),
  preparedMeals('prepared_meals', controlled: false),
  bakeryBread('bakery_bread', controlled: false),
  pantry('pantry', controlled: false),
  frozen('frozen', controlled: false),
  snacksBeverages('snacks_beverages', controlled: false),
  babyFood('baby_food', controlled: false),
  infantFormula('infant_formula', controlled: true);

  const FoodCategory(this.api, {required this.controlled});
  final String api;
  final bool controlled;

  String get requestApi => switch (this) {
        FoodCategory.produce => 'Produce',
        FoodCategory.dairy => 'Dairy',
        FoodCategory.meatProtein => 'Meat / Protein',
        FoodCategory.preparedMeals => 'Prepared Meals',
        FoodCategory.bakeryBread => 'Bakery / Bread',
        FoodCategory.pantry => 'Pantry',
        FoodCategory.frozen => 'Frozen',
        FoodCategory.snacksBeverages => 'Snacks & Beverages',
        FoodCategory.babyFood => 'Baby Food',
        FoodCategory.infantFormula => 'Infant Formula',
      };

  static FoodCategory? tryFromRequestApi(String v) {
    final normalized = v.trim().toLowerCase();
    for (final c in values) {
      if (c.requestApi.toLowerCase() == normalized) return c;
    }
    return null;
  }

  static FoodCategory? tryFromApi(String v) {
    for (final c in values) {
      if (c.api == v) return c;
    }
    return null;
  }
}

/// Approved MVP notification channels. SMS is intentionally ABSENT and must
/// not be added without separate founder approval.
enum NotificationChannel {
  inApp('in_app'),
  push('push'),
  email('email');

  const NotificationChannel(this.api);
  final String api;
}

/// Weight unit for display. Backend stores canonical values; the client shows
/// lbs first then kg for the U.S. MVP (platform-wide weight decision).
enum WeightUnit { lb, kg }
