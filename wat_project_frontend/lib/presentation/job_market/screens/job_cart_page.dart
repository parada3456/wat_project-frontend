import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:wat_project_frontend/domain/models/job_models.dart';
import 'package:wat_project_frontend/domain/ui_status/ui_status.dart';
import 'package:wat_project_frontend/presentation/job_market/bloc/job_market_bloc.dart';
import 'package:wat_project_frontend/core/widgets/app_popup.dart';
import 'package:wat_project_frontend/utils/theme_constants.dart';

class JobCartPage extends StatefulWidget {
  const JobCartPage({super.key});

  @override
  State<JobCartPage> createState() => _JobCartPageState();
}

class _JobCartPageState extends State<JobCartPage> {
  late final JobMarketBloc _bloc;
  final Set<String> _selectedJobIds = {};

  @override
  void initState() {
    super.initState();
    _bloc = GetIt.instance<JobMarketBloc>();
    _bloc.add(const JobMarketEvent.listCartItems());
    _bloc.add(const JobMarketEvent.listJobs(filters: {}));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bloc,
      child: BlocListener<JobMarketBloc, JobMarketState>(
        listenWhen: (previous, current) =>
            previous.status != current.status ||
            previous.removeFromCartStatus != current.removeFromCartStatus ||
            previous.updateCartStatus != current.updateCartStatus,
        listener: (context, state) {
          // 1. Check for Load Failures across different operations
          if (state.status is UILoadFailed) {
            final msg = (state.status as UILoadFailed).message ?? 'An error occurred loading your cart.';
            _showErrorPopup(context, msg);
          }
          
          if (state.removeFromCartStatus is UILoadFailed) {
            final msg = (state.removeFromCartStatus as UILoadFailed).message ?? 'Failed to remove job.';
            _showErrorPopup(context, msg);
          }
          
          if (state.updateCartStatus is UILoadFailed) {
            final msg = (state.updateCartStatus as UILoadFailed).message ?? 'Failed to update status.';
            _showErrorPopup(context, msg);
          }

          // 2. Clean up selections and refresh on success
          if (state.removeFromCartStatus is UILoadSuccess) {
            setState(_selectedJobIds.clear);
            _bloc.add(const JobMarketEvent.listCartItems());
          }
          if (state.updateCartStatus is UILoadSuccess) {
            _bloc.add(const JobMarketEvent.listCartItems());
          }
        },
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
              'My Cart',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          bottomNavigationBar: _selectedJobIds.isEmpty
              ? null
              : SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(AppDimension.space16),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: AppColors.white,
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppDimension.radiusMedium),
                        ),
                        elevation: 0,
                      ),
                      onPressed: _selectedJobIds.length < 2
                          ? null
                          : () {
                              final idsParam = _selectedJobIds.join(',');
                              context.push(
                                '/jobs/compare?ids=$idsParam',
                                extra: _selectedJobIds.toList(),
                              );
                            },
                      child: Text(
                        _selectedJobIds.length < 2
                            ? 'Select at least 2 jobs to compare (${_selectedJobIds.length} selected)'
                            : 'Compare Selected (${_selectedJobIds.length})',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
          body: BlocBuilder<JobMarketBloc, JobMarketState>(
            builder: (context, state) {
              if (state.status is UILoading && state.cartItems.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }
              
              if (state.cartItems.isEmpty) {
                return const Center(
                  child: Text(
                    'Your cart is empty.',
                    style: TextStyle(color: AppColors.textSecondary),
                  ),
                );
              }

              return SafeArea(
                child: ListView.separated(
                  padding: const EdgeInsets.all(AppDimension.space16),
                  itemCount: state.cartItems.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: AppDimension.space12),
                  itemBuilder: (context, index) {
                    final item = state.cartItems[index];
                    
                    // Match corresponding job info
                    final job = state.jobs.firstWhere(
                      (j) => j.jobId == item.jobId,
                      orElse: () => JobPostingModel(
                        jobId: item.jobId,
                        position: 'Saved Job Posting',
                        employerTitle: 'Job Info Loading...',
                        updatedAt: DateTime.now(),
                      ),
                    );

                    return Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppDimension.radiusMedium),
                      ),
                      color: AppColors.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppDimension.space12,
                          vertical: AppDimension.space16,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Checkbox(
                                value: _selectedJobIds.contains(item.jobId),
                                activeColor: AppColors.primary,
                                onChanged: (checked) {
                                  setState(() {
                                    if (checked == true) {
                                      _selectedJobIds.add(item.jobId);
                                    } else {
                                      _selectedJobIds.remove(item.jobId);
                                    }
                                  });
                                },
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: InkWell(
                                onTap: () => context.push('/jobs/${item.jobId}'),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            job.position ?? 'Unknown Position',
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.textPrimary,
                                            ),
                                          ),
                                        ),
                                        IconButton(
                                          icon: const Icon(
                                            Icons.delete_outline,
                                            color: AppColors.error,
                                            size: 22,
                                          ),
                                          onPressed: () => _bloc.add(
                                            JobMarketEvent.removeJobFromCart(cartItemId: item.cartId),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      job.employerTitle ?? 'Unknown Employer',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    Row(
                                      children: [
                                        const Icon(Icons.location_on_outlined, size: 16, color: AppColors.primary),
                                        const SizedBox(width: 4),
                                        Text(
                                          '${job.locationCity ?? 'N/A'}, ${job.locationState ?? 'N/A'}',
                                          style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 6),
                                    Row(
                                      children: [
                                        const Icon(Icons.monetization_on_outlined, size: 16, color: Colors.green),
                                        const SizedBox(width: 4),
                                        Text(
                                          '\$${job.salaryRangeMin.toStringAsFixed(2)} - \$${job.salaryRangeMax.toStringAsFixed(2)}/hr',
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.green,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 16),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        PopupMenuButton<String>(
                                          onSelected: (newStatus) => _bloc.add(
                                            JobMarketEvent.updateCartStatus(
                                              cartId: item.cartId,
                                              status: newStatus,
                                            ),
                                          ),
                                          itemBuilder: (context) => [
                                            const PopupMenuItem(
                                              value: 'Saved',
                                              child: Text('Saved'),
                                            ),
                                            const PopupMenuItem(
                                              value: 'Applied',
                                              child: Text('Applied'),
                                            ),
                                          ],
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                            decoration: BoxDecoration(
                                              color: item.status == CartStatus.applied
                                                  ? Colors.green.withValues(alpha: 0.1)
                                                  : AppColors.primary.withValues(alpha: 0.1),
                                              borderRadius: BorderRadius.circular(12),
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  item.status.name[0].toUpperCase() + item.status.name.substring(1),
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                    color: item.status == CartStatus.applied
                                                        ? Colors.green
                                                        : AppColors.primary,
                                                  ),
                                                ),
                                                const SizedBox(width: 4),
                                                Icon(
                                                  Icons.arrow_drop_down,
                                                  size: 14,
                                                  color: item.status == CartStatus.applied
                                                      ? Colors.green
                                                      : AppColors.primary,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        if (job.usSponsor)
                                          Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                            decoration: BoxDecoration(
                                              color: Colors.blue.withValues(alpha: 0.1),
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            child: const Text(
                                              'Sponsor',
                                              style: TextStyle(
                                                fontSize: 10,
                                                color: Colors.blue,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _showErrorPopup(BuildContext context, String message) {
    AppPopup.show<void>(
      context: context,
      type: AppPopupType.error,
      title: 'Error',
      message: message,
      buttons: [
        AppPopupButton(
          label: 'OK', 
          onPressed: () => Navigator.pop(context),
        )
      ],
    );
  }
}