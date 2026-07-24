import 'package:flutter/material.dart';
import 'package:wat_project_frontend/core/extension/extension.dart';
import 'package:wat_project_frontend/core/widgets/pixel_border_container.dart';
import 'package:wat_project_frontend/utils/theme_constants.dart';

/// WatCardItem — Pixel RPG styled card tile.
/// Used as a general-purpose list item or content card.
class WatCardItem extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final Color? borderColor;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry? margin;
  final String? label;

  const WatCardItem({
    super.key,
    required this.child,
    this.onTap,
    this.backgroundColor,
    this.borderColor,
    this.padding = const EdgeInsets.all(AppDimension.space12),
    this.margin,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    return PixelBorderContainer(
      backgroundColor: backgroundColor,
      borderColor: borderColor,
      padding: padding,
      margin: margin,
      onTap: onTap,
      child: label != null
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  label!.toUpperCase(),
                  style: context.textTheme.labelMedium?.copyWith(color: AppColors.primary,),
                ),
                const SizedBox(height: AppDimension.space8),
                child,
              ],
            )
          : child,
    );
  }
}
