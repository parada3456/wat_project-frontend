// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mission_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MissionDetailResponse _$MissionDetailResponseFromJson(
  Map<String, dynamic> json,
) => MissionDetailResponse(
  mission: MissionEntity.fromJson(json['mission'] as Map<String, dynamic>),
  userMission: UserMissionEntity.fromJson(
    json['user_mission'] as Map<String, dynamic>,
  ),
  tasks: (json['tasks'] as List<dynamic>).map((e) => e as String).toList(),
  userTasks: (json['user_tasks'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
);

Map<String, dynamic> _$MissionDetailResponseToJson(
  MissionDetailResponse instance,
) => <String, dynamic>{
  'mission': instance.mission,
  'user_mission': instance.userMission,
  'tasks': instance.tasks,
  'user_tasks': instance.userTasks,
};
