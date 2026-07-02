// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_settings_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateSettingsRequest _$UpdateSettingsRequestFromJson(
  Map<String, dynamic> json,
) => UpdateSettingsRequest(
  radarVisibility: json['radar_visibility'] as String?,
  pushNotifications: json['push_notifications'] as bool?,
);

Map<String, dynamic> _$UpdateSettingsRequestToJson(
  UpdateSettingsRequest instance,
) => <String, dynamic>{
  'radar_visibility': instance.radarVisibility,
  'push_notifications': instance.pushNotifications,
};
