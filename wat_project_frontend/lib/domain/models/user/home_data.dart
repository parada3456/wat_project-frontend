import 'package:wat_project_frontend/domain/models/user_models.dart';
import 'package:wat_project_frontend/domain/models/journey_models.dart';
import 'package:wat_project_frontend/domain/models/mission_models.dart';

class HomeData {
  final UserModel user;
  final JourneyPhaseModel currentPhase;
  final List<JourneyPhaseModel> allPhases;
  final List<MissionModel> phaseMissions;
  final bool isMock;

  const HomeData({
    required this.user,
    required this.currentPhase,
    required this.allPhases,
    required this.phaseMissions,
    this.isMock = false,
  });
}
