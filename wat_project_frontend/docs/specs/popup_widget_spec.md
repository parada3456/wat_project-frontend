# Spec: Popup Widget and SnackBar Replacement

## Objective
We want to replace the current use of ScaffoldMessenger-based SnackBars across the application with a new custom popup dialog widget (`AppPopup`). The popup should:
1. Support 1, 2, or 3 buttons with customizable actions and styling.
2. Adapt to light and dark themes beautifully.
3. Show clean iconography matching the context (Success, Error, Warning, Info).
4. Provide a consistent, premium design with clean typography and spacing.
5. Provide a static helper method to display it with minimal boilerplate code.

## Tech Stack
- Frontend: Flutter & Dart
- State Management: `flutter_bloc`
- Key Theme Values: `AppColors`, `AppDimension` from `lib/utils/theme_constants.dart`

## Commands
- Run app: `flutter run`
- Run all tests: `flutter test`
- Run specific test file: `flutter test test/app_popup_test.dart`
- Format code: `dart format lib/ test/`
- Analyze code: `flutter analyze`

## Project Structure
We will add/modify files in the following structure:
```
lib/
  core/
    widgets/
      app_popup.dart         # New: The AppPopup widget and helper class
test/
  app_popup_test.dart        # New: Widget tests for AppPopup
```

## Code Style
Here is a snippet showing how `AppPopup` should be designed and invoked:

```dart
// Usage example:
AppPopup.show(
  context: context,
  title: 'Success',
  message: 'Logged in successfully!',
  type: AppPopupType.success,
  buttons: [
    AppPopupButton(
      label: 'Go to Home',
      isPrimary: true,
      onPressed: () {
        Navigator.of(context).pop();
        context.push('/home');
      },
    ),
  ],
);
```

Key features of the implementation:
- Use standard Material `showDialog` underneath.
- Type enum `AppPopupType` to support `success`, `error`, `warning`, `info`, and `none`.
- Dynamic button layout: Row for 1-2 buttons, Column for 3 buttons.
- Proper spacing and constraints (maximum width of 340dp).
- The dialog should have a subtle animation and clean alignment.

## Testing Strategy
- Frame: `flutter_test` (Widget Testing)
- Verify that `AppPopup` displays title, message, and correct number of buttons.
- Verify that clicking a button triggers its `onPressed` callback.
- Verify the responsive layouts: Row layout for <= 2 buttons, Column layout for 3 buttons.
- Verification locations: `test/app_popup_test.dart`.

## Boundaries
- **Always**: Use the existing theme's `AppColors` and `AppDimension` for styling.
- **Ask first**: Making changes to build runner or routing mechanism (already using go_router).
- **Never**: Hardcode text styles or colors that ignore light/dark theme.

## Success Criteria
- [ ] `AppPopup` class created in [app_popup.dart](file:///Users/user/development/work/WAT_project/frontend/wat_project_frontend/lib/core/widgets/app_popup.dart) with support for 1-3 buttons.
- [ ] Popups match the app design theme (support dark & light modes).
- [ ] Unit and widget tests pass in `test/app_popup_test.dart`.
- [ ] Existing `SnackBar` usages are replaced with `AppPopup` where user notifications (success, error) occur. Specifically in:
  - `login_view.dart`
  - `edit_profile_page.dart`
  - `profile_page.dart`
  - `user_settings_page.dart`
  - `admin_dashboard_page.dart`
  - `create_mission_page.dart`
  - `mission_detail_page.dart`
- [ ] No compilation or runtime errors are introduced.

## Technical Implementation Plan
1. **Prepare test suite compilation**: Fix `test/missions_usecases_test.dart` compilation error (the file is fully commented out, but needs to be either deleted or renamed, or we can just provide an empty `void main() {}` in it so it passes compilation).
2. **Implement AppPopup widget & types**: Define `AppPopupType`, `AppPopupButton`, and `AppPopup` with dynamic layouts depending on button counts.
3. **Write widget tests**: Write `test/app_popup_test.dart` to cover all layout variations (1, 2, 3 buttons) and verify logic.
4. **Integrate popups in place of SnackBars**: Locate and rewrite ScaffoldMessenger calls to `AppPopup.show`.
5. **Validate**: Run formatting, analyzer, and tests to verify everything is 100% green.

## Tasks
- [ ] **Task 1**: Fix compilation error in [missions_usecases_test.dart](file:///Users/user/development/work/WAT_project/frontend/wat_project_frontend/test/missions_usecases_test.dart) by adding a dummy/empty `main()` function at the end.
  - *Acceptance*: `flutter test` compiles and runs successfully.
  - *Verify*: Run `flutter test` command.
  - *Files*: `test/missions_usecases_test.dart`
- [ ] **Task 2**: Create [app_popup.dart](file:///Users/user/development/work/WAT_project/frontend/wat_project_frontend/lib/core/widgets/app_popup.dart).
  - *Acceptance*: Correct styling, material dialog structure, colors from theme, support for 1-3 buttons, support for dark/light themes, and enum helper for success, error, warning, info, none.
  - *Verify*: Code compiles.
  - *Files*: `lib/core/widgets/app_popup.dart`
- [ ] **Task 3**: Create and run widget tests in [app_popup_test.dart](file:///Users/user/development/work/WAT_project/frontend/wat_project_frontend/test/app_popup_test.dart).
  - *Acceptance*: Tests covering 1, 2, and 3 buttons layouts and callback execution pass.
  - *Verify*: Run `flutter test test/app_popup_test.dart`.
  - *Files*: `test/app_popup_test.dart`
- [ ] **Task 4**: Replace `SnackBar` with `AppPopup` in auth & profile views.
  - *Acceptance*: All active SnackBars in login, register, edit profile, profile, and settings are replaced with `AppPopup`.
  - *Verify*: Code compiles.
  - *Files*:
    - `lib/presentation/auth_profile/login/ui/login_view.dart`
    - `lib/presentation/auth_profile/profile/ui/edit_profile_page.dart`
    - `lib/presentation/auth_profile/profile/ui/profile_page.dart`
    - `lib/presentation/auth_profile/screens/user_settings_page.dart`
- [ ] **Task 5**: Replace `SnackBar` with `AppPopup` in admin & mission pages.
  - *Acceptance*: SnackBars in admin dashboard, create mission, and mission detail are replaced.
  - *Verify*: Code compiles.
  - *Files*:
    - `lib/presentation/admin_dashboard/screens/admin_dashboard_page.dart`
    - `lib/presentation/missions_tasks/screens/create_mission_page.dart`
    - `lib/presentation/missions_tasks/screens/mission_detail_page.dart`
- [ ] **Task 6**: Run formatting, analyzer, and full test suite.
  - *Acceptance*: `dart format`, `flutter analyze`, and `flutter test` are clean and pass without issues.
  - *Verify*: Run command line validations.
  - *Files*: All modified files.
