import 'package:flutter/material.dart';
import '../../core/theme/tokens.dart';
import '../../l10n/app_localizations.dart';

/// Shared scaffold for the onboarding/auth screens: a back affordance, a serif
/// title, an optional subtitle, and a scrollable body. Matches the v45 auth
/// layout (24px gutters, serif 22 title, muted subtitle).
class AuthScaffold extends StatelessWidget {
  const AuthScaffold({
    super.key,
    required this.title,
    required this.children,
    this.subtitle,
    this.onBack,
    this.showBack = true,
    this.backgroundColor = SavColors.surface,
    this.footer,
  });

  final String title;
  final String? subtitle;
  final List<Widget> children;
  final VoidCallback? onBack;
  final bool showBack;
  final Color backgroundColor;
  final Widget? footer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(
                    SavSpace.x24, SavSpace.x16, SavSpace.x24, SavSpace.x24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (showBack)
                      Align(
                        alignment: Alignment.centerLeft,
                        child: _BackButton(onTap: onBack ?? () => _pop(context)),
                      ),
                    const SizedBox(height: SavSpace.x16),
                    Text(title,
                        style: const TextStyle(
                            fontFamily: SavFonts.serif,
                            fontSize: 22,
                            color: SavColors.navy)),
                    if (subtitle != null) ...[
                      const SizedBox(height: SavSpace.x6),
                      Text(subtitle!,
                          style: const TextStyle(
                              fontFamily: SavFonts.sans,
                              fontSize: 13,
                              height: 1.45,
                              fontWeight: FontWeight.w500,
                              color: SavColors.txt3)),
                    ],
                    const SizedBox(height: SavSpace.x20),
                    ...children,
                  ],
                ),
              ),
            ),
            if (footer != null)
              Padding(
                padding: const EdgeInsets.fromLTRB(
                    SavSpace.x24, 0, SavSpace.x24, SavSpace.x12),
                child: footer,
              ),
          ],
        ),
      ),
    );
  }

  void _pop(BuildContext context) {
    final nav = Navigator.of(context);
    if (nav.canPop()) nav.pop();
  }
}

class _BackButton extends StatelessWidget {
  const _BackButton({required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return InkWell(
      onTap: onTap,
      borderRadius: SavRadius.field,
      child: Container(
        constraints: const BoxConstraints(minHeight: SavSpace.minTouch),
        padding: const EdgeInsets.symmetric(vertical: SavSpace.x8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.arrow_back, size: 18, color: SavColors.navy),
            const SizedBox(width: SavSpace.x6),
            Text(l.actionBack,
                style: const TextStyle(
                    fontFamily: SavFonts.sans,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: SavColors.navy)),
          ],
        ),
      ),
    );
  }
}
