import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:wat_project_frontend/data/sources/api/api_client.dart';import 'package:wat_project_frontend/data/sources/api/auth_api_client.dart';import 'package:wat_project_frontend/data/sources/api/user_api_client.dart';import 'package:wat_project_frontend/data/sources/api/mission_api_client.dart';import 'package:wat_project_frontend/data/sources/api/journey_api_client.dart';import 'package:wat_project_frontend/data/sources/api/friend_api_client.dart';import 'package:wat_project_frontend/data/sources/api/expense_api_client.dart';import 'package:wat_project_frontend/data/sources/api/notification_api_client.dart';import 'package:wat_project_frontend/data/sources/api/job_api_client.dart';
@module
abstract class ApiModule {
  @lazySingleton
  ApiService mainApi(@Named('mainDio') Dio dio) => ApiService(dio);

  @lazySingleton
  AuthApiService authApi(@Named('authDio') Dio dio) => AuthApiService(dio);

  @lazySingleton
  UserApiService userApi(@Named('mainDio') Dio dio) => UserApiService(dio);

  @lazySingleton
  MissionApiService missionApi(@Named('mainDio') Dio dio) => MissionApiService(dio);

  @lazySingleton
  JourneyApiService journeyApi(@Named('mainDio') Dio dio) => JourneyApiService(dio);

  @lazySingleton
  FriendApiService friendApi(@Named('mainDio') Dio dio) => FriendApiService(dio);

  @lazySingleton
  ExpenseApiService expenseApi(@Named('mainDio') Dio dio) => ExpenseApiService(dio);

  @lazySingleton
  NotificationApiService notificationApi(@Named('mainDio') Dio dio) => NotificationApiService(dio);

  @lazySingleton
  JobApiService jobApi(@Named('mainDio') Dio dio) => JobApiService(dio);
}
