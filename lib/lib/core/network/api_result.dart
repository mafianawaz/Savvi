/// A minimal Result type for the API layer so screens can handle
/// success / failure without try/catch scattered through the UI.
sealed class ApiResult<T> {
  const ApiResult();

  R when<R>({
    required R Function(T data) ok,
    required R Function(ApiFailure failure) err,
  }) {
    final self = this;
    return switch (self) {
      ApiOk<T>(:final data) => ok(data),
      ApiErr<T>(:final failure) => err(failure),
    };
  }
}

class ApiOk<T> extends ApiResult<T> {
  const ApiOk(this.data);
  final T data;
}

class ApiErr<T> extends ApiResult<T> {
  const ApiErr(this.failure);
  final ApiFailure failure;
}

/// Normalised failure surfaced to the UI. [messageKey] is an l10n key so error
/// copy is localised (never a raw server string shown directly to a member).
class ApiFailure {
  const ApiFailure({
    required this.kind,
    required this.messageKey,
    this.status,
    this.detail,
  });

  final ApiFailureKind kind;
  final String messageKey;
  final int? status;
  final String? detail; // developer-facing only; never shown to members

  factory ApiFailure.network() => const ApiFailure(
        kind: ApiFailureKind.network,
        messageKey: 'err_network',
      );
  factory ApiFailure.timeout() => const ApiFailure(
        kind: ApiFailureKind.timeout,
        messageKey: 'err_timeout',
      );
  factory ApiFailure.unauthorized() => const ApiFailure(
        kind: ApiFailureKind.unauthorized,
        messageKey: 'err_unauthorized',
        status: 401,
      );
  factory ApiFailure.server([int? status, String? detail]) => ApiFailure(
        kind: ApiFailureKind.server,
        messageKey: 'err_server',
        status: status,
        detail: detail,
      );
  factory ApiFailure.unknown([String? detail]) => ApiFailure(
        kind: ApiFailureKind.unknown,
        messageKey: 'err_unknown',
        detail: detail,
      );
}

enum ApiFailureKind { network, timeout, unauthorized, server, unknown }
