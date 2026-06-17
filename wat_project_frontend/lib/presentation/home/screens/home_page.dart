import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wat_project_frontend/di/inject.dart';
import 'package:wat_project_frontend/domain/repositories/user_repository.dart';
import 'package:wat_project_frontend/domain/repositories/journey_repository.dart';
import 'package:wat_project_frontend/domain/repositories/mission_repository.dart';
import 'package:wat_project_frontend/domain/models/user_model.dart';
import 'package:wat_project_frontend/domain/models/journey_phase_model.dart';
import 'package:wat_project_frontend/domain/models/user_mission_model.dart';
import 'package:wat_project_frontend/domain/models/mission_model.dart';
import 'package:wat_project_frontend/data/entities/mission_entity.dart';
import 'package:wat_project_frontend/data/entities/user_mission_entity.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/mission_detail_response.dart';
import 'package:wat_project_frontend/presentation/missions_tasks/widgets/mission_card.dart';
import 'package:wat_project_frontend/utils/theme_constants.dart';

class HomeData {
  final UserModel user;
  final JourneyPhaseModel currentPhase;
  final List<JourneyPhaseModel> allPhases;
  final List<MissionDetailResponse> phaseMissions;
  final bool isMock;

  const HomeData({
    required this.user,
    required this.currentPhase,
    required this.allPhases,
    required this.phaseMissions,
    this.isMock = false,
  });
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<HomeData> _homeDataFuture;

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  void _refreshData() {
    setState(() {
      _homeDataFuture = _loadHomeData();
    });
  }

  Future<HomeData> _loadHomeData() async {
    try {
      final user = await getIt<UserRepository>().getMe();
      final phases = await getIt<JourneyRepository>().listPhases();
      final userMissions = await getIt<MissionRepository>().listMissions();

      // Determine current phase based on user profile
      final currentPhase = phases.firstWhere(
        (p) => p.phaseId == user.currentPhaseId,
        orElse: () => phases.isNotEmpty 
            ? phases.first 
            : JourneyPhaseModel(
                phaseId: user.currentPhaseId ?? 'phase-1',
                phaseNumber: 1,
                title: 'Preparation & Booking',
                description: 'Complete your initial preparations, flights and visa documentations.',
                createdAt: DateTime.now(),
                updatedAt: DateTime.now(),
              ),
      );

      // Concurrently fetch details of user's active missions to filter by phase
      final detailsList = await Future.wait(
        userMissions.map((um) async {
          try {
            return await getIt<MissionRepository>().getMissionDetail(um.missionId);
          } catch (_) {
            return null;
          }
        }),
      );

      final phaseMissions = detailsList
          .where((d) => d != null && d.mission.phaseId == currentPhase.phaseId)
          .cast<MissionDetailResponse>()
          .toList();

      return HomeData(
        user: user,
        currentPhase: currentPhase,
        allPhases: phases,
        phaseMissions: phaseMissions,
      );
    } catch (e) {
      // API call failed (unauthorized, offline, or server down). 
      // Fallback gracefully with realistic local/mock data to prevent showing a broken UI.
      debugPrint('Home API call failed: $e. Loading mock demo data.');
      return _loadMockHomeData();
    }
  }

  Future<HomeData> _loadMockHomeData() async {
    // Return high quality mock data so the app remains fully functional and visual
    final mockUser = UserModel(
      id: 'mock-user-123',
      email: 'traveler@watproject.org',
      firstName: 'Alex',
      lastName: 'Wanderer',
      currentPhaseId: 'phase-1',
      totalLifetimePoints: 850,
      currentPhasePoints: 450,
      missionStreak: 3,
      createdAt: DateTime.now().subtract(const Duration(days: 30)),
      updatedAt: DateTime.now(),
    );

    final mockPhases = [
      JourneyPhaseModel(
        phaseId: 'phase-1',
        phaseNumber: 1,
        title: 'Application & Visa prep',
        description: 'Prepare and submit your visa application, book flight tickets, and gather basic documents.',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      JourneyPhaseModel(
        phaseId: 'phase-2',
        phaseNumber: 2,
        title: 'Pre-Departure Orientation',
        description: 'Learn about US customs, housing arrangements, and safety rules.',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      JourneyPhaseModel(
        phaseId: 'phase-3',
        phaseNumber: 3,
        title: 'On-Site Work',
        description: 'Arrive at your employer location, start your job, and begin exploring.',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    ];

    // Build mock details response for phase 1 using Entity types
    final mockMissions = [
      MissionDetailResponse(
        mission: MissionEntity(
          missionId: 'm-1',
          phaseId: 'phase-1',
          title: 'Visa Document Verification',
          description: 'Submit your DS-2019 and passport details for administrative review.',
          basePoints: 500,
          isMandatory: true,
          verificationType: VerificationType.upload,
          createdAt: DateTime.now().toIso8601String(),
          updatedAt: DateTime.now().toIso8601String(),
        ),
        userMission: UserMissionEntity(
          userMissionId: 'um-1',
          userId: mockUser.id,
          missionId: 'm-1',
          status: UserMissionStatus.inProgress,
          calculatedDueDate: DateTime.now().add(const Duration(days: 3)).toIso8601String(),
          basePointsEarned: 0,
          speedBonusPoints: 0,
          streakBonusPoints: 0,
          firstCompleterBonusPoints: 0,
          totalPointsEarned: 0,
          createdAt: DateTime.now().toIso8601String(),
          updatedAt: DateTime.now().toIso8601String(),
        ),
        tasks: [],
        userTasks: [],
      ),
      MissionDetailResponse(
        mission: MissionEntity(
          missionId: 'm-2',
          phaseId: 'phase-1',
          title: 'Flight Ticket Booking',
          description: 'Book your flight ticket and submit the itinerary details.',
          basePoints: 300,
          isMandatory: false,
          verificationType: VerificationType.none,
          createdAt: DateTime.now().toIso8601String(),
          updatedAt: DateTime.now().toIso8601String(),
        ),
        userMission: UserMissionEntity(
          userMissionId: 'um-2',
          userId: mockUser.id,
          missionId: 'm-2',
          status: UserMissionStatus.completed,
          calculatedDueDate: DateTime.now().add(const Duration(days: 5)).toIso8601String(),
          basePointsEarned: 300,
          speedBonusPoints: 0,
          streakBonusPoints: 0,
          firstCompleterBonusPoints: 0,
          totalPointsEarned: 300,
          createdAt: DateTime.now().toIso8601String(),
          updatedAt: DateTime.now().toIso8601String(),
        ),
        tasks: [],
        userTasks: [],
      ),
    ];

    return HomeData(
      user: mockUser,
      currentPhase: mockPhases[0],
      allPhases: mockPhases,
      phaseMissions: mockMissions,
      isMock: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundAlt,
      appBar: AppBar(
        title: const Text(
          'WAT Project',
          style: TextStyle(fontWeight: FontWeight.w800, color: AppColors.textPrimary),
        ),
        elevation: 0,
        backgroundColor: AppColors.background,
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.bug_report_outlined, color: AppColors.primary),
            tooltip: 'Debug Dashboard',
            onPressed: () => context.push('/home/debug'),
          ),
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: AppColors.textPrimary),
            onPressed: () => context.push('/notifications'),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          _refreshData();
          await _homeDataFuture;
        },
        color: AppColors.primary,
        child: FutureBuilder<HomeData>(
          future: _homeDataFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              );
            }

            if (snapshot.hasError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.cloud_off, size: 64, color: AppColors.error),
                      const SizedBox(height: 16),
                      Text(
                        'Unable to load your home dashboard',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        snapshot.error.toString(),
                        style: const TextStyle(color: Colors.grey),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: _refreshData,
                        child: const Text('Try Again'),
                      ),
                    ],
                  ),
                ),
              );
            }

            final data = snapshot.data!;
            final currentProgress = data.allPhases.indexOf(data.currentPhase) + 1;
            final totalPhases = data.allPhases.isNotEmpty ? data.allPhases.length : 3;

            return SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Mock notification banner if in Demo Mode
                  if (data.isMock) _buildDemoBanner(),

                  // Greeting Section
                  _buildGreeting(data.user),
                  const SizedBox(height: 20),

                  // Current Journey Phase Section
                  _buildPhaseCard(data.currentPhase, currentProgress, totalPhases),
                  const SizedBox(height: 28),

                  // Section title for missions
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Active Missions',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      TextButton.icon(
                        onPressed: () => context.push('/missions'),
                        icon: const Icon(Icons.arrow_forward, size: 16),
                        label: const Text('View All'),
                        style: TextButton.styleFrom(
                          foregroundColor: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Missions List
                  if (data.phaseMissions.isEmpty)
                    _buildEmptyMissionsState()
                  else
                    ...data.phaseMissions.map((dm) {
                      final isCompleted = dm.userMission.status == UserMissionStatus.completed;
                      final progress = isCompleted ? 1.0 : 0.4;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: InkWell(
                          onTap: () => context.push('/missions/detail', extra: dm.mission.missionId),
                          borderRadius: BorderRadius.circular(AppDimension.radiusMedium),
                          child: MissionCard(
                            title: dm.mission.title,
                            deadline: _formatDeadline(dm.userMission.calculatedDueDate != null ? DateTime.tryParse(dm.userMission.calculatedDueDate!) : null) ?? 'Soon',
                            bonusPoints: dm.mission.basePoints,
                            isMandatory: dm.mission.isMandatory,
                            progress: progress,
                          ),
                        ),
                      );
                    }),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildDemoBanner() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16.0),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.08),
        borderRadius: BorderRadius.circular(AppDimension.radiusMedium),
        border: Border.all(color: AppColors.primary.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          const Icon(Icons.info_outline_rounded, color: AppColors.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Demo/Offline Mode Active',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                    fontSize: 13,
                  ),
                ),
                Text(
                  'Unable to reach server. Showing cached demo data.',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: _refreshData,
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  Widget _buildGreeting(UserModel user) {
    final name = user.firstName ?? 'Traveler';
    return Row(
      children: [
        CircleAvatar(
          radius: 26,
          backgroundColor: AppColors.primary.withOpacity(0.15),
          child: Text(
            name.substring(0, 1).toUpperCase(),
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: AppColors.primary,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hi, $name!',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: AppColors.textPrimary,
              ),
            ),
            const Text(
              'Welcome back to your WAT adventure.',
              style: TextStyle(
                fontSize: 13,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPhaseCard(JourneyPhaseModel phase, int currentProgress, int totalPhases) {
    final progressFraction = currentProgress / totalPhases;

    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      color: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimension.radiusMedium),
        side: BorderSide(color: Colors.grey.withOpacity(0.15)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppDimension.radiusSmall),
                  ),
                  child: Text(
                    'Phase $currentProgress of $totalPhases',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                const Icon(Icons.flag_rounded, color: AppColors.primary, size: 20),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              phase.title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: AppColors.textPrimary,
              ),
            ),
            if (phase.description != null) ...[
              const SizedBox(height: 8),
              Text(
                phase.description!,
                style: const TextStyle(
                  fontSize: 13,
                  color: AppColors.textSecondary,
                  height: 1.4,
                ),
              ),
            ],
            const SizedBox(height: 20),
            // Progress Bar
            ClipRRect(
              borderRadius: BorderRadius.circular(AppDimension.radiusSmall),
              child: LinearProgressIndicator(
                value: progressFraction,
                minHeight: 8,
                backgroundColor: AppColors.surfaceAlt,
                valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Journey Status',
                  style: TextStyle(fontSize: 11, color: Colors.grey),
                ),
                Text(
                  '${(progressFraction * 100).toInt()}% Completed',
                  style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyMissionsState() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppDimension.radiusMedium),
        border: Border.all(color: Colors.grey.withOpacity(0.15)),
      ),
      child: const Column(
        children: [
          Icon(Icons.assignment_turned_in_outlined, size: 48, color: Colors.grey),
          SizedBox(height: 12),
          Text(
            'All Done for This Phase!',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: 4),
          Text(
            'No active missions in this phase. Keep it up!',
            style: TextStyle(
              fontSize: 12,
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  String? _formatDeadline(DateTime? deadline) {
    if (deadline == null) return null;
    final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return '${months[deadline.month - 1]} ${deadline.day}';
  }
}
