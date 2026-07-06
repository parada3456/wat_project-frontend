import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wat_project_frontend/core/error/failures.dart';
import 'package:wat_project_frontend/domain/repositories/friend_repository.dart';

@injectable
class RemoveFriendUseCase {
  final FriendRepository _repository;

  RemoveFriendUseCase(this._repository);

  Future<Either<Failure, bool>> call(String friendId) async {
    try {
      await _repository.removeFriend(friendId);
      return const Right(true);
    } catch (e) {
      return Left(mapExceptionToFailure(e));
    }
  }
}
