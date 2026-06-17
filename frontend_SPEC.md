
# Flutter + Golang + PostgreSQL Project Specification

> Reference architecture derived from: `github.com/parada3456/test_fetch_loading`

---

## 1. Project Overview

A production-ready full-stack mobile application with:
- **Frontend**: Flutter (Dart) — OOP, Clean Architecture, BLoC state management
- **Backend**: Golang — RESTful API, Clean Architecture
- **Database**: PostgreSQL

---

## 2. Flutter Frontend Specification

### 2.1 Architecture

**Pattern**: Clean Architecture with 3 layers

```
Presentation  →  Domain  →  Data
(Features/UI)    (Models, Repos, UseCases)   (Entities, Impl, API)
```

**State Management**: `flutter_bloc` (BLoC + Cubit)  
**DI**: `get_it` + `injectable` (same injection pattern as reference)  
**Navigation**: `go_router`  
**Networking**: `dio` + `retrofit` (code-gen `@RestApi`)  
**Code Gen**: `freezed`, `json_serializable`, `injectable_generator`, `retrofit_generator`

---

### 2.2 File Structure

```
lib/
├── main.dart
├── core/
│   ├── extension/
│   │   └── extension.dart              # RequestOptions.needLogin helper
│   ├── l10n/
│   │   ├── app_en.arb
│   │   ├── app_th.arb
│   │   └── app_localizations.dart
│   ├── theme/
│   │   └── app_theme.dart              # AppTheme class (light/dark ThemeData)
│   └── widget/
│       ├── app_button.dart
│       ├── app_card.dart
│       └── loading_overlay.dart
│
├── data/
│   ├── entities/                       # JSON-serializable API response models
│   │   ├── auth_entity.dart
│   │   ├── auth_entity.g.dart
│   │   ├── user_entity.dart
│   │   └── user_entity.g.dart
│   ├── mapper/                         # entity → domain model converters
│   │   └── user_mapper.dart
│   ├── repository_impl/               # concrete Repository implementations
│   │   ├── auth_repo_impl.dart
│   │   └── user_repo_impl.dart
│   └── source/
│       └── api/
│           ├── api_client.dart         # @RestApi() main authenticated endpoints
│           ├── api_client.g.dart
│           ├── auth_api_client.dart    # @RestApi() unauthenticated auth endpoints
│           ├── auth_api_client.g.dart
│           └── api_model/
│               ├── login_request.dart
│               └── auth_refresh_request.dart
│
├── di/
│   ├── inject.dart                     # GetIt instance + configureDependencies()
│   ├── inject.config.dart              # generated
│   ├── api_module.dart                 # @module: ApiService, AuthApiService
│   ├── auth_module.dart                # @module: AuthSessionManager singleton
│   ├── bloc_module.dart                # @module: BLoC registrations
│   ├── dio_module.dart                 # @module: authDio + mainDio (with AuthInterceptor)
│   ├── local_module.dart               # @module: FlutterSecureStorage, SharedPrefs
│   ├── repository_module.dart          # @module: Repository bindings
│   ├── router_module.dart              # @module: GoRouter singleton
│   └── usecase_module.dart             # @module: UseCase bindings
│
├── domain/
│   ├── errors/
│   │   ├── api_exceptions.dart
│   │   └── auth_exception.dart
│   ├── models/                         # Pure Dart domain models (freezed)
│   │   ├── auth_model.dart
│   │   ├── auth_model.g.dart
│   │   └── user_model.dart
│   ├── providers/
│   │   ├── locale_provider.dart
│   │   └── theme_provider.dart
│   ├── repository/                     # abstract interfaces
│   │   ├── auth_repository.dart
│   │   └── user_repository.dart
│   ├── services/
│   │   ├── auth_interceptor.dart       # Dio interceptor: token inject + refresh
│   │   └── auth_manager.dart           # AuthSessionManager singleton
│   ├── ui_status/
│   │   ├── ui_status.dart              # sealed UIStatus (idle/loading/success/error)
│   │   └── ui_status.freezed.dart
│   └── usecase/
│       ├── get_login_usecase.dart
│       └── get_user_usecase.dart
│
├── features/
│   ├── login/
│   │   ├── bloc/
│   │   │   ├── login_bloc.dart
│   │   │   ├── login_event.dart
│   │   │   └── login_state.dart
│   │   └── ui/
│   │       ├── login_screen.dart
│   │       └── login_view.dart
│   ├── home/
│   │   ├── bloc/
│   │   │   └── home_bloc/
│   │   │       ├── home_bloc.dart
│   │   │       ├── home_event.dart
│   │   │       └── home_state.dart
│   │   └── ui/
│   │       └── home_screen.dart
│   └── profile/
│       ├── bloc/
│       │   ├── profile_bloc.dart
│       │   ├── profile_event.dart
│       │   └── profile_state.dart
│       └── ui/
│           └── profile_screen.dart
│
├── routes/
│   └── app_router.dart
│
└── utils/
    ├── theme_constants.dart            # AppColors, AppDimension, AppAssets
    └── date_formatter.dart

assets/
├── fonts/
├── icons/
└── images/

test/                                   # mirrors lib/ structure
integration_test/
```

---

### 2.3 ThemeData Class Specification

File: `lib/core/theme/app_theme.dart`

```dart
// MUST follow this OOP class pattern (private constructor, static factory getters)
class AppTheme {
  AppTheme._();                         // private constructor — cannot be instantiated

  static ThemeData get light => ThemeData(
    fontFamily: 'YourFont',
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.surfaceLight,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primaryLight,
      primary: AppColors.primaryLight,
      secondary: AppColors.secondaryLight,
      surface: AppColors.surfaceLight,
    ),
    textTheme: _buildTextTheme(AppColors.blackText),
    elevatedButtonTheme: _buildButtonTheme(AppColors.primaryLight, AppColors.white),
    bottomNavigationBarTheme: _buildNavBarTheme(AppColors.secondaryLight),
    appBarTheme: _buildAppBarTheme(),
    cardTheme: _buildCardTheme(),
  );

  static ThemeData get dark => ThemeData(/* dark variant */);

  // Private builder methods — one per widget category
  static TextTheme _buildTextTheme(Color bodyColor) => TextTheme(/* ... */);
  static ElevatedButtonThemeData _buildButtonTheme(Color bg, Color fg) => ...;
  static BottomNavigationBarThemeData _buildNavBarTheme(Color bg) => ...;
  static AppBarTheme _buildAppBarTheme() => ...;
  static CardTheme _buildCardTheme() => ...;
}
```

Consumed in `main.dart`:
```dart
MaterialApp.router(
  theme: AppTheme.light,
  darkTheme: AppTheme.dark,
  themeMode: themeProvider.themeMode,
  ...
)
```

---

### 2.4 Auth Injection Pattern

Identical to reference repo — **do not deviate**:

**Step 1** — `dio_module.dart`: Two named Dio instances
```dart
@module abstract class DioModule {
  @Named('authDio')   @lazySingleton Dio authDio() => Dio(...);
  @Named('mainDio')   @lazySingleton Dio mainDio(@Named('authDio') Dio authDio) {
    final dio = Dio(...);
    dio.interceptors.add(AuthInterceptor(getIt<AuthSessionManager>(), dio: authDio));
    return dio;
  }
}
```

**Step 2** — `auth_module.dart`: AuthSessionManager singleton
```dart
@module abstract class AuthModule {
  @singleton
  AuthSessionManager authSessionManager(FlutterSecureStorage storage, AuthApiService api) =>
    AuthSessionManager(storage, api: api);
}
```

**Step 3** — `api_module.dart`: Retrofit clients bound to named Dio
```dart
@module abstract class ApiModule {
  @lazySingleton ApiService mainApi(@Named('mainDio') Dio dio) => ApiService(dio);
  @lazySingleton AuthApiService authApi(@Named('authDio') Dio dio) => AuthApiService(dio);
}
```

**Step 4** — `inject.dart`: Single entry point
```dart
final getIt = GetIt.instance;
@InjectableInit(initializerName: 'init', preferRelativeImports: true, asExtension: true)
void configureDependencies() => getIt.init();
```

**Step 5** — `main()`: Init sequence
```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  await getIt<AuthSessionManager>().initialize(); // restore session from secure storage
  runApp(MultiProvider(providers: [...], child: const MainApp()));
}
```

---

### 2.5 AuthInterceptor Behaviour

Must implement all of the following (match reference exactly):

| Scenario | Behaviour |
|----------|-----------|
| Route with `needLogin: false` | Skip auth validation, pass through |
| Token is null or expired | Force logout → reject with `SessionExpiredException` |
| Another refresh in progress | Queue request, await `_refreshCompleter`, then inject token |
| Token near expiry (proactive) | Refresh before sending, inject new token |
| 401 response received | Check if token already changed → retry or refresh then retry |
| Refresh fails | Clear session, propagate error |

Extension on `RequestOptions`:
```dart
extension RequestOptionsX on RequestOptions {
  bool get needLogin => extra['needLogin'] != false;
}
```

---

### 2.6 Key Dependencies (pubspec.yaml)

```yaml
dependencies:
  flutter_bloc: ^9.x
  get_it: ^9.x
  injectable: ^2.x
  dio: ^5.x
  retrofit: ^4.x
  json_annotation: ^4.x
  freezed_annotation: ^3.x
  flutter_secure_storage: ^10.x
  go_router: ^14.x
  intl: ^0.20.x

dev_dependencies:
  build_runner: ^2.x
  injectable_generator: ^2.x
  retrofit_generator: ^10.x
  json_serializable: ^6.x
  freezed: ^3.x
  mocktail: ^1.x
  bloc_test: ^10.x
```

---

## 3. Golang Backend Specification

### 3.1 Architecture

**Pattern**: Clean Architecture with 4 layers

```
Handler (HTTP) → UseCase (Business Logic) → Repository (DB) → PostgreSQL
```

**Framework**: `gin` or `echo`  
**ORM**: `pgx/v5` (native PostgreSQL driver, no heavy ORM)  
**Auth**: JWT (access + refresh tokens stored in DB)  
**Config**: `viper` or `.env` + `godotenv`  
**Migrations**: `golang-migrate`

---

### 3.2 File Structure

```
backend/
├── cmd/
│   └── server/
│       └── main.go                     # entry point
│
├── config/
│   ├── config.go                       # Config struct + Load()
│   └── .env.example
│
├── internal/
│   ├── domain/                         # pure interfaces + models (no dependencies)
│   │   ├── model/
│   │   │   ├── user.go
│   │   │   ├── auth.go
│   │   │   └── post.go
│   │   ├── repository/                 # abstract interfaces
│   │   │   ├── user_repository.go
│   │   │   ├── auth_repository.go
│   │   │   └── post_repository.go
│   │   └── usecase/                    # abstract interfaces
│   │       ├── auth_usecase.go
│   │       ├── user_usecase.go
│   │       └── post_usecase.go
│   │
│   ├── usecase/                        # concrete implementations
│   │   ├── auth_usecase_impl.go
│   │   ├── user_usecase_impl.go
│   │   └── post_usecase_impl.go
│   │
│   ├── repository/                     # PostgreSQL implementations
│   │   ├── postgres/
│   │   │   ├── user_repo.go
│   │   │   ├── auth_repo.go
│   │   │   └── post_repo.go
│   │   └── cache/ (optional)
│   │       └── redis_cache.go
│   │
│   ├── handler/                        # HTTP handlers (thin — delegates to usecase)
│   │   ├── auth_handler.go
│   │   ├── user_handler.go
│   │   └── post_handler.go
│   │
│   ├── middleware/
│   │   ├── auth_middleware.go          # JWT validation + inject userID to ctx
│   │   ├── cors_middleware.go
│   │   └── logger_middleware.go
│   │
│   ├── router/
│   │   └── router.go                   # route grouping + middleware attachment
│   │
│   └── infrastructure/
│       ├── database/
│       │   └── postgres.go             # pgx pool setup
│       └── jwt/
│           └── jwt_service.go
│
├── migrations/
│   ├── 001_create_users.up.sql
│   ├── 001_create_users.down.sql
│   ├── 002_create_auth_tokens.up.sql
│   └── 002_create_auth_tokens.down.sql
│
├── go.mod
├── go.sum
├── Makefile
└── docker-compose.yml
```

---

### 3.3 PostgreSQL Schema

```sql
-- users
CREATE TABLE users (
  id          SERIAL PRIMARY KEY,
  email       VARCHAR(255) UNIQUE NOT NULL,
  password    VARCHAR(255) NOT NULL,        -- bcrypt hashed
  first_name  VARCHAR(100),
  last_name   VARCHAR(100),
  created_at  TIMESTAMPTZ DEFAULT NOW(),
  updated_at  TIMESTAMPTZ DEFAULT NOW()
);

-- auth_tokens (refresh token store)
CREATE TABLE auth_tokens (
  id            SERIAL PRIMARY KEY,
  user_id       INT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  refresh_token VARCHAR(500) NOT NULL,
  expires_at    TIMESTAMPTZ NOT NULL,
  created_at    TIMESTAMPTZ DEFAULT NOW()
);

-- posts (example domain entity)
CREATE TABLE posts (
  id          SERIAL PRIMARY KEY,
  user_id     INT NOT NULL REFERENCES users(id),
  title       VARCHAR(255) NOT NULL,
  body        TEXT,
  created_at  TIMESTAMPTZ DEFAULT NOW()
);
```

---

### 3.4 Auth API Contract

| Method | Path | Auth | Description |
|--------|------|------|-------------|
| POST | `/auth/login` | None | Returns `{token, refreshToken, expiresAt}` |
| POST | `/auth/refresh` | None (refresh token in body) | Returns new access + refresh token |
| POST | `/auth/logout` | Bearer | Revoke refresh token |
| GET | `/user/me` | Bearer | Get current user profile |
| GET | `/posts` | Bearer | List all posts |
| GET | `/posts/userId?userId=1,2` | Bearer | Posts filtered by user IDs |

JWT payload:
```json
{ "sub": 1, "exp": 1234567890, "iat": 1234567890 }
```

Access token TTL: **15 minutes**  
Refresh token TTL: **7 days**

---

### 3.5 Golang OOP/Interface Pattern

```go
// domain/repository/user_repository.go
type UserRepository interface {
    FindByID(ctx context.Context, id int) (*model.User, error)
    FindByEmail(ctx context.Context, email string) (*model.User, error)
    Create(ctx context.Context, user *model.User) (*model.User, error)
}

// domain/usecase/auth_usecase.go  
type AuthUseCase interface {
    Login(ctx context.Context, email, password string) (*model.AuthResponse, error)
    RefreshToken(ctx context.Context, refreshToken string) (*model.AuthResponse, error)
    Logout(ctx context.Context, refreshToken string) error
}

// concrete impl receives interface (dependency inversion)
type authUseCaseImpl struct {
    userRepo  repository.UserRepository
    authRepo  repository.AuthRepository
    jwtSvc    jwt.Service
}

func NewAuthUseCase(userRepo repository.UserRepository, authRepo repository.AuthRepository, jwtSvc jwt.Service) AuthUseCase {
    return &authUseCaseImpl{userRepo, authRepo, jwtSvc}
}
```

---

### 3.6 Docker Compose

```yaml
services:
  postgres:
    image: postgres:16-alpine
    environment:
      POSTGRES_DB: app_db
      POSTGRES_USER: app_user
      POSTGRES_PASSWORD: app_password
    ports: ["5432:5432"]
    volumes: [postgres_data:/var/lib/postgresql/data]

  backend:
    build: .
    ports: ["8080:8080"]
    depends_on: [postgres]
    environment:
      DB_HOST: postgres
      JWT_SECRET: supersecret
```

---

## 4. Constraints & Best Practices

### Flutter
- All BLoC events/states must use `freezed`
- All JSON models must use `json_serializable` + `@JsonSerializable`
- Repository interfaces live in `domain/repository/` — impls in `data/repository_impl/`
- UseCases are thin orchestrators — no business logic in BLoC or Repository
- No `BuildContext` passed to BLoC/UseCases
- ThemeData **only** from `AppTheme` class — never inline `ThemeData()`
- All colors from `AppColors` abstract class — never inline `Color(0xFF...)`

### Golang
- All DB access through Repository interface — no raw SQL in handlers or usecases
- Use `context.Context` everywhere for cancellation
- Return typed errors (not raw `error` strings)
- All routes requiring auth must use `AuthMiddleware`
- Passwords must be `bcrypt` hashed (cost ≥ 12)
- Refresh tokens stored hashed in DB

### Cross-cutting
- `baseUrl` configurable via environment (not hardcoded)
- CORS configured on backend to allow Flutter client origins
- All timestamps stored as `TIMESTAMPTZ` (UTC)
