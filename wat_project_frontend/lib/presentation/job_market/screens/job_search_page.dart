import 'package:flutter/material.dart';
import 'package:wat_project_frontend/presentation/job_market/widgets/job_card.dart';
import 'package:wat_project_frontend/presentation/widgets/wat_input_field.dart';
import 'package:wat_project_frontend/utils/theme_constants.dart';

class JobSearchPage extends StatefulWidget {
  const JobSearchPage({super.key});

  @override
  State<JobSearchPage> createState() => _JobSearchPageState();
}

class _JobSearchPageState extends State<JobSearchPage> {
  final _searchController = TextEditingController();

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
        title: const Text(
          'Marketplace',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.shopping_cart_outlined,
              color: AppColors.textPrimary,
            ),
            onPressed: () {
              // TODO: Navigate to Job Cart
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(AppDimension.space16),
              color: AppColors.background,
              child: WatInputField(
                label: 'Search Jobs',
                hint: 'Position, city, or employer...',
                controller: _searchController,
                suffixIcon: const Icon(
                  Icons.search,
                  color: AppColors.textSecondary,
                ),
              ),
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(AppDimension.space16),
                itemCount: 5,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: AppDimension.space16),
                itemBuilder: (context, index) {
                  return JobCard(
                    title: 'Position ${index + 1}',
                    company: 'Employer ${index + 1}',
                    location: 'City, State',
                    salary: 15.0 + index,
                    rating: 4.5,
                    reviewCount: 12,
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
