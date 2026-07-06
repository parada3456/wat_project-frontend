import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wat_project_frontend/domain/usecases/notification_usecases.dart';
import 'package:wat_project_frontend/domain/usecases/notification_usecases.dart';
import 'package:wat_project_frontend/domain/usecases/notification_usecases.dart';
import 'package:wat_project_frontend/domain/usecases/notification_usecases.dart';
import 'package:wat_project_frontend/presentation/notifications/bloc/notifications_event.dart';
import 'package:wat_project_frontend/presentation/notifications/bloc/notifications_state.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  final ListNotificationsUseCase _listNotificationsUseCase;
  final MarkNotificationReadUseCase _markNotificationReadUseCase;
  final MarkAllNotificationsReadUseCase _markAllNotificationsReadUseCase;
  final DeleteNotificationUseCase _deleteNotificationUseCase;

  NotificationsBloc(
    this._listNotificationsUseCase,
    this._markNotificationReadUseCase,
    this._markAllNotificationsReadUseCase,
    this._deleteNotificationUseCase,
  ) : super(const NotificationsInitial()) {
    on<LoadNotificationsEvent>(_onLoadNotifications);
    on<MarkNotificationReadEvent>(_onMarkNotificationRead);
    on<MarkAllNotificationsReadEvent>(_onMarkAllNotificationsRead);
    on<DeleteNotificationEvent>(_onDeleteNotification);
  }

  Future<void> _onLoadNotifications(
    LoadNotificationsEvent event,
    Emitter<NotificationsState> emit,
  ) async {
    emit(const NotificationsLoading());
    final result = await _listNotificationsUseCase();
    result.fold(
      (failure) => emit(NotificationsFailure(failure.message)),
      (notifications) => emit(NotificationsSuccess(notifications)),
    );
  }

  Future<void> _onMarkNotificationRead(
    MarkNotificationReadEvent event,
    Emitter<NotificationsState> emit,
  ) async {
    emit(const NotificationsLoading());
    final result = await _markNotificationReadUseCase(event.notificationId);
    await result.fold(
      (failure) async => emit(NotificationsFailure(failure.message)),
      (_) async {
        final listResult = await _listNotificationsUseCase();
        listResult.fold(
          (failure) => emit(NotificationsFailure(failure.message)),
          (notifications) => emit(NotificationsSuccess(notifications)),
        );
      },
    );
  }

  Future<void> _onMarkAllNotificationsRead(
    MarkAllNotificationsReadEvent event,
    Emitter<NotificationsState> emit,
  ) async {
    emit(const NotificationsLoading());
    final result = await _markAllNotificationsReadUseCase();
    await result.fold(
      (failure) async => emit(NotificationsFailure(failure.message)),
      (_) async {
        final listResult = await _listNotificationsUseCase();
        listResult.fold(
          (failure) => emit(NotificationsFailure(failure.message)),
          (notifications) => emit(NotificationsSuccess(notifications)),
        );
      },
    );
  }

  Future<void> _onDeleteNotification(
    DeleteNotificationEvent event,
    Emitter<NotificationsState> emit,
  ) async {
    emit(const NotificationsLoading());
    final result = await _deleteNotificationUseCase(event.notificationId);
    await result.fold(
      (failure) async => emit(NotificationsFailure(failure.message)),
      (_) async {
        final listResult = await _listNotificationsUseCase();
        listResult.fold(
          (failure) => emit(NotificationsFailure(failure.message)),
          (notifications) => emit(NotificationsSuccess(notifications)),
        );
      },
    );
  }
}
