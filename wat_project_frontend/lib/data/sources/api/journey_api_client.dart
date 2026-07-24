import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:wat_project_frontend/data/entities/gamification/journey_phase_entity.dart';
import 'package:wat_project_frontend/data/entities/gamification/leaderboard_entry.dart';
import 'package:wat_project_frontend/data/entities/gamification/point_ledger_entity.dart';
import 'package:wat_project_frontend/data/entities/gamification/user_badge_entity.dart';
import 'package:wat_project_frontend/data/entities/gamification/user_credit_entity.dart';
import 'package:wat_project_frontend/data/entities/gamification/user_phase_history_entity.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/gamification/phase_transition_result.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/pagination_response.dart';

part 'journey_api_client.g.dart';

@RestApi()
abstract class JourneyApiService {
  factory JourneyApiService(Dio dio, {String baseUrl}) = _JourneyApiService;

  @GET('journey/phases')
  Future<PaginationResponse<JourneyPhaseEntity>> listPhases();

  @POST('journey/phase-transitions')
  Future<PhaseTransitionResult> advancePhase();

  @GET('journey/history')
  Future<PaginationResponse<UserPhaseHistoryEntity>> getHistory();

  @GET('leaderboard')
  Future<List<LeaderboardEntry>> getLeaderboard(
    @Query('scope') String? scope,
    @Query('job_id') String? jobId,
  );

  @GET('leaderboard/friends/credit-score')
  Future<PaginationResponse<UserCreditEntity>> getFriendsCreditScoreLeaderboard(
    @Query('page') int? page,
    @Query('pageSize') int? pageSize,
  );

  @GET('user/badges')
  Future<PaginationResponse<UserBadgeEntity>> listBadges();

  @GET('user/credit-score/history')
  Future<PaginationResponse<PointLedgerEntity>> getCreditHistory();
}
