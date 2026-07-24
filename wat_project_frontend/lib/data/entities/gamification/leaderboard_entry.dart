import 'package:json_annotation/json_annotation.dart';
import 'package:wat_project_frontend/data/entities/user/short_user_entity.dart';

part 'leaderboard_entry.g.dart';

@JsonSerializable()
class LeaderboardEntry {
  final int rank;
  final ShortUserEntity user;
  final int points;
  final int streak;
  final List<String> badges;

  LeaderboardEntry({
    required this.rank,
    required this.user,
    required this.points,
    required this.streak,
    required this.badges,
  });

  factory LeaderboardEntry.fromJson(Map<String, dynamic> json) =>
      _$LeaderboardEntryFromJson(json);
}
