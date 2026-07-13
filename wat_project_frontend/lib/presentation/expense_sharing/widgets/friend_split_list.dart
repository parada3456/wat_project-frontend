import 'package:flutter/material.dart';
import 'package:wat_project_frontend/presentation/expense_sharing/widgets/friendship_mock.dart' show FriendshipMock;
import 'package:wat_project_frontend/utils/theme_constants.dart';

class FriendSplitList extends StatelessWidget {
  final List<FriendshipMock> filteredFriends;
  final Set<String> selectedFriendIds;
  final Map<String, TextEditingController> oweControllers;
  final bool equalSplit;
  final String selectedCurrency;
  final void Function(String friendId, bool isSelected) onFriendSelected;

  const FriendSplitList({
    super.key,
    required this.filteredFriends,
    required this.selectedFriendIds,
    required this.oweControllers,
    required this.equalSplit,
    required this.selectedCurrency,
    required this.onFriendSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: filteredFriends.length,
      separatorBuilder: (_, index) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final friend = filteredFriends[index];
        final isSelected = selectedFriendIds.contains(friend.userId);
        final oweController = oweControllers[friend.userId]!;

        return Container(
          padding: const EdgeInsets.symmetric(vertical: AppDimension.space8),
          child: Row(
            children: [
              Checkbox(
                value: isSelected,
                activeColor: AppColors.primary,
                onChanged: (val) {
                  onFriendSelected(friend.userId, val ?? false);
                },
              ),
              const SizedBox(width: AppDimension.space8),
              Expanded(
                child: Text(
                  friend.name,
                  style: const TextStyle(
                    fontSize: 16,
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              if (isSelected)
                SizedBox(
                  width: 110,
                  height: 44,
                  child: TextField(
                    controller: oweController,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    textAlign: TextAlign.end,
                    readOnly: equalSplit,
                    decoration: InputDecoration(
                      prefixText: selectedCurrency == 'USD' ? '\$ ' : '$selectedCurrency ',
                      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppDimension.radiusSmall),
                      ),
                      fillColor: equalSplit ? Colors.grey[100] : Colors.white,
                      filled: true,
                    ),
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
