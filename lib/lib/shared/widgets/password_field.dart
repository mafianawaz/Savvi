import 'package:flutter/material.dart';
import '../../core/theme/tokens.dart';
import '../../l10n/app_localizations.dart';

/// The four password requirements checked in the v45 signup flow.
class PasswordChecks {
  const PasswordChecks({
    required this.length,
    required this.upper,
    required this.number,
    required this.special,
  });

  final bool length;
  final bool upper;
  final bool number;
  final bool special;

  int get score =>
      (length ? 1 : 0) + (upper ? 1 : 0) + (number ? 1 : 0) + (special ? 1 : 0);

  bool get allMet => score == 4;

  factory PasswordChecks.of(String value) => PasswordChecks(
        length: value.length >= 8,
        upper: RegExp(r'[A-Z]').hasMatch(value),
        number: RegExp(r'\d').hasMatch(value),
        special: RegExp(r'[^A-Za-z0-9]').hasMatch(value),
      );
}

/// Password input with a live 4-segment strength meter and requirement chips
/// (8+ characters, Uppercase, Number, Special character). Ported from v45.
class PasswordField extends StatefulWidget {
  const PasswordField({
    super.key,
    required this.controller,
    required this.label,
    this.required = true,
    this.onChanged,
  });

  final TextEditingController controller;
  final String label;
  final bool required;
  final ValueChanged<PasswordChecks>? onChanged;

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  var _checks = const PasswordChecks(
      length: false, upper: false, number: false, special: false);
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: SavSpace.x6, left: 2),
          child: RichText(
            text: TextSpan(
              text: widget.label,
              style: const TextStyle(
                  fontFamily: SavFonts.sans,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: SavColors.txt2),
              children: widget.required
                  ? const [
                      TextSpan(text: ' *', style: TextStyle(color: SavColors.red))
                    ]
                  : null,
            ),
          ),
        ),
        TextFormField(
          controller: widget.controller,
          obscureText: _obscure,
          autofillHints: const [AutofillHints.newPassword],
          validator: (v) {
            if ((v ?? '').isEmpty) return l.valRequired;
            return PasswordChecks.of(v!).allMet ? null : l.pwdNotMet;
          },
          onChanged: (v) {
            setState(() => _checks = PasswordChecks.of(v));
            widget.onChanged?.call(_checks);
          },
          style: const TextStyle(
              fontFamily: SavFonts.sans, fontSize: 15, color: SavColors.txt),
          decoration: InputDecoration(
            hintText: l.hintPassword,
            suffixIcon: IconButton(
              icon: Icon(_obscure ? Icons.visibility_off : Icons.visibility,
                  size: 20, color: SavColors.txt4),
              onPressed: () => setState(() => _obscure = !_obscure),
            ),
          ),
        ),
        const SizedBox(height: SavSpace.x8),
        _StrengthBars(score: _checks.score),
        const SizedBox(height: SavSpace.x8),
        _ReqGrid(checks: _checks),
      ],
    );
  }
}

class _StrengthBars extends StatelessWidget {
  const _StrengthBars({required this.score});
  final int score;

  @override
  Widget build(BuildContext context) {
    Color colorFor(int index) {
      if (index >= score) return SavColors.border;
      return switch (score) {
        <= 1 => SavColors.red,
        2 => SavColors.red,
        3 => SavColors.amber,
        _ => SavColors.greenDark,
      };
    }

    return Row(
      children: List.generate(4, (i) {
        return Expanded(
          child: Container(
            height: 3,
            margin: EdgeInsets.only(right: i == 3 ? 0 : SavSpace.x4),
            decoration: BoxDecoration(
                color: colorFor(i), borderRadius: BorderRadius.circular(2)),
          ),
        );
      }),
    );
  }
}

class _ReqGrid extends StatelessWidget {
  const _ReqGrid({required this.checks});
  final PasswordChecks checks;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final items = <(String, bool)>[
      (l.pwdReqLength, checks.length),
      (l.pwdReqUpper, checks.upper),
      (l.pwdReqNumber, checks.number),
      (l.pwdReqSpecial, checks.special),
    ];
    return Wrap(
      spacing: SavSpace.x6,
      runSpacing: SavSpace.x6,
      children: [
        for (final (label, ok) in items)
          Container(
            width: (MediaQuery.of(context).size.width - 48 - SavSpace.x6) / 2,
            padding: const EdgeInsets.symmetric(
                horizontal: SavSpace.x10, vertical: 7),
            decoration: BoxDecoration(
              color: ok ? SavColors.greenLight : SavColors.page,
              borderRadius: SavRadius.field,
              border: Border.all(
                  color: ok ? const Color(0xFFA7D7A8) : SavColors.border),
            ),
            child: Row(
              children: [
                Icon(ok ? Icons.check_circle : Icons.circle_outlined,
                    size: 14,
                    color: ok ? SavColors.pillGreenFg : SavColors.txt4),
                const SizedBox(width: SavSpace.x6),
                Flexible(
                  child: Text(label,
                      style: TextStyle(
                          fontFamily: SavFonts.sans,
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: ok ? SavColors.pillGreenFg : SavColors.txt3)),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
