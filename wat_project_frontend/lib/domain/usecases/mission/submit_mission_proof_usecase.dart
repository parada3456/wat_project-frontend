import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wat_project_frontend/core/error/failures.dart';
import 'package:wat_project_frontend/domain/repositories/mission_repository.dart';

@injectable
class SubmitMissionProofUseCase {
  final MissionRepository _repository;

  SubmitMissionProofUseCase(this._repository);

  Future<Either<Failure, void>> call(String missionId, File? file) async {
    try {
      await _repository.submitProof(missionId, file);
      return const Right(null);
    } catch (e) {
      return Left(mapExceptionToFailure(e));
    }
  }
}
