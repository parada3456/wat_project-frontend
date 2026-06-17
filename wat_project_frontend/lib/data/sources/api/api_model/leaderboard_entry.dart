import 'package:json_annotation/json_annotation.dart';

part 'leaderboard_entry.g.dart';

@JsonSerializable()
class LeaderboardEntry {
  final int rank;
  @JsonKey(name: 'user_id')
  final String userId;
  final String name;
  final int points;
  final int streak;
  final List<String> badges;

  LeaderboardEntry({
    required this.rank,
    required this.userId,
    required this.name,
    required this.points,
    required this.streak,
    required this.badges,
  });

  factory LeaderboardEntry.fromJson(Map<String, dynamic> json) =>
      _$LeaderboardEntryFromJson(json);
}
