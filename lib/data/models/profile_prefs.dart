/// Dietary preferences and allergens carried on the member profile and sent
/// with a food request for nonprofit packing only. Backend string ids are
/// authoritative; these mirror them.
enum DietaryPref {
  senior('senior'),
  lowSodium('low_sodium'),
  diabetic('diabetic'),
  vegetarian('vegetarian'),
  vegan('vegan'),
  halal('halal'),
  noPork('no_pork'),
  glutenFree('gluten_free');

  const DietaryPref(this.api);
  final String api;

  static DietaryPref? tryFromApi(String v) {
    for (final d in values) {
      if (d.api == v) return d;
    }
    return null;
  }
}

enum Allergen {
  peanuts('peanuts'),
  treeNuts('tree_nuts'),
  milk('milk'),
  eggs('eggs'),
  soy('soy'),
  wheat('wheat'),
  fish('fish'),
  shellfish('shellfish'),
  sesame('sesame');

  const Allergen(this.api);
  final String api;

  static Allergen? tryFromApi(String v) {
    for (final a in values) {
      if (a.api == v) return a;
    }
    return null;
  }
}
