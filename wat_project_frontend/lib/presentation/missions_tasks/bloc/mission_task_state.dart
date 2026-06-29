import 'package:wat_project_frontend/domain/models/user_mission_model.dart';
import 'package:wat_project_frontend/domain/models/mission_detail_model.dart';

abstract class MissionTaskState {
  const MissionTaskState();
}

class MissionTaskInitial extends MissionTaskState {
  const MissionTaskInitial();
}

class MissionTaskLoading extends MissionTaskState {
  const MissionTaskLoading();
}

class MissionTaskListSuccess extends MissionTaskState {
  final List<UserMissionModel> missions;
  const MissionTaskListSuccess(this.missions);
}

class MissionTaskDetailSuccess extends MissionTaskState {
  final MissionDetailModel detail;
  const MissionTaskDetailSuccess(this.detail);
}

class MissionTaskProofSubmitSuccess extends MissionTaskState {
  const MissionTaskProofSubmitSuccess();
}

class MissionTaskToggleSuccess extends MissionTaskState {
  final String userMissionId;
  final String taskId;
  final bool completed;

  const MissionTaskToggleSuccess({
    required this.userMissionId,
    required this.taskId,
    required this.completed,
  });
}

class MissionTaskFailure extends MissionTaskState {
  final String message;
  const MissionTaskFailure(this.message);
}
