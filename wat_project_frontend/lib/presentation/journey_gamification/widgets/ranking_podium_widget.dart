import 'package:flutter/material.dart';
import 'package:wat_project_frontend/domain/models/gamification/user_credit_model.dart';
import 'package:wat_project_frontend/core/utils/theme_constants.dart';

class RankingPodiumWidget extends StatelessWidget {
  final List<UserCreditModel> topThree;
  final String selectedPeriod;
  final ValueChanged<String>? onPeriodChanged;

  const RankingPodiumWidget({
    super.key,
    required this.topThree,
    this.selectedPeriod = 'Day',
    this.onPeriodChanged,
  });

  @override
  Widget build(BuildContext context) {
    UserCreditModel? first;
    UserCreditModel? second;
    UserCreditModel? third;

    for (final userCredit in topThree) {
      if (userCredit.rank == 1) first = userCredit;
      if (userCredit.rank == 2) second = userCredit;
      if (userCredit.rank == 3) third = userCredit;
    }

    return Card(
      elevation: 0,
      color: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
        side: BorderSide(color: Colors.grey.withValues(alpha: 0.15)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.backgroundAlt,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedPeriod,
                    isDense: true,
                    icon: const Icon(Icons.keyboard_arrow_down, size: 18),
                    items: ['Day', 'Week', 'Month', 'All Time']
                        .map(
                          (period) => DropdownMenuItem(
                            value: period,
                            child: Text(
                              period,
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (val) {
                      if (val != null && onPeriodChanged != null) {
                        onPeriodChanged!(val);
                      }
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _buildPodiumColumn(
                  context,
                  item: second,
                  rank: 2,
                  podiumHeight: 120,
                  podiumColor: const Color(0xFFEE8A68),
                ),
                _buildPodiumColumn(
                  context,
                  item: first,
                  rank: 1,
                  podiumHeight: 160,
                  podiumColor: const Color(0xFF8B6BFA),
                ),
                _buildPodiumColumn(
                  context,
                  item: third,
                  rank: 3,
                  podiumHeight: 100,
                  podiumColor: const Color(0xFFEE8A68),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPodiumColumn(
    BuildContext context, {
    required UserCreditModel? item,
    required int rank,
    required double podiumHeight,
    required Color podiumColor,
  }) {
    final name = item?.name ?? '---';
    final score = item?.creditScore ?? 0;
    final avatarUrl = item?.avatarUrl;

    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          CircleAvatar(
            radius: rank == 1 ? 32 : 28,
            backgroundColor: podiumColor.withValues(alpha: 0.2),
            backgroundImage:
                (avatarUrl != null && avatarUrl.isNotEmpty) ? NetworkImage(avatarUrl) : null,
            child: (avatarUrl == null || avatarUrl.isEmpty)
                ? Text(
                    name.isNotEmpty ? name[0].toUpperCase() : '?',
                    style: TextStyle(
                      fontSize: rank == 1 ? 20 : 16,
                      fontWeight: FontWeight.bold,
                      color: podiumColor,
                    ),
                  )
                : null,
          ),
          const SizedBox(height: 8),
          Text(
            name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.topCenter,
            children: [
              Container(
                height: podiumHeight,
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  color: podiumColor,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  '$rank',
                  style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
              ),
              Positioned(
                top: -16,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.star,
                        size: 14,
                        color: Color(0xFFFFB800),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '$score',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
