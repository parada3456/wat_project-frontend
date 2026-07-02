// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'points_adjustment_result_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PointsAdjustmentResultEntity _$PointsAdjustmentResultEntityFromJson(
  Map<String, dynamic> json,
) => PointsAdjustmentResultEntity(
  userId: json['userId'] as String,
  lifetimeBalanceAfter: (json['lifetimeBalanceAfter'] as num).toInt(),
  phaseBalanceAfter: (json['phaseBalanceAfter'] as num).toInt(),
  ledgerId: json['ledgerId'] as String,
);

Map<String, dynamic> _$PointsAdjustmentResultEntityToJson(
  PointsAdjustmentResultEntity instance,
) => <String, dynamic>{
  'userId': instance.userId,
  'lifetimeBalanceAfter': instance.lifetimeBalanceAfter,
  'phaseBalanceAfter': instance.phaseBalanceAfter,
  'ledgerId': instance.ledgerId,
};
