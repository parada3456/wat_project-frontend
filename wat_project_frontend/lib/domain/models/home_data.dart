import 'package:wat_project_frontend/domain/models/user_model.dart';
import 'package:wat_project_frontend/domain/models/journey_phase_model.dart';
import 'package:wat_project_frontend/domain/models/mission_detail_model.dart';

class HomeData {
  final UserModel user;
  final JourneyPhaseModel currentPhase;
  final List<JourneyPhaseModel> allPhases;
  final List<MissionDetailModel> phaseMissions;
  final bool isMock;

  const HomeData({
    required this.user,
    required this.currentPhase,
    required this.allPhases,
    required this.phaseMissions,
    this.isMock = false,
  });
}
