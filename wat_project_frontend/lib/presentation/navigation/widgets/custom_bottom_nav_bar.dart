import 'package:flutter/material.dart';
import 'package:wat_project_frontend/core/extension/extension.dart';
import 'package:wat_project_frontend/utils/theme_constants.dart';

/// CustomBottomNavBar — Pixel RPG map toolbar.
/// Hard-edged panel with top pixel border, asset-based icons, and
/// a solid tile highlight for the active tab.
class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  static const _tabs = [
    _NavTab(label: 'HOME', activeIcon: AppAssets.iconHomeActive, icon: AppAssets.iconHome),
    _NavTab(label: 'JOURNEY', activeIcon: AppAssets.iconMapActive, icon: AppAssets.iconMap),
    _NavTab(label: 'EXPENSES', activeIcon: AppAssets.iconExpensesActive, icon: AppAssets.iconExpenses),
    _NavTab(label: 'JOBS', activeIcon: AppAssets.iconJobsActive, icon: AppAssets.iconJobs),
    _NavTab(label: 'PROFILE', activeIcon: AppAssets.iconProfileActive, icon: AppAssets.iconProfile),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? AppColors.darkBackground : AppColors.lightNavBar;
    final borderColor = isDark ? AppColors.darkBorder : AppColors.lightBorder;

    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        border: Border(
          top: BorderSide(
            color: borderColor,
            width: AppDimension.pixelBorderWidth,
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 64,
          child: Row(
            children: List.generate(_tabs.length, (i) {
              return Expanded(
                child: _PixelNavItem(
                  tab: _tabs[i],
                  isSelected: currentIndex == i,
                  onTap: () => onTap(i),
                  borderColor: borderColor,
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class _NavTab {
  final String label;
  final String icon;
  final String activeIcon;
  const _NavTab({
    required this.label,
    required this.icon,
    required this.activeIcon,
  });
}

class _PixelNavItem extends StatelessWidget {
  final _NavTab tab;
  final bool isSelected;
  final VoidCallback onTap;
  final Color borderColor;

  const _PixelNavItem({
    required this.tab,
    required this.isSelected,
    required this.onTap,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final activeColor = AppColors.primary;
    final inactiveColor =
        isDark ? AppColors.darkTextSecondary : AppColors.lightBorder;
    final selectedBg = activeColor.withValues(alpha: isDark ? 0.15 : 0.1);

    return Semantics(
      label: '${tab.label} tab',
      selected: isSelected,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 120),
          decoration: BoxDecoration(
            color: isSelected ? selectedBg : Colors.transparent,
            border: isSelected
                ? Border(
                    top: BorderSide(
                      color: activeColor,
                      width: AppDimension.pixelBorderWidth,
                    ),
                  )
                : null,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppAssets.img(
                isSelected ? tab.activeIcon : tab.icon,
                size: 24,
                color: null,
              ),
              const SizedBox(height: AppDimension.space4),
              Text(
                tab.label,
                style: context.textTheme.labelSmall?.copyWith(color: isSelected ? activeColor : inactiveColor,),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
