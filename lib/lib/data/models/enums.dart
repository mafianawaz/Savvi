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

  static RequestMethod fromApi(String v) =>
      values.firstWhere((e) => e.api == v, orElse: () => RequestMethod.pickup);
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
