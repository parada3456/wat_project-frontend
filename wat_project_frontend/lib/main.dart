import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:wat_project_frontend/core/l10n/app_localizations.dart';
import 'package:wat_project_frontend/di/inject.dart';import 'package:wat_project_frontend/domain/providers/locale_provider.dart';import 'package:wat_project_frontend/domain/providers/theme_provider.dart';import 'package:wat_project_frontend/domain/services/auth_manager.dart';import 'package:wat_project_frontend/core/theme/app_theme.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  await getIt<AuthSessionManager>().initialize();
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: getIt<LocaleProvider>()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final localeProvider = context.watch<LocaleProvider>();
    final themeProvider = context.watch<ThemeProvider>();

    return MaterialApp.router(
      title: 'WAT Project',
      routerConfig: getIt<GoRouter>(),
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeProvider.themeMode,
      locale: localeProvider.locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
