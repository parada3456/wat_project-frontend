// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'radar_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RadarEntry _$RadarEntryFromJson(Map<String, dynamic> json) => RadarEntry(
  userId: json['user_id'] as String,
  username: json['username'] as String,
  firstName: json['first_name'] as String?,
  lastName: json['last_name'] as String?,
  avatarUrl: json['avatar_url'] as String?,
  latitude: (json['latitude'] as num).toDouble(),
  longitude: (json['longitude'] as num).toDouble(),
  distance: (json['distance'] as num?)?.toDouble(),
);

Map<String, dynamic> _$RadarEntryToJson(RadarEntry instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'username': instance.username,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'avatar_url': instance.avatarUrl,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'distance': instance.distance,
    };
