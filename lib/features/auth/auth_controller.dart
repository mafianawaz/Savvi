import 'package:flutter/cupertino.dart';
import '../../core/auth/token_storage.dart';
import '../../core/auth/user_storage.dart';
import '../../data/models/user.dart';
import '../../core/localization/locale_controller.dart';
import '../../core/network/savvi_api.dart';
import '../../core/network/api_result.dart';
import '../../core/routing/app_router.dart';
import 'package:get/get.dart';
import '../../l10n/app_localizations.dart';
import '../../shared/patterns/error_text.dart';
import '../../shared/patterns/feedback.dart';
import '../access/access_controller.dart';
import '../profile/profile_controller.dart';

/// Auth session state.
///
/// In production the signed-in identity comes from Firebase Auth; the ID
/// token then backs the API client. Firebase wiring is a later stage —
/// Stage 2 models the states and the sign-in call against the mock so the
/// screens and transitions are real.
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
  const AuthSignedIn({required this.user, required this.profile});

  final UserModel user;
  final Map<String, dynamic> profile;
}

class AuthFailed extends AuthState {
  const AuthFailed(this.messageKey);

  final String messageKey; // l10n key
}

class AuthController extends GetxController {
  AuthController({
    required this.api,
    required this.tokenStorage,
    required this.userStorage,
  });

  final SavviApi api;
  final TokenStorage tokenStorage;
  final UserStorage userStorage;

  /// Current authentication state.
  // final Rx<AuthState> state = const AuthSignedOut().obs;
  final Rx<AuthState> state = Rx<AuthState>(const AuthSignedOut());

  @override
  void onInit() {
    super.onInit();
    restoreSession();
  }

  /// Restores the last persisted API session without making a network call.
  /// The first authenticated API request will still validate the token.
  void restoreSession() {
    final savedUser = userStorage.user;
    if (tokenStorage.hasAccessToken && savedUser != null) {
      state.value = AuthSignedIn(
        user: savedUser,
        profile: savedUser.toProfileMap(),
      );
    }
  }
  /// Sign in with email + password.
  ///
  /// Authenticate directly against the Savvi backend. The returned bearer
  /// token and typed user are persisted for subsequent API calls and app
  /// restarts.
  Future<AuthState> signIn({
    required String email,
    required String password,
  }) async {
    state.value = const AuthBusy();

    final result = await api.login(
      email: email,
      password: password,
    );

    if (result is ApiErr<Map<String, dynamic>>) {
      final next = AuthFailed(result.failure.messageKey);
      state.value = next;
      return next;
    }

    final data = (result as ApiOk<Map<String, dynamic>>).data;
    final token = data['token']?.toString() ?? '';
    final rawUser = data['user'];

    if (token.isEmpty || rawUser is! Map) {
      const next = AuthFailed('err_unknown');
      state.value = next;
      return next;
    }

    final user = UserModel.fromJson(Map<String, dynamic>.from(rawUser));
    if (user.id.isEmpty || user.email.isEmpty) {
      const next = AuthFailed('err_unknown');
      state.value = next;
      return next;
    }

    await tokenStorage.save(accessToken: token);
    await userStorage.save(user);

    final next = AuthSignedIn(
      user: user,
      profile: user.toProfileMap(),
    );
    state.value = next;
    return next;
  }

  void signOut() {
    state.value = const AuthSignedOut();
    tokenStorage.clear();
    userStorage.clear();
  }

  /// Merge updated fields into the signed-in profile so edits made on the
  /// Profile screen propagate everywhere that reads the session profile.
  void patchProfile(Map<String, dynamic> updates) {
    final current = state.value;

    if (current is AuthSignedIn) {
      final merged = {...current.profile, ...updates};
      final updatedUser = UserModel.fromJson(merged);
      state.value = AuthSignedIn(
        user: updatedUser,
        profile: updatedUser.toProfileMap(),
      );
      userStorage.save(updatedUser);
    }
  }

  bool get isBusy => state.value is AuthBusy;

  bool get isSignedIn => state.value is AuthSignedIn;

  /// Typed signed-in user. Prefer this for new feature code.
  UserModel? get user {
    final current = state.value;
    return current is AuthSignedIn ? current.user : null;
  }

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

    // FIX: these three were previously declared `late final` but never
    // assigned here (the Get.find/Get.put calls were commented out), so
    // onReady() below threw a LateInitializationError the instant the
    // sign-in screen loaded. All four dependencies are permanent
    // singletons registered in main.dart before runApp(), so a plain
    // Get.find is correct and safe here.
    authController = Get.find<AuthController>();
    profileController = Get.find<EditProfileController>();
    localeController = Get.find<LocaleController>();
  }

  @override
  void onReady() {
    super.onReady();

    /// Landing on sign-in is the entry point; clear any in-progress
    /// onboarding state so a prior, abandoned attempt can't leave a stale
    /// verified grant.
    if (Get.isRegistered<AccessController>()) {
      Get.delete<AccessController>(force: true);
    }
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
    localeController.setLocale(
      isEnglish ? SavviLocales.esUS : SavviLocales.enUS,
    );
  }
}