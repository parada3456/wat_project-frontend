import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:wat_project_frontend/domain/models/job_models.dart';
import 'package:wat_project_frontend/domain/ui_status/ui_status.dart';
import 'package:wat_project_frontend/presentation/job_market/bloc/job_market_bloc.dart';
import 'package:wat_project_frontend/presentation/job_market/widgets/job_cart_item_tile.dart';
import 'package:wat_project_frontend/core/widgets/app_popup.dart';
import 'package:wat_project_frontend/utils/theme_constants.dart';

class JobCartPage extends StatefulWidget {
  const JobCartPage({super.key});

  @override
  State<JobCartPage> createState() => _JobCartPageState();
}

class _JobCartPageState extends State<JobCartPage> {
  late final JobMarketBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = GetIt.instance<JobMarketBloc>();
    _bloc.add(const JobMarketEvent.listCartItems());
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

          // 2. Trigger fresh fetch only if mutations successfully finish
          if (state.removeFromCartStatus is UILoadSuccess || state.updateCartStatus is UILoadSuccess) {
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
          body: BlocBuilder<JobMarketBloc, JobMarketState>(
            builder: (context, state) {
              // Show loader only if status is loading AND no data exists yet (prevents shifting layouts)
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
                  separatorBuilder: (_, __) =>
                      const SizedBox(height: AppDimension.space8),
                  itemBuilder: (context, index) {
                    final item = state.cartItems[index];
                    return JobCartItemTile(
                      title: 'Job #${item.jobId.substring(0, item.jobId.length > 8 ? 8 : item.jobId.length)}',
                      company: 'Saved Job Posting',
                      status: item.status.name[0].toUpperCase() + item.status.name.substring(1),
                      onDelete: () => _bloc.add(
                        JobMarketEvent.removeJobFromCart(cartItemId: item.cartId),
                      ),
                      onStatusChanged: (newStatus) => _bloc.add(
                        JobMarketEvent.updateCartStatus(
                          cartId: item.cartId,
                          status: newStatus,
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
    AppPopup.show(
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