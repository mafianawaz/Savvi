import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/localization/locale_controller.dart';
import '../../core/network/savvi_api.dart';
import '../../core/routing/app_router.dart';
import '../../core/state/providers.dart';

/// Auth session state. In production the signed-in identity comes from Firebase
/// Auth; the ID token then backs the API client. Firebase wiring is a later
/// stage — Stage 2 models the states and the sign-in call against the mock so
/// the screens and transitions are real.
///
/// RiverPod
// sealed class AuthState {
//   const AuthState();
// }
//
// class AuthSignedOut extends AuthState {
//   const AuthSignedOut();
// }
//
// class AuthBusy extends AuthState {
//   const AuthBusy();
// }
//
// class AuthSignedIn extends AuthState {
//   const AuthSignedIn(this.profile);
//   final Map<String, dynamic> profile;
// }
//
// class AuthFailed extends AuthState {
//   const AuthFailed(this.messageKey);
//   final String messageKey; // l10n key
// }
//
// class AuthController extends StateNotifier<AuthState> {
//   AuthController(this._ref) : super(const AuthSignedOut());
//   final Ref _ref;
//
//   /// Sign in with email + password.
//   ///
//   /// Later stage: authenticate with Firebase, then call SavviApi.session()
//   /// with the resulting ID token. Stage 2 calls the mock session() so the UI
//   /// flow is exercised end to end.
//   Future<AuthState> signIn({
//     required String email,
//     required String password,
//   }) async {
//     state = const AuthBusy();
//     final api = _ref.read(savviApiProvider);
//     final result = await api.session();
//     final next = result.when(
//       ok: (data) => AuthSignedIn(data),
//       err: (f) => AuthFailed(f.messageKey),
//     );
//     state = next;
//     return next;
//   }
//
//   void signOut() => state = const AuthSignedOut();
//
//   /// Merge updated fields into the signed-in profile so edits made on the
//   /// Profile screen propagate everywhere that reads the session profile.
//   void patchProfile(Map<String, dynamic> updates) {
//     final s = state;
//     if (s is AuthSignedIn) {
//       state = AuthSignedIn({...s.profile, ...updates});
//     }
//   }
// }
//
// final authControllerProvider =
//     StateNotifierProvider<AuthController, AuthState>(
//         (ref) => AuthController(ref));


/// GETx
///
import 'package:get/get.dart';

import '../../l10n/app_localizations.dart';
import '../../shared/patterns/error_text.dart';
import '../../shared/patterns/feedback.dart';
import '../access/access_controller.dart';
import '../profile/profile_controller.dart';

/// Auth session state.
///
/// In production the signed-in identity comes from Firebase Auth; the ID token
/// then backs the API client. Firebase wiring is a later stage — Stage 2 models
/// the states and the sign-in call against the mock so the screens and
/// transitions are real.
sealed class AuthState {
  const AuthState();
}

class AuthSignedOut extends AuthState {
  const AuthSignedOut();
}

class AuthBusy extends AuthState {
  const AuthBusy();
}

class AuthSignedIn extends AuthState {
  const AuthSignedIn(this.profile);

  final Map<String, dynamic> profile;
}

class AuthFailed extends AuthState {
  const AuthFailed(this.messageKey);

  final String messageKey; // l10n key
}

class AuthController extends GetxController {
  AuthController({
    required this.api,
  });

  final SavviApi api;

  /// Current authentication state.
  // final Rx<AuthState> state = const AuthSignedOut().obs;
  final Rx<AuthState> state = Rx<AuthState>(
    const AuthSignedOut(),
  );
  /// Sign in with email + password.
  ///
  /// Later stage: authenticate with Firebase, then call SavviApi.session()
  /// with the resulting ID token. Stage 2 calls the mock session() so the UI
  /// flow is exercised end to end.
  Future<AuthState> signIn({
    required String email,
    required String password,
  }) async {
    state.value = const AuthBusy();

    final result = await api.session();

    final next = result.when(
      ok: (data) => AuthSignedIn(data),
      err: (f) => AuthFailed(f.messageKey),
    );

    state.value = next;
    return next;
  }

  void signOut() {
    state.value = const AuthSignedOut();
  }

  /// Merge updated fields into the signed-in profile so edits made on the
  /// Profile screen propagate everywhere that reads the session profile.
  void patchProfile(Map<String, dynamic> updates) {
    final current = state.value;

    if (current is AuthSignedIn) {
      state.value = AuthSignedIn({
        ...current.profile,
        ...updates,
      });
    }
  }

  bool get isBusy => state.value is AuthBusy;

  bool get isSignedIn => state.value is AuthSignedIn;

  Map<String, dynamic>? get profile {
    final current = state.value;

    if (current is AuthSignedIn) {
      return current.profile;
    }

    return null;
  }
}

class SignInController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  late final AuthController authController;
  late final AccessController accessController;
  late final EditProfileController profileController;
  late final LocaleController localeController;

  @override
  void onInit() {
    super.onInit();

    authController = Get.find();
    accessController = Get.find();
    profileController = Get.find();
    localeController = Get.find();
  }

  @override
  void onReady() {
    super.onReady();

    accessController.reset();
    profileController.refreshFromProfile();
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  bool get isBusy => authController.state.value is AuthBusy;

  Future<void> signIn(BuildContext context) async {
    final l = AppLocalizations.of(context);

    if (!formKey.currentState!.validate()) {
      return;
    }

    final result = await authController.signIn(
      email: emailController.text.trim(),
      password: passwordController.text,
    );

    switch (result) {
      case AuthSignedIn():
        Get.offAllNamed(Routes.home);

      case AuthFailed(:final messageKey):
        SavFeedback.toast(
          context,
          errText(l, messageKey),
          tone: FeedbackTone.error,
        );

      default:
        break;
    }
  }

  void goToAccessLink() {
    Get.toNamed(Routes.accessLink);
  }

  void toggleLocale() {
    final isEnglish = localeController.locale.value == SavviLocales.enUS;
    localeController.setLocale(isEnglish ? SavviLocales.esUS : SavviLocales.enUS);
  }
}