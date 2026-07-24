// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leaderboard_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeaderboardEntry _$LeaderboardEntryFromJson(Map<String, dynamic> json) =>
    LeaderboardEntry(
      rank: (json['rank'] as num).toInt(),
      user: ShortUserEntity.fromJson(json['user'] as Map<String, dynamic>),
      points: (json['points'] as num).toInt(),
      streak: (json['streak'] as num).toInt(),
      badges: (json['badges'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$LeaderboardEntryToJson(LeaderboardEntry instance) =>
    <String, dynamic>{
      'rank': instance.rank,
      'user': instance.user,
      'points': instance.points,
      'streak': instance.streak,
      'badges': instance.badges,
    };
