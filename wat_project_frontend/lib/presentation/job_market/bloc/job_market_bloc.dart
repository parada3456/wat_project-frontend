import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wat_project_frontend/data/entities/job_review/job/job_detail_response.dart';
import 'package:wat_project_frontend/data/entities/job_review/review/job_review_entity.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/job_review/create_review_request.dart';
import 'package:wat_project_frontend/domain/models/job/job_posting_model.dart';
import 'package:wat_project_frontend/domain/models/job/user_cart_model.dart';
import 'package:wat_project_frontend/domain/models/job/user_job_model.dart';
import 'package:wat_project_frontend/domain/usecases/job_usecases.dart';
import 'package:wat_project_frontend/domain/ui_status/ui_status.dart';

part 'job_market_event.dart';
part 'job_market_state.dart';
part 'job_market_bloc.freezed.dart'; // Ensure matching name with file name if needed

class JobMarketBloc extends Bloc<JobMarketEvent, JobMarketState> {
  final ListJobsUseCase _listJobsUseCase;
  final GetJobDetailUseCase _getJobDetailUseCase;
  final AddJobToCartUseCase _addJobToCartUseCase;
  final ListCartItemsUseCase _listCartItemsUseCase;
  final RemoveJobFromCartUseCase _removeJobFromCartUseCase;
  final CreateJobReviewUseCase _createJobReviewUseCase;
  final ListApplicationsUseCase _listApplicationsUseCase;
  final ListJobReviewsUseCase _listJobReviewsUseCase;
  final UpdateCartStatusUseCase _updateCartStatusUseCase;
  final CreateJobUseCase _createJobUseCase;
  final UpdateJobUseCase _updateJobUseCase;
  final DeleteJobUseCase _deleteJobUseCase;

  JobMarketBloc({
    required ListJobsUseCase listJobsUseCase,
    required GetJobDetailUseCase getJobDetailUseCase,
    required AddJobToCartUseCase addJobToCartUseCase,
    required ListCartItemsUseCase listCartItemsUseCase,
    required RemoveJobFromCartUseCase removeJobFromCartUseCase,
    required CreateJobReviewUseCase createJobReviewUseCase,
    required ListApplicationsUseCase listApplicationsUseCase,
    required ListJobReviewsUseCase listJobReviewsUseCase,
    required UpdateCartStatusUseCase updateCartStatusUseCase,
    required CreateJobUseCase createJobUseCase,
    required UpdateJobUseCase updateJobUseCase,
    required DeleteJobUseCase deleteJobUseCase,
  }) : _listJobsUseCase = listJobsUseCase,
       _getJobDetailUseCase = getJobDetailUseCase,
       _addJobToCartUseCase = addJobToCartUseCase,
       _listCartItemsUseCase = listCartItemsUseCase,
       _removeJobFromCartUseCase = removeJobFromCartUseCase,
       _createJobReviewUseCase = createJobReviewUseCase,
       _listApplicationsUseCase = listApplicationsUseCase,
       _listJobReviewsUseCase = listJobReviewsUseCase,
       _updateCartStatusUseCase = updateCartStatusUseCase,
       _createJobUseCase = createJobUseCase,
       _updateJobUseCase = updateJobUseCase,
       _deleteJobUseCase = deleteJobUseCase,
       super(const JobMarketState()) {
    on<ListJobsEvent>(_onListJobs);
    on<GetJobDetailEvent>(_onGetJobDetail);
    on<AddJobToCartEvent>(_onAddJobToCart);
    on<ListCartItemsEvent>(_onListCartItems);
    on<RemoveJobFromCartEvent>(_onRemoveJobFromCart);
    on<CreateJobReviewEvent>(_onCreateJobReview);
    on<ListApplicationsEvent>(_onListApplications);
    on<ListJobReviewsEvent>(_onListJobReviews);
    on<UpdateCartStatusEvent>(_onUpdateCartStatus);
    on<CreateJobEvent>(_onCreateJob);
    on<UpdateJobEvent>(_onUpdateJob);
    on<DeleteJobEvent>(_onDeleteJob);
  }

  Future<void> _onListJobs(
    ListJobsEvent event,
    Emitter<JobMarketState> emit,
  ) async {
    emit(state.copyWith(status: const UIStatus.loading()));
    final result = await _listJobsUseCase(event.filters);
    result.fold(
      (failure) => emit(
        state.copyWith(status: UIStatus.loadFailed(message: failure.message)),
      ),
      (jobs) => emit(
        state.copyWith(status: const UIStatus.loadSuccess(), jobs: jobs),
      ),
    );
  }

  Future<void> _onGetJobDetail(
    GetJobDetailEvent event,
    Emitter<JobMarketState> emit,
  ) async {
    emit(state.copyWith(status: const UIStatus.loading()));
    final result = await _getJobDetailUseCase(event.jobId);
    result.fold(
      (failure) => emit(
        state.copyWith(status: UIStatus.loadFailed(message: failure.message)),
      ),
      (jobDetail) => emit(
        state.copyWith(
          status: const UIStatus.loadSuccess(),
          jobDetail: jobDetail,
        ),
      ),
    );
  }

  Future<void> _onAddJobToCart(
    AddJobToCartEvent event,
    Emitter<JobMarketState> emit,
  ) async {
    emit(state.copyWith(addToCartStatus: const UIStatus.loading()));
    final result = await _addJobToCartUseCase(event.jobId);
    result.fold(
      (failure) => emit(
        state.copyWith(
          addToCartStatus: UIStatus.loadFailed(message: failure.message),
        ),
      ),
      (_) {
        emit(state.copyWith(addToCartStatus: const UIStatus.loadSuccess()));
        add(const JobMarketEvent.listCartItems());
      },
    );
  }

  Future<void> _onListCartItems(
    ListCartItemsEvent event,
    Emitter<JobMarketState> emit,
  ) async {
    emit(state.copyWith(status: const UIStatus.loading()));
    final result = await _listCartItemsUseCase();
    result.fold(
      (failure) => emit(
        state.copyWith(status: UIStatus.loadFailed(message: failure.message)),
      ),
      (cartItems) => emit(
        state.copyWith(
          status: const UIStatus.loadSuccess(),
          cartItems: cartItems,
        ),
      ),
    );
  }

  Future<void> _onRemoveJobFromCart(
    RemoveJobFromCartEvent event,
    Emitter<JobMarketState> emit,
  ) async {
    emit(state.copyWith(removeFromCartStatus: const UIStatus.loading()));
    final result = await _removeJobFromCartUseCase(event.cartItemId);
    result.fold(
      (failure) => emit(
        state.copyWith(
          removeFromCartStatus: UIStatus.loadFailed(message: failure.message),
        ),
      ),
      (_) {
        emit(
          state.copyWith(removeFromCartStatus: const UIStatus.loadSuccess()),
        );
        add(const JobMarketEvent.listCartItems());
      },
    );
  }

  Future<void> _onCreateJobReview(
    CreateJobReviewEvent event,
    Emitter<JobMarketState> emit,
  ) async {
    emit(state.copyWith(createReviewStatus: const UIStatus.loading()));
    final result = await _createJobReviewUseCase(event.request);
    result.fold(
      (failure) => emit(
        state.copyWith(
          createReviewStatus: UIStatus.loadFailed(message: failure.message),
        ),
      ),
      (_) {
        emit(state.copyWith(createReviewStatus: const UIStatus.loadSuccess()));
        add(JobMarketEvent.listJobReviews(jobId: event.request.jobId));
      },
    );
  }

  Future<void> _onListApplications(
    ListApplicationsEvent event,
    Emitter<JobMarketState> emit,
  ) async {
    emit(state.copyWith(status: const UIStatus.loading()));
    final result = await _listApplicationsUseCase();
    result.fold(
      (failure) => emit(
        state.copyWith(status: UIStatus.loadFailed(message: failure.message)),
      ),
      (applications) => emit(
        state.copyWith(
          status: const UIStatus.loadSuccess(),
          applications: applications,
        ),
      ),
    );
  }

  Future<void> _onListJobReviews(
    ListJobReviewsEvent event,
    Emitter<JobMarketState> emit,
  ) async {
    // If we already have job details, we might not want to show full screen status loading.
    // However, sticking to the standard workflow:
    emit(state.copyWith(status: const UIStatus.loading()));
    final result = await _listJobReviewsUseCase(event.jobId);
    result.fold(
      (failure) => emit(
        state.copyWith(status: UIStatus.loadFailed(message: failure.message)),
      ),
      (reviews) => emit(
        state.copyWith(status: const UIStatus.loadSuccess(), reviews: reviews),
      ),
    );
  }

  Future<void> _onUpdateCartStatus(
    UpdateCartStatusEvent event,
    Emitter<JobMarketState> emit,
  ) async {
    emit(state.copyWith(updateCartStatus: const UIStatus.loading()));
    final result = await _updateCartStatusUseCase(event.cartId, event.status);
    result.fold(
      (failure) => emit(
        state.copyWith(
          updateCartStatus: UIStatus.loadFailed(message: failure.message),
        ),
      ),
      (_) =>
          emit(state.copyWith(updateCartStatus: const UIStatus.loadSuccess())),
    );
  }

  Future<void> _onCreateJob(
    CreateJobEvent event,
    Emitter<JobMarketState> emit,
  ) async {
    emit(state.copyWith(createJobStatus: const UIStatus.loading()));
    final result = await _createJobUseCase(event.job);
    result.fold(
      (failure) => emit(
        state.copyWith(
          createJobStatus: UIStatus.loadFailed(message: failure.message),
        ),
      ),
      (_) {
        emit(state.copyWith(createJobStatus: const UIStatus.loadSuccess()));
        add(const JobMarketEvent.listJobs(filters: {}));
      },
    );
  }

  Future<void> _onUpdateJob(
    UpdateJobEvent event,
    Emitter<JobMarketState> emit,
  ) async {
    emit(state.copyWith(updateJobStatus: const UIStatus.loading()));
    final result = await _updateJobUseCase(event.id, event.job);
    result.fold(
      (failure) => emit(
        state.copyWith(
          updateJobStatus: UIStatus.loadFailed(message: failure.message),
        ),
      ),
      (_) {
        emit(state.copyWith(updateJobStatus: const UIStatus.loadSuccess()));
        add(const JobMarketEvent.listJobs(filters: {}));
      },
    );
  }

  Future<void> _onDeleteJob(
    DeleteJobEvent event,
    Emitter<JobMarketState> emit,
  ) async {
    emit(state.copyWith(deleteJobStatus: const UIStatus.loading()));
    final result = await _deleteJobUseCase(event.id);
    result.fold(
      (failure) => emit(
        state.copyWith(
          deleteJobStatus: UIStatus.loadFailed(message: failure.message),
        ),
      ),
      (_) {
        emit(state.copyWith(deleteJobStatus: const UIStatus.loadSuccess()));
        add(const JobMarketEvent.listJobs(filters: {}));
      },
    );
  }
}
