import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wat_project_frontend/utils/theme_constants.dart';

/// WatButton — Pixel RPG styled button.
/// Hard corners, double-pixel border, press-down animation.
class WatButton extends StatefulWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? textColor;
  final double? width;
  final bool outlined;

  const WatButton({
    super.key,
    required this.label,
    this.onPressed,
    this.isLoading = false,
    this.backgroundColor,
    this.borderColor,
    this.textColor,
    this.width,
    this.outlined = false,
  });

  /// Outlined / secondary variant
  const WatButton.outlined({
    super.key,
    required this.label,
    this.onPressed,
    this.isLoading = false,
    this.backgroundColor,
    this.borderColor,
    this.textColor,
    this.width,
  }) : outlined = true;

  @override
  State<WatButton> createState() => _WatButtonState();
}

class _WatButtonState extends State<WatButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final Color bg = widget.backgroundColor ??
        (widget.outlined
            ? Colors.transparent
            : AppColors.primary);

    final Color border = widget.borderColor ??
        (isDark ? AppColors.darkBorder : AppColors.lightBorder);

    final Color fg = widget.textColor ??
        (widget.outlined
            ? (isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary)
            : AppColors.black);

    final bool disabled = widget.onPressed == null && !widget.isLoading;

    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) {
        setState(() => _pressed = false);
        if (!widget.isLoading && !disabled) widget.onPressed?.call();
      },
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 80),
        width: widget.width ?? double.infinity,
        transform: _pressed
            ? (Matrix4.identity()..translateByDouble(2.0, 2.0, 0.0, 1.0))
            : Matrix4.identity(),
        child: Container(
          height: 48,
          decoration: BoxDecoration(
            color: disabled ? bg.withValues(alpha: 0.4) : bg,
            border: Border.all(
              color: disabled ? border.withValues(alpha: 0.4) : border,
              width: AppDimension.pixelBorderWidth,
            ),
            // Pixel "shadow" effect: right+bottom border
            boxShadow: _pressed || disabled
                ? []
                : [
                    BoxShadow(
                      color: border.withValues(alpha: 0.8),
                      offset: const Offset(3, 3),
                      blurRadius: 0,
                    ),
                  ],
          ),
          alignment: Alignment.center,
          child: widget.isLoading
              ? PixelLoadingDots(color: fg)
              : Text(
                  widget.label.toUpperCase(),
                  style: GoogleFonts.pressStart2p(
                    fontSize: 9,
                    color: disabled ? fg.withValues(alpha: 0.5) : fg,
                    height: 1.5,
                  ),
                ),
        ),
      ),
    );
  }
}

/// Animated pixel loading indicator — blinking "..." dots
class PixelLoadingDots extends StatefulWidget {
  final Color color;
  const PixelLoadingDots({super.key, required this.color});

  @override
  State<PixelLoadingDots> createState() => _PixelLoadingDotsState();
}

class _PixelLoadingDotsState extends State<PixelLoadingDots>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<int> _step;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat();
    _step = IntTween(begin: 0, end: 3).animate(_ctrl);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _step,
      builder: (context, child) {
        final dots = '.' * (_step.value + 1);
        return Text(
          dots,
          style: GoogleFonts.pressStart2p(
            fontSize: 16,
            color: widget.color,
          ),
        );
      },
    );
  }
}
