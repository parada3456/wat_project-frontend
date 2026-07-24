import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:wat_project_frontend/core/widgets/app_popup.dart';
import 'package:wat_project_frontend/domain/models/job_models.dart';
import 'package:wat_project_frontend/domain/ui_status/ui_status.dart';
import 'package:wat_project_frontend/presentation/job_market/bloc/job_market_bloc.dart';
import 'package:wat_project_frontend/core/utils/theme_constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wat_project_frontend/core/widgets/pixel_border_container.dart';
import 'package:wat_project_frontend/domain/models/job_models.dart';
import 'package:wat_project_frontend/domain/ui_status/ui_status.dart';
import 'package:wat_project_frontend/presentation/job_market/bloc/job_market_bloc.dart';
import 'package:wat_project_frontend/core/widgets/app_popup.dart';
import 'package:wat_project_frontend/presentation/widgets/wat_button.dart';
import 'package:wat_project_frontend/core/utils/theme_constants.dart';

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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = AppColors.bg(context);
    final textColor = AppColors.text(context);
    final subtextColor = AppColors.textSub(context);

    return BlocProvider.value(
      value: _bloc,
      child: BlocListener<JobMarketBloc, JobMarketState>(
        listenWhen: (previous, current) =>
            previous.status != current.status ||
            previous.removeFromCartStatus != current.removeFromCartStatus ||
            previous.updateCartStatus != current.updateCartStatus,
        listener: (context, state) {
          if (state.status is UILoadFailed) {
            final msg =
                (state.status as UILoadFailed).message ??
                'An error occurred loading your cart.';
            _showErrorPopup(context, msg);
          }
          if (state.removeFromCartStatus is UILoadFailed) {
            final msg =
                (state.removeFromCartStatus as UILoadFailed).message ??
                'Failed to remove job.';
            _showErrorPopup(context, msg);
          }
          if (state.updateCartStatus is UILoadFailed) {
            final msg =
                (state.updateCartStatus as UILoadFailed).message ??
                'Failed to update status.';
            _showErrorPopup(context, msg);
          }
          if (state.removeFromCartStatus is UILoadSuccess) {
            setState(_selectedJobIds.clear);
            _bloc.add(const JobMarketEvent.listCartItems());
          }
          if (state.updateCartStatus is UILoadSuccess) {
            _bloc.add(const JobMarketEvent.listCartItems());
          }
        },
        child: Scaffold(
          backgroundColor: bgColor,
          appBar: AppBar(
            leading: IconButton(
              icon: AppAssets.img(AppAssets.iconBack, size: 20, color: textColor),
              onPressed: () => context.pop(),
            ),
            title: const Text('MY CART'),
          ),
          bottomNavigationBar: _selectedJobIds.isEmpty
              ? null
              : SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(AppDimension.space12),
                    child: WatButton(
                      label: _selectedJobIds.length < 2
                          ? 'SELECT 2+ TO COMPARE'
                          : 'COMPARE SELECTED (${_selectedJobIds.length})',
                      onPressed: _selectedJobIds.length < 2
                          ? null
                          : () {
                              final idsParam = _selectedJobIds.join(',');
                              context.push(
                                '/jobs/compare?ids=$idsParam',
                                extra: _selectedJobIds.toList(),
                              );
                            },
                    ),
                  ),
                ),
          body: BlocBuilder<JobMarketBloc, JobMarketState>(
            builder: (context, state) {
              if (state.status is UILoading && state.cartItems.isEmpty) {
                return const Center(child: PixelLoadingDots(color: AppColors.primary));
              }

              if (state.cartItems.isEmpty) {
                return Center(
                  child: Text(
                    'YOUR CART IS EMPTY.',
                    style: GoogleFonts.notoSansThai(
                      fontSize: 12,
                      color: subtextColor,
                    ),
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

                    final job = state.jobs.firstWhere(
                      (j) => j.jobId == item.jobId,
                      orElse: () => JobPostingModel(
                        jobId: item.jobId,
                        position: 'Saved Job Posting',
                        employerTitle: 'Job Info Loading...',
                        updatedAt: DateTime.now(),
                      ),
                    );

                    final isApplied = item.status == CartStatus.applied;
                    final statusBg = isApplied
                        ? AppColors.success.withValues(alpha: 0.15)
                        : AppColors.primary.withValues(alpha: 0.15);
                    final statusColor = isApplied ? AppColors.success : AppColors.primary;

                    return PixelBorderContainer(
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
                          const SizedBox(width: 4),
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
                                          (job.position ?? 'UNKNOWN POSITION').toUpperCase(),
                                          style: GoogleFonts.notoSansThai(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: textColor,
                                            height: 1.4,
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                        icon: AppAssets.img(
                                          AppAssets.iconDelete,
                                          size: 20,
                                          color: AppColors.error,
                                        ),
                                        onPressed: () => _bloc.add(
                                          JobMarketEvent.removeJobFromCart(cartItemId: item.cartId),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    (job.employerTitle ?? 'UNKNOWN EMPLOYER').toUpperCase(),
                                    style: GoogleFonts.notoSansThai(
                                      fontSize: 11,
                                      color: subtextColor,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Row(
                                    children: [
                                      AppAssets.img(
                                        AppAssets.iconLocation,
                                        size: 14,
                                        color: subtextColor,
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        '${job.locationCity ?? 'N/A'}, ${job.locationState ?? 'N/A'}'.toUpperCase(),
                                        style: GoogleFonts.notoSansThai(
                                          fontSize: 11,
                                          color: subtextColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 6),
                                  Row(
                                    children: [
                                      AppAssets.img(
                                        AppAssets.iconSalary,
                                        size: 14,
                                        color: AppColors.success,
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        '\$${job.salaryRangeMin.toStringAsFixed(2)} - \$${job.salaryRangeMax.toStringAsFixed(2)}/HR',
                                        style: GoogleFonts.notoSansThai(
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.success,
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
                                        color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
                                        itemBuilder: (context) => [
                                          PopupMenuItem(
                                            value: 'Saved',
                                            child: Text(
                                              'SAVED',
                                              style: GoogleFonts.notoSansThai(fontSize: 11, color: textColor),
                                            ),
                                          ),
                                          PopupMenuItem(
                                            value: 'Applied',
                                            child: Text(
                                              'APPLIED',
                                              style: GoogleFonts.notoSansThai(fontSize: 11, color: textColor),
                                            ),
                                          ),
                                        ],
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                          decoration: BoxDecoration(
                                            color: statusBg,
                                            border: Border.all(
                                              color: statusColor,
                                              width: AppDimension.pixelBorderWidth,
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                item.status.name.toUpperCase(),
                                                style: GoogleFonts.notoSansThai(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.bold,
                                                  color: statusColor,
                                                ),
                                              ),
                                              const SizedBox(width: 4),
                                              AppAssets.img(
                                                AppAssets.iconBack, // flipped arrow helper
                                                size: 10,
                                                color: statusColor,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      if (job.usSponsor)
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                                          decoration: BoxDecoration(
                                            color: Colors.blue.withValues(alpha: 0.15),
                                            border: Border.all(
                                              color: Colors.blue,
                                              width: AppDimension.pixelBorderWidth,
                                            ),
                                          ),
                                          child: Text(
                                            'SPONSOR',
                                            style: GoogleFonts.notoSansThai(
                                              fontSize: 11,
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
          onPressed: () => context.pop(),
        )
      ],
    );
  }
}
