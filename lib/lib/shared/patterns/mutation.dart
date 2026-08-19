import '../../core/network/api_result.dart';

/// Reusable pattern for backend mutations (mark-read, clear, toggle a
/// preference, save a profile field, …). The convention across the app:
///
///  • The backend is the source of truth — never toast success before the API
///    confirms.
///  • Track a pending flag in the controller's state; the UI disables the
///    control and/or shows a saving state while pending, preventing duplicate
///    taps.
///  • Optimistic mutations apply the new value immediately, then **roll back**
///    on failure. Non-optimistic mutations show a pending state and patch only
///    on success.
///  • Every mutation returns a [MutationResult] so the UI can toast success or a
///    localized error (via `errText(l, result.errorKey!)`).
class MutationResult {
  const MutationResult._(this.ok, this.errorKey);
  const MutationResult.ok() : this._(true, null);
  const MutationResult.err(String key) : this._(false, key);

  final bool ok;
  final String? errorKey;
}

/// Maps a void [ApiResult] to a [MutationResult], running [onRollback] on
/// failure (for optimistic flows) so the UI never disagrees with the backend.
MutationResult resultOf(ApiResult<void> res, {void Function()? onRollback}) =>
    res.when(
      ok: (_) => const MutationResult.ok(),
      err: (f) {
        onRollback?.call();
        return MutationResult.err(f.messageKey);
      },
    );
