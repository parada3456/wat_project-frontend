import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wat_project_frontend/core/widgets/pixel_border_container.dart';
import 'package:wat_project_frontend/utils/theme_constants.dart';

class JobCartItemTile extends StatelessWidget {
  final String title;
  final String company;
  final String status; // 'Saved', 'Applied', etc.
  final VoidCallback onDelete;
  final ValueChanged<String>? onStatusChanged;

  const JobCartItemTile({
    super.key,
    required this.title,
    required this.company,
    required this.status,
    required this.onDelete,
    this.onStatusChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isApplied = status.toLowerCase() == 'applied';
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = AppColors.text(context);
    final subtextColor = AppColors.textSub(context);
    final borderColor = AppColors.border(context);

    final statusBg = isApplied
        ? AppColors.success.withValues(alpha: 0.15)
        : AppColors.primary.withValues(alpha: 0.15);
    final statusColor = isApplied ? AppColors.success : AppColors.primary;

    return PixelBorderContainer(
      padding: const EdgeInsets.all(AppDimension.space12),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: isDark ? AppColors.darkSurfaceAlt : AppColors.lightSurfaceAlt,
              border: Border.all(
                color: borderColor,
                width: AppDimension.pixelBorderWidth,
              ),
            ),
            alignment: Alignment.center,
            child: AppAssets.img(
              AppAssets.iconJobs,
              size: 20,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(width: AppDimension.space12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title.toUpperCase(),
                  style: GoogleFonts.pressStart2p(
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  company.toUpperCase(),
                  style: GoogleFonts.pressStart2p(
                    fontSize: 6,
                    color: subtextColor,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          if (onStatusChanged != null)
            PopupMenuButton<String>(
              onSelected: onStatusChanged,
              color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 'Saved',
                  child: Text(
                    'SAVED',
                    style: GoogleFonts.pressStart2p(fontSize: 7, color: textColor),
                  ),
                ),
                PopupMenuItem(
                  value: 'Applied',
                  child: Text(
                    'APPLIED',
                    style: GoogleFonts.pressStart2p(fontSize: 7, color: textColor),
                  ),
                ),
              ],
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                decoration: BoxDecoration(
                  color: statusBg,
                  border: Border.all(
                    color: statusColor,
                    width: AppDimension.pixelBorderWidth,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      status.toUpperCase(),
                      style: GoogleFonts.pressStart2p(
                        fontSize: 6,
                        fontWeight: FontWeight.bold,
                        color: statusColor,
                      ),
                    ),
                    const SizedBox(width: 4),
                    AppAssets.img(
                      AppAssets.iconBack, // flipped/styled arrow
                      size: 8,
                      color: statusColor,
                    ),
                  ],
                ),
              ),
            )
          else
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              decoration: BoxDecoration(
                color: statusBg,
                border: Border.all(
                  color: statusColor,
                  width: AppDimension.pixelBorderWidth,
                ),
              ),
              child: Text(
                status.toUpperCase(),
                style: GoogleFonts.pressStart2p(
                  fontSize: 6,
                  fontWeight: FontWeight.bold,
                  color: statusColor,
                ),
              ),
            ),
          const SizedBox(width: 8),
          IconButton(
            icon: AppAssets.img(
              AppAssets.iconDelete,
              size: 20,
              color: AppColors.error,
            ),
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }
}
