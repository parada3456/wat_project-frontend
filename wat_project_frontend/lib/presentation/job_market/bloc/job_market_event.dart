import 'package:wat_project_frontend/data/sources/api/api_model/job_review/create_review_request.dart';

abstract class JobMarketEvent {
  const JobMarketEvent();
}

class ListJobsEvent extends JobMarketEvent {
  final Map<String, dynamic> filters;
  const ListJobsEvent(this.filters);
}

class GetJobDetailEvent extends JobMarketEvent {
  final String jobId;
  const GetJobDetailEvent(this.jobId);
}

class AddJobToCartEvent extends JobMarketEvent {
  final String jobId;
  const AddJobToCartEvent(this.jobId);
}

class ListCartItemsEvent extends JobMarketEvent {
  const ListCartItemsEvent();
}

class RemoveJobFromCartEvent extends JobMarketEvent {
  final String cartItemId;
  const RemoveJobFromCartEvent(this.cartItemId);
}

class CreateJobReviewEvent extends JobMarketEvent {
  final CreateReviewRequest request;
  const CreateJobReviewEvent(this.request);
}

class ListApplicationsEvent extends JobMarketEvent {
  const ListApplicationsEvent();
}
