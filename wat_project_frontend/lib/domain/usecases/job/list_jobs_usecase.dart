import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wat_project_frontend/core/error/failures.dart';
import 'package:wat_project_frontend/domain/models/job_models.dart';
import 'package:wat_project_frontend/domain/repositories/job_repository.dart';

import 'package:wat_project_frontend/domain/models/paged_model.dart';
import 'package:wat_project_frontend/data/entities/job_review/job/job_posting_entity.dart';

@injectable
class ListJobsUseCase {
  final JobRepository _repository;

  ListJobsUseCase(this._repository);

  Future<Either<Failure, PagedModel<JobPostingModel>>> call(
    Map<String, dynamic> filters, {
    int page = 1,
    int pageSize = 10,
  }) async {
    try {
      final queryFilters = {
        ...filters,
        'page': page,
        'pageSize': pageSize,
      };
      final response = await _repository.listJobs(queryFilters);
      final models = response.data.map((e) => e.toModel()).toList();
      final totalPages = response.pagination?.totalPages ??
          (models.length == pageSize ? page + 1 : page);

      return Right(PagedModel<JobPostingModel>.fromResponse(
        updatedItems: models,
        serverCurrentPage: page,
        totalPages: totalPages,
        pageSize: pageSize,
      ));
    } catch (e) {
      return Left(mapExceptionToFailure(e));
    }
  }
}
