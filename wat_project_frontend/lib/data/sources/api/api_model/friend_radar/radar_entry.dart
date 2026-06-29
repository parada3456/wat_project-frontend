import 'package:json_annotation/json_annotation.dart';

part 'radar_entry.g.dart';

@JsonSerializable()
class RadarEntry {
  @JsonKey(name: 'user_id')
  final String userId;
  final String username;
  @JsonKey(name: 'first_name')
  final String? firstName;
  @JsonKey(name: 'last_name')
  final String? lastName;
  @JsonKey(name: 'avatar_url')
  final String? avatarUrl;
  final double latitude;
  final double longitude;
  final double? distance;

  RadarEntry({
    required this.userId,
    required this.username,
    this.firstName,
    this.lastName,
    this.avatarUrl,
    required this.latitude,
    required this.longitude,
    this.distance,
  });

  String get name => username;
  double get lat => latitude;
  double get lng => longitude;

  factory RadarEntry.fromJson(Map<String, dynamic> json) =>
      _$RadarEntryFromJson(json);
}
