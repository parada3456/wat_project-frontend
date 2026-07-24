import 'package:flutter/material.dart';
import 'package:wat_project_frontend/core/utils/theme_constants.dart';

class ReviewStarsRow extends StatelessWidget {
  final double rating;
  final double size;
  final bool isInteractive;
  final ValueChanged<double>? onRatingChanged;

  const ReviewStarsRow({
    super.key,
    required this.rating,
    this.size = 20,
    this.isInteractive = false,
    this.onRatingChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        final starRating = index + 1.0;
        final isFilled = rating >= starRating || (rating >= starRating - 0.5);

        return GestureDetector(
          onTap: isInteractive ? () => onRatingChanged?.call(starRating) : null,
          child: Padding(
            padding: const EdgeInsets.only(right: 2.0),
            child: AppAssets.img(
              isFilled ? AppAssets.iconStar : AppAssets.iconStarEmpty,
              size: size,
              color: isFilled ? AppColors.secondary : Colors.grey[500],
            ),
          ),
        );
      }),
    );
  }
}
