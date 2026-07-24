import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wat_project_frontend/core/l10n/app_localizations.dart';

extension RequestOptionsX on RequestOptions {
  bool get needLogin => extra['needLogin'] != false;
}

extension ContextExt on BuildContext{
  AppLocalizations get l10n => AppLocalizations.of(this)!; 
  String get languageCode => Localizations.localeOf(this).languageCode;
  TextTheme get textTheme => Theme.of(this).textTheme;
}


