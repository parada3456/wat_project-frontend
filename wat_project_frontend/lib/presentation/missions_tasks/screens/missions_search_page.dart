import 'package:flutter/material.dart';
import 'package:wat_project_frontend/presentation/missions_tasks/widgets/mission_card.dart';
import 'package:wat_project_frontend/presentation/widgets/wat_input_field.dart';
import 'package:wat_project_frontend/utils/theme_constants.dart';

class MissionsSearchPage extends StatefulWidget {
  const MissionsSearchPage({super.key});

  @override
  State<MissionsSearchPage> createState() => _MissionsSearchPageState();
}

class _MissionsSearchPageState extends State<MissionsSearchPage> {
  final _searchController = TextEditingController();
  String _selectedFilter = 'All';

  final List<String> _filters = ['All', 'Mandatory', 'Completed', 'Overdue'];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

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
          'Search Missions',
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
              padding: const EdgeInsets.all(AppDimension.space16),
              color: AppColors.background,
              child: Column(
                children: [
                  WatInputField(
                    label: 'Search',
                    hint: 'Search missions...',
                    controller: _searchController,
                    suffixIcon: const Icon(Icons.search, color: AppColors.textSecondary),
                  ),
                  const SizedBox(height: AppDimension.space16),
                  SizedBox(
                    height: 40,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: _filters.length,
                      separatorBuilder: (context, index) => const SizedBox(width: AppDimension.space8),
                      itemBuilder: (context, index) {
                        final filter = _filters[index];
                        final isSelected = _selectedFilter == filter;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedFilter = filter;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: AppDimension.space16),
                            decoration: BoxDecoration(
                              color: isSelected ? AppColors.primary : AppColors.surfaceAlt,
                              borderRadius: BorderRadius.circular(AppDimension.radiusExtraLarge),
                            ),
                            child: Center(
                              child: Text(
                                filter,
                                style: TextStyle(
                                  color: isSelected ? AppColors.white : AppColors.textSecondary,
                                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(AppDimension.space16),
                itemCount: 2,
                separatorBuilder: (context, index) => const SizedBox(height: AppDimension.space16),
                itemBuilder: (context, index) {
                  return const MissionCard(
                    title: 'Search Result Mission',
                    deadline: 'July 1',
                    bonusPoints: 100,
                    progress: 0.5,
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
