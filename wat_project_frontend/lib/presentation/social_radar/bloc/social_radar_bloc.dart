import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/friend_radar/radar_entry.dart';
import 'package:wat_project_frontend/domain/models/friendship_model.dart';
import 'package:wat_project_frontend/domain/usecases/send_friend_request_usecase.dart';
import 'package:wat_project_frontend/domain/usecases/list_pending_requests_usecase.dart';
import 'package:wat_project_frontend/domain/usecases/respond_to_friend_request_usecase.dart';
import 'package:wat_project_frontend/domain/usecases/list_friends_usecase.dart';
import 'package:wat_project_frontend/domain/usecases/remove_friend_usecase.dart';
import 'package:wat_project_frontend/domain/usecases/get_radar_users_usecase.dart';
import 'package:wat_project_frontend/presentation/social_radar/bloc/social_radar_event.dart';
import 'package:wat_project_frontend/presentation/social_radar/bloc/social_radar_state.dart';

class SocialRadarBloc extends Bloc<SocialRadarEvent, SocialRadarState> {
  final SendFriendRequestUseCase _sendFriendRequestUseCase;
  final ListPendingRequestsUseCase _listPendingRequestsUseCase;
  final RespondToFriendRequestUseCase _respondToFriendRequestUseCase;
  final ListFriendsUseCase _listFriendsUseCase;
  final RemoveFriendUseCase _removeFriendUseCase;
  final GetRadarUsersUseCase _getRadarUsersUseCase;

  SocialRadarBloc(
    this._sendFriendRequestUseCase,
    this._listPendingRequestsUseCase,
    this._respondToFriendRequestUseCase,
    this._listFriendsUseCase,
    this._removeFriendUseCase,
    this._getRadarUsersUseCase,
  ) : super(const SocialRadarInitial()) {
    on<LoadSocialRadar>(_onLoadSocialRadar);
    on<GetRadarUsers>(_onGetRadarUsers);
    on<ListPendingRequests>(_onListPendingRequests);
    on<ListFriends>(_onListFriends);
    on<SendFriendRequest>(_onSendFriendRequest);
    on<RespondToFriendRequest>(_onRespondToFriendRequest);
    on<RemoveFriend>(_onRemoveFriend);
  }

  Future<void> _onLoadSocialRadar(
    LoadSocialRadar event,
    Emitter<SocialRadarState> emit,
  ) async {
    emit(const SocialRadarLoading());

    final results = await Future.wait([
      _getRadarUsersUseCase(),
      _listFriendsUseCase(),
      _listPendingRequestsUseCase(),
    ]);

    final radarRes = results[0];
    final friendsRes = results[1];
    final pendingRes = results[2];

    String? errorMessage;
    radarRes.fold((failure) => errorMessage ??= failure.message, (_) {});
    friendsRes.fold((failure) => errorMessage ??= failure.message, (_) {});
    pendingRes.fold((failure) => errorMessage ??= failure.message, (_) {});

    if (errorMessage != null) {
      emit(SocialRadarFailure(errorMessage!));
    } else {
      final radarUsers = radarRes.fold((_) => <RadarEntry>[], (data) => data as List<RadarEntry>);
      final friends = friendsRes.fold((_) => <FriendshipModel>[], (data) => data as List<FriendshipModel>);
      final pendingRequests = pendingRes.fold((_) => <FriendshipModel>[], (data) => data as List<FriendshipModel>);

      emit(SocialRadarLoadSuccess(
        radarUsers: radarUsers,
        friends: friends,
        pendingRequests: pendingRequests,
      ));
    }
  }

  Future<void> _onGetRadarUsers(
    GetRadarUsers event,
    Emitter<SocialRadarState> emit,
  ) async {
    emit(const SocialRadarLoading());
    final result = await _getRadarUsersUseCase();
    result.fold(
      (failure) => emit(SocialRadarFailure(failure.message)),
      (radarUsers) => emit(RadarUsersLoadSuccess(radarUsers)),
    );
  }

  Future<void> _onListPendingRequests(
    ListPendingRequests event,
    Emitter<SocialRadarState> emit,
  ) async {
    emit(const SocialRadarLoading());
    final result = await _listPendingRequestsUseCase();
    result.fold(
      (failure) => emit(SocialRadarFailure(failure.message)),
      (pendingRequests) => emit(PendingRequestsLoadSuccess(pendingRequests)),
    );
  }

  Future<void> _onListFriends(
    ListFriends event,
    Emitter<SocialRadarState> emit,
  ) async {
    emit(const SocialRadarLoading());
    final result = await _listFriendsUseCase();
    result.fold(
      (failure) => emit(SocialRadarFailure(failure.message)),
      (friends) => emit(FriendsLoadSuccess(friends)),
    );
  }

  Future<void> _onSendFriendRequest(
    SendFriendRequest event,
    Emitter<SocialRadarState> emit,
  ) async {
    emit(const SocialRadarLoading());
    final result = await _sendFriendRequestUseCase(event.targetUserId);
    result.fold(
      (failure) => emit(SocialRadarFailure(failure.message)),
      (_) => emit(const SendFriendRequestSuccess()),
    );
  }

  Future<void> _onRespondToFriendRequest(
    RespondToFriendRequest event,
    Emitter<SocialRadarState> emit,
  ) async {
    emit(const SocialRadarLoading());
    final result = await _respondToFriendRequestUseCase(
      event.friendshipId,
      event.accept,
    );
    result.fold(
      (failure) => emit(SocialRadarFailure(failure.message)),
      (_) => emit(const RespondToFriendRequestSuccess()),
    );
  }

  Future<void> _onRemoveFriend(
    RemoveFriend event,
    Emitter<SocialRadarState> emit,
  ) async {
    emit(const SocialRadarLoading());
    final result = await _removeFriendUseCase(event.friendId);
    result.fold(
      (failure) => emit(SocialRadarFailure(failure.message)),
      (_) => emit(const RemoveFriendSuccess()),
    );
  }
}
