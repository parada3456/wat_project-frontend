---
name: wat-project-developer
description: Skill for automated onboarding and development of the Work and Travel (WAT) Flutter frontend project. Includes project specifications, architectural patterns (Clean Architecture + BLoC), and UI design tokens.
---

# Google Antigravity Skill: WAT Project Developer

This skill guides development on the **Work and Travel (WAT) / Job Review Portal** frontend repository. Any incoming agent or developer subagent MUST read this file to understand the architecture, guidelines, and style requirements of the project.

## 1. Project Context & Rules

* **Stack:** Flutter frontend, Node.js backend, PostgreSQL database.
* **Workspace Location:** `/Users/user/development/work/WAT_project/frontend/wat_project_frontend`
* **Development Rules:**
  1. **Spec-Driven Development:** Write a detailed design specification before changing or writing any code.
  2. **Small Atomic Tasks:** Break down work into small, incremental, atomic tasks that are easily testable.
  3. **Test Coverage:** Tests must be written and verify correctness before submitting or merging changes.

---

## 2. Directory Mappings & Architecture

The codebase adheres strictly to Clean Architecture principles. Do not bypass layers or create tight coupling between UI and data sources.

| Path | Purpose | Key Files / Subdirectories |
|---|---|---|
| [lib/core/](file:///Users/user/development/work/WAT_project/frontend/wat_project_frontend/lib/core) | Shared resources, themes, core utilities, widgets | [theme/](file:///Users/user/development/work/WAT_project/frontend/wat_project_frontend/lib/core/theme), [widgets/](file:///Users/user/development/work/WAT_project/frontend/wat_project_frontend/lib/core/widgets), [l10n/](file:///Users/user/development/work/WAT_project/frontend/wat_project_frontend/lib/core/l10n), [providers/](file:///Users/user/development/work/WAT_project/frontend/wat_project_frontend/lib/core/providers) |
| [lib/domain/](file:///Users/user/development/work/WAT_project/frontend/wat_project_frontend/lib/domain) | Pure business logic, abstract definitions (No framework dependencies) | [repositories/](file:///Users/user/development/work/WAT_project/frontend/wat_project_frontend/lib/domain/repositories), [usecases/](file:///Users/user/development/work/WAT_project/frontend/wat_project_frontend/lib/domain/usecases), [models/](file:///Users/user/development/work/WAT_project/frontend/wat_project_frontend/lib/domain/models), [services/](file:///Users/user/development/work/WAT_project/frontend/wat_project_frontend/lib/domain/services) |
| [lib/data/](file:///Users/user/development/work/WAT_project/frontend/wat_project_frontend/lib/data) | Data fetching, database, local storage, API clients, repository implementations | [sources/](file:///Users/user/development/work/WAT_project/frontend/wat_project_frontend/lib/data/sources), [db/](file:///Users/user/development/work/WAT_project/frontend/wat_project_frontend/lib/data/db), [entities/](file:///Users/user/development/work/WAT_project/frontend/wat_project_frontend/lib/data/entities), [repositories_impl/](file:///Users/user/development/work/WAT_project/frontend/wat_project_frontend/lib/data/repositories_impl), [mappers/](file:///Users/user/development/work/WAT_project/frontend/wat_project_frontend/lib/data/mappers) |
| [lib/features/](file:///Users/user/development/work/WAT_project/frontend/wat_project_frontend/lib/features) | UI/Presentation feature modules | [auth/](file:///Users/user/development/work/WAT_project/frontend/wat_project_frontend/lib/features/auth), [post/](file:///Users/user/development/work/WAT_project/frontend/wat_project_frontend/lib/features/post) |
| [lib/di/](file:///Users/user/development/work/WAT_project/frontend/wat_project_frontend/lib/di) | Dependency Injection registration (get_it + injectable) | [api_module.dart](file:///Users/user/development/work/WAT_project/frontend/wat_project_frontend/lib/di/api_module.dart), [bloc_module.dart](file:///Users/user/development/work/WAT_project/frontend/wat_project_frontend/lib/di/bloc_module.dart) |
| [lib/routes/](file:///Users/user/development/work/WAT_project/frontend/wat_project_frontend/lib/routes) | Navigation configurations | [app_routes.dart](file:///Users/user/development/work/WAT_project/frontend/wat_project_frontend/lib/routes/app_routes.dart) |

---

## 3. Design System & Style Guide

All UI screens must use the extracted Figma design tokens to maintain a premium visual aesthetic.

### Typography (Inter Font Family)
Use standard style mappings using the following scale:
* **Display:** `fontSize: 20`, `fontWeight: FontWeight.w700`, `lineHeight: 1.4` (28px)
* **Body Lg:** `fontSize: 17`, `fontWeight: FontWeight.w400`
* **Body Lg Semibold:** `fontSize: 17`, `fontWeight: FontWeight.w600`
* **Body Bold:** `fontSize: 16`, `fontWeight: FontWeight.w700`
* **Body Bold 2:** `fontSize: 15`, `fontWeight: FontWeight.w700`
* **Body Sm:** `fontSize: 13`, `fontWeight: FontWeight.w400`

### Color Palette
Map colors to variables in [app_colors.dart](file:///Users/user/development/work/WAT_project/frontend/wat_project_frontend/lib/core/theme/app_colors.dart):
* `textPrimary`: `Color(0xFF000000)`
* `textSecondary`: `Color(0xFF494551)`
* `accent`: `Color(0xFF9747FF)` (Primary Brand Purple)
* `background`: `Color(0xFFFFFFFF)`
* `backgroundAlt`: `Color(0xFFF6F4F4)`
* `surface`: `Color(0xFFD9D9D9)`
* `surfaceAlt`: `Color(0xFFEFEFEF)` (light surface) / `Color(0xFFB3B3B3)` (dark surface alt)

### Spacing & Grid System
* Base unit is **4px**. Use only values on the grid: `4, 8, 12, 16, 20, 24, 32, 40, 48, 64`.
* *Correction Rule:* If Figma dimensions show odd offsets (like 3px, 5px, 9px, 10px), round them to the nearest 4px grid multiple in the Flutter code.

### Shape Language (Border Radii)
* `radius-sm`: `10.0`
* `radius-md`: `15.0`
* `radius-lg-2`: `20.0`
* `radius-lg`: `50.0` (Use for circle elements or full-pill buttons)

### Elevation & Shadows
* `elevation-1`: Shadow configuration: `BoxShadow(color: Color(0x40000000), offset: Offset(2, 4), blurRadius: 4, spreadRadius: 0)`

---

## 4. Coding Conventions & Code Patterns

### Dependency Injection (DI)
Use `@module` annotation with the `injectable` package to register dependencies:
* Api instances go to [api_module.dart](file:///Users/user/development/work/WAT_project/frontend/wat_project_frontend/lib/di/api_module.dart).
* Blocs / state containers go to [bloc_module.dart](file:///Users/user/development/work/WAT_project/frontend/wat_project_frontend/lib/di/bloc_module.dart).

### API Client
Retrofit is utilized to define network requests. Write request methods in [api_client.dart](file:///Users/user/development/work/WAT_project/frontend/wat_project_frontend/lib/data/sources/api_client/api_client.dart):
```dart
@RestApi()
abstract class ApiClient {
  @factoryMethod
  factory ApiClient(Dio dio) = _ApiClient;

  @POST("/auth/login")
  Future<LoginResponseModel> login(@Body() LoginRequestModel request);
}
```
* **Interceptors:** Every network request must route through [auth_interceptor.dart](file:///Users/user/development/work/WAT_project/frontend/wat_project_frontend/lib/data/sources/api_client/interceptors/auth_interceptor.dart) and [logging_interceptor.dart](file:///Users/user/development/work/WAT_project/frontend/wat_project_frontend/lib/data/sources/api_client/interceptors/logging_interceptor.dart).

### Repositories & Usecases
* Define abstract repositories in `domain/repositories/` (e.g. [auth_repository.dart](file:///Users/user/development/work/WAT_project/frontend/wat_project_frontend/lib/domain/repositories/auth_repository.dart)).
* Implement them in `data/repositories_impl/` (e.g. [auth_repository_impl.dart](file:///Users/user/development/work/WAT_project/frontend/wat_project_frontend/lib/data/repositories_impl/auth_repository_impl.dart)).
* Map remote DTO models to Domain Models using mappers in `data/mappers/` (e.g. [post_mapper.dart](file:///Users/user/development/work/WAT_project/frontend/wat_project_frontend/lib/data/mappers/post_mapper.dart)).
* Usecases should perform a single business action, injected with relevant repositories:
```dart
@injectable
class GetPostsUseCase {
  final PostRepository _repository;
  GetPostsUseCase(this._repository);

  Future<Either<Failure, List<Post>>> call() async => _repository.getPosts();
}
```

### State Management (BLoC)
Every feature uses `flutter_bloc` for state management:
* **Events:** Immutable events in `feature_event.dart`.
* **State:** Distinct, descriptive states in `feature_state.dart` (Initial, Loading, Success, Error).
* **BLoC:** Implements event handlers in `feature_bloc.dart`.

---

## 5. Development Checklist for New Agents

Before declaring any feature or fix complete, verify the following:

- [ ] A design or functional spec was written first.
- [ ] No API client or database calls are written directly in UI screens or BLoC; all go through usecases and repositories.
- [ ] Mappers are used to isolate network API response models from domain layer models.
- [ ] Custom widgets from [lib/core/widgets/](file:///Users/user/development/work/WAT_project/frontend/wat_project_frontend/lib/core/widgets/) are preferred over inline layouts.
- [ ] Color values match the token variables in [app_colors.dart](file:///Users/user/development/work/WAT_project/frontend/wat_project_frontend/lib/core/theme/app_colors.dart).
- [ ] All code conforms to Flutter lint configurations in [analysis_options.yaml](file:///Users/user/development/work/WAT_project/frontend/wat_project_frontend/analysis_options.yaml).
- [ ] Unit or widget tests are created or updated, proving the logic works correctly.
