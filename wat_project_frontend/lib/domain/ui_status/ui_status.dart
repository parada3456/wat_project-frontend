import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/api_error.dart';

part 'ui_status.freezed.dart';

/// Ui status: initial, loading, loadSuccess and loadFailed
@Freezed(fromJson: false, toJson: false)
class UIStatus with _$UIStatus {
  const factory UIStatus.initial() = UIInitial;

  const factory UIStatus.loading() = UILoading;

  const factory UIStatus.loadFailed({String? message, ApiError? apiError}) =
      UILoadFailed;

  const factory UIStatus.loadSuccess({String? message}) = UILoadSuccess;
}
