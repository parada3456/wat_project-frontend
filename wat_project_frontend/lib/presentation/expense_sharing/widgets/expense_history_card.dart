import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wat_project_frontend/core/widgets/pixel_border_container.dart';
import 'package:wat_project_frontend/utils/theme_constants.dart';

class ExpenseHistoryCard extends StatelessWidget {
  final String title;
  final String date;
  final double amount;
  final String category;
  final bool isOwner;

  const ExpenseHistoryCard({
    super.key,
    required this.title,
    required this.date,
    required this.amount,
    required this.category,
    this.isOwner = false,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = AppColors.text(context);
    final subtextColor = AppColors.textSub(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final borderColor = AppColors.border(context);

    return PixelBorderContainer(
      padding: const EdgeInsets.all(AppDimension.space12),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.15),
              border: Border.all(
                color: AppColors.primary,
                width: AppDimension.pixelBorderWidth,
              ),
            ),
            alignment: Alignment.center,
            child: AppAssets.img(
              _getCategoryIcon(category),
              color: AppColors.primary,
              size: 20,
            ),
          ),
          const SizedBox(width: AppDimension.space12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title.toUpperCase(),
                  style: GoogleFonts.notoSansThai(
                    fontSize: 7,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                    height: 1.4,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  date.toUpperCase(),
                  style: GoogleFonts.notoSansThai(
                    fontSize: 6,
                    color: subtextColor,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '\$${amount.toStringAsFixed(2)}',
                style: GoogleFonts.notoSansThai(
                  fontSize: 7,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              if (isOwner) ...[
                const SizedBox(height: 4),
                Text(
                  'YOU PAID',
                  style: GoogleFonts.notoSansThai(
                    fontSize: 5,
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  String _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'food':
        return AppAssets.iconCart;
      case 'housing':
        return AppAssets.iconHome;
      case 'travel':
        return AppAssets.iconLocation;
      default:
        return AppAssets.iconExpenses;
    }
  }
}
