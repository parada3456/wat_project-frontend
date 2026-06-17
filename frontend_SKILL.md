---
name: flutter-golang-pg
description: >
  Use this skill whenever the user wants to build a Flutter mobile app with a Golang backend and PostgreSQL database.
  Triggers include any combination of: Flutter + Golang, Flutter + Go backend, Flutter + PostgreSQL, 
  Flutter clean architecture with BLoC, Dio + Retrofit + injectable DI, auth interceptor with token refresh,
  ThemeData class OOP pattern, or "same architecture as parada3456/test_fetch_loading".
  Also trigger when the user asks to scaffold a Flutter project with DI injection, auth manager, 
  or when they ask about setting up get_it + injectable modules, AuthInterceptor with refresh token queuing,
  or two-Dio pattern (authDio / mainDio). Use this skill proactively — don't just answer from memory.
---

# Flutter + Golang + PostgreSQL Full-Stack Skill

Build production-ready Flutter apps with Golang backends and PostgreSQL, following the clean architecture
and auth injection patterns established in `github.com/parada3456/test_fetch_loading`.

## Reference Architecture Summary

**Flutter stack**: BLoC + get_it/injectable DI + Dio/Retrofit + freezed + go_router  
**Backend**: Golang Clean Architecture (handler → usecase → repository → pgx/PostgreSQL)  
**Auth**: JWT (access + refresh) with Dio interceptor handling proactive refresh + concurrent request queuing

## When to Use This Skill

- Scaffolding a new Flutter + Go project from scratch
- Implementing the auth injection pattern (two-Dio, AuthInterceptor, AuthSessionManager)
- Setting up `injectable` DI modules (DioModule, AuthModule, ApiModule, RepositoryModule, etc.)
- Creating `AppTheme` class with OOP private-constructor pattern
- Writing Golang clean architecture layers (domain interfaces → usecase impl → repository → handler)
- Setting up PostgreSQL schema with migrations for a Go backend
- Debugging auth interceptor: token refresh, race conditions, 401 retry logic

## Key Files — Read These First

- **SPEC.md** — Complete specification: file structures, class signatures, API contracts, DB schema
- **PLAN.md** — Phase-by-phase implementation checklist (10 phases)

## Quick Reference

### Flutter File Structure (top-level `lib/`)
```
core/theme/app_theme.dart          ← AppTheme class (OOP, private constructor)
core/extension/extension.dart      ← RequestOptions.needLogin
data/entities/                     ← JSON-serializable API response models
data/repository_impl/              ← concrete Repository implementations
data/source/api/api_client.dart    ← @RestApi() main Retrofit client
data/source/api/auth_api_client.dart ← @RestApi() auth endpoints (no auth required)
di/inject.dart                     ← getIt + configureDependencies()
di/dio_module.dart                 ← authDio + mainDio with AuthInterceptor
di/auth_module.dart                ← AuthSessionManager @singleton
di/api_module.dart                 ← ApiService + AuthApiService
di/repository_module.dart          ← Repository bindings
domain/services/auth_interceptor.dart ← Dio interceptor (token inject + refresh + queue)
domain/services/auth_manager.dart  ← AuthSessionManager (secure storage + ValueNotifier)
domain/models/auth_model.dart      ← freezed AuthModel with isExpired, isNearExpiration
features/<name>/bloc/              ← BLoC events/states (freezed)
features/<name>/ui/                ← Screens and Views
routes/app_router.dart             ← GoRouter with auth guard redirect
utils/theme_constants.dart         ← AppColors, AppDimension, AppAssets (abstract classes)
```

### Golang File Structure (top-level `internal/`)
```
domain/model/          ← pure Go structs (no DB tags)
domain/repository/     ← interface definitions
domain/usecase/        ← interface definitions
usecase/               ← concrete implementations
repository/postgres/   ← pgx implementations
handler/               ← HTTP handlers (thin, delegate to usecase)
middleware/            ← auth, cors, logger
router/router.go       ← route groups + middleware
infrastructure/        ← DB pool, JWT service
migrations/            ← SQL migration files
```

## Critical Patterns

### 1. AppTheme Class (OOP)
```dart
class AppTheme {
  AppTheme._();   // private constructor — NEVER instantiate
  static ThemeData get light => ThemeData(/* ... */);
  static ThemeData get dark => ThemeData(/* ... */);
  // private _build* methods for each widget theme category
}
```
**Rule**: All colors come from `AppColors`, never inline `Color(0xFF...)` in theme.

### 2. Two-Dio DI Pattern
```
authDio   →  no interceptors  →  AuthApiService  (login, refresh)
mainDio   →  AuthInterceptor  →  ApiService      (all protected endpoints)
```
Both Dio instances registered as `@Named` `@lazySingleton` in `DioModule`.

### 3. Auth Injection Chain
```
main() → configureDependencies() → getIt<AuthSessionManager>().initialize()
```
DI wiring: `LocalModule(FlutterSecureStorage)` → `AuthModule(AuthSessionManager)` → `DioModule(authDio, mainDio)` → `ApiModule(ApiService, AuthApiService)` → `RepositoryModule` → `UseCaseModule` → `BlocModule`

### 4. AuthInterceptor Decision Tree
```
onRequest:
  needLogin == false → pass through
  token null or expired → force logout → reject SessionExpiredException
  _refreshCompleter != null → wait for active refresh → inject token → continue
  isNearExpiration → proactive refresh → inject new token → continue
  else → inject token → continue

onError (401):
  token already changed by another request → await refresh → retry
  else → executeTokenRefresh → retry
  refresh fails → pass error through
```

### 5. Golang Dependency Injection (manual wiring in main.go)
```go
pool := database.NewPostgresPool(cfg)
jwtSvc := jwt.NewService(cfg.JWTSecret)
userRepo := postgres.NewUserRepo(pool)
authRepo := postgres.NewAuthRepo(pool)
authUseCase := usecase.NewAuthUseCase(userRepo, authRepo, jwtSvc)
authHandler := handler.NewAuthHandler(authUseCase)
router.Setup(authHandler, ...)
```
No framework DI — plain constructor injection through interfaces.

## Code Generation

Always run after modifying models, DI modules, or Retrofit clients:
```bash
dart run build_runner build --delete-conflicting-outputs
```

## Common Mistakes to Avoid

| Mistake | Correct approach |
|---------|-----------------|
| Hardcoding colors in theme | Use `AppColors.xxx` constants |
| Instantiating `AppTheme()` | Use `AppTheme.light` / `AppTheme.dark` static getters |
| Using same Dio for auth + main calls | Use `authDio` for token refresh to avoid interceptor loop |
| Calling `getIt<T>()` inside `@module` methods | Inject via constructor parameter instead |
| Business logic in BLoC | Move to UseCase; BLoC only maps events to UseCase calls |
| Raw SQL in handlers or usecases (Go) | All DB access through Repository interface |
| Storing plain-text passwords | Use `bcrypt` with cost ≥ 12 |

## Phases (see PLAN.md for full checklists)

0. Setup & Scaffolding  
1. Golang: Infrastructure + DB Migrations  
2. Golang: Domain → Repository → UseCase → Handler → Router  
3. Flutter: Theme + Error types + Domain models + Entities  
4. Flutter: Networking (Retrofit) + Auth services + DI modules  
5. Flutter: Repositories + UseCases  
6. Flutter: Providers + Router + Features (Login, Home, Profile)  
7. Flutter: main.dart wiring  
8. L10n  
9. Testing (unit + BLoC + widget + integration)  
10. Integration + Docker verification  
