import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wat_project_frontend/core/error/failures.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/friend_radar/radar_entry.dart';
import 'package:wat_project_frontend/domain/repositories/friend_repository.dart';

@injectable
class GetRadarUsersUseCase {
  final FriendRepository _repository;

  GetRadarUsersUseCase(this._repository);

  Future<Either<Failure, List<RadarEntry>>> call() async {
    try {
      final result = await _repository.getRadar();
      return Right(result);
    } catch (e) {
      return Left(mapExceptionToFailure(e));
    }
  }
}
