import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wat_project_frontend/core/error/failures.dart';
import 'package:wat_project_frontend/domain/repositories/notification_repository.dart';

@injectable
class MarkAllNotificationsReadUseCase {
  final NotificationRepository _repository;

  MarkAllNotificationsReadUseCase(this._repository);

  Future<Either<Failure, void>> call() async {
    try {
      await _repository.markAllRead();
      return const Right(null);
    } catch (e) {
      return Left(mapExceptionToFailure(e));
    }
  }
}
