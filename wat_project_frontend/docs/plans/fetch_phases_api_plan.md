# Implementation Plan: Dynamic Journey Phase Integration

## Overview
We need to fetch journey phases dynamically from `/api/v1/journey/phases` using `JourneyPhaseEntity` / `JourneyPhaseModel` and use this live data across all pages that display or reference phases:
1. **Journey Timeline**: Render the timeline nodes dynamically based on the fetched phases.
2. **Register Form**: Populate the phase dropdown selector dynamically from the API (with a safe fallback if unauthenticated).
3. **Create Mission Form**: Populate the phase dropdown dynamically using `ListJourneyPhasesUseCase`.

## Architectural Integration

### 1. Data and Use Case Level
- **Retrofit & Repository**: The API call `listPhases()` returning `PaginationResponse<JourneyPhaseEntity>` and repository layer returning `Future<List<JourneyPhaseEntity>>` are already implemented.
- **Use Case**: `ListJourneyPhasesUseCase` returns `Future<Either<Failure, List<JourneyPhaseModel>>>`. We will use this use case inside widgets to pull phase information dynamically.

### 2. State & UI Binding

#### A. Journey Timeline Page (`JourneyTimelinePage`)
- **Action**: Wrap the `Timeline` tab body in a `BlocProvider` of `JourneyGamificationBloc` (if not already provided by parent router context) and a `BlocBuilder`.
- **Flow**:
  1. Trigger `JourneyPhasesRequested` event on page load.
  2. Handle state states (`JourneyGamificationLoading`, `JourneyPhasesLoadSuccess`, `JourneyGamificationFailure`).
  3. Map the active phase using the logged-in user's profile (`UserModel.currentPhaseId` or `UserAccount.currentPhaseId`).
  4. Dynamically build `PhaseNodeWidget` list from the returned phases:
     - Completed: `phaseNumber < currentPhaseNumber`
     - Active: `phaseNumber == currentPhaseNumber`
     - Upcoming: `phaseNumber > currentPhaseNumber`

#### B. Register Page (`RegisterPage`)
- **Action**: Fetch phases from `ListJourneyPhasesUseCase` during `initState()`.
- **Flow**:
  1. Call `getIt<ListJourneyPhasesUseCase>().call()`.
  2. If successful, populate the `_phases` list and rebuild the dropdown.
  3. If it fails (e.g., due to 401 unauthenticated access), fallback to the hardcoded `phase-1` to `phase-4` items.

#### C. Create Mission Page (`CreateMissionPage`)
- **Action**: Fetch phases dynamically during `initState()`.
- **Flow**:
  1. Define a private `List<JourneyPhaseModel> _fetchedPhases = []` state list.
  2. Call `getIt<ListJourneyPhasesUseCase>().call()` in `initState()`.
  3. On success, update `_fetchedPhases` and select the first item as the default `_selectedPhaseId`.
  4. Map the dropdown items dynamically using `_fetchedPhases`.

## Task List

### Phase 1: Usecase Integration & State Management
- [ ] **Task 1: Fetch Phases in Register Page**
  - *Description*: Load phases dynamically in `RegisterPage`'s `initState` using `ListJourneyPhasesUseCase`.
  - *Files*: `lib/presentation/auth_profile/login/ui/register_page.dart`
  - *Scope*: S

- [ ] **Task 2: Fetch Phases in Create Mission Page**
  - *Description*: Replace the static phase list in `CreateMissionPage` with dynamic data fetched from `ListJourneyPhasesUseCase`.
  - *Files*: `lib/presentation/missions_tasks/screens/create_mission_page.dart`
  - *Scope*: S

- [ ] **Task 3: Dynamic Timeline Tab in JourneyTimelinePage**
  - *Description*: Wrap the timeline tab in `BlocBuilder<JourneyGamificationBloc, JourneyGamificationState>` and trigger `JourneyPhasesRequested` on initialization. Render dynamic `PhaseNodeWidget`s by comparing with the current user's profile phase.
  - *Files*: `lib/presentation/journey_gamification/screens/journey_timeline_page.dart`
  - *Scope*: M

### Checkpoint: Complete Verification
- [ ] Run static analysis (`flutter analyze`).
- [ ] Run unit and widget tests (`flutter test`).
- [ ] Ensure that code generation and dependency injection are fully aligned.
