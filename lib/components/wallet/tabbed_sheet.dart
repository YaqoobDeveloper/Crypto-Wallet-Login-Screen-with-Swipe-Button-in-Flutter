import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../theme/wallet_colors.dart';

/// White sheet whose top edge rises into a folder tab behind the
/// selected label, like the "My Assets / My Transaction" card.
class TabbedSheet extends StatelessWidget {
  const TabbedSheet({
    super.key,
    required this.tabs,
    required this.selectedIndex,
    required this.onTabChanged,
    required this.child,
  }) : assert(tabs.length == 2);

  static const tabHeight = 58.0;

  final List<String> tabs;
  final int selectedIndex;
  final ValueChanged<int> onTabChanged;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.paddingOf(context).bottom;

    return Stack(
      children: [
        Positioned.fill(
          child: ClipPath(
            clipper: _FolderTabClipper(mirrored: selectedIndex == 1),
            child: const ColoredBox(color: WalletColors.surface),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: tabHeight,
              child: Row(
                children: [
                  for (var i = 0; i < tabs.length; i++)
                    Expanded(child: _tabLabel(i)),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(24, 20, 24, 24 + bottomInset),
                child: child,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _tabLabel(int i) {
    final selected = i == selectedIndex;
    // Plain gesture instead of InkWell: no hover or splash highlight.
    return MouseRegion(
      cursor: selected ? MouseCursor.defer : SystemMouseCursors.click,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: selected ? null : () => onTabChanged(i),
        child: Center(
          child: Text(
            tabs[i],
            style: GoogleFonts.plusJakartaSans(
              fontSize: 15,
              fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
              color: selected ? WalletColors.text : WalletColors.grey,
            ),
          ),
        ),
      ),
    );
  }
}

class _FolderTabClipper extends CustomClipper<Path> {
  const _FolderTabClipper({required this.mirrored});

  /// When true the tab sits on the right half instead of the left.
  final bool mirrored;

  @override
  Path getClip(Size size) {
    const r = 30.0;
    const tabH = TabbedSheet.tabHeight;
    final w = size.width;
    final tabW = w / 2;
    double x(double v) => mirrored ? w - v : v;

    return Path()
      ..moveTo(x(0), r)
      ..arcToPoint(
        Offset(x(r), 0),
        radius: const Radius.circular(r),
        clockwise: !mirrored,
      )
      ..lineTo(x(tabW - 30), 0)
      // Smooth S-curve stepping down from the tab to the sheet.
      ..cubicTo(x(tabW + 4), 0, x(tabW - 4), tabH, x(tabW + 30), tabH)
      ..lineTo(x(w - r), tabH)
      ..arcToPoint(
        Offset(x(w), tabH + r),
        radius: const Radius.circular(r),
        clockwise: !mirrored,
      )
      ..lineTo(x(w), size.height)
      ..lineTo(x(0), size.height)
      ..close();
  }

  @override
  bool shouldReclip(covariant _FolderTabClipper oldClipper) =>
      oldClipper.mirrored != mirrored;
}
