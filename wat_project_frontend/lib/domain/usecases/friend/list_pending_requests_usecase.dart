import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wat_project_frontend/core/error/failures.dart';
import 'package:wat_project_frontend/domain/models/friend_models.dart';
import 'package:wat_project_frontend/domain/repositories/friend_repository.dart';

@injectable
class ListPendingRequestsUseCase {
  final FriendRepository _repository;

  ListPendingRequestsUseCase(this._repository);

  Future<Either<Failure, List<FriendshipModel>>> call() async {
    try {
      final result = await _repository.listPendingRequests();
      return Right(result.map((e) => e.toModel()).toList());
    } catch (e) {
      return Left(mapExceptionToFailure(e));
    }
  }
}
