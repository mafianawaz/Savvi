import 'package:flutter/material.dart';

import '../../data/models/enums.dart';

/// Savvi design tokens — ported 1:1 from the approved v45 prototype CSS.
///
/// These are the single source of truth for colour, radius, and spacing.
/// Do not hard-code hex values or paddings in widgets; reference [SavColors],
/// [SavRadius], and [SavSpace] instead.
import 'package:flutter/material.dart';

import '../../data/models/enums.dart';

/// Savvi design tokens — ported 1:1 from the approved v45 prototype CSS.
///
/// These are the single source of truth for colour, radius, and spacing.
/// Do not hard-code hex values or paddings in widgets; reference [SavColors],
/// [SavRadius], and [SavSpace] instead.
class SavColors {
  SavColors._();

  // Brand
  static const navy = Color(0xFF01284D);
  static const navyDark = Color(0xFF011E3A);
  static const green = Color(0xFF29E050);
  static const greenDk = Color(0xFF148A3B);
  static const greenDark = Color(0xFF1DB540);
  static const greenLight = Color(0xFFE8F5E9);
  static const blue = Color(0xFF00BDFF);
  static const blueLight = Color(0xFFE3F6FD);
  static const amber = Color(0xFFF59E0B);
  static const amberLight = Color(0xFFFEF9EC);
  static const red = Color(0xFFEF4444);
  static const redLight = Color(0xFFFEF2F2);

  // Surfaces
  static const page = Color(0xFFF7F8FA);
  static const surface = Color(0xFFFFFFFF);
  static const border = Color(0xFFE9ECF0);

  // Text — v45 two-step muted scale (both pass WCAG AA on white and page).
  //   txt3 #4B5563 = 7.56:1 on white   |  txt4 #6B7280 = 4.83:1 on white
  static const txt = Color(0xFF111827);
  static const txt2 = Color(0xFF374151);
  static const txt3 = Color(0xFF4B5563);
  static const txt4 = Color(0xFF6B7280);

  // Semantic text-on-fill (from v45 pill colours)
  static const pillGreenFg = Color(0xFF166534);
  static const pillBlueFg = Color(0xFF0369A1);
  static const pillAmberFg = Color(0xFF92400E);
  static const pillRedFg = Color(0xFF991B1B);
}

class SavRadius {
  SavRadius._();
  static const r4 = 4.0;
  static const r8 = 8.0;
  static const r12 = 12.0;
  static const r14 = 14.0;
  static const r16 = 16.0;
  static const r20 = 20.0;

  static const card = BorderRadius.all(Radius.circular(r16));
  static const cardLg = BorderRadius.all(Radius.circular(r20));
  static const field = BorderRadius.all(Radius.circular(r12));
  static const button = BorderRadius.all(Radius.circular(r14));
  static const pill = BorderRadius.all(Radius.circular(r4));
  static const sheet =
  BorderRadius.vertical(top: Radius.circular(22));
}

class SavSpace {
  SavSpace._();
  static const x2 = 2.0;
  static const x4 = 4.0;
  static const x6 = 6.0;
  static const x8 = 8.0;
  static const x10 = 10.0;
  static const x12 = 12.0;
  static const x14 = 14.0;
  static const x16 = 16.0;
  static const x20 = 20.0;
  static const x24 = 24.0;

  /// Minimum tappable dimension. Enforced on all interactive shared widgets
  /// (v45 accessibility decision: 44px minimum touch targets).
  static const minTouch = 44.0;
}

/// Font families. DM Sans for body/UI, DM Serif Display for titles and KPI
/// numbers only — matches the v45 typography spec. The font assets are added
/// to pubspec in a later stage; the family names are fixed here so text styles
/// never drift.
class SavFonts {
  SavFonts._();
  static const sans = 'DMSans';
  static const serif = 'DMSerifDisplay';
}


class SavImages{
  SavImages._();

  static const String logo = "assets/images/logo.jpg";
  static const String banner = "assets/images/banner.jpg";
  static const String actCard1 = "assets/images/act_card_1.jpg";
  static const String actCard2 = "assets/images/act_card_2.jpg";
  static const String alertScreen = "assets/images/alert_screen.jpg";
  static const String approved = "assets/images/approved.jpg";
  static const String babyFood = "assets/images/baby_food.jpg";
  static const String babyFormula = "assets/images/baby_formula.jpg";
  static const String bakery = "assets/images/bakery.jpg";
  static const String beverages = "assets/images/beverages.jpg";
  static const String coming = "assets/images/coming.jpg";
  static const String delivery = "assets/images/delivery.jpg";
  static const String deliveryPickup = "assets/images/delivery_pickup.jpg";
  static const String foodAccessAlert = "assets/images/food_access_alert.jpg";
  static const String frozen = "assets/images/frozens.jpg";
  static const String navRequest = "assets/images/nav_request.jpg";
  static const String pantry = "assets/images/pantry.jpg";
  static const String pickup = "assets/images/pickup.jpg";
  static const String preparedMeat = "assets/images/prepared_meat.jpg";
  static const String produce = "assets/images/produce.jpg";
  static const String protein = "assets/images/protein_meat.jpg";
  static const String request = "assets/images/request.jpg";
  static const String shelfStable = "assets/images/shelf_stable.jpg";
  static const String dairy = "assets/images/shelf_stable.jpg";

  static String category(FoodCategory category) => switch (category) {
    FoodCategory.produce => produce,
    FoodCategory.dairy => dairy,
    FoodCategory.meatProtein => protein,
    FoodCategory.preparedMeals => preparedMeat,
    FoodCategory.bakeryBread => bakery,
    FoodCategory.pantry => pantry,
    FoodCategory.frozen => frozen,
    FoodCategory.snacksBeverages => beverages,
    FoodCategory.babyFood => babyFood,
    FoodCategory.infantFormula => babyFormula,
  };

  static String method(RequestMethod method) => switch (method) {
    RequestMethod.pickup => pickup,
    RequestMethod.delivery => delivery,
  };
}


