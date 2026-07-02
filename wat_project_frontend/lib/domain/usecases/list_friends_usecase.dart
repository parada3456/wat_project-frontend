import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wat_project_frontend/core/error/failures.dart';
import 'package:wat_project_frontend/domain/models/friendship_model.dart';
import 'package:wat_project_frontend/domain/repositories/friend_repository.dart';

@injectable
class ListFriendsUseCase {
  final FriendRepository _repository;

  ListFriendsUseCase(this._repository);

  Future<Either<Failure, List<FriendshipModel>>> call() async {
    try {
      final result = await _repository.listFriends();
      return Right(result.map((e) => e.toModel()).toList());
    } catch (e) {
      return Left(mapExceptionToFailure(e));
    }
  }
}
