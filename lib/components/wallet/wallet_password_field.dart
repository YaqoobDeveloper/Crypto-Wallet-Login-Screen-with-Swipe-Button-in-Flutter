import 'package:flutter/material.dart';

import 'wallet_field.dart';

/// [WalletField] whose round button shows / hides the password.
class WalletPasswordField extends StatefulWidget {
  const WalletPasswordField({
    super.key,
    required this.controller,
    this.label = 'Password',
    this.onSubmitted,
    this.validator,
  });

  final TextEditingController controller;
  final String label;
  final ValueChanged<String>? onSubmitted;
  final FormFieldValidator<String>? validator;

  @override
  State<WalletPasswordField> createState() => _WalletPasswordFieldState();
}

class _WalletPasswordFieldState extends State<WalletPasswordField> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return WalletField(
      controller: widget.controller,
      label: widget.label,
      hint: '••••••••',
      obscureText: _obscure,
      textInputAction: TextInputAction.done,
      onSubmitted: widget.onSubmitted,
      validator: widget.validator,
      trailingIcon: _obscure
          ? Icons.visibility_off_outlined
          : Icons.visibility_outlined,
      onTrailingTap: () => setState(() => _obscure = !_obscure),
    );
  }
}
