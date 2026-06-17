# Implementation Plan: Flutter + Golang + PostgreSQL

> Follow SPEC.md for detailed specifications of each component.

---

## Phase 0 — Setup & Scaffolding

### 0.1 Repository Structure
```
project-root/
├── app/          ← Flutter project
├── backend/      ← Golang server
└── docker-compose.yml
```

### 0.2 Flutter Project Init
- [ ] `flutter create app --org com.yourcompany`
- [ ] Add all dependencies to `pubspec.yaml` (see SPEC §2.6)
- [ ] Configure `analysis_options.yaml` (strict mode)
- [ ] Add assets: fonts, icons, images directories
- [ ] Enable `generate: true` in `pubspec.yaml` for l10n
- [ ] Add `l10n.yaml`

### 0.3 Golang Project Init
- [ ] `go mod init github.com/yourorg/backend`
- [ ] Add dependencies: `gin`, `pgx/v5`, `golang-jwt/jwt`, `bcrypt`, `godotenv`, `golang-migrate`
- [ ] Create `Makefile` with targets: `run`, `migrate-up`, `migrate-down`, `generate`
- [ ] Create `docker-compose.yml`
- [ ] Create `.env.example`

---

## Phase 1 — Golang Backend

### 1.1 Infrastructure Layer
- [ ] `internal/infrastructure/database/postgres.go` — pgx connection pool
  - `NewPostgresPool(cfg Config) (*pgxpool.Pool, error)`
  - Connection string from env vars
  - Ping on startup
- [ ] `config/config.go` — typed Config struct + Load() from env

### 1.2 Database Migrations
- [ ] `migrations/001_create_users.up.sql` + `.down.sql`
- [ ] `migrations/002_create_auth_tokens.up.sql` + `.down.sql`
- [ ] `migrations/003_create_posts.up.sql` + `.down.sql`
- [ ] Run: `make migrate-up`

### 1.3 Domain Layer (Interfaces + Models)
- [ ] `internal/domain/model/user.go` — User struct
- [ ] `internal/domain/model/auth.go` — AuthResponse, TokenClaims
- [ ] `internal/domain/model/post.go` — Post struct
- [ ] `internal/domain/repository/user_repository.go` — interface
- [ ] `internal/domain/repository/auth_repository.go` — interface
- [ ] `internal/domain/repository/post_repository.go` — interface
- [ ] `internal/domain/usecase/auth_usecase.go` — interface
- [ ] `internal/domain/usecase/user_usecase.go` — interface
- [ ] `internal/domain/usecase/post_usecase.go` — interface

### 1.4 JWT Service
- [ ] `internal/infrastructure/jwt/jwt_service.go`
  - `GenerateAccessToken(userID int) (string, time.Time, error)`
  - `GenerateRefreshToken() (string, time.Time, error)`
  - `ValidateAccessToken(token string) (*TokenClaims, error)`

### 1.5 Repository Layer (PostgreSQL)
- [ ] `internal/repository/postgres/user_repo.go` — implements UserRepository
  - `FindByEmail`, `FindByID`, `Create`
- [ ] `internal/repository/postgres/auth_repo.go` — implements AuthRepository
  - `SaveRefreshToken`, `FindRefreshToken`, `DeleteRefreshToken`, `DeleteAllForUser`
- [ ] `internal/repository/postgres/post_repo.go` — implements PostRepository
  - `FindAll`, `FindByUserIDs`, `FindByIDs`

### 1.6 UseCase Layer
- [ ] `internal/usecase/auth_usecase_impl.go`
  - `Login`: find user → verify bcrypt → generate tokens → save refresh token → return
  - `RefreshToken`: find refresh token → validate → generate new pair → rotate refresh → return
  - `Logout`: delete refresh token from DB
- [ ] `internal/usecase/user_usecase_impl.go`
  - `GetProfile(ctx, userID)`
- [ ] `internal/usecase/post_usecase_impl.go`
  - `GetAll`, `GetByUserIDs`, `GetByIDs`

### 1.7 Middleware
- [ ] `internal/middleware/auth_middleware.go`
  - Extract `Authorization: Bearer <token>`
  - Validate JWT → inject `userID` into `gin.Context`
  - Return 401 on failure
- [ ] `internal/middleware/cors_middleware.go`
- [ ] `internal/middleware/logger_middleware.go`

### 1.8 Handler Layer
- [ ] `internal/handler/auth_handler.go`
  - `POST /auth/login`
  - `POST /auth/refresh`
  - `POST /auth/logout`
- [ ] `internal/handler/user_handler.go`
  - `GET /user/me`
- [ ] `internal/handler/post_handler.go`
  - `GET /posts`
  - `GET /posts/userId?userId=...`
  - `GET /posts/detail?id=...`

### 1.9 Router
- [ ] `internal/router/router.go`
  - Public group: `/auth/*`
  - Protected group (AuthMiddleware): `/user/*`, `/posts/*`

### 1.10 Entry Point
- [ ] `cmd/server/main.go`
  - Load config → init DB pool → wire all dependencies → start HTTP server

### 1.11 Verify Backend
- [ ] `docker-compose up postgres`
- [ ] `make run`
- [ ] Test with curl/Postman:
  - Login → get token
  - GET /posts with Bearer token
  - POST /auth/refresh with refresh token
  - GET /user/me

---

## Phase 2 — Flutter: Foundation

### 2.1 Theme System
- [ ] `lib/utils/theme_constants.dart`
  - `abstract class AppColors` — all Color constants
  - `abstract class AppDimension` — spacing constants
  - `abstract class AppAssets` — asset path constants
- [ ] `lib/core/theme/app_theme.dart`
  - `class AppTheme { AppTheme._(); }`
  - `static ThemeData get light` — full Material 3 config
  - `static ThemeData get dark`
  - Private builder methods: `_buildTextTheme`, `_buildButtonTheme`, `_buildNavBarTheme`, `_buildAppBarTheme`, `_buildCardTheme`

### 2.2 Error Types
- [ ] `lib/domain/errors/api_exceptions.dart`
  - `ApiException`, `NetworkException`, `UnauthorizedException`
- [ ] `lib/domain/errors/auth_exception.dart`
  - `SessionExpiredException`, `ProactiveRefreshFailedException`, `QueuedRefreshFailedException`, `AuthRetryFailedException`, `StorageSessionExpiredException`

### 2.3 Core Extension
- [ ] `lib/core/extension/extension.dart`
  ```dart
  extension RequestOptionsX on RequestOptions {
    bool get needLogin => extra['needLogin'] != false;
  }
  ```

### 2.4 Domain Models (freezed)
- [ ] `lib/domain/models/auth_model.dart` — `@freezed AuthModel`
  - Fields: `token`, `refreshToken`, `expiresAt`
  - `bool get isExpired`
  - `bool get isNearExpiration` (within 2 min)
  - `fromJson` / `toJson`
- [ ] `lib/domain/models/user_model.dart`
- [ ] `lib/domain/models/post_model.dart`
- [ ] Run: `dart run build_runner build`

### 2.5 Entities (json_serializable)
- [ ] `lib/data/entities/auth_entity.dart` → `toModel()` returns `AuthModel`
- [ ] `lib/data/entities/user_entity.dart`
- [ ] `lib/data/entities/post_entity.dart`
- [ ] `lib/data/entities/login_entity.dart`

### 2.6 UI Status
- [ ] `lib/domain/ui_status/ui_status.dart`
  ```dart
  @freezed
  sealed class UiStatus<T> with _$UiStatus<T> {
    const factory UiStatus.idle() = Idle;
    const factory UiStatus.loading() = Loading;
    const factory UiStatus.success(T data) = Success;
    const factory UiStatus.error(String message) = Error;
  }
  ```

---

## Phase 3 — Flutter: Networking & DI

### 3.1 Retrofit API Clients
- [ ] `lib/data/source/api/auth_api_client.dart`
  - `@RestApi() abstract class AuthApiService`
  - `POST /auth/login` → `@Extra({'needLogin': false})`
  - `POST /auth/refresh` → `@Extra({'needLogin': false})`
- [ ] `lib/data/source/api/api_client.dart`
  - `@RestApi() abstract class ApiService`
  - All protected endpoints
- [ ] `lib/data/source/api/api_model/login_request.dart` (json_serializable)
- [ ] `lib/data/source/api/api_model/auth_refresh_request.dart`
- [ ] Run `dart run build_runner build`

### 3.2 Auth Services
- [ ] `lib/domain/services/auth_manager.dart` — `AuthSessionManager`
  - `initialize()` — restore from FlutterSecureStorage
  - `saveSession(AuthModel, int? userId)`
  - `clearSession()`
  - `refreshSession()` — calls `AuthApiService.refresh()`, saves new tokens
  - `ValueNotifier<AuthModel?> sessionNotifier`
- [ ] `lib/domain/services/auth_interceptor.dart` — `AuthInterceptor extends Interceptor`
  - Full implementation per SPEC §2.5

### 3.3 DI Modules
- [ ] `lib/di/inject.dart`
- [ ] `lib/di/local_module.dart` — `FlutterSecureStorage` singleton
- [ ] `lib/di/auth_module.dart` — `AuthSessionManager` singleton
- [ ] `lib/di/dio_module.dart` — `authDio` + `mainDio` with AuthInterceptor
- [ ] `lib/di/api_module.dart` — `ApiService` + `AuthApiService`
- [ ] `lib/di/repository_module.dart` — Repository bindings
- [ ] `lib/di/usecase_module.dart` — UseCase bindings
- [ ] `lib/di/bloc_module.dart` — BLoC bindings
- [ ] `lib/di/router_module.dart` — GoRouter singleton
- [ ] Run `dart run build_runner build` → generates `inject.config.dart`

---

## Phase 4 — Flutter: Repositories & UseCases

### 4.1 Repository Interfaces
- [ ] `lib/domain/repository/auth_repository.dart`
- [ ] `lib/domain/repository/user_repository.dart`
- [ ] `lib/domain/repository/post_repository.dart`

### 4.2 Repository Implementations
- [ ] `lib/data/repository_impl/auth_repo_impl.dart`
  - `login(email, password)` → `api.login()` → `LoginEntity` → `AuthModel`
- [ ] `lib/data/repository_impl/user_repo_impl.dart`
- [ ] `lib/data/repository_impl/post_repo_impl.dart`

### 4.3 UseCases
- [ ] `lib/domain/usecase/get_login_usecase.dart`
  - `call(email, password)` → calls repo → calls `authSessionManager.saveSession()`
- [ ] `lib/domain/usecase/get_user_usecase.dart`
- [ ] `lib/domain/usecase/get_posts_usecase.dart`

---

## Phase 5 — Flutter: Providers & Routing

### 5.1 Providers
- [ ] `lib/domain/providers/theme_provider.dart` — `ThemeMode` toggle
- [ ] `lib/domain/providers/locale_provider.dart` — locale switching (EN/TH)

### 5.2 Router
- [ ] `lib/routes/app_router.dart`
  - `/login` → `LoginScreen` (public)
  - `/home` → `HomeScreen` (guarded: redirect to /login if no session)
  - `/profile` → `ProfileScreen`
  - Redirect logic reads `AuthSessionManager.sessionNotifier`

---

## Phase 6 — Flutter: Features

### 6.1 Login Feature
- [ ] `LoginEvent`: `LoginSubmitted(email, password)`, `LogoutRequested`
- [ ] `LoginState` (freezed): `LoginStatus` enum + error field
- [ ] `LoginBloc`:
  - `on<LoginSubmitted>` → call `GetLoginUseCase` → emit success/error
- [ ] `LoginScreen` — wraps BlocProvider
- [ ] `LoginView` — form UI, `BlocListener` for navigation on success

### 6.2 Home Feature
- [ ] `HomeEvent`: `HomeFetched`
- [ ] `HomeState` (freezed): `UiStatus<List<PostModel>>`
- [ ] `HomeBloc`: `on<HomeFetched>` → `GetPostsUseCase` → emit
- [ ] `HomeScreen` — BlocBuilder renders list/loading/error

### 6.3 Profile Feature
- [ ] `ProfileEvent`: `ProfileFetched`
- [ ] `ProfileState` (freezed)
- [ ] `ProfileBloc`
- [ ] `ProfileScreen`

---

## Phase 7 — Flutter: Main App

### 7.1 main.dart
```dart
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
```

### 7.2 MainApp widget
```dart
MaterialApp.router(
  routerConfig: getIt<GoRouter>(),
  theme: AppTheme.light,
  darkTheme: AppTheme.dark,
  themeMode: themeProvider.themeMode,
  localizationsDelegates: AppLocalizations.localizationsDelegates,
  supportedLocales: AppLocalizations.supportedLocales,
  locale: localeProvider.locale,
)
```

---

## Phase 8 — L10n

- [ ] `lib/core/l10n/app_en.arb` — English strings
- [ ] `lib/core/l10n/app_th.arb` — Thai strings
- [ ] Run: `flutter gen-l10n`

---

## Phase 9 — Testing

### Flutter Tests (mirror `lib/` structure under `test/`)
- [ ] Unit: domain models
- [ ] Unit: repository implementations (mock ApiService via mocktail)
- [ ] Unit: usecases
- [ ] BLoC: `bloc_test` for each BLoC
- [ ] Widget: key screens
- [ ] Integration: `integration_test/app_test.dart`

### Golang Tests
- [ ] Unit: usecase layer (mock repositories)
- [ ] Integration: handler tests with `httptest`
- [ ] DB: repository tests against test PostgreSQL instance

---

## Phase 10 — Integration & Deployment

- [ ] Set `baseUrl` in `dio_module.dart` from environment/config
- [ ] Configure CORS on Golang backend (`allowOrigins: *` for dev)
- [ ] `docker-compose up` — verify Flutter app can reach backend
- [ ] Run full regression: login → browse posts → token refresh → logout
- [ ] Write `README.md` with setup instructions

---

## Code Generation Commands

```bash
# Flutter — run after ANY model/DI/router change
dart run build_runner build --delete-conflicting-outputs

# Golang — if using sqlc (optional)
sqlc generate

# Database migrations
make migrate-up    # apply all pending
make migrate-down  # rollback last
```

---

## Key Decision Log

| Decision | Reason |
|----------|--------|
| `pgx/v5` over GORM | Lightweight, native PostgreSQL types, no magic |
| `retrofit` + `@RestApi` | Type-safe API client, matches reference repo pattern |
| Two Dio instances (`authDio`, `mainDio`) | `authDio` bypasses auth interceptor for token refresh calls |
| `freezed` for BLoC states | Sealed classes, copyWith, pattern matching |
| `injectable` + `get_it` | Compile-time DI validation, matches reference repo exactly |
| Access token 15min TTL | Short-lived for security; proactive refresh prevents UX interruption |
| `ValueNotifier` in AuthSessionManager | Lightweight reactive session state without BLoC overhead |
