import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../theme/wallet_colors.dart';

/// Orange pill with a white knob you drag to the end, like
/// "Swipe to Withdraw". [onSwiped] returns whether the action
/// succeeded; on failure the knob springs back.
class SwipeButton extends StatefulWidget {
  const SwipeButton({super.key, required this.label, required this.onSwiped});

  final String label;
  final bool Function() onSwiped;

  @override
  State<SwipeButton> createState() => _SwipeButtonState();
}

class _SwipeButtonState extends State<SwipeButton>
    with SingleTickerProviderStateMixin {
  static const _height = 66.0;
  static const _pad = 5.0;
  static const _knob = _height - _pad * 2;

  late final _progress = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 250),
  );
  bool _done = false;

  @override
  void dispose() {
    _progress.dispose();
    super.dispose();
  }

  Future<void> _release() async {
    if (_progress.value < 0.8) {
      await _progress.reverse();
      return;
    }
    await _progress.forward();
    if (!mounted) return;
    if (!widget.onSwiped()) {
      await _progress.reverse();
      return;
    }
    setState(() => _done = true);
    await Future<void>.delayed(const Duration(milliseconds: 1200));
    if (!mounted) return;
    setState(() => _done = false);
    await _progress.reverse();
  }

  /// How far the knob can move, in pixels.
  double get _travel => context.size!.width - _knob - _pad * 2;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _height,
      padding: const EdgeInsets.all(_pad),
      decoration: BoxDecoration(
        color: WalletColors.orange,
        borderRadius: BorderRadius.circular(_height / 2),
      ),
      child: AnimatedBuilder(
        animation: _progress,
        builder: (context, _) => Stack(
          alignment: Alignment.center,
          children: [
            Opacity(
              opacity: 1 - _progress.value,
              child: Padding(
                padding: const EdgeInsets.only(left: _knob),
                child: Text(
                  widget.label,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment(_progress.value * 2 - 1, 0),
              child: GestureDetector(
                key: const ValueKey('swipe-knob'),
                onHorizontalDragUpdate: _done
                    ? null
                    : (d) => _progress.value += d.delta.dx / _travel,
                onHorizontalDragEnd: _done ? null : (_) => _release(),
                child: Container(
                  width: _knob,
                  height: _knob,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    _done ? Icons.check_rounded : Icons.arrow_forward,
                    color: WalletColors.orange,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
