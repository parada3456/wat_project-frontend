import 'package:flutter/material.dart';
import 'package:wat_project_frontend/utils/theme_constants.dart';

/// PixelBorderContainer — The primitive building block of the gather.town/
/// 2D top-down pixel art design system.
///
/// Renders a hard-corner panel with a double-pixel border:
///   [outerBorder] → [innerAccentLine] → [backgroundColor fill] → [child]
///
/// Usage:
///   PixelBorderContainer(
///     child: Text('PANEL'),
///   )
class PixelBorderContainer extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? innerBorderColor;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry? margin;
  final bool showInnerBorder;
  final VoidCallback? onTap;

  const PixelBorderContainer({
    super.key,
    required this.child,
    this.backgroundColor,
    this.borderColor,
    this.innerBorderColor,
    this.width,
    this.height,
    this.padding = const EdgeInsets.all(AppDimension.space12),
    this.margin,
    this.showInnerBorder = true,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final resolvedBg = backgroundColor ??
        (isDark ? AppColors.darkSurface : AppColors.lightSurface);
    final resolvedBorder =
        borderColor ?? (isDark ? AppColors.darkBorder : AppColors.lightBorder);
    final resolvedInner = innerBorderColor ?? resolvedBg.withValues(alpha: 0.6);

    final Widget container = Container(
      width: width,
      height: height,
      margin: margin,
      decoration: BoxDecoration(
        color: resolvedBg,
        // Outer pixel border
        border: Border.all(
          color: resolvedBorder,
          width: AppDimension.pixelBorderWidth,
        ),
        // No border radius — hard pixel corners
        borderRadius: BorderRadius.zero,
      ),
      child: showInnerBorder
          ? Container(
              // Inner accent line (1px inset)
              margin: const EdgeInsets.all(AppDimension.pixelBorderInner),
              decoration: BoxDecoration(
                border: Border.all(
                  color: resolvedInner,
                  width: AppDimension.pixelBorderInner,
                ),
              ),
              padding: padding,
              child: child,
            )
          : Padding(padding: padding, child: child),
    );

    if (onTap != null) {
      return GestureDetector(onTap: onTap, child: container);
    }
    return container;
  }
}

/// A labelled pixel section header — like a sign in an RPG town.
///
/// Renders a full-width horizontal rule with a centered label.
/// Example:
///   PixelSectionHeader(label: 'QUEST LOG')
class PixelSectionHeader extends StatelessWidget {
  final String label;
  final Color? color;

  const PixelSectionHeader({super.key, required this.label, this.color});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final c = color ?? (isDark ? AppColors.darkBorder : AppColors.lightBorder);
    final textStyle = Theme.of(context).textTheme.labelMedium?.copyWith(
          color: c,
          letterSpacing: 2,
        );

    return Row(
      children: [
        Expanded(child: Divider(color: c, thickness: AppDimension.pixelBorderWidth, height: 1)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppDimension.space8),
          child: Text(label.toUpperCase(), style: textStyle),
        ),
        Expanded(child: Divider(color: c, thickness: AppDimension.pixelBorderWidth, height: 1)),
      ],
    );
  }
}

/// Pixel dialogue box — like a character speech bubble in a top-down RPG.
/// Use this in dialog popups and info panels.
class PixelDialogBox extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;
  final Color? borderColor;
  final String? title;

  const PixelDialogBox({
    super.key,
    required this.child,
    this.backgroundColor,
    this.borderColor,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = backgroundColor ??
        (isDark ? AppColors.darkSurface : AppColors.lightSurface);
    final bc =
        borderColor ?? (isDark ? AppColors.darkBorder : AppColors.lightBorder);

    return Container(
      decoration: BoxDecoration(
        color: bg,
        border: Border.all(color: bc, width: AppDimension.pixelBorderWidth * 2),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (title != null)
            Container(
              color: bc,
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimension.space12,
                vertical: AppDimension.space8,
              ),
              child: Text(
                title!.toUpperCase(),
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: bg,
                      letterSpacing: 1.5,
                    ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(AppDimension.space16),
            child: child,
          ),
        ],
      ),
    );
  }
}
