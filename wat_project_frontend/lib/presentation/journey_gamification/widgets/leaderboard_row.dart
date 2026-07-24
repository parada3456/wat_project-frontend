import 'package:flutter/material.dart';
import 'package:wat_project_frontend/core/utils/theme_constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wat_project_frontend/core/widgets/pixel_border_container.dart';
import 'package:wat_project_frontend/core/utils/theme_constants.dart';

class LeaderboardRow extends StatelessWidget {
  final int rank;
  final String name;
  final int points;
  final String? avatarUrl;
  final bool isCurrentUser;

  const LeaderboardRow({
    super.key,
    required this.rank,
    required this.name,
    required this.points,
    this.avatarUrl,
    this.isCurrentUser = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = AppColors.text(context);
    final subtextColor = AppColors.textSub(context);
    final borderColor = AppColors.border(context);

    final Color rankColor = rank == 1
        ? AppColors.secondary
        : rank == 2
            ? Colors.grey[400]!
            : rank == 3
                ? Colors.brown[300]!
                : subtextColor;

    return PixelBorderContainer(
      borderColor: isCurrentUser ? AppColors.primary : borderColor,
      backgroundColor: isCurrentUser
          ? AppColors.primary.withValues(alpha: 0.15)
          : (isDark ? AppColors.darkSurface : AppColors.lightSurface),
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimension.space12,
        vertical: AppDimension.space8,
      ),
      child: Row(
        children: [
          SizedBox(
            width: 24,
            child: Text(
              '$rank',
              style: GoogleFonts.notoSansThai(
                fontSize: 8,
                fontWeight: FontWeight.bold,
                color: rankColor,
              ),
            ),
          ),
          const SizedBox(width: 4),
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: isDark ? AppColors.darkSurfaceAlt : AppColors.lightSurfaceAlt,
              border: Border.all(
                color: borderColor,
                width: AppDimension.pixelBorderWidth,
              ),
              image: avatarUrl != null && avatarUrl!.isNotEmpty
                  ? DecorationImage(
                      image: NetworkImage(avatarUrl!),
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
            alignment: Alignment.center,
            child: avatarUrl == null || avatarUrl!.isEmpty
                ? AppAssets.img(
                    AppAssets.iconCharacter,
                    size: 16,
                    color: textColor,
                  )
                : null,
          ),
          const SizedBox(width: AppDimension.space12),
          Expanded(
            child: Text(
              name.toUpperCase(),
              style: GoogleFonts.notoSansThai(
                fontSize: 7,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            '$points PTS',
            style: GoogleFonts.notoSansThai(
              fontSize: 7,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}
