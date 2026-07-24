import 'package:flutter/material.dart';
import 'package:wat_project_frontend/core/utils/theme_constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wat_project_frontend/core/widgets/pixel_border_container.dart';
import 'package:wat_project_frontend/core/utils/theme_constants.dart';

class SettingsToggleTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const SettingsToggleTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = AppColors.text(context);
    final subtextColor = AppColors.textSub(context);

    return PixelBorderContainer(
      padding: const EdgeInsets.all(AppDimension.space12),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title.toUpperCase(),
                  style: GoogleFonts.notoSansThai(
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: GoogleFonts.notoSansThai(
                    fontSize: 6,
                    color: subtextColor,
                    height: 1.8,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppDimension.space8),
          Switch(
            value: value,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
