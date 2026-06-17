import 'package:dio/dio.dart';

extension RequestOptionsX on RequestOptions {
  bool get needLogin => extra['needLogin'] != false;
}
