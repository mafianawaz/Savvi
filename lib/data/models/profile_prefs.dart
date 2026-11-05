/// Dietary preferences and allergens carried on the member profile and sent
/// with a food request for nonprofit packing only. Backend string ids are
/// authoritative; these mirror them.
enum DietaryPref {
  senior('senior', 'Senior-Friendly Foods'),
  lowSodium('low_sodium', 'Low sodium'),
  diabetic('diabetic', 'Diabetic-friendly'),
  vegetarian('vegetarian', 'Vegetarian'),
  vegan('vegan', 'Vegan'),
  halal('halal', 'Halal-friendly'),
  noPork('no_pork', 'No pork'),
  glutenFree('gluten_free', 'Gluten-free');

  const DietaryPref(this.api, this.profileApi);
  final String api;
  /// Value accepted by the profile PATCH endpoint. Keep this separate from
  /// [api] because request APIs may use compact/internal identifiers.
  final String profileApi;

  static DietaryPref? tryFromApi(String v) {
    for (final d in values) {
      if (d.api == v) return d;
    }
    return null;
  }
}

enum Allergen {
  peanuts('peanuts', 'Peanuts'),
  treeNuts('tree_nuts', 'Tree nuts'),
  milk('milk', 'Milk/Dairy'),
  eggs('eggs', 'Eggs'),
  soy('soy', 'Soy'),
  wheat('wheat', 'Wheat/Gluten'),
  fish('fish', 'Fish'),
  shellfish('shellfish', 'Shellfish'),
  sesame('sesame', 'Sesame');

  const Allergen(this.api, this.profileApi);
  final String api;
  /// Value accepted by the profile PATCH endpoint.
  final String profileApi;

  static Allergen? tryFromApi(String v) {
    for (final a in values) {
      if (a.api == v) return a;
    }
    return null;
  }
}
