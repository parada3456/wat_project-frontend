// // ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

// import 'package:wat_project_frontend/domain/models/admin_models.dart';
// import 'package:wat_project_frontend/domain/models/auth_models.dart';
// import 'package:wat_project_frontend/domain/models/gamification_models.dart';
// import 'package:wat_project_frontend/domain/models/user_models.dart';
// import 'package:wat_project_frontend/domain/models/expense_models.dart';
// import 'package:wat_project_frontend/domain/models/expense_models.dart';
// import 'package:wat_project_frontend/domain/models/friend_models.dart';
// import 'package:wat_project_frontend/domain/models/user_models.dart';
// import 'package:wat_project_frontend/domain/models/job_models.dart';
// import 'package:wat_project_frontend/domain/models/job_models.dart';
// import 'package:wat_project_frontend/domain/models/job_models.dart';
// import 'package:wat_project_frontend/domain/models/job_models.dart';
// import 'package:wat_project_frontend/domain/models/journey_models.dart';
// import 'package:wat_project_frontend/domain/models/mission_models.dart';
// import 'package:wat_project_frontend/domain/models/notification_models.dart';
// import 'package:wat_project_frontend/domain/models/gamification_models.dart';
// import 'package:wat_project_frontend/domain/models/admin_models.dart';
// import 'package:wat_project_frontend/domain/models/user_models.dart';
// import 'package:wat_project_frontend/domain/models/mission_models.dart';
// import 'package:wat_project_frontend/domain/models/gamification_models.dart';
// import 'package:wat_project_frontend/domain/models/job_models.dart';
// import 'package:wat_project_frontend/domain/models/job_models.dart';
// import 'package:wat_project_frontend/domain/models/mission_models.dart';
// import 'package:wat_project_frontend/domain/models/expense_models.dart';
// import 'package:wat_project_frontend/domain/models/mission_models.dart';
// import 'package:wat_project_frontend/domain/models/user_models.dart';
// import 'package:wat_project_frontend/domain/models/journey_models.dart';
// import 'package:wat_project_frontend/domain/models/user_models.dart';
// import 'package:wat_project_frontend/domain/models/mission_models.dart';

// // Entities
// import 'package:wat_project_frontend/data/entities/admin/admin_stats_entity.dart';
// import 'package:wat_project_frontend/data/entities/auth/auth_entity.dart';
// import 'package:wat_project_frontend/data/entities/auth/login_entity.dart';
// import 'package:wat_project_frontend/data/entities/user/profile_entity.dart';
// import 'package:wat_project_frontend/data/entities/user/user_account_entity.dart';
// import 'package:wat_project_frontend/data/entities/expense/credit_score_entity.dart';
// import 'package:wat_project_frontend/data/entities/expense/expense_split_entity.dart';
// import 'package:wat_project_frontend/data/entities/expense/expense_transaction_entity.dart';
// import 'package:wat_project_frontend/data/entities/friend/friendship_entity.dart';
// import 'package:wat_project_frontend/data/entities/gamification/badge_entity.dart';
// import 'package:wat_project_frontend/data/entities/gamification/journey_phase_entity.dart';
// import 'package:wat_project_frontend/data/entities/gamification/point_ledger_entity.dart';
// import 'package:wat_project_frontend/data/entities/gamification/points_adjustment_result_entity.dart';
// import 'package:wat_project_frontend/data/entities/gamification/user_badge_entity.dart';
// import 'package:wat_project_frontend/data/entities/job_review/job/job_housing_entity.dart';
// import 'package:wat_project_frontend/data/entities/job_review/job/job_overall_rating_entity.dart';
// import 'package:wat_project_frontend/data/entities/job_review/job/job_posting_entity.dart';
// import 'package:wat_project_frontend/data/entities/job_review/job/user_cart_entity.dart';
// import 'package:wat_project_frontend/data/entities/job_review/job/assigned_job_entity.dart';
// import 'package:wat_project_frontend/data/entities/job_review/review/job_review_entity.dart';
// import 'package:wat_project_frontend/data/entities/mission/mission_entity.dart';
// import 'package:wat_project_frontend/data/entities/mission/task_entity.dart';
// import 'package:wat_project_frontend/data/entities/mission/user_mission_entity.dart';
// import 'package:wat_project_frontend/data/entities/gamification/user_phase_history_entity.dart';
// import 'package:wat_project_frontend/data/entities/mission/user_task_entity.dart';
// import 'package:wat_project_frontend/data/entities/notification/notification_entity.dart';

// // API Models (Requests/Responses)
// import 'package:wat_project_frontend/data/sources/api/api_model/admin/adjust_points_request.dart';
// import 'package:wat_project_frontend/data/sources/api/api_model/admin/verify_mission_request.dart';
// import 'package:wat_project_frontend/data/sources/api/api_model/api_error.dart';
// import 'package:wat_project_frontend/data/sources/api/api_model/authentication/auth_refresh_request.dart';
// import 'package:wat_project_frontend/data/sources/api/api_model/authentication/forgot_password_request.dart';
// import 'package:wat_project_frontend/data/sources/api/api_model/authentication/login_request.dart';
// import 'package:wat_project_frontend/data/sources/api/api_model/authentication/logout_request.dart';
// import 'package:wat_project_frontend/data/sources/api/api_model/authentication/register_request.dart';
// import 'package:wat_project_frontend/data/sources/api/api_model/authentication/reset_password_request.dart';
// import 'package:wat_project_frontend/data/sources/api/api_model/expense/create_expense_request.dart';
// import 'package:wat_project_frontend/data/entities/expense/expense_detail_response.dart';
// import 'package:wat_project_frontend/data/sources/api/api_model/field_error.dart';
// import 'package:wat_project_frontend/data/sources/api/api_model/friend/respond_friend_request.dart';
// import 'package:wat_project_frontend/data/sources/api/api_model/friend/send_friend_request.dart';
// import 'package:wat_project_frontend/data/sources/api/api_model/friend_radar/radar_entry.dart';
// import 'package:wat_project_frontend/data/sources/api/api_model/gamification/leaderboard_entry.dart';
// import 'package:wat_project_frontend/data/sources/api/api_model/gamification/phase_transition_result.dart';
// import 'package:wat_project_frontend/data/sources/api/api_model/job_review/add_to_cart_request.dart';
// import 'package:wat_project_frontend/data/sources/api/api_model/job_review/assign_job_request.dart';
// import 'package:wat_project_frontend/data/sources/api/api_model/job_review/create_review_alternative_request.dart';
// import 'package:wat_project_frontend/data/sources/api/api_model/job_review/create_review_request.dart';
// import 'package:wat_project_frontend/data/entities/job_review/job/job_detail_response.dart';
// import 'package:wat_project_frontend/data/sources/api/api_model/job_review/patch_job_request.dart';
// import 'package:wat_project_frontend/data/sources/api/api_model/job_review/update_cart_status_request.dart';
// import 'package:wat_project_frontend/data/sources/api/api_model/pagination_response.dart';
// import 'package:wat_project_frontend/data/entities/mission/mission_detail_response.dart';
// import 'package:wat_project_frontend/data/entities/mission/pending_verifications_response.dart';
// import 'package:wat_project_frontend/data/sources/api/api_model/mission/toggle_task_request.dart';
// import 'package:wat_project_frontend/data/entities/mission/verify_mission_response.dart';
// import 'package:wat_project_frontend/data/sources/api/api_model/upload_media_response.dart';
// import 'package:wat_project_frontend/data/sources/api/api_model/user/delete_account_request.dart';
// import 'package:wat_project_frontend/data/sources/api/api_model/user/update_location_request.dart';
// import 'package:wat_project_frontend/data/sources/api/api_model/user/update_password_request.dart';
// import 'package:wat_project_frontend/data/sources/api/api_model/user/update_profile_request.dart';
// import 'package:wat_project_frontend/data/sources/api/api_model/user/update_settings_request.dart';
// import 'package:wat_project_frontend/data/sources/api/api_model/pagination_info.dart';

// /// Centralized repository of all mock data in WAT Project.
// /// Contains pre-configured mock objects for Domain Models, Entities, and API DTO Requests/Responses.
// abstract class MockData {
//   // Shared mock constants
//   static final DateTime defaultDate = DateTime(2026, 6, 25, 9, 30);
//   static const String defaultDateStr = "2026-06-25T09:30:00Z";
//   static const String userId = "user-12345";
//   static const String friendId = "friend-67890";
//   static const String phaseId = "phase-1";
//   static const String missionId = "mission-101";
//   static const String taskId = "task-202";
//   static const String jobId = "job-303";
//   static const String housingId = "house-404";
//   static const String ratingSummaryId = "rating-505";
//   static const String splitId = "split-606";
//   static const String transactionId = "tx-707";
//   static const String ledgerId = "ledger-808";
//   static const String badgeId = "badge-909";
//   static const String userBadgeId = "user-badge-000";
//   static const String cartId = "cart-111";
//   static const String historyId = "history-222";
//   static const String userMissionId = "user-mission-333";
//   static const String userTaskId = "user-task-444";
//   static const String reviewId = "review-555";
//   static const String notificationId = "notification-666";
//   static const String email = "john.doe@example.com";

//   // ==============================================================================================================================
//   // 1. DOMAIN MODELS MOCKS
//   // ==============================================================================================================================
  
//   static final AdminStatsModel adminStatsModel = AdminStatsModel(
//     totalUsers: 1500,
//     activeUsers: 840,
//     pendingVerifications: 42,
//     activeJobs: 120,
//     averageCreditScore: 92,
//     totalPointsAwarded: 245000,
//   );

//   static final AuthModel authModel = AuthModel(
//     token: "mock-access-token-jwt-value",
//     refreshToken: "mock-refresh-token-jwt-value",
//     expiresAt: defaultDate.add(const Duration(minutes: 15)),
//     tokenType: "Bearer",
//   );

//   static final BadgeModel badgeModel = BadgeModel(
//     badgeId: badgeId,
//     title: "First Steps",
//     description: "Earned by completing the onboarding phase.",
//     triggerType: BadgeTriggerType.manual,
//     iconUrl: "https://example.com/assets/badges/first-steps.png",
//     createdAt: defaultDate,
//   );

//   static final CreditScoreModel creditScoreModel = CreditScoreModel(
//     creditId: "credit-score-1",
//     userId: userId,
//     currentScore: 95,
//     lastUpdated: defaultDate,
//   );

//   static final ExpenseSplitModel expenseSplitModel = ExpenseSplitModel(
//     splitId: splitId,
//     transactionId: transactionId,
//     userId: userId,
//     oweAmount: 25.50,
//     paymentStatus: PaymentStatus.pending,
//     paymentMethod: "Venmo",
//     payslipUrl: "https://example.com/files/payslips/tx-707-split.png",
//     approvalStatus: ApprovalStatus.pendingApproval,
//     settledAt: null,
//     updatedAt: defaultDate,
//   );

//   static final ExpenseTransactionModel expenseTransactionModel = ExpenseTransactionModel(
//     transactionId: transactionId,
//     paidByUserId: friendId,
//     title: "Weekly Grocery Split",
//     totalAmount: 76.50,
//     currency: "USD",
//     memo: "Divided equally among three roommates",
//     transactionDate: defaultDate.subtract(const Duration(days: 1)),
//     dueDate: defaultDate.add(const Duration(days: 5)),
//     createdAt: defaultDate.subtract(const Duration(days: 1)),
//     updatedAt: defaultDate,
//   );

//   static final FriendshipModel friendshipModel = FriendshipModel(
//     friendshipId: "friendship-x",
//     userId1: userId,
//     userId2: friendId,
//     status: FriendshipStatus.accepted,
//     createdAt: defaultDate.subtract(const Duration(days: 10)),
//     updatedAt: defaultDate,
//   );

//   static final JourneyPhaseModel journeyPhaseModel = JourneyPhaseModel(
//     phaseId: phaseId,
//     phaseNumber: 1,
//     title: "Phase 1: Pre-Departure Prep",
//     description: "Complete paperwork, purchase tickets, and upload visa information.",
//     createdAt: defaultDate.subtract(const Duration(days: 30)),
//     updatedAt: defaultDate,
//   );

//   static final JobHousingModel jobHousingModel = JobHousingModel(
//     housingId: housingId,
//     jobId: jobId,
//     description: "Cozy student dorms with single rooms and shared kitchen facilities.",
//     weeklyRate: 120.0,
//     deposit: 300.0,
//     transportation: "Bikes provided, public bus stop 5 minutes walking distance.",
//     rangeMinStartDate: defaultDate.add(const Duration(days: 10)),
//     rangeMaxStartDate: defaultDate.add(const Duration(days: 20)),
//     createdAt: defaultDate.subtract(const Duration(days: 15)),
//     updatedAt: defaultDate,
//   );

//   static final JobOverallRatingModel jobOverallRatingModel = JobOverallRatingModel(
//     ratingSummaryId: ratingSummaryId,
//     jobId: jobId,
//     overallRate: 4.5,
//     agencyRate: 4.2,
//     jobRate: 4.6,
//     coworkersRate: 4.8,
//     townRate: 4.3,
//     hoursRate: 4.1,
//     housingRate: 4.0,
//     secondJobFeasibilityRate: 3.5,
//     overtimeAvailabilityRate: 4.4,
//     reviewCount: 15,
//     updatedAt: defaultDate,
//   );

//   static final JobPostingModel jobPostingModel = JobPostingModel(
//     jobId: jobId,
//     agencyName: "InterExchange",
//     employerTitle: "Yellowstone National Park Lodge",
//     position: "Food Service Associate",
//     positionType: "Hospitality",
//     locationCity: "Yellowstone",
//     locationState: "WY",
//     groupLocation: "National Parks",
//     usSponsor: true,
//     salaryRangeMin: 14.50,
//     salaryRangeMax: 16.00,
//     availableSlots: 5,
//     description: "Great opportunity to work in a world-famous National Park! Duties include assisting with food prep, cash handling, and customer service.",
//     sourceUrl: "https://example.com/jobs/yellowstone-food-service",
//     scrapeAt: defaultDate.subtract(const Duration(days: 2)),
//     postedAt: defaultDate.subtract(const Duration(days: 4)),
//     updatedAt: defaultDate,
//   );

//   static final JobReviewModel jobReviewModel = JobReviewModel(
//     reviewId: reviewId,
//     jobId: jobId,
//     userId: friendId,
//     ratingStars: 5.0,
//     reviewText: "Amazing experience! The manager was super nice and I met friends from all over the world.",
//     tipsForNextGeneration: "Pack warm clothes because nights in Wyoming get very cold, even in July.",
//     scoreAgency: 4.0,
//     scoreJob: 5.0,
//     scoreCoworkers: 5.0,
//     scoreTown: 4.0,
//     scoreHours: 5.0,
//     scoreHousing: 4.0,
//     scoreSecondJobFeasibility: 3.0,
//     scoreOvertimeAvailability: 4.5,
//     createdAt: defaultDate.subtract(const Duration(days: 3)),
//     updatedAt: defaultDate,
//   );

//   static final MissionModel missionModel = MissionModel(
//     missionId: missionId,
//     phaseId: phaseId,
//     title: "Upload DS-2019 Document",
//     description: "Provide a scanned copy of your official DS-2019 form issued by your sponsor.",
//     location: "Online / Mobile App",
//     basePoints: 100,
//     isMandatory: true,
//     verificationType: VerificationType.upload,
//     // dueDateType: "Relative",
//     // fixedDueDate: null,
//     // relativeTriggerEvent: "OnboardingComplete",
//     // relativeDaysOffset: 7,
//     isActive: true,
//     isLocked: false,
//     createdAt: defaultDate.subtract(const Duration(days: 10)),
//     updatedAt: defaultDate,
//   );

//   static final NotificationModel notificationModel = NotificationModel(
//     notificationId: notificationId,
//     userId: userId,
//     title: "Mission Completed!",
//     body: "Your DS-2019 form has been verified. You've earned 100 points!",
//     isRead: false,
//     createdAt: defaultDate,
//   );

//   static final PointLedgerModel pointLedgerModel = PointLedgerModel(
//     ledgerId: ledgerId,
//     userId: userId,
//     sourceType: PointSourceType.missionBase,
//     sourceId: userMissionId,
//     delta: 100,
//     lifetimeBalanceAfter: 250,
//     phaseBalanceAfter: 150,
//     note: "Earned for completing DS-2019 Verification",
//     createdAt: defaultDate,
//   );

//   static final PointsAdjustmentResultModel pointsAdjustmentResultModel = PointsAdjustmentResultModel(
//     userId: userId,
//     lifetimeBalanceAfter: 350,
//     phaseBalanceAfter: 250,
//     ledgerId: ledgerId,
//   );

//   static final ProfileModel profileModel = ProfileModel(
//     profileId: "profile-1",
//     userId: userId,
//     phoneNumber: "+15550199",
//     bio: "Adventurous student from Bangkok exploring Yellowstone this summer!",
//     avatarUrl: "https://example.com/assets/avatars/john_doe.jpg",
//     radarVisibility: RadarVisibility.showFriends,
//     currentCoordinates: "44.4279,-110.5884",
//     locationUpdatedAt: defaultDate.subtract(const Duration(minutes: 5)),
//     updatedAt: defaultDate,
//   );

//   static final TaskModel taskModel = TaskModel(
//     taskId: taskId,
//     missionId: missionId,
//     title: "Scan DS-2019",
//     description: "Ensure the scan is clear, matches your passport details, and is in PDF format.",
//     createdAt: defaultDate.subtract(const Duration(days: 10)),
//     updatedAt: defaultDate,
//   );

//   static final UserBadgeModel userBadgeModel = UserBadgeModel(
//     userBadgeId: userBadgeId,
//     userId: userId,
//     badgeId: badgeId,
//     sourceId: "source-badge-grant",
//     earnedAt: defaultDate.subtract(const Duration(days: 2)), badge: BadgeModel(badgeId: "badgeId", title: "title", triggerType: BadgeTriggerType.streak, createdAt: DateTime.now()),
//   );

//   static final UserCartModel userCartModel = UserCartModel(
//     cartId: cartId,
//     userId: userId,
//     jobId: jobId,
//     status: CartStatus.saved,
//     createdAt: defaultDate.subtract(const Duration(days: 5)),
//     updatedAt: defaultDate,
//   );

//   static final UserJobModel userJobModel = UserJobModel(
//     userId: userId,
//     jobId: jobId,
//     assignedAt: defaultDate.subtract(const Duration(days: 8)),
//     isMain: true,
//     startDate: defaultDate,
//     endDate: defaultDate.add(const Duration(days: 90)),
//   );

//   static final UserMissionModel userMissionModel = UserMissionModel(
//     userMissionId: userMissionId,
//     userId: userId,
//     missionId: missionId,
//     status: UserMissionStatus.completed,
//     calculatedDueDate: defaultDate.add(const Duration(days: 2)),
//     proofUrl: "https://example.com/proofs/user-12345/ds2019.pdf",
//     proofSubmittedAt: defaultDate.subtract(const Duration(days: 1)),
//     verifiedAt: defaultDate,
//     verifiedBy: "admin-system",
//     basePointsEarned: 100,
//     speedBonusPoints: 20,
//     streakBonusPoints: 10,
//     firstCompleterBonusPoints: 0,
//     totalPointsEarned: 130,
//     rewardedAt: defaultDate,
//     createdAt: defaultDate.subtract(const Duration(days: 6)),
//     updatedAt: defaultDate,
//   );

//   static final UserModel userModel = UserModel(
//     id: userId,
//     email: email,
//     firstName: "John",
//     lastName: "Doe",
//     currentPhaseId: phaseId,
//     totalLifetimePoints: 250,
//     currentPhasePoints: 150,
//     missionStreak: 3,
//     arrivalDate: defaultDate.subtract(const Duration(days: 5)),
//     jobStartDate: defaultDate,
//     createdAt: defaultDate.subtract(const Duration(days: 45)),
//     updatedAt: defaultDate,
//   );

//   static final UserPhaseHistoryModel userPhaseHistoryModel = UserPhaseHistoryModel(
//     historyId: historyId,
//     userId: userId,
//     phaseId: phaseId,
//     phasePointsEarned: 150,
//     enteredAt: defaultDate.subtract(const Duration(days: 15)),
//     completedAt: defaultDate,
//   );

//   static final UserProfileModel userProfile = UserProfileModel(
//     user: userModel,
//     profile: profileModel,
//     creditScore: creditScoreModel,
//     userJobs: [userJobModel],
//   );

//   static final UserTaskModel userTaskModel = UserTaskModel(
//     userTaskId: userTaskId,
//     userId: userId,
//     taskId: taskId,
//     userMissionId: userMissionId,
//     isCompleted: true,
//     completedAt: defaultDate.subtract(const Duration(days: 1)),
//     updatedAt: defaultDate,
//   );

//   static final HomeData homeData = HomeData(
//     user: userModel,
//     currentPhase: journeyPhaseModel,
//     allPhases: [journeyPhaseModel],
//     phaseMissions: [
//       MissionDetailModel(
//         mission: missionModel,
//         userMission: userMissionModel,
//         tasks: [taskModel],
//         userTasks: [userTaskModel],
//       ),
//     ],
//     isMock: true,
//   );

//   // ==============================================================================================================================
//   // 2. DATA ENTITIES MOCKS
//   // ==============================================================================================================================
  
//   static final AdminStatsEntity adminStatsEntity = AdminStatsEntity(
//     totalUsers: 1500,
//     activeUsers: 840,
//     pendingVerifications: 42,
//     activeJobs: 120,
//     averageCreditScore: 92,
//     totalPointsAwarded: 245000,
//   );

//   static final AuthEntity authEntity = AuthEntity(
//     token: "mock-access-token-jwt-value",
//     refreshToken: "mock-refresh-token-jwt-value",
//     expiresAt: defaultDate,
//     tokenType: "Bearer",
//   );

//   static final LoginEntity loginEntity = LoginEntity(
//     auth: authEntity,
//     user: userEntity,
//   );

//   static final ProfileEntity profileEntity = ProfileEntity(
//     profileId: "profile-1",
//     userId: userId,
//     phoneNumber: "+15550199",
//     bio: "Adventurous student from Bangkok exploring Yellowstone this summer!",
//     avatarUrl: "https://example.com/assets/avatars/john_doe.jpg",
//     radarVisibility: RadarVisibility.showFriends,
//     currentCoordinates: "44.4279,-110.5884",
//     locationUpdatedAt: defaultDate,
//     updatedAt: defaultDate,
//   );

//   static final UserAccountEntity userEntity = UserAccountEntity(
//     userId: userId,
//     email: email,
//     firstName: "John",
//     lastName: "Doe",
//     currentPhaseId: phaseId,
//     totalLifetimePoints: 250,
//     currentPhasePoints: 150,
//     missionStreak: 3,
//     arrivalDate: defaultDate,
//     jobStartDate: defaultDate,
//     createdAt: defaultDate,
//     updatedAt: defaultDate,
//     profileId: "profile-1",
//     phoneNumber: "+15550199",
//     bio: "Adventurous student from Bangkok exploring Yellowstone this summer!",
//     avatarUrl: "https://example.com/assets/avatars/john_doe.jpg",
//     radarVisibility: RadarVisibility.showFriends,
//     currentCoordinates: "44.4279,-110.5884",
//     locationUpdatedAt: defaultDate,
//   );

//   static final CreditScoreEntity creditScoreEntity = CreditScoreEntity(
//     creditId: "credit-score-1",
//     userId: userId,
//     currentScore: 95,
//     lastUpdated: defaultDate,
//   );

//   static final ExpenseSplitEntity expenseSplitEntity = ExpenseSplitEntity(
//     splitId: splitId,
//     transactionId: transactionId,
//     userId: userId,
//     oweAmount: 25.50,
//     paymentStatus: PaymentStatus.pending,
//     paymentMethod: "Venmo",
//     payslipUrl: "https://example.com/files/payslips/tx-707-split.png",
//     approvalStatus: ApprovalStatus.pendingApproval,
//     settledAt: null,
//     updatedAt: defaultDate,
//   );

//   static final ExpenseTransactionEntity expenseTransactionEntity = ExpenseTransactionEntity(
//     transactionId: transactionId,
//     paidByUserId: friendId,
//     title: "Weekly Grocery Split",
//     totalAmount: 76.50,
//     currency: "USD",
//     memo: "Divided equally among three roommates",
//     transactionDate: defaultDate,
//     dueDate: defaultDate,
//     createdAt: defaultDate,
//     updatedAt: defaultDate,
//   );

//   static final FriendshipEntity friendshipEntity = FriendshipEntity(
//     friendshipId: "friendship-x",
//     userId1: userId,
//     userId2: friendId,
//     status: FriendshipStatus.accepted,
//     createdAt: defaultDate,
//     updatedAt: defaultDate,
//   );

//   static final BadgeEntity badgeEntity = BadgeEntity(
//     badgeId: badgeId,
//     title: "First Steps",
//     description: "Earned by completing the onboarding phase.",
//     triggerType: BadgeTriggerType.manual,
//     iconUrl: "https://example.com/assets/badges/first-steps.png",
//     createdAt: defaultDate,
//   );

//   static final JourneyPhaseEntity journeyPhaseEntity = JourneyPhaseEntity(
//     phaseId: phaseId,
//     phaseNumber: 1,
//     title: "Phase 1: Pre-Departure Prep",
//     description: "Complete paperwork, purchase tickets, and upload visa information.",
//     createdAt: defaultDate,
//     updatedAt: defaultDate,
//   );

//   static final PointLedgerEntity pointLedgerEntity = PointLedgerEntity(
//     ledgerId: ledgerId,
//     userId: userId,
//     sourceType: PointSourceType.missionBase,
//     sourceId: userMissionId,
//     delta: 100,
//     lifetimeBalanceAfter: 250,
//     phaseBalanceAfter: 150,
//     note: "Earned for completing DS-2019 Verification",
//     createdAt: defaultDate,
//   );

//   static final PointsAdjustmentResultEntity pointsAdjustmentResultEntity = PointsAdjustmentResultEntity(
//     userId: userId,
//     lifetimeBalanceAfter: 350,
//     phaseBalanceAfter: 250,
//     ledgerId: ledgerId,
//   );

//   static final UserBadgeEntity userBadgeEntity = UserBadgeEntity(
//     userBadgeId: userBadgeId,
//     userId: userId,
//     badgeId: badgeId,
//     sourceId: "source-badge-grant",
//     earnedAt: defaultDate, badge: BadgeEntity(badgeId: "badgeId", title: "title", triggerType: BadgeTriggerType.streak, createdAt: DateTime.now()),
//   );

//   static final JobHousingEntity jobHousingEntity = JobHousingEntity(
//     housingId: housingId,
//     jobId: jobId,
//     description: "Cozy student dorms with single rooms and shared kitchen facilities.",
//     weeklyRate: 120.0,
//     deposit: 300.0,
//     transportation: "Bikes provided, public bus stop 5 minutes walking distance.",
//     rangeMinStartDate: defaultDate,
//     rangeMaxStartDate: defaultDate,
//     createdAt: defaultDate,
//     updatedAt: defaultDate,
//   );

//   static final JobOverallRatingEntity jobOverallRatingEntity = JobOverallRatingEntity(
//     ratingSummaryId: ratingSummaryId,
//     jobId: jobId,
//     overallRate: 4.5,
//     agencyRate: 4.2,
//     jobRate: 4.6,
//     coworkersRate: 4.8,
//     townRate: 4.3,
//     hoursRate: 4.1,
//     housingRate: 4.0,
//     secondJobFeasibilityRate: 3.5,
//     overtimeAvailabilityRate: 4.4,
//     reviewCount: 15,
//     updatedAt: defaultDate,
//   );

//   static final JobPostingEntity jobPostingEntity = JobPostingEntity(
//     jobId: jobId,
//     agencyName: "InterExchange",
//     employerTitle: "Yellowstone National Park Lodge",
//     position: "Food Service Associate",
//     positionType: "Hospitality",
//     locationCity: "Yellowstone",
//     locationState: "WY",
//     groupLocation: "National Parks",
//     usSponsor: true,
//     salaryRangeMin: 14.50,
//     salaryRangeMax: 16.00,
//     availableSlots: 5,
//     description: "Great opportunity to work in a world-famous National Park! Duties include assisting with food prep, cash handling, and customer service.",
//     sourceUrl: "https://example.com/jobs/yellowstone-food-service",
//     scrapeAt: defaultDate,
//     postedAt: defaultDate,
//     updatedAt: defaultDate,
//   );

//   static final UserCartEntity userCartEntity = UserCartEntity(
//     cartId: cartId,
//     userId: userId,
//     jobId: jobId,
//     status: CartStatus.saved,
//     createdAt: defaultDate,
//     updatedAt: defaultDate,
//   );

//   static final AssignedJobEntity userJobEntity = AssignedJobEntity(
//     userId: userId,
//     jobId: jobId,
//     assignedAt: defaultDate,
//     isMain: true,
//     startDate: defaultDate,
//     endDate: defaultDate,
//   );

//   static final JobReviewEntity jobReviewEntity = JobReviewEntity(
//     reviewId: reviewId,
//     jobId: jobId,
//     userId: friendId,
//     ratingStars: 5.0,
//     reviewText: "Amazing experience! The manager was super nice and I met friends from all over the world.",
//     tipsForNextGeneration: "Pack warm clothes because nights in Wyoming get very cold, even in July.",
//     scoreHours: 45.0,
//     scoreAgency: 4.0,
//     scoreJob: 5.0,
//     scoreCoworkers: 5.0,
//     scoreTown: 4.0,
//     scoreHousing: 4.0,
//     scoreSecondJobFeasibility: 3.0,
//     scoreOvertimeAvailability: 4.5,
//     createdAt: defaultDate,
//     updatedAt: defaultDate,
//   );

//   static final MissionEntity missionEntity = MissionEntity(
//     missionId: missionId,
//     phaseId: phaseId,
//     title: "Upload DS-2019 Document",
//     description: "Provide a scanned copy of your official DS-2019 form issued by your sponsor.",
//     location: "Online / Mobile App",
//     basePoints: 100,
//     isMandatory: true,
//     verificationType: VerificationType.upload,
//     // dueDateType: "Relative",
//     // fixedDueDate: null,
//     // relativeTriggerEvent: "OnboardingComplete",
//     // relativeDaysOffset: 7,
//     isActive: true,
//     isLocked: false,
//     createdAt: defaultDate,
//     updatedAt: defaultDate,
//   );

//   static final TaskEntity taskEntity = TaskEntity(
//     taskId: taskId,
//     missionId: missionId,
//     title: "Scan DS-2019",
//     description: "Ensure the scan is clear, matches your passport details, and is in PDF format.",
//     createdAt: defaultDate,
//     updatedAt: defaultDate,
//   );

//   static final UserMissionEntity userMissionEntity = UserMissionEntity(
//     userMissionId: userMissionId,
//     userId: userId,
//     missionId: missionId,
//     status: UserMissionStatus.completed,
//     calculatedDueDate: defaultDate,
//     proofUrl: "https://example.com/proofs/user-12345/ds2019.pdf",
//     proofSubmittedAt: defaultDate,
//     verifiedAt: defaultDate,
//     verifiedBy: "admin-system",
//     // basePointsEarned: 100,
//     // speedBonusPoints: 20,
//     // streakBonusPoints: 10,
//     // firstCompleterBonusPoints: 0,
//     // totalPointsEarned: 130,
//     // rewardedAt: defaultDate,
//     createdAt: defaultDate,
//     updatedAt: defaultDate,
//   );

//   static final UserPhaseHistoryEntity userPhaseHistoryEntity = UserPhaseHistoryEntity(
//     historyId: historyId,
//     userId: userId,
//     phaseId: phaseId,
//     phasePointsEarned: 150,
//     enteredAt: defaultDate,
//     completedAt: defaultDate,
//   );

//   static final UserTaskEntity userTaskEntity = UserTaskEntity(
//     userTaskId: userTaskId,
//     userId: userId,
//     taskId: taskId,
//     userMissionId: userMissionId,
//     isCompleted: true,
//     completedAt: defaultDate,
//     updatedAt: defaultDate,
//   );

//   static final NotificationEntity notificationEntity = NotificationEntity(
//     notificationId: notificationId,
//     userId: userId,
//     title: "Mission Completed!",
//     body: "Your DS-2019 form has been verified. You've earned 100 points!",
//     isRead: false,
//     createdAt: defaultDate,
//   );

//   // ==============================================================================================================================
//   // 3. API DTO MODELS MOCKS
//   // ==============================================================================================================================
  
//   static final AdjustPointsRequest adjustPointsRequest = AdjustPointsRequest(
//     pointsDelta: 50,
//     reason: "Bonus points for early submission",
//   );

//   static final VerifyMissionRequest verifyMissionRequest = VerifyMissionRequest(
//     approved: true,
//     rejectionReason: null,
//   );

//   static final FieldError fieldError = FieldError(
//     field: "email",
//     reason: "Enter a valid email address.",
//   );

//   static final ApiError apiError = ApiError(
//     code: "validation_failed",
//     message: "One or more validation constraints failed.",
//     details: [fieldError],
//   );

//   static final AuthRefreshRequest authRefreshRequest = AuthRefreshRequest(
//     refreshToken: "mock-refresh-token-jwt-value",
//   );

//   static final ForgotPasswordRequest forgotPasswordRequest = ForgotPasswordRequest(
//     email: email,
//   );

//   static final LoginRequest loginRequest = LoginRequest(
//     email: email,
//     password: "StrongSecurePassword123!",
//   );

//   static final LogoutRequest logoutRequest = LogoutRequest(
//     refreshToken: "mock-refresh-token-jwt-value",
//   );

//   static final RegisterRequest registerRequest = RegisterRequest(
//     email: email,
//     password: "StrongSecurePassword123!",
//     firstName: "John",
//     lastName: "Doe",
//   );

//   static final ResetPasswordRequest resetPasswordRequest = ResetPasswordRequest(
//     token: "mock-password-reset-token",
//     newPassword: "NewStrongSecurePassword789!",
//   );

//   static final ExpenseSplitRequest expenseSplitRequest = ExpenseSplitRequest(
//     userId: friendId,
//     oweAmount: 25.50,
//   );

//   static final CreateExpenseRequest createExpenseRequest = CreateExpenseRequest(
//     title: "Weekly Grocery Split",
//     totalAmount: 76.50,
//     currency: "USD",
//     memo: "Divided equally among three roommates",
//     dueDate: "2026-07-02T12:00:00Z",
//     splits: [
//       ExpenseSplitRequest(userId: userId, oweAmount: 25.50),
//       ExpenseSplitRequest(userId: friendId, oweAmount: 25.50),
//       ExpenseSplitRequest(userId: "user-9999", oweAmount: 25.50),
//     ],
//   );

//   static final ExpenseDetailResponse expenseDetailResponse = ExpenseDetailResponse(
//     transaction: expenseTransactionEntity,
//     splits: [],
//   );

//   static final RespondFriendRequest respondFriendRequest = RespondFriendRequest(
//     accept: true,
//     status: "accepted",
//   );

//   static final SendFriendRequest sendFriendRequest = SendFriendRequest(
//     targetUserId: friendId,
//   );

//   static final RadarEntry radarEntry = RadarEntry(
//     userId: friendId,
//     username: "jane.doe",
//     firstName: "Jane",
//     lastName: "Doe",
//     avatarUrl: "https://example.com/assets/avatars/jane_doe.jpg",
//     latitude: 44.4281,
//     longitude: -110.5888,
//     distance: 120.5,
//   );

//   static final LeaderboardEntry leaderboardEntry = LeaderboardEntry(
//     rank: 1,
//     userId: userId,
//     name: "John Doe",
//     points: 250,
//     streak: 3,
//     badges: ["First Steps", "Quick Starter"],
//   );

//   static final PhaseTransitionResult phaseTransitionResult = PhaseTransitionResult(
//     transitioned: true,
//     previousPhaseId: phaseId,
//     newPhaseId: "phase-2",
//     pointsRewarded: 50,
//     completedAt: defaultDateStr,
//   );

//   static final AddToCartRequest addToCartRequest = AddToCartRequest(
//     jobId: jobId,
//   );

//   static final AssignJobRequest assignJobRequest = AssignJobRequest(
//     jobId: jobId,
//     isMain: true,
//     startDate: defaultDateStr,
//     endDate: defaultDateStr,
//   );

//   static final CreateReviewAlternativeRequest createReviewAlternativeRequest = CreateReviewAlternativeRequest(
//     jobId: jobId,
//     ratingStars: 4.5,
//     reviewText: "Great manager, good hours.",
//   );

//   static final CreateReviewRequest createReviewRequest = CreateReviewRequest(
//     jobId: jobId,
//     ratingStars: 4.5,
//     reviewText: "Great manager, good hours.",
//   );

//   static final JobDetailResponse jobDetailResponse = JobDetailResponse(
//     job: jobPostingEntity,
//     housing: [jobHousingEntity],
//     rating: jobOverallRatingEntity,
//   );

//   static final PatchJobRequest patchJobRequest = PatchJobRequest(
//     jobId: jobId,
//     position: "Lead Food Service Associate",
//     salaryRangeMin: 15.50,
//     availableSlots: 4,
//   );

//   static final UpdateCartStatusRequest updateCartStatusRequest = UpdateCartStatusRequest(
//     status: "saved",
//   );

//   static final PaginationInfo paginationInfo = PaginationInfo(
//     page: 1,
//     pageSize: 10,
//     totalItems: 45,
//     totalPages: 5,
//   );

//   static final PaginationResponse<JobPostingEntity> jobPostingListResponse = PaginationResponse<JobPostingEntity>(
//     data: [jobPostingEntity],
//     pagination: paginationInfo,
//   );

//   static final MissionDetailResponse missionDetailResponse = MissionDetailResponse(
//     mission: missionEntity,
//     userMission: userMissionEntity,
//     tasks: [taskEntity],
//     userTasks: [userTaskEntity],
//   );

//   static final PendingVerificationsResponse pendingVerificationsResponse = PendingVerificationsResponse(
//     data: [userMissionEntity],
//   );

//   static final ToggleTaskRequest toggleTaskRequest = ToggleTaskRequest(
//     completed: true,
//     isCompleted: true,
//   );

//   static final VerifyMissionResponse verifyMissionResponse = VerifyMissionResponse(
//     userMissionId: userMissionId,
//     status: "verified",
//     verifiedAt: defaultDateStr,
//     verifiedBy: "admin-system",
//   );

//   static final UploadMediaResponse uploadMediaResponse = UploadMediaResponse(
//     url: "https://s3.amazonaws.com/wat-proofs/visa_scan.jpg",
//     key: "proofs/visa_scan.jpg",
//   );

//   static final DeleteAccountRequest deleteAccountRequest = DeleteAccountRequest(
//     currentPassword: "StrongSecurePassword123!",
//   );

//   static final UpdateLocationRequest updateLocationRequest = UpdateLocationRequest(
//     latitude: 44.4279,
//     longitude: -110.5884,
//   );

//   static final UpdatePasswordRequest updatePasswordRequest = UpdatePasswordRequest(
//     currentPassword: "StrongSecurePassword123!",
//     newPassword: "SuperNewStrongSecurePassword999!",
//   );

//   static final UpdateProfileRequest updateProfileRequest = UpdateProfileRequest(
//     firstName: "Johnathan",
//     bio: "An upgraded student bio.",
//   );

//   static final UpdateSettingsRequest updateSettingsRequest = UpdateSettingsRequest(
//     radarVisibility: "friends",
//     pushNotifications: true,
//   );

// }
