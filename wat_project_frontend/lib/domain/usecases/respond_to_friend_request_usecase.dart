import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wat_project_frontend/core/error/failures.dart';
import 'package:wat_project_frontend/domain/repositories/friend_repository.dart';

@injectable
class RespondToFriendRequestUseCase {
  final FriendRepository _repository;

  RespondToFriendRequestUseCase(this._repository);

  Future<Either<Failure, bool>> call(String friendshipId, bool accept) async {
    try {
      await _repository.respondToRequest(friendshipId, accept);
      return const Right(true);
    } catch (e) {
      return Left(mapExceptionToFailure(e));
    }
  }
}
