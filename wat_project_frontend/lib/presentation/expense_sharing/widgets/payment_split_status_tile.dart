import 'package:flutter/material.dart';
import 'package:wat_project_frontend/core/utils/theme_constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wat_project_frontend/core/widgets/pixel_border_container.dart';
import 'package:wat_project_frontend/core/utils/theme_constants.dart';

class PaymentSplitStatusTile extends StatelessWidget {
  final String name;
  final double amount;
  final String status;

  const PaymentSplitStatusTile({
    super.key,
    required this.name,
    required this.amount,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final isPaid = status.toLowerCase() == 'paid';
    final textColor = AppColors.text(context);
    final subtextColor = AppColors.textSub(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final borderColor = AppColors.border(context);

    return PixelBorderContainer(
      padding: const EdgeInsets.all(AppDimension.space12),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: isDark ? AppColors.darkSurfaceAlt : AppColors.lightSurfaceAlt,
              border: Border.all(
                color: borderColor,
                width: AppDimension.pixelBorderWidth,
              ),
            ),
            alignment: Alignment.center,
            child: AppAssets.img(
              AppAssets.iconCharacter,
              size: 16,
              color: textColor,
            ),
          ),
          const SizedBox(width: AppDimension.space12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name.toUpperCase(),
                  style: GoogleFonts.notoSansThai(
                    fontSize: 7,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  isPaid ? 'PAID' : 'PENDING',
                  style: GoogleFonts.notoSansThai(
                    fontSize: 6,
                    color: isPaid ? AppColors.success : subtextColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text(
            '\$${amount.toStringAsFixed(2)}',
            style: GoogleFonts.notoSansThai(
              fontSize: 7,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}
