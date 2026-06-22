import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:wat_project_frontend/data/entities/journey_phase_entity.dart';import 'package:wat_project_frontend/data/entities/user_phase_history_entity.dart';import 'package:wat_project_frontend/data/entities/user_badge_entity.dart';import 'package:wat_project_frontend/data/entities/point_ledger_entity.dart';import 'package:wat_project_frontend/data/sources/api/api_model/leaderboard_entry.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/list_response.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/phase_transition_result.dart';

part 'journey_api_client.g.dart';

@RestApi()
abstract class JourneyApiService {
  factory JourneyApiService(Dio dio, {String baseUrl}) = _JourneyApiService;

  @GET('journey/phases')
  Future<ListResponse<JourneyPhaseEntity>> listPhases();

  @POST('journey/phase-transitions')
  Future<PhaseTransitionResult> advancePhase();

  @GET('journey/history')
  Future<ListResponse<UserPhaseHistoryEntity>> getHistory();

  @GET('leaderboard')
  Future<List<LeaderboardEntry>> getLeaderboard(
    @Query('scope') String? scope,
    @Query('job_id') String? jobId,
  );

  @GET('user/badges')
  Future<ListResponse<UserBadgeEntity>> listBadges();

  @GET('user/credit-score/history')
  Future<ListResponse<PointLedgerEntity>> getCreditHistory();
}
