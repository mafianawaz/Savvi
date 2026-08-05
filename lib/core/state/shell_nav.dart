import 'package:flutter_riverpod/flutter_riverpod.dart';

///RiverPod
// /// Bottom-nav tab indices for the signed-in shell.
// const int kTabHome = 0;
// const int kTabAlerts = 1;
// const int kTabActivity = 2;
// const int kTabProfile = 3;
//
// /// Selected shell tab. Held in a provider so flows like the wizard's "Edit in
// /// profile" can switch to an existing tab instead of pushing a duplicate screen
// /// (Profile is a single instance — the shell tab).
// final shellTabProvider = StateProvider<int>((ref) => kTabHome);
//
// /// True when the member left the request wizard to edit their profile, so the
// /// Profile screen can offer "Return to request". The request draft is preserved
// /// (the draft provider is kept alive), so returning resumes where they left off.
// final requestReturnProvider = StateProvider<bool>((ref) => false);


/// GetX

import 'package:get/get.dart';

/// Bottom-nav tab indices for the signed-in shell.
// const int kTabHome = 0;
// const int kTabAlerts = 1;
// const int kTabActivity = 2;
// const int kTabProfile = 3;
const kTabHome = 0;
const kTabAlerts = 1;
const kTabRequest = 2;
const kTabActivity = 3;
const kTabProfile = 4;

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

  /// Change active tab.
  void changeTab(int index) {
    selectedTab.value = index;
  }

  /// Convenience helper.
  void goToHome() {
    selectedTab.value = kTabHome;
  }

  void goToAlerts() {
    selectedTab.value = kTabAlerts;
  }

  void goToActivity() {
    selectedTab.value = kTabActivity;
  }

  void goToProfile() {
    selectedTab.value = kTabProfile;
  }

  /// Mark whether request flow should resume.
  void setRequestReturn(bool value) {
    requestReturn.value = value;
  }

  /// Restore defaults.
  void reset() {
    selectedTab.value = kTabHome;
    requestReturn.value = false;
  }
}