import 'package:flutter/material.dart';
import 'package:wat_project_frontend/utils/theme_constants.dart';
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
        IconData icon;
        Color color;

        if (rating >= starRating) {
          icon = Icons.star;
          color = Colors.orange;
        } else if (rating >= starRating - 0.5) {
          icon = Icons.star_half;
          color = Colors.orange;
        } else {
          icon = Icons.star_border;
          color = AppColors.secondary;
        }

        return GestureDetector(
          onTap: isInteractive ? () => onRatingChanged?.call(starRating) : null,
          child: Icon(icon, size: size, color: color),
        );
      }),
    );
  }
}
