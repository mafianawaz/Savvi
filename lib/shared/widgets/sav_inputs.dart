import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/theme/tokens.dart';

/// Labelled text field (v45 field pattern). Wraps [TextFormField] so it plugs
/// into a [Form] with the shared [Validators].
class SavField extends StatelessWidget {
  const SavField({
    super.key,
    required this.label,
    this.controller,
    this.hint,
    this.helper,
    this.required = false,
    this.keyboardType,
    this.obscure = false,
    this.autofillHints,
    this.inputFormatters,
    this.validator,
    this.maxLines = 1,
    this.onChanged,
  });

  final String label;
  final TextEditingController? controller;
  final String? hint;
  final String? helper;
  final bool required;
  final TextInputType? keyboardType;
  final bool obscure;
  final Iterable<String>? autofillHints;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final int maxLines;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: SavSpace.x6, left: 2),
          child: RichText(
            text: TextSpan(
              text: label,
              style: const TextStyle(
                fontFamily: SavFonts.sans,
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: SavColors.txt2,
              ),
              children: required
                  ? const [
                      TextSpan(
                        text: ' *',
                        style: TextStyle(color: SavColors.red),
                      )
                    ]
                  : null,
            ),
          ),
        ),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscure,
          autofillHints: autofillHints,
          inputFormatters: inputFormatters,
          validator: validator,
          maxLines: obscure ? 1 : maxLines,
          onChanged: onChanged,
          style: const TextStyle(
            fontFamily: SavFonts.sans,
            fontSize: 15,
            color: SavColors.txt,
          ),
          decoration: InputDecoration(hintText: hint),
        ),
        if (helper != null)
          Padding(
            padding: const EdgeInsets.only(top: SavSpace.x6, left: 2),
            child: Text(
              helper!,
              style: const TextStyle(
                fontFamily: SavFonts.sans,
                fontSize: 11.5,
                height: 1.45,
                fontWeight: FontWeight.w500,
                color: SavColors.txt3,
              ),
            ),
          ),
      ],
    );
  }
}

/// Inline notice / callout (v45 `.notice`). Tone drives the colour.
enum NoticeTone { neutral, green, blue, amber, red }

class SavNotice extends StatelessWidget {
  const SavNotice({
    super.key,
    required this.message,
    this.tone = NoticeTone.neutral,
    this.icon = Icons.info_outline,
    this.title,
  });

  final String message;
  final NoticeTone tone;
  final IconData icon;
  final String? title;

  @override
  Widget build(BuildContext context) {
    final (bg, fg) = switch (tone) {
      NoticeTone.neutral => (SavColors.page, SavColors.txt2),
      NoticeTone.green => (SavColors.greenLight, SavColors.pillGreenFg),
      NoticeTone.blue => (SavColors.blueLight, SavColors.pillBlueFg),
      NoticeTone.amber => (SavColors.amberLight, SavColors.pillAmberFg),
      NoticeTone.red => (SavColors.redLight, SavColors.pillRedFg),
    };
    return Container(
      padding: const EdgeInsets.all(SavSpace.x12),
      decoration:
          BoxDecoration(color: bg, borderRadius: SavRadius.field),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 16, color: fg),
          const SizedBox(width: SavSpace.x10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (title != null)
                  Text(
                    title!,
                    style: TextStyle(
                      fontFamily: SavFonts.sans,
                      fontSize: 12.5,
                      fontWeight: FontWeight.w700,
                      color: fg,
                    ),
                  ),
                Text(
                  message,
                  style: TextStyle(
                    fontFamily: SavFonts.sans,
                    fontSize: 12,
                    height: 1.45,
                    fontWeight: FontWeight.w500,
                    color: fg,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
