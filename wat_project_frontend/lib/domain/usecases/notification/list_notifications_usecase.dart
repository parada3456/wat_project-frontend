import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wat_project_frontend/core/error/failures.dart';
import 'package:wat_project_frontend/domain/models/notification_models.dart';
import 'package:wat_project_frontend/domain/repositories/notification_repository.dart';

@injectable
class ListNotificationsUseCase {
  final NotificationRepository _repository;

  ListNotificationsUseCase(this._repository);

  Future<Either<Failure, List<NotificationModel>>> call() async {
    try {
      final result = await _repository.listNotifications();
      return Right(result.map((e) => e.toModel()).toList());
    } catch (e) {
      return Left(mapExceptionToFailure(e));
    }
  }
}
