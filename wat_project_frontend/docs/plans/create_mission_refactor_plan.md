# Implementation Plan: Create Mission Page & Mission Detail Refactor

## Overview
We need to refactor the mission creation page to support role-based validation (admin vs. normal user settings for points/mandatory status), improve the UI with a multi-page step form and task reordering (up/down rearrangement), use a dropdown for phase selection, and check/display the creator on the mission detail page.

## Architecture Decisions
1. **Admin Role Checking via AuthSessionManager**: We will add a helper property `isAdmin` to `AuthSessionManager` that decodes the active JWT token payload and checks for the `'is_admin'` claim.
2. **Local Multi-Page Form State**: The `CreateMissionPage` step state will be managed locally via `_currentStep` (0 for basic details, 1 for tasks check list) within `_CreateMissionViewState` to keep form validation clean.
3. **Task List Reordering**: Tasks list controllers will support swap-based index operations triggered by up/down arrow buttons.
4. **Creator Tracking**: We will add a nullable `createdBy` field to `MissionEntity` and `MissionModel` and check it against the local user session ID.

## Task List

### Phase 1: Models & Auth Helpers
- [ ] **Task 1: Add `isAdmin` property to `AuthSessionManager`**
  - *Description*: Implement a getter `bool get isAdmin` on `AuthSessionManager` to parse the JWT payload claims for the `'is_admin'` field.
  - *Acceptance*: `isAdmin` returns true for admin tokens and false otherwise.
  - *Verification*: Add a unit test or verify router usage compatibility.
  - *Files*: `lib/domain/services/auth_manager.dart`
  - *Scope*: XS

- [ ] **Task 2: Add `createdBy` field to Mission models**
  - *Description*: Add `created_by` parsing to `MissionEntity` and its mapper/model representation.
  - *Acceptance*: `createdBy` is properly deserialized and mapped to `MissionModel`.
  - *Verification*: Run `build_runner` build and check generated code files.
  - *Files*:
    - `lib/data/entities/mission/mission_entity.dart`
    - `lib/domain/models/mission/mission_model.dart`
    - `lib/data/mappers/mission_mapper.dart`
  - *Scope*: S

### Checkpoint: Models & Auth Helpers
- [ ] Application builds successfully: `flutter analyze` is clean.
- [ ] `build_runner` compiles successfully.

### Phase 2: Create Mission Page Refactoring
- [ ] **Task 3: Phase Selection & Role-based Settings**
  - *Description*: Change Phase ID input to a dropdown of Phase 1-4. Disable and fix points to 100, and mandatory status to false if user is not an admin.
  - *Acceptance*: Dropdown selection functions, normal users cannot edit base points or mandatory status (locked at 100 and false), admin users retain full editing capability.
  - *Verification*: Manual inspection of create page UI state with mock sessions.
  - *Files*: `lib/presentation/missions_tasks/screens/create_mission_page.dart`
  - *Scope*: M

- [ ] **Task 4: Multi-page Step Form Flow**
  - *Description*: Separate the form layout into two screens: Screen 1 for basic details/settings, Screen 2 for tasks checklist. Add navigation buttons ("Next", "Back") between pages.
  - *Acceptance*: Users must pass Screen 1 validation to proceed to Screen 2. Screen 2 displays the task list and a submit option.
  - *Verification*: Form validation functions correctly on step transition and final submit.
  - *Files*: `lib/presentation/missions_tasks/screens/create_mission_page.dart`
  - *Scope*: M

- [ ] **Task 5: Task List Rearrangement (Up/Down)**
  - *Description*: Add "Up" and "Down" buttons to the task list view cards to allow index-swapping the controllers and rearranging the checklist items.
  - *Acceptance*: Clicking "Up" shifts a task up, clicking "Down" shifts it down. The task index labels update accordingly.
  - *Verification*: Widget interaction and state rearrangement work correctly.
  - *Files*: `lib/presentation/missions_tasks/screens/create_mission_page.dart`
  - *Scope*: S

### Checkpoint: Create Mission Features
- [ ] Run `flutter analyze` to ensure form changes are error-free.
- [ ] Form submit creates missions with correct phase ID mappings and points.

### Phase 3: Mission Detail Refactoring
- [ ] **Task 6: Creator Identity Check & Badging**
  - *Description*: In `MissionDetailPage`, compare the logged-in user's ID with the mission's `createdBy` property and display a clean "Created by You" badge/indicator if they match.
  - *Acceptance*: A visually distinct chip or text indicator "Created by You" is displayed for owned missions.
  - *Verification*: Render mission details with matching and non-matching user IDs.
  - *Files*: `lib/presentation/missions_tasks/screens/mission_detail_page.dart`
  - *Scope*: S

### Checkpoint: Complete Refactor
- [ ] All unit and widget tests pass: `flutter test`.
- [ ] `flutter analyze` shows no new warnings or errors.

## Risks and Mitigations
| Risk | Impact | Mitigation |
|------|--------|------------|
| Codegen conflicts in `mission_entity.g.dart` | Med | Run `flutter pub run build_runner build --delete-conflicting-outputs` |
| Navigation back button pops the whole screen instead of previous step | Med | Intercept pop event using `PopScope` or local step logic inside scaffold leading appBar icon |

## Open Questions
- What styling should we use for the "Created by You" badge? (Recommended: A modern purple chip with an icon like `Icons.person_pin` next to the mission details header).
- Should the step progress (e.g. "Step 1 of 2") be shown at the top of the create mission page? (Recommended: Yes, to improve user orientation).
