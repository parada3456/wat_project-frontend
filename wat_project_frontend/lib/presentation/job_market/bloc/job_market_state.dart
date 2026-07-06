import 'package:wat_project_frontend/data/entities/job_review/job/job_detail_response.dart';
import 'package:wat_project_frontend/domain/models/job_models.dart';
import 'package:wat_project_frontend/domain/models/job_models.dart';
import 'package:wat_project_frontend/domain/models/job_models.dart';

abstract class JobMarketState {
  const JobMarketState();
}

class JobMarketInitial extends JobMarketState {
  const JobMarketInitial();
}

class JobMarketLoading extends JobMarketState {
  const JobMarketLoading();
}

class ListJobsSuccess extends JobMarketState {
  final List<JobPostingModel> jobs;
  const ListJobsSuccess(this.jobs);
}

class GetJobDetailSuccess extends JobMarketState {
  final JobDetailResponse jobDetail;
  const GetJobDetailSuccess(this.jobDetail);
}

class ListCartItemsSuccess extends JobMarketState {
  final List<UserCartModel> cartItems;
  const ListCartItemsSuccess(this.cartItems);
}

class AddJobToCartSuccess extends JobMarketState {
  const AddJobToCartSuccess();
}

class RemoveJobFromCartSuccess extends JobMarketState {
  const RemoveJobFromCartSuccess();
}

class CreateJobReviewSuccess extends JobMarketState {
  const CreateJobReviewSuccess();
}

class ListApplicationsSuccess extends JobMarketState {
  final List<UserJobModel> applications;
  const ListApplicationsSuccess(this.applications);
}

class JobMarketFailure extends JobMarketState {
  final String message;
  const JobMarketFailure(this.message);
}
