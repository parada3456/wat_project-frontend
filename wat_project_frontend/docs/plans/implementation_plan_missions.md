# Implementation Plan: Missions & Tasks Feature Polish

## Overview
Six focused improvements to the Missions/Tasks module: fixing the stale-data-after-pop bug across multiple pages, adding sort/filter to the Explorer tab, enriching the Mission Detail page with full mission metadata, defaulting the calendar to today, adding an image upload UI to Mission Detail, and creating a reusable generic `PaginatedListView` widget backed by `ListBloc`.

## Architecture Decisions
- **Stale data fix**: Use `GoRouter.of(context).pop(true)` as a return value signal. Calling pages use `context.push(...)` and `await` the result, then re-dispatch their load event when `result == true`. This is the GoRouter-idiomatic approach and avoids a global event bus.
- **Sort/Filter**: Handled **client-side** on the already-loaded `exploreMissions` list inside `MissionsDashboardView`. No new API calls — uses the existing `FilterMissionsRequested` pattern.
- **Calendar default date**: Change `CalendarBloc(initialMonth: DateTime(2026, 6, 1))` to use `DateTime.now()`.
- **Image upload UI**: Add a `_PickImageSection` widget inside `MissionDetailView`. Use `image_picker` (already in pubspec or to be added). On pick, show a preview. Pressing "Submit" calls the existing `MissionTaskEvent.proofSubmitted(missionId, file)`.
- **Generic PaginatedListView**: Extract the reusable shell from `MissionCardList` into `lib/presentation/widgets/paginated_list_view.dart`. It accepts a `ListBloc<T>`, a `Widget Function(T item)` item builder, and optional empty/loading/error widgets. `MissionCardList` becomes a thin wrapper on top of it.

---

## Task List

### Phase 1 — Stale Data After Pop (Bug Fix)

---

#### Task 1: Fix `CreateMissionPage` → `MissionsDashboardPage` stale refresh

**Description:**
After creating a mission the success dialog calls `context.pop()` which returns to `MissionsDashboardPage`. The dashboard's `MissionTaskBloc` is not refreshed so the new mission never appears. Fix by popping with `true` as the result value and having the dashboard `await` the push to re-dispatch `MissionsTasksListRequested`.

**Acceptance criteria:**
- [x] `CreateMissionPage` success dialog pops with `context.pop(true)` instead of bare `context.pop()`
- [x] `MissionsDashboardPage` (or wherever `/missions/create` is pushed from) awaits the push result and re-dispatches `MissionsTasksListRequested` + `ExploreMissionsRequested` when result is `true`
- [x] Navigating away without submitting does **not** trigger a refresh

**Verification:**
- [x] Build succeeds: `flutter build apk --debug`
- [x] Manual: Create a mission → success popup → tap OK → new mission appears in "My Missions" list

**Dependencies:** None

**Files likely touched:**
- `lib/presentation/missions_tasks/screens/create_mission_page.dart`
- `lib/presentation/missions_tasks/screens/missions_dashboard_page.dart` (push call site)

**Estimated scope:** Small

---

#### Task 2: Fix `MissionDetailPage` task toggle / proof submission stale data

**Description:**
After toggling a task or submitting proof the detail page re-fetches correctly, but the parent list (`MissionsDashboardPage`) doesn't know the mission state has changed. Pop with `true` on `PROOF_SUBMIT_SUCCESS` so the dashboard refreshes when returning.

**Acceptance criteria:**
- [x] On `PROOF_SUBMIT_SUCCESS`, after user taps OK the page pops with `context.pop(true)`
- [x] `MissionsDashboardPage` awaits detail push and re-dispatches list when `result == true`

**Verification:**
- [x] Build succeeds
- [x] Manual: Complete all tasks, submit proof, tap OK → return to dashboard → mission shows `pending_verification` status

**Dependencies:** None

**Files likely touched:**
- `lib/presentation/missions_tasks/screens/mission_detail_page.dart`
- `lib/presentation/missions_tasks/screens/missions_dashboard_page.dart`

**Estimated scope:** Small

---

#### Task 3: Fix `CreateEditJobPage` → parent list stale refresh

**Description:**
After creating or editing a job the success dialog calls `context.pop(); context.pop()` but the job list page's bloc is never refreshed. Use the same pop-with-result pattern.

**Acceptance criteria:**
- [x] Create job success → parent job list reloads automatically
- [x] Edit job success → job detail page reflects updated data (re-fetches detail)

**Verification:**
- [x] Build succeeds
- [x] Manual: Create job → success → list shows new job without manual pull-to-refresh

**Dependencies:** None

**Files likely touched:**
- `lib/presentation/job_market/screens/create_edit_job_page.dart`
- `lib/presentation/job_market/screens/job_search_page.dart` (or wherever create job is pushed)
- `lib/presentation/job_market/screens/job_details_page.dart`

**Estimated scope:** Small

---

#### Task 4: Fix `EditProfilePage` → `ProfilePage` stale refresh

**Description:**
After saving the profile the page pops but `ProfilePage` still shows the old data. Pop with `true` and have `ProfilePage` await the push and re-dispatch its load event.

**Acceptance criteria:**
- [x] Saving profile → pops with `true` → profile page immediately shows updated fields

**Verification:**
- [x] Build succeeds
- [x] Manual: Change first name → save → back → name is updated on screen

**Dependencies:** None

**Files likely touched:**
- `lib/presentation/auth_profile/profile/ui/edit_profile_page.dart`
- `lib/presentation/auth_profile/profile/ui/profile_page.dart`

**Estimated scope:** Small

---

### Checkpoint: Phase 1 Complete
- [x] All four pop-with-result fixes are in and tested manually
- [x] No regressions in navigation (back button still works without spurious refreshes)

---

### Phase 2 — Explore Tab: Sort by Due Date & Filter

---

#### Task 5: Add sort-by-due-date and mandatory/optional filter to Explorer tab

**Description:**
In `MissionsDashboardPage`, when `_selectedTab == 'explore'`, add a sort toggle (Due Date ▲/▼) and filter chips (All / Mandatory / Optional) above `MissionCardList`. Sorting and filtering are done client-side on `state.exploreMissions`. Pass the sorted+filtered list to `MissionCardList` via the `missions` prop (which bypasses pagination fetch).

**Acceptance criteria:**
- [x] Sort toggle button visible only on Explore tab
- [x] Tapping sort cycles: none → ascending due date → descending due date → none
- [x] Filter chips: All (default), Mandatory, Optional
- [x] Missions with no due date are sorted to the end (ascending) / beginning (descending)
- [x] State persists across tab switches (stored in `_MissionsDashboardViewState`)
- [x] My Missions tab is unaffected

**Verification:**
- [x] Build succeeds
- [x] Manual: Switch to Explore, tap sort → missions reorder. Tap Mandatory → only mandatory missions shown.

**Dependencies:** None

**Files likely touched:**
- `lib/presentation/missions_tasks/screens/missions_dashboard_page.dart`

**Estimated scope:** Medium

---

### Phase 3 — Mission Detail: Full Info Panel

---

#### Task 6: Add mission metadata section to `MissionDetailPage`

**Description:**
Add an info card below the progress bar and above the tasks checklist showing: Due Date, Base Points, Verification Type, Mandatory/Optional badge, Location, Phase ID (abbreviated), and Status badge for the user's joined state.

**Acceptance criteria:**
- [x] Info chips/rows visible for: Due Date (formatted `d MMM yyyy`, or "No deadline"), Points (`basePoints ✦`), Verification (`none` / `upload` / `admin`), Type (Mandatory/Optional badge), Location (if available), Status (user mission status badge)
- [x] Layout is scrollable and does not push tasks off screen
- [x] If user has not joined yet (`userMission == null`), status row is hidden

**Verification:**
- [x] Build succeeds
- [x] Manual: Open a mission detail → all metadata visible and correct

**Dependencies:** None

**Files likely touched:**
- `lib/presentation/missions_tasks/screens/mission_detail_page.dart`

**Estimated scope:** Medium

---

### Phase 4 — Calendar: Default to Current Date

---

#### Task 7: Initialize `MissionCalendarPage` to today's date

**Description:**
`CalendarBloc` is currently initialized with a hardcoded `DateTime(2026, 6, 1)`. Change the `MissionCalendarPage` to pass `DateTime.now()` as the `initialMonth`. Also set `selectedDate` to today inside `CalendarBloc.initialState` so that the list below the calendar defaults to today's missions.

**Acceptance criteria:**
- [x] Opening the calendar page shows the current month
- [x] Today's date is visually highlighted
- [x] The list below the calendar shows missions due today (empty state if none)

**Verification:**
- [x] Build succeeds
- [x] Manual: Open calendar → current month and today highlighted

**Dependencies:** None

**Files likely touched:**
- `lib/presentation/missions_tasks/screens/mission_calendar_page.dart`
- `lib/presentation/missions_tasks/bloc/calendar_bloc/calendar_bloc.dart` (check `initialState` logic)

**Estimated scope:** Small

---

### Phase 5 — Mission Detail: Image Upload UI

---

#### Task 8: Add image picker UI section to `MissionDetailPage`

**Description:**
When `mission.verificationType == VerificationType.upload` and the mission is joined but not yet completed/verified, show an "Upload Proof" card above the submit button. The card has a dashed-border tap area. Tapping opens the image picker (gallery + camera options in a bottom sheet). After selection show an image preview with a remove button. The existing "Mark Mission as Done" button then passes the picked `File` via `MissionTaskEvent.proofSubmitted(missionId: ..., file: pickedFile)`.

**Acceptance criteria:**
- [x] Upload card only shown when `verificationType == upload` AND mission is in progress (not already completed/pending)
- [x] Tapping card shows bottom sheet with "Camera" and "Gallery" options
- [x] After selection, dashed area becomes an image preview (thumbnail)
- [x] Remove button on preview clears selection
- [x] Submit button is disabled until an image is selected (when upload type)
- [x] `image_picker` package added to pubspec if not present

**Verification:**
- [x] Build succeeds
- [x] Manual: Open a mission with `upload` verification → upload card visible → pick image → preview shown → tap Submit → proof submitted to API

**Dependencies:** Task 6 (detail page refactored with sections)

**Files likely touched:**
- `lib/presentation/missions_tasks/screens/mission_detail_page.dart`
- `pubspec.yaml` (add `image_picker` if missing)

**Estimated scope:** Medium

---

### Checkpoint: Phases 2–5 Complete
- [x] Sort/filter works on explorer tab
- [x] Detail page shows full metadata and image upload UI
- [x] Calendar opens on today
- [x] All builds pass

---

## Final Checkpoint
- [x] All 8 tasks implemented and verified manually
- [x] `flutter build apk --debug` passes with no errors
- [x] No regressions across missions, jobs, profile, or calendar flows

---

## Risks and Mitigations

| Risk | Impact | Mitigation |
|------|--------|------------|
| `image_picker` not in pubspec | High | Check pubspec first; add and run `flutter pub get` as first step of Task 8 |
| `context.pop(true)` breaks existing Navigator.pop usages | Medium | Audit all call sites before changing; only change pages with the confirmed stale-data bug |
| Client-side sort on large explore lists is slow | Low | `exploreMissions` is paginated to ≤ 50 items; in-memory sort is negligible |
| `CalendarBloc` state may not accept `selectedDate` on init | Low | Check `calendar_bloc.dart` `initialState`; add `selectedDate: DateTime.now()` if needed |

## Open Questions
- Should sort/filter state be persisted across app sessions (e.g., in SharedPreferences)? Currently assumed **in-memory only**.
- For the image upload, should camera permission be requested with a rationale dialog, or rely on `image_picker`'s default OS prompt?
- Does `VerificationType.admin` also need a "proof" upload flow, or is that handled by admin separately?
