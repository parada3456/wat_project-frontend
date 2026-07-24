import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_credit_model.freezed.dart';

@freezed
abstract class UserCreditModel with _$UserCreditModel {
  const factory UserCreditModel({
    required int rank,
    required String userId,
    required String name,
    String? avatarUrl,
    required int creditScore,
  }) = _UserCreditModel;
}
