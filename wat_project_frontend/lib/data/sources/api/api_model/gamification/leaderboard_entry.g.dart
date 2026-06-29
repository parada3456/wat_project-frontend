// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leaderboard_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeaderboardEntry _$LeaderboardEntryFromJson(Map<String, dynamic> json) =>
    LeaderboardEntry(
      rank: (json['rank'] as num).toInt(),
      userId: json['user_id'] as String,
      name: json['name'] as String,
      points: (json['points'] as num).toInt(),
      streak: (json['streak'] as num).toInt(),
      badges: (json['badges'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$LeaderboardEntryToJson(LeaderboardEntry instance) =>
    <String, dynamic>{
      'rank': instance.rank,
      'user_id': instance.userId,
      'name': instance.name,
      'points': instance.points,
      'streak': instance.streak,
      'badges': instance.badges,
    };
