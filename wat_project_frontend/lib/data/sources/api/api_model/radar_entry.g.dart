// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'radar_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RadarEntry _$RadarEntryFromJson(Map<String, dynamic> json) => RadarEntry(
  userId: json['user_id'] as String,
  name: json['name'] as String,
  avatarUrl: json['avatar_url'] as String,
  lat: (json['lat'] as num).toDouble(),
  lng: (json['lng'] as num).toDouble(),
);

Map<String, dynamic> _$RadarEntryToJson(RadarEntry instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'name': instance.name,
      'avatar_url': instance.avatarUrl,
      'lat': instance.lat,
      'lng': instance.lng,
    };
