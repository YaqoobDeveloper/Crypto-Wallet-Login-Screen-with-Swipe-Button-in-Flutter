import 'package:flutter/material.dart';

import '../../theme/wallet_colors.dart';

/// Big cream circle, like the quick actions under the balance.
class RoundActionButton extends StatelessWidget {
  const RoundActionButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.size = 72,
  });

  final Widget icon;
  final VoidCallback onTap;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: WalletColors.cream,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: SizedBox(
          width: size,
          height: size,
          child: Center(child: icon),
        ),
      ),
    );
  }
}
