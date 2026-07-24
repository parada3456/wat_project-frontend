import 'package:flutter/material.dart';
import 'package:wat_project_frontend/core/utils/theme_constants.dart';

class MissionFilterAndToggleRow extends StatelessWidget {
  final String selectedTab;
  final String selectedFilter;
  final String exploreSort;
  final String exploreTypeFilter;
  final String selectedView;
  final ValueChanged<String> onFilterChanged;
  final ValueChanged<String> onExploreSortChanged;
  final ValueChanged<String> onExploreTypeFilterChanged;
  final ValueChanged<String> onViewChanged;

  const MissionFilterAndToggleRow({
    super.key,
    required this.selectedTab,
    required this.selectedFilter,
    required this.exploreSort,
    required this.exploreTypeFilter,
    required this.selectedView,
    required this.onFilterChanged,
    required this.onExploreSortChanged,
    required this.onExploreTypeFilterChanged,
    required this.onViewChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isExplore = selectedTab == 'explore';
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (!isExplore)
          Row(
            children: [
              _buildFilterPill(
                'recommended',
                selectedFilter == 'recommended',
                () => onFilterChanged(
                  selectedFilter == 'recommended' ? 'all' : 'recommended',
                ),
              ),
              const SizedBox(width: 8),
              _buildFilterPill(
                'personal',
                selectedFilter == 'personal',
                () => onFilterChanged(
                  selectedFilter == 'personal' ? 'all' : 'personal',
                ),
              ),
            ],
          )
        else
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    if (exploreSort == 'none') {
                      onExploreSortChanged('asc');
                    } else if (exploreSort == 'asc') {
                      onExploreSortChanged('desc');
                    } else {
                      onExploreSortChanged('none');
                    }
                  },
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: exploreSort != 'none'
                          ? AppColors.primary
                          : AppColors.surface,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          exploreSort == 'desc'
                              ? Icons.arrow_downward
                              : Icons.arrow_upward,
                          size: 14,
                          color: exploreSort != 'none'
                              ? Colors.white
                              : AppColors.textPrimary,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Due Date',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: exploreSort != 'none'
                                ? Colors.white
                                : AppColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                _buildFilterPill(
                  'All',
                  exploreTypeFilter == 'all',
                  () => onExploreTypeFilterChanged('all'),
                ),
                const SizedBox(width: 6),
                _buildFilterPill(
                  'Mandatory',
                  exploreTypeFilter == 'mandatory',
                  () => onExploreTypeFilterChanged('mandatory'),
                ),
                const SizedBox(width: 6),
                _buildFilterPill(
                  'Optional',
                  exploreTypeFilter == 'optional',
                  () => onExploreTypeFilterChanged('optional'),
                ),
              ],
            ),
          ),
        Container(
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () => onViewChanged('list'),
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: selectedView == 'list'
                        ? Colors.white
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Icon(
                    Icons.list_alt,
                    size: 20,
                    color: selectedView == 'list'
                        ? Colors.black
                        : Colors.grey[600],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => onViewChanged('calendar'),
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: selectedView == 'calendar'
                        ? Colors.white
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Icon(
                    Icons.calendar_month,
                    size: 20,
                    color: selectedView == 'calendar'
                        ? Colors.black
                        : Colors.grey[600],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFilterPill(String label, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.textPrimary : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppColors.textPrimary : Colors.grey[300]!,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.white : Colors.grey[700],
          ),
        ),
      ),
    );
  }
}
