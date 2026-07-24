import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wat_project_frontend/di/inject.dart';
import 'package:wat_project_frontend/domain/ui_status/ui_status.dart';
import 'package:wat_project_frontend/presentation/auth_profile/profile/bloc/profile_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wat_project_frontend/presentation/journey_gamification/widgets/credit_history_row.dart';
import 'package:wat_project_frontend/core/utils/theme_constants.dart';

class CreditHistoryPage extends StatelessWidget {
  const CreditHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileBloc>(
      create: (context) => getIt<ProfileBloc>()..add(const GetProfileEvent()),
      child: Scaffold(
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
          child: BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              if (state.status is UILoading) {
                return const Center(
                  child: CircularProgressIndicator(color: AppColors.primary),
                );
              }

              if (state.status is UILoadFailed) {
                final failure = state.status as UILoadFailed;
                return Center(
                  child: Text(
                    failure.message ?? 'Failed to load credit history',
                    style: const TextStyle(color: AppColors.textSecondary),
                  ),
                );
              }

              final history = state.creditHistory;
              final score = state.profile?.creditScore?.currentScore ?? 0;

              return Column(
                children: [
                  Container(
                    width: double.infinity,
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
                        Text(
                          '$score',
                          style: const TextStyle(
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
                          child: Text(
                            score >= 700
                                ? 'Excellent'
                                : (score >= 500
                                    ? 'Good'
                                    : 'Needs Improvement'),
                            style: const TextStyle(
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
                    child: history.isEmpty
                        ? const Center(
                            child: Text(
                              'No credit history records',
                              style:
                                  TextStyle(color: AppColors.textSecondary),
                            ),
                          )
                        : ListView.separated(
                            padding:
                                const EdgeInsets.all(AppDimension.space16),
                            itemCount: history.length,
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: AppDimension.space8),
                            itemBuilder: (context, index) {
                              final item = history[index];
                              return CreditHistoryRow(
                                title: item.note ?? item.sourceType.name,
                                date: item.createdAt
                                    .toIso8601String()
                                    .split('T')
                                    .first,
                                delta: item.delta,
                              );
                            },
                          ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

