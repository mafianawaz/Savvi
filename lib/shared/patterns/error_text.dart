import '../../l10n/app_localizations.dart';

/// Maps an `ApiFailure.messageKey` to localized text. Shared across screens so
/// the error-key → copy mapping lives in exactly one place.
String errText(AppLocalizations l, String key) => switch (key) {
      'err_network' => l.errNetwork,
      'err_timeout' => l.errTimeout,
      'err_unauthorized' => l.errUnauthorized,
      'err_server' => l.errServer,
      _ => l.errUnknown,
    };
