import '../network/api_result.dart';

/// Firebase-specific auth operations that do NOT go through the NestJS
/// backend / SavviApi. Password-reset confirmation is one of these: Firebase
/// issues an oobCode in the emailed link, and the Firebase client SDK
/// confirms it directly. SavviApi.sendPasswordReset only ever *requests* the
/// email; it deliberately has no confirm method (see its doc comment: "the
/// frontend never stores passwords").
///
/// Stage 1 stub — the real implementation wraps
/// FirebaseAuth.instance.confirmPasswordReset(code: ..., newPassword: ...)
/// once Firebase is wired.
abstract interface class FirebaseAuthGateway {
  /// Confirms a password reset using the oobCode from the emailed link.
  /// [oobCode] is empty in this mock flow since there's no real email link yet.
  Future<ApiResult<void>> confirmPasswordReset({
    required String oobCode,
    required String newPassword,
  });
}

class StubFirebaseAuthGateway implements FirebaseAuthGateway {
  @override
  Future<ApiResult<void>> confirmPasswordReset({
    required String oobCode,
    required String newPassword,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 450));
    return const ApiOk<void>(null); // swap for real FirebaseAuth call later
  }
}