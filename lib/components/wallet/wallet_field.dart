import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../theme/wallet_colors.dart';

/// Small grey label over a large bold input, with a round tinted
/// button on the right — like the "Current Wallet Balance" row.
class WalletField extends StatelessWidget {
  const WalletField({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    required this.trailingIcon,
    this.onTrailingTap,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
    this.onSubmitted,
    this.validator,
  });

  final TextEditingController controller;
  final String label;
  final String hint;
  final IconData trailingIcon;
  final VoidCallback? onTrailingTap;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onSubmitted;
  final FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 14),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: WalletColors.line, width: 1.5),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13,
                    color: WalletColors.grey,
                  ),
                ),
                TextFormField(
                  controller: controller,
                  obscureText: obscureText,
                  keyboardType: keyboardType,
                  textInputAction: textInputAction,
                  onFieldSubmitted: onSubmitted,
                  validator: validator,
                  cursorColor: WalletColors.orange,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 19,
                    fontWeight: FontWeight.w700,
                    color: WalletColors.text,
                  ),
                  decoration: InputDecoration(
                    hintText: hint,
                    hintStyle: GoogleFonts.plusJakartaSans(
                      fontSize: 19,
                      fontWeight: FontWeight.w600,
                      color: WalletColors.grey.withValues(alpha: 0.4),
                    ),
                    isDense: true,
                    contentPadding: const EdgeInsets.only(top: 8),
                    border: InputBorder.none,
                    errorStyle: GoogleFonts.plusJakartaSans(
                      fontSize: 12,
                      color: WalletColors.orange,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Material(
            color: WalletColors.orangeTint,
            shape: const CircleBorder(),
            child: InkWell(
              customBorder: const CircleBorder(),
              onTap: onTrailingTap,
              child: SizedBox(
                width: 50,
                height: 50,
                child: Icon(trailingIcon, color: WalletColors.orange, size: 22),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
