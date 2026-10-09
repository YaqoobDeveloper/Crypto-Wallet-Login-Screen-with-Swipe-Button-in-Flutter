import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../theme/wallet_colors.dart';

/// "Wallet" title on the left with a cream help button on the right.
class WalletHeader extends StatelessWidget {
  const WalletHeader({super.key, required this.title, this.onHelp});

  final String title;
  final VoidCallback? onHelp;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        const Spacer(),
        Material(
          color: WalletColors.creamText,
          shape: const CircleBorder(),
          child: InkWell(
            customBorder: const CircleBorder(),
            onTap: onHelp,
            child: const SizedBox(
              width: 46,
              height: 46,
              child: Icon(
                Icons.headset_mic_outlined,
                size: 22,
                color: WalletColors.ink,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
