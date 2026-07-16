import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wat_project_frontend/presentation/journey_gamification/widgets/credit_history_row.dart';
import 'package:wat_project_frontend/utils/theme_constants.dart';

class CreditHistoryPage extends StatelessWidget {
  const CreditHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = AppColors.text(context);
    final subtextColor = AppColors.textSub(context);

    return Scaffold(
      backgroundColor: AppColors.bg(context),
      appBar: AppBar(
        leading: IconButton(
          icon: AppAssets.img(AppAssets.iconBack, size: 20, color: textColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('CREDIT HISTORY'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimension.space16,
                vertical: AppDimension.space24,
              ),
              color: isDark ? AppColors.darkSurfaceAlt : AppColors.lightSurfaceAlt,
              child: Column(
                children: [
                  Text(
                    'CURRENT SCORE',
                    style: GoogleFonts.notoSansThai(
                      fontSize: 8,
                      color: subtextColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '850',
                    style: GoogleFonts.notoSansThai(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: AppDimension.space12),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.success.withValues(alpha: 0.15),
                      border: Border.all(
                        color: AppColors.success,
                        width: AppDimension.pixelBorderWidth,
                      ),
                    ),
                    child: Text(
                      'EXCELLENT',
                      style: GoogleFonts.notoSansThai(
                        fontSize: 6,
                        fontWeight: FontWeight.bold,
                        color: AppColors.success,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(AppDimension.space16),
                itemCount: 5,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: AppDimension.space8),
                itemBuilder: (context, index) {
                  final titles = [
                    'On-time Bill Payment',
                    'Mission Bonus',
                    'Late Bill Penalty',
                    'Friendship Bonus',
                    'Phase Completion',
                  ];
                  final deltas = [50, 100, -200, 20, 500];
                  return CreditHistoryRow(
                    title: titles[index],
                    date: 'June ${15 - index}, 2026',
                    delta: deltas[index],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
