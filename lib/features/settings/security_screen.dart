import 'package:flutter/material.dart';

import '../forgot_password/new_password_screen.dart';

/// Security & password. Shows the same New password form used by the
/// forgot-password flow (strength meter, requirement chips, confirm field) for
/// the signed-in member, instead of the old "send reset link" card.
class SecurityScreen extends StatelessWidget {
  const SecurityScreen({super.key});

  @override
  Widget build(BuildContext context) =>
      const NewPasswordScreen(fromSecurity: true);
}
