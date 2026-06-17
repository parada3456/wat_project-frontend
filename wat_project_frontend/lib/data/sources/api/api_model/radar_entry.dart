import 'package:json_annotation/json_annotation.dart';

part 'radar_entry.g.dart';

@JsonSerializable()
class RadarEntry {
  @JsonKey(name: 'user_id')
  final String userId;
  final String name;
  @JsonKey(name: 'avatar_url')
  final String avatarUrl;
  final double lat;
  final double lng;

  RadarEntry({
    required this.userId,
    required this.name,
    required this.avatarUrl,
    required this.lat,
    required this.lng,
  });

  factory RadarEntry.fromJson(Map<String, dynamic> json) =>
      _$RadarEntryFromJson(json);
}
