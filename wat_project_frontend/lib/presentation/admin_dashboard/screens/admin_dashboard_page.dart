import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wat_project_frontend/di/inject.dart';
import 'package:wat_project_frontend/domain/models/admin_stats_model.dart';
import 'package:wat_project_frontend/domain/models/user_mission_model.dart';
import 'package:wat_project_frontend/domain/models/user_model.dart';
import 'package:wat_project_frontend/presentation/admin_dashboard/bloc/admin_dashboard_bloc.dart';
import 'package:wat_project_frontend/presentation/admin_dashboard/bloc/admin_dashboard_event.dart';
import 'package:wat_project_frontend/presentation/admin_dashboard/bloc/admin_dashboard_state.dart';
import 'package:wat_project_frontend/utils/theme_constants.dart';

class AdminDashboardPage extends StatelessWidget {
  const AdminDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AdminDashboardBloc>(
      create: (context) => getIt<AdminDashboardBloc>()..add(const AdminStatsRequested()),
      child: const AdminDashboardView(),
    );
  }
}

class AdminDashboardView extends StatefulWidget {
  const AdminDashboardView({super.key});

  @override
  State<AdminDashboardView> createState() => _AdminDashboardViewState();
}

class _AdminDashboardViewState extends State<AdminDashboardView> {
  int _currentTab = 0;
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onTabChanged(int index) {
    setState(() {
      _currentTab = index;
    });

    final bloc = context.read<AdminDashboardBloc>();
    if (index == 0) {
      bloc.add(const AdminStatsRequested());
    } else if (index == 1) {
      bloc.add(const AdminPendingVerificationsRequested());
    } else if (index == 2) {
      bloc.add(AdminUsersSearchRequested(_searchController.text));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundAlt,
      appBar: AppBar(
        title: const Text(
          'Admin Control Panel',
          style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.textPrimary),
        ),
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: AppColors.primary),
            onPressed: () => _onTabChanged(_currentTab),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentTab,
        onTap: _onTabChanged,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textSecondary,
        backgroundColor: AppColors.background,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_outlined),
            activeIcon: Icon(Icons.dashboard),
            label: 'Overview',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.rule_folder_outlined),
            activeIcon: Icon(Icons.rule_folder),
            label: 'Verifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_outline),
            activeIcon: Icon(Icons.people),
            label: 'Users',
          ),
        ],
      ),
      body: BlocListener<AdminDashboardBloc, AdminDashboardState>(
        listener: (context, state) {
          if (state is AdminDashboardFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: AppColors.error,
              ),
            );
          } else if (state is AdminDashboardVerifySuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Mission verified successfully!'),
                backgroundColor: Colors.green,
              ),
            );
            context.read<AdminDashboardBloc>().add(const AdminPendingVerificationsRequested());
          } else if (state is AdminDashboardAdjustPointsSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Points adjusted! Ledger ID: ${state.result.ledgerId}'),
                backgroundColor: Colors.green,
              ),
            );
            context.read<AdminDashboardBloc>().add(AdminUsersSearchRequested(_searchController.text));
          }
        },
        child: BlocBuilder<AdminDashboardBloc, AdminDashboardState>(
          builder: (context, state) {
            if (state is AdminDashboardLoading) {
              return const Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              );
            }

            if (_currentTab == 0) {
              if (state is AdminDashboardStatsSuccess) {
                return _buildOverviewTab(state.stats);
              }
            } else if (_currentTab == 1) {
              if (state is AdminDashboardPendingVerificationsSuccess) {
                return _buildVerificationsTab(state.verifications);
              }
            } else if (_currentTab == 2) {
              if (state is AdminDashboardUsersSuccess) {
                return _buildUsersTab(state.users);
              } else if (state is AdminDashboardUserDetailSuccess) {
                return _buildUserDetailView(state.user);
              }
            }

            return const Center(
              child: Text('Pull to refresh or select another tab.'),
            );
          },
        ),
      ),
    );
  }

  Widget _buildOverviewTab(AdminStatsModel stats) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppDimension.space16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'System Performance Metrics',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: AppDimension.space16),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: AppDimension.space16,
            mainAxisSpacing: AppDimension.space16,
            children: [
              _buildStatCard(
                'Total Registered',
                '${stats.totalUsers}',
                Icons.people_alt_rounded,
                Colors.blue,
              ),
              _buildStatCard(
                'Active Users',
                '${stats.activeUsers}',
                Icons.online_prediction_rounded,
                Colors.green,
              ),
              _buildStatCard(
                'Pending Review',
                '${stats.pendingVerifications}',
                Icons.hourglass_empty_rounded,
                Colors.amber,
              ),
              _buildStatCard(
                'Active Jobs',
                '${stats.activeJobs}',
                Icons.work_rounded,
                Colors.deepPurple,
              ),
              _buildStatCard(
                'Avg Credit Score',
                '${stats.averageCreditScore}',
                Icons.score_rounded,
                Colors.teal,
              ),
              _buildStatCard(
                'Points Distributed',
                '${stats.totalPointsAwarded}',
                Icons.stars_rounded,
                Colors.orange,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon, Color color) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimension.radiusMedium),
        side: const BorderSide(color: AppColors.surface),
      ),
      color: AppColors.background,
      child: Padding(
        padding: const EdgeInsets.all(AppDimension.space16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 36),
            const Spacer(),
            Text(
              value,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w900,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: AppDimension.space4),
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.textSecondary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVerificationsTab(List<UserMissionModel> list) {
    if (list.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_circle_outline, size: 64, color: Colors.green),
            SizedBox(height: AppDimension.space16),
            Text(
              'No pending verifications',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(AppDimension.space16),
      itemCount: list.length,
      itemBuilder: (context, index) {
        final item = list[index];
        return Card(
          margin: const EdgeInsets.only(bottom: AppDimension.space16),
          color: AppColors.background,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimension.radiusMedium),
            side: const BorderSide(color: AppColors.surface),
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppDimension.space16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(AppDimension.space8),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.assignment, color: AppColors.primary),
                    ),
                    const SizedBox(width: AppDimension.space12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'User ID: ${item.userId}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          Text(
                            'Mission ID: ${item.missionId}',
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Divider(height: 24.0),
                if (item.proofUrl != null && item.proofUrl!.isNotEmpty) ...[
                  const Text(
                    'Submitted Proof File / Image:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                  const SizedBox(height: AppDimension.space4),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(AppDimension.space12),
                    decoration: BoxDecoration(
                      color: AppColors.backgroundAlt,
                      borderRadius: BorderRadius.circular(AppDimension.radiusSmall),
                    ),
                    child: Text(
                      item.proofUrl!,
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 12,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppDimension.space16),
                ],
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.error,
                        side: const BorderSide(color: AppColors.error),
                      ),
                      onPressed: () => _showRejectionDialog(context, item.userMissionId),
                      child: const Text('Reject'),
                    ),
                    const SizedBox(width: AppDimension.space12),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: AppColors.onPrimary,
                      ),
                      onPressed: () {
                        context.read<AdminDashboardBloc>().add(
                              AdminVerifyMissionSubmitted(
                                userMissionId: item.userMissionId,
                                approved: true,
                              ),
                            );
                      },
                      child: const Text('Approve'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildUsersTab(List<UserModel> list) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(AppDimension.space16),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search user email or ID...',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  _searchController.clear();
                  context.read<AdminDashboardBloc>().add(const AdminUsersSearchRequested(''));
                },
              ),
              filled: true,
              fillColor: AppColors.background,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppDimension.radiusMedium),
                borderSide: BorderSide.none,
              ),
            ),
            onSubmitted: (val) {
              context.read<AdminDashboardBloc>().add(AdminUsersSearchRequested(val));
            },
          ),
        ),
        Expanded(
          child: list.isEmpty
              ? const Center(
                  child: Text('No users found.'),
                )
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: AppDimension.space16),
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    final user = list[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: AppDimension.space12),
                      color: AppColors.background,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppDimension.radiusMedium),
                        side: const BorderSide(color: AppColors.surface),
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: AppColors.primary.withOpacity(0.1),
                          child: Text(
                            (user.firstName ?? 'U').substring(0, 1).toUpperCase(),
                            style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold),
                          ),
                        ),
                        title: Text('${user.firstName ?? ''} ${user.lastName ?? ''}'),
                        subtitle: Text(user.email),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () {
                          context.read<AdminDashboardBloc>().add(AdminUserDetailRequested(user.id));
                        },
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildUserDetailView(UserModel user) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppDimension.space16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  context.read<AdminDashboardBloc>().add(AdminUsersSearchRequested(_searchController.text));
                },
              ),
              const Text(
                'User Details',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: AppDimension.space16),
          Card(
            color: AppColors.background,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppDimension.radiusMedium),
              side: const BorderSide(color: AppColors.surface),
            ),
            child: Padding(
              padding: const EdgeInsets.all(AppDimension.space16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDetailRow('User ID', user.id),
                  _buildDetailRow('Email', user.email),
                  _buildDetailRow('First Name', user.firstName ?? 'Not provided'),
                  _buildDetailRow('Last Name', user.lastName ?? 'Not provided'),
                  _buildDetailRow('Current Phase ID', user.currentPhaseId ?? 'No active phase'),
                  _buildDetailRow('Lifetime Points', '${user.totalLifetimePoints}'),
                  _buildDetailRow('Current Phase Points', '${user.currentPhasePoints}'),
                  _buildDetailRow('Streak Count', '${user.missionStreak}'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24.0),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.onPrimary,
                padding: const EdgeInsets.all(AppDimension.space16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppDimension.radiusMedium),
                ),
              ),
              onPressed: () => _showPointsAdjustmentDialog(context, user.id),
              child: const Text(
                'Adjust User Points',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppDimension.space8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.textSecondary,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showRejectionDialog(BuildContext context, String userMissionId) {
    final reasonController = TextEditingController();
    showDialog<void>(
      context: context,
      builder: (diagContext) => AlertDialog(
        title: const Text('Reject Submission'),
        content: TextField(
          controller: reasonController,
          decoration: const InputDecoration(
            hintText: 'Enter rejection reason (optional)...',
            border: OutlineInputBorder(),
          ),
          maxLines: 3,
        ),
        actions: [
          TextButton(
            child: const Text('Cancel'),
            onPressed: () => Navigator.pop(diagContext),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
              foregroundColor: AppColors.onError,
            ),
            child: const Text('Reject'),
            onPressed: () {
              final reason = reasonController.text.trim();
              context.read<AdminDashboardBloc>().add(
                    AdminVerifyMissionSubmitted(
                      userMissionId: userMissionId,
                      approved: false,
                      reason: reason.isEmpty ? null : reason,
                    ),
                  );
              Navigator.pop(diagContext);
            },
          ),
        ],
      ),
    );
  }

  void _showPointsAdjustmentDialog(BuildContext context, String userId) {
    final deltaController = TextEditingController();
    final reasonController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    showDialog<void>(
      context: context,
      builder: (diagContext) => AlertDialog(
        title: const Text('Adjust User Points'),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: deltaController,
                keyboardType: const TextInputType.numberWithOptions(signed: true),
                decoration: const InputDecoration(
                  labelText: 'Points Delta (e.g. +50 or -20)',
                  border: OutlineInputBorder(),
                ),
                validator: (val) {
                  if (val == null || val.isEmpty) return 'Delta points required';
                  if (int.tryParse(val) == null) return 'Must be a valid integer';
                  return null;
                },
              ),
              const SizedBox(height: AppDimension.space16),
              TextFormField(
                controller: reasonController,
                decoration: const InputDecoration(
                  labelText: 'Reason',
                  border: OutlineInputBorder(),
                ),
                validator: (val) {
                  if (val == null || val.trim().isEmpty) return 'Reason is required';
                  return null;
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            child: const Text('Cancel'),
            onPressed: () => Navigator.pop(diagContext),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.onPrimary,
            ),
            child: const Text('Submit'),
            onPressed: () {
              if (formKey.currentState?.validate() ?? false) {
                final delta = int.parse(deltaController.text);
                final reason = reasonController.text.trim();
                context.read<AdminDashboardBloc>().add(
                      AdminAdjustPointsSubmitted(
                        userId: userId,
                        pointsDelta: delta,
                        reason: reason,
                      ),
                    );
                Navigator.pop(diagContext);
              }
            },
          ),
        ],
      ),
    );
  }
}
