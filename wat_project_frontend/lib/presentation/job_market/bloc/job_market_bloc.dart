import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wat_project_frontend/domain/usecases/job_usecases.dart';
import 'package:wat_project_frontend/presentation/job_market/bloc/job_market_event.dart';
import 'package:wat_project_frontend/presentation/job_market/bloc/job_market_state.dart';

class JobMarketBloc extends Bloc<JobMarketEvent, JobMarketState> {
  final ListJobsUseCase _listJobsUseCase;
  final GetJobDetailUseCase _getJobDetailUseCase;
  final AddJobToCartUseCase _addJobToCartUseCase;
  final ListCartItemsUseCase _listCartItemsUseCase;
  final RemoveJobFromCartUseCase _removeJobFromCartUseCase;
  final CreateJobReviewUseCase _createJobReviewUseCase;
  final ListApplicationsUseCase _listApplicationsUseCase;

  JobMarketBloc({
    required ListJobsUseCase listJobsUseCase,
    required GetJobDetailUseCase getJobDetailUseCase,
    required AddJobToCartUseCase addJobToCartUseCase,
    required ListCartItemsUseCase listCartItemsUseCase,
    required RemoveJobFromCartUseCase removeJobFromCartUseCase,
    required CreateJobReviewUseCase createJobReviewUseCase,
    required ListApplicationsUseCase listApplicationsUseCase,
  }) : _listJobsUseCase = listJobsUseCase,
       _getJobDetailUseCase = getJobDetailUseCase,
       _addJobToCartUseCase = addJobToCartUseCase,
       _listCartItemsUseCase = listCartItemsUseCase,
       _removeJobFromCartUseCase = removeJobFromCartUseCase,
       _createJobReviewUseCase = createJobReviewUseCase,
       _listApplicationsUseCase = listApplicationsUseCase,
       super(const JobMarketInitial()) {
    on<ListJobsEvent>(_onListJobs);
    on<GetJobDetailEvent>(_onGetJobDetail);
    on<AddJobToCartEvent>(_onAddJobToCart);
    on<ListCartItemsEvent>(_onListCartItems);
    on<RemoveJobFromCartEvent>(_onRemoveJobFromCart);
    on<CreateJobReviewEvent>(_onCreateJobReview);
    on<ListApplicationsEvent>(_onListApplications);
  }

  Future<void> _onListJobs(
    ListJobsEvent event,
    Emitter<JobMarketState> emit,
  ) async {
    emit(const JobMarketLoading());
    final result = await _listJobsUseCase(event.filters);
    result.fold(
      (failure) => emit(JobMarketFailure(failure.message)),
      (jobs) => emit(ListJobsSuccess(jobs)),
    );
  }

  Future<void> _onGetJobDetail(
    GetJobDetailEvent event,
    Emitter<JobMarketState> emit,
  ) async {
    emit(const JobMarketLoading());
    final result = await _getJobDetailUseCase(event.jobId);
    result.fold(
      (failure) => emit(JobMarketFailure(failure.message)),
      (jobDetail) => emit(GetJobDetailSuccess(jobDetail)),
    );
  }

  Future<void> _onAddJobToCart(
    AddJobToCartEvent event,
    Emitter<JobMarketState> emit,
  ) async {
    emit(const JobMarketLoading());
    final result = await _addJobToCartUseCase(event.jobId);
    result.fold(
      (failure) => emit(JobMarketFailure(failure.message)),
      (_) => emit(const AddJobToCartSuccess()),
    );
  }

  Future<void> _onListCartItems(
    ListCartItemsEvent event,
    Emitter<JobMarketState> emit,
  ) async {
    emit(const JobMarketLoading());
    final result = await _listCartItemsUseCase();
    result.fold(
      (failure) => emit(JobMarketFailure(failure.message)),
      (cartItems) => emit(ListCartItemsSuccess(cartItems)),
    );
  }

  Future<void> _onRemoveJobFromCart(
    RemoveJobFromCartEvent event,
    Emitter<JobMarketState> emit,
  ) async {
    emit(const JobMarketLoading());
    final result = await _removeJobFromCartUseCase(event.cartItemId);
    result.fold(
      (failure) => emit(JobMarketFailure(failure.message)),
      (_) => emit(const RemoveJobFromCartSuccess()),
    );
  }

  Future<void> _onCreateJobReview(
    CreateJobReviewEvent event,
    Emitter<JobMarketState> emit,
  ) async {
    emit(const JobMarketLoading());
    final result = await _createJobReviewUseCase(event.request);
    result.fold(
      (failure) => emit(JobMarketFailure(failure.message)),
      (_) => emit(const CreateJobReviewSuccess()),
    );
  }

  Future<void> _onListApplications(
    ListApplicationsEvent event,
    Emitter<JobMarketState> emit,
  ) async {
    emit(const JobMarketLoading());
    final result = await _listApplicationsUseCase();
    result.fold(
      (failure) => emit(JobMarketFailure(failure.message)),
      (applications) => emit(ListApplicationsSuccess(applications)),
    );
  }
}
