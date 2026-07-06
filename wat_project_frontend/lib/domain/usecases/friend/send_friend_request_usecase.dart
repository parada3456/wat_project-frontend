import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wat_project_frontend/core/error/failures.dart';
import 'package:wat_project_frontend/domain/repositories/friend_repository.dart';

@injectable
class SendFriendRequestUseCase {
  final FriendRepository _repository;

  SendFriendRequestUseCase(this._repository);

  Future<Either<Failure, bool>> call(String targetUserId) async {
    try {
      await _repository.sendRequest(targetUserId);
      return const Right(true);
    } catch (e) {
      return Left(mapExceptionToFailure(e));
    }
  }
}
