import 'package:flutter/material.dart';
import 'package:wat_project_frontend/presentation/journey_gamification/widgets/credit_history_row.dart';
import 'package:wat_project_frontend/utils/theme_constants.dart';

class CreditHistoryPage extends StatelessWidget {
  const CreditHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundAlt,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Credit History',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(AppDimension.space32),
              color: AppColors.background,
              child: Column(
                children: [
                  const Text(
                    'Current Score',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const Text(
                    '850',
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: AppDimension.space8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'Excellent',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Colors.green,
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
