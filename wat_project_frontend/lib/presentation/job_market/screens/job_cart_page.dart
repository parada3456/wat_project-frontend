import 'package:flutter/material.dart';
import 'package:wat_project_frontend/presentation/job_market/widgets/job_cart_item_tile.dart';
import 'package:wat_project_frontend/utils/theme_constants.dart';

class JobCartPage extends StatelessWidget {
  const JobCartPage({super.key});

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
          'My Cart',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SafeArea(
        child: ListView.separated(
          padding: const EdgeInsets.all(AppDimension.space16),
          itemCount: 3,
          separatorBuilder: (context, index) =>
              const SizedBox(height: AppDimension.space8),
          itemBuilder: (context, index) {
            final titles = ['Lifeguard', 'Housekeeping', 'Server'];
            final companies = ['Disney World', 'Hilton', 'Bubba Gump'];
            final statuses = ['Applied', 'Saved', 'Saved'];
            return JobCartItemTile(
              title: titles[index],
              company: companies[index],
              status: statuses[index],
              onDelete: () {},
            );
          },
        ),
      ),
    );
  }
}
