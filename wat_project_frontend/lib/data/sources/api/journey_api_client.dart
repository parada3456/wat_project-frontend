import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:wat_project_frontend/data/entities/journey_phase_entity.dart';import 'package:wat_project_frontend/data/entities/user_phase_history_entity.dart';import 'package:wat_project_frontend/data/entities/user_badge_entity.dart';import 'package:wat_project_frontend/data/entities/point_ledger_entity.dart';import 'package:wat_project_frontend/data/sources/api/api_model/leaderboard_entry.dart';
part 'journey_api_client.g.dart';

@RestApi()
abstract class JourneyApiService {
  factory JourneyApiService(Dio dio, {String baseUrl}) = _JourneyApiService;

  @GET('/journey/phases')
  Future<List<JourneyPhaseEntity>> listPhases();

  @POST('/journey/phase/transition')
  Future<Map<String, bool>> advancePhase();

  @GET('/journey/history')
  Future<List<UserPhaseHistoryEntity>> getHistory();

  @GET('/leaderboard')
  Future<List<LeaderboardEntry>> getLeaderboard(
    @Query('scope') String? scope,
    @Query('job_id') String? jobId,
  );

  @GET('/user/badges')
  Future<List<UserBadgeEntity>> listBadges();

  @GET('/user/credit-score/history')
  Future<List<PointLedgerEntity>> getCreditHistory();
}
