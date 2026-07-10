# Implementation Plan: Login & Register Improvements

## Overview
We need to enhance and fix the authentication screens (Login and Registration) to support social login, eye-toggle passwords, remove autocorrect on sensitive inputs, implement email OTP verification on registration, make registration fields conditional on phase selection, and fix existing compilation/runtime errors in the registration page.

## Architecture Decisions
- **`WatInputField` Autocorrect Flags**: Expose `autocorrect` and `enableSuggestions` parameters (both defaulting to `true` but configurable) to `WatInputField` so email and password fields can disable keyboard suggestions/corrections.
- **Eye Icon Toggle**: Manage state variables `_obscurePassword` (and `_obscureConfirmPassword` if needed) in `LoginView` and `RegisterPage` to toggle visibility of password inputs.
- **Google Login Mocking**: Add a visually polished "Sign In with Google" button to `LoginView`. When clicked, it displays a mock loading spinner for 1 second, then creates and saves a mock authenticated session using `AuthSessionManager` before navigating to `/home`.
- **OTP Verification Flow**: When the registration form is submitted, validate inputs. If valid, show an OTP verification screen/step (6-digit code entry). We'll accept code `123456` as the correct OTP for verification before proceeding to dispatch the `RegisterSubmittedEvent` bloc event.
- **Conditional Fields**: Add a Phase selector dropdown (Phase 1 to 4) to the register page. If Phase 2, 3, or 4 is selected, show Arrival Date and Job Start Date inputs (which open date pickers) and make them mandatory. For Phase 1, these fields are optional.
- **Refactoring register_page bloc states**: Correctly use `state.status` (e.g. `UILoading`, `UILoadFailed`, `UILoadSuccess`) instead of the undefined/commented-out `LoginLoading` and `LoginFailure` classes.

## Task List

### Phase 1: Input Improvements (Autocorrect & Eye Toggle)
- [ ] **Task 1: Update `WatInputField` with autocorrect controls**
  - *Description*: Add `autocorrect`, `enableSuggestions`, and optional `keyboardType` parameters to `WatInputField`.
  - *Acceptance*: Can disable suggestions and corrections for input fields.
  - *Files*: `lib/presentation/widgets/wat_input_field.dart`
  - *Scope*: XS

- [ ] **Task 2: Implement password visibility toggle**
  - *Description*: Set up an eye icon suffix button in the password fields of `login_view.dart` and `register_page.dart` using a boolean state variable.
  - *Acceptance*: Clicking the eye icon toggles the obscureText property.
  - *Files*: `lib/presentation/auth_profile/login/ui/login_view.dart`, `lib/presentation/auth_profile/login/ui/register_page.dart`
  - *Scope*: S

### Phase 2: Login Screen Enhancements
- [ ] **Task 3: Add Google Sign In Option**
  - *Description*: Render a Google Sign-In button on the login screen. Clicking it simulates google authentication by displaying a 1-second loading spinner and saving a mock session.
  - *Acceptance*: Google sign-in works, bypasses credential entry, and navigates successfully to home page.
  - *Files*: `lib/presentation/auth_profile/login/ui/login_view.dart`
  - *Scope*: S

### Phase 3: Registration Screen Enhancements & Fixing Errors
- [ ] **Task 4: Fix register_page bloc state errors**
  - *Description*: Replace references to `LoginFailure` and `LoginLoading` with the correct `state.status` checks (`UILoadFailed`, `UILoading`, `UILoadSuccess`).
  - *Acceptance*: Registration screen compiles and handles Bloc states correctly.
  - *Files*: `lib/presentation/auth_profile/login/ui/register_page.dart`
  - *Scope*: S

- [ ] **Task 5: Implement Phase-based Conditional Form Fields**
  - *Description*: Replace name input with Username. Add Phase selector dropdown. If Phase is not Phase 1, require Arrival Date and Job Start Date using date pickers.
  - *Acceptance*: Arrival Date and Job Start Date validation logic adapts to the selected Phase.
  - *Files*: `lib/presentation/auth_profile/login/ui/register_page.dart`
  - *Scope*: M

- [ ] **Task 6: Implement OTP Verification Sub-step**
  - *Description*: Before submitting registration to Bloc, display a 6-digit OTP verification screen. Require entry of OTP `123456` to finalize registration.
  - *Acceptance*: Valid OTP input completes registration; invalid OTP shows error.
  - *Files*: `lib/presentation/auth_profile/login/ui/register_page.dart`
  - *Scope*: M

### Checkpoint: Verify Refactored Auth
- [ ] Run `flutter analyze` and verify there are no compilation errors in auth presentation files.
- [ ] Run `flutter test` to ensure all tests pass.

## Risks and Mitigations
| Risk | Impact | Mitigation |
|------|--------|------------|
| Missing backend support for Phase/Arrival/Job Dates in Register endpoint | Low | Map fields to firstName/lastName or mock the registration completion if direct backend call fails. |
