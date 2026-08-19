import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// GetX
/// Bottom-nav tab indices for the signed-in shell.
const int kTabHome = 0;
const int kTabAlerts = 1;
const int kTabActivity = 2;
const int kTabProfile = 3;

/// Registered on [GetMaterialApp.navigatorObservers] so [MainShell] can use
/// `RouteAware` to know when a route pushed on top of it (the request
/// wizard) is popped back to it, and clear the Request tile's selected
/// state accordingly — without every wizard exit point needing to know
/// about the shell.
final RouteObserver<PageRoute> shellRouteObserver = RouteObserver<PageRoute>();

/// Controls the selected shell tab and whether the member should
/// return to the request flow after editing their profile.
///
/// This replaces:
/// - shellTabProvider
/// - requestReturnProvider
class ShellController extends GetxController {
  /// Currently selected bottom navigation tab.
  final RxInt selectedTab = kTabHome.obs;

  /// True when the user temporarily left the request wizard to edit
  /// their profile.
  final RxBool requestReturn = false.obs;

  /// True while the request wizard is the topmost route, so the bottom
  /// nav's Request tile can show its selected (green border) state even
  /// though Request isn't one of the persisted [IndexedStack] tabs.
  final RxBool isRequestActive = false.obs;

  /// Change active tab.
  void changeTab(int index) {
    selectedTab.value = index;
  }

  /// Convenience helper.
  void goToHome() {
    selectedTab.value = kTabHome;
    isRequestActive.value = false;
  }

  void goToAlerts() {
    selectedTab.value = kTabAlerts;
    isRequestActive.value = false;
  }

  void goToActivity() {
    selectedTab.value = kTabActivity;
    isRequestActive.value = false;
  }

  void goToProfile() {
    selectedTab.value = kTabProfile;
    isRequestActive.value = false;
  }

  /// Mark whether request flow should resume.
  void setRequestReturn(bool value) {
    requestReturn.value = value;
  }

  /// Marks the Request tile selected/unselected. Set true right before
  /// pushing the wizard; cleared when the wizard route is popped back to
  /// this shell (see [MainShell]'s `RouteAware.didPopNext`) or when the
  /// wizard replaces the stack on successful submission.
  void setRequestActive(bool value) {
    isRequestActive.value = value;
  }

  /// Restore defaults.
  void reset() {
    selectedTab.value = kTabHome;
    requestReturn.value = false;
    isRequestActive.value = false;
  }
}