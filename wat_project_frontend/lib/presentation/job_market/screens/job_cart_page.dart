import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:wat_project_frontend/domain/models/job_models.dart';
import 'package:wat_project_frontend/presentation/job_market/bloc/job_market_bloc.dart';
import 'package:wat_project_frontend/presentation/job_market/bloc/job_market_event.dart';
import 'package:wat_project_frontend/presentation/job_market/bloc/job_market_state.dart';
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
  List<UserCartModel> _cartItems = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _bloc = GetIt.instance<JobMarketBloc>();
    _bloc.add(const ListCartItemsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bloc,
      child: BlocListener<JobMarketBloc, JobMarketState>(
        listener: (context, state) {
          if (state is ListCartItemsSuccess) {
            setState(() {
              _cartItems = state.cartItems;
              _isLoading = false;
            });
          } else if (state is RemoveJobFromCartSuccess) {
            _bloc.add(const ListCartItemsEvent());
          } else if (state is UpdateCartStatusSuccess) {
            _bloc.add(const ListCartItemsEvent());
          } else if (state is JobMarketFailure) {
            setState(() => _isLoading = false);
            AppPopup.show(
              context: context,
              type: AppPopupType.error,
              title: 'Error',
              message: state.message,
              buttons: [AppPopupButton(label: 'OK', onPressed: () => Navigator.pop(context))],
            );
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
              if (_isLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (_cartItems.isEmpty) {
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
                  itemCount: _cartItems.length,
                  separatorBuilder: (_, __) =>
                      const SizedBox(height: AppDimension.space8),
                  itemBuilder: (context, index) {
                    final item = _cartItems[index];
                    return JobCartItemTile(
                      title: 'Job #${item.jobId.substring(0, item.jobId.length > 8 ? 8 : item.jobId.length)}',
                      company: 'Saved Job Posting',
                      status: item.status.name[0].toUpperCase() + item.status.name.substring(1),
                      onDelete: () => _bloc.add(
                        RemoveJobFromCartEvent(item.cartId),
                      ),
                      onStatusChanged: (newStatus) => _bloc.add(
                        UpdateCartStatusEvent(
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
}
