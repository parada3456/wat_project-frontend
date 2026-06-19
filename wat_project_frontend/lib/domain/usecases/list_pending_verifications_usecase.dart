import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wat_project_frontend/core/error/failures.dart';
import 'package:wat_project_frontend/domain/models/user_mission_model.dart';
import 'package:wat_project_frontend/domain/repositories/admin_repository.dart';

@injectable
class ListPendingVerificationsUseCase {
  final AdminRepository _repository;

  ListPendingVerificationsUseCase(this._repository);

  Future<Either<Failure, List<UserMissionModel>>> call() async {
    try {
      final result = await _repository.listPendingVerifications();
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
