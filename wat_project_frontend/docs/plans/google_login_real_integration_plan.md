# Implementation Plan: Google Sign-In Integration

## Overview
We need to replace the simulated Google login with a real Google Sign-In flow using the official `google_sign_in` package, communicating with the backend `/api/v1/auth/google` REST endpoint.

## Architecture Decisions
- **Dependency Management**: Add `google_sign_in` dependency to `pubspec.yaml`.
- **API Request Model**: Create a new request model `GoogleLoginRequest` that maps to the `/api/v1/auth/google` request body schema: `{ "id_token": "..." }`.
- **API Client Endpoint**: Define the post request endpoint `@POST('auth/google')` in `AuthApiService`.
- **Repository Pattern**: Add `googleLogin(String idToken)` to `AuthRepository` interface and its implementation `AuthRepoImpl`.
- **Clean Architecture Use Case**: Create a new `GoogleLoginUseCase` in domain layer to orchestrate the backend request and mapping.
- **BLoC Pattern**: Add `GoogleLoginSubmittedEvent` to `LoginBloc` and wire the UI action to dispatch this event.

## Task List

### Phase 1: Dependencies & Network Models
- [ ] **Task 1: Add `google_sign_in` dependency**
  - *Description*: Add the `google_sign_in` package to `pubspec.yaml` using Flutter CLI.
  - *Acceptance*: Dependency is added to `pubspec.yaml` and `flutter pub get` completes successfully.
  - *Files*: `pubspec.yaml`
  - *Scope*: XS

- [ ] **Task 2: Create API request model and add endpoint**
  - *Description*: Define `GoogleLoginRequest` in `api_model/authentication/google_login_request.dart` and add `googleLogin` endpoint to `AuthApiService` interface. Run retrofit generator.
  - *Acceptance*: Retrofit generator rebuilds `auth_api_client.g.dart` without errors.
  - *Files*:
    - `lib/data/sources/api/api_model/authentication/google_login_request.dart`
    - `lib/data/sources/api/auth_api_client.dart`
  - *Scope*: S

### Phase 2: Domain & Data Implementation
- [ ] **Task 3: Implement AuthRepository & UseCase**
  - *Description*: Update `AuthRepository` and `AuthRepoImpl` with `googleLogin`. Create `GoogleLoginUseCase`.
  - *Acceptance*: UseCase delegates the call correctly to Repository and handles mapping.
  - *Files*:
    - `lib/domain/repositories/auth_repository.dart`
    - `lib/data/repository_impl/auth_repo_impl.dart`
    - `lib/domain/usecases/auth/google_login_usecase.dart`
    - `lib/domain/usecases/auth_usecases.dart`
  - *Scope*: S

- [ ] **Task 3.1: Run `build_runner` code generation**
  - *Description*: Rebuild retrofit and json serialization classes using `flutter pub run build_runner build --delete-conflicting-outputs`.
  - *Acceptance*: All codegen completes successfully.
  - *Scope*: XS

- [ ] **Task 4: Add GoogleLoginSubmittedEvent to BLoC**
  - *Description*: Add `GoogleLoginSubmittedEvent` to `LoginEvent` and handle it in `LoginBloc`. Update injectable DI.
  - *Acceptance*: `LoginBloc` has event listener for Google sign-in and passes the token to the usecase.
  - *Files*:
    - `lib/presentation/auth_profile/login/bloc/login_event.dart`
    - `lib/presentation/auth_profile/login/bloc/login_bloc.dart`
  - *Scope*: S

### Phase 3: UI Integration
- [ ] **Task 5: Integrate Google Sign-In in LoginView**
  - *Description*: Import `google_sign_in` in `login_view.dart`, implement `getGoogleIdToken()`, and dispatch `GoogleLoginSubmittedEvent` with the obtained ID token on button click.
  - *Acceptance*: Tapping Google button triggers native Google Sign-in flow and forwards token to Bloc.
  - *Files*: `lib/presentation/auth_profile/login/ui/login_view.dart`
  - *Scope*: S

### Checkpoint: Complete Verification
- [ ] Rebuild all dependency injectors.
- [ ] Run static analysis (`flutter analyze`) and unit tests (`flutter test`).
- [ ] Verify that Google sign-in flow triggers and maps responses correctly.

## Risks and Mitigations
| Risk | Impact | Mitigation |
|------|--------|------------|
| Google Sign-In cancelled by user | Low | Correctly handle null result from `googleSignIn.signIn()` and return cleanly. |
| Client Configuration (OAuth Client IDs) | Medium | Client IDs for Android/iOS should be configured in corresponding platform directories (GoogleServices-Info.plist and google-services.json) or supplied via options. |
