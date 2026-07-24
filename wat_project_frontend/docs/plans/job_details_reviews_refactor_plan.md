# Implementation Plan: Job Detail UI and Add Review UI Refactor

## Overview
We need to refactor the Job Detail and Add Review screens to:
1. Move the "Write Review" button from a floating button to a fixed row element positioned just above the review comments list.
2. Relocate the "Save to Cart" / "Remove from Cart" actions to an icon button in the top right of the Job Detail AppBar.
3. Change the "Reserve" button to a Floating Action Button at the bottom right with the label "Apply now 🚀".
4. Add an "Employee Insights" card showing the overall ratings and a linear progress breakdown of all 8 score categories.
5. Expand the "Write Review" screen to collect all rating parameters (Agency, Job, Coworkers, Town, Hours, Housing, Feasibility, Overtime) and a new "Tips for Next Generation" field.
6. Update `CreateReviewRequest` API model and regenerate the generated code files.

## Architecture Decisions
- **Unified AppBar Actions**: appBar leading back button + actions for save-to-cart, editing/deleting (for admin), and sharing.
- **Form Sectioning in WriteReviewPage**: Use collapsible or clear headers to structure the 8 rating sliders, making the UI clean and easy to fill.
- **Model Regeneration**: Modify `CreateReviewRequest` and run `flutter pub run build_runner build --delete-conflicting-outputs` to update `create_review_request.g.dart`.

## Task List

### Phase 1: API Model & Code Generation
- [x] **Task 1: Update `CreateReviewRequest` Model**
  - *Description*: Add `tips_for_next_generation`, `score_agency`, `score_job`, `score_coworkers`, `score_town`, `score_hours`, `score_housing`, `score_second_job_feasibility`, and `score_overtime_availability` to the request model class.
  - *Acceptance*: Model class compiles and lists all new variables.
  - *Verification*: Code compiles.
  - *Files*: `lib/data/sources/api/api_model/job_review/create_review_request.dart`
  - *Scope*: S

- [x] **Task 2: Regenerate JSON Serialization Code**
  - *Description*: Run the build runner to regenerate serialization code for `CreateReviewRequest`.
  - *Acceptance*: Generated file `create_review_request.g.dart` is updated successfully.
  - *Verification*: Run `flutter pub run build_runner build --delete-conflicting-outputs`.
  - *Files*: `lib/data/sources/api/api_model/job_review/create_review_request.g.dart`
  - *Scope*: S

### Checkpoint: Foundation
- [x] Code compiles and build runner completes without errors.

### Phase 2: Add Review Form UI Refactor
- [x] **Task 3: Refactor `WriteReviewPage` UI and Submission**
  - *Description*: Update `WriteReviewPage` to display input fields and rating selectors for the new scores, a tips text field, and wire them up to construct and dispatch the expanded `CreateReviewRequest`.
  - *Acceptance*: Submitting a review posts all new scores and tips.
  - *Verification*: Open review page, interact with sliders, write tips, and submit.
  - *Files*: `lib/presentation/job_market/screens/write_review_page.dart`
  - *Scope*: M

### Phase 3: Job Detail UI Refactor
- [x] **Task 4: Add Ratings Breakdown Card**
  - *Description*: Create a new widget or section in the Job Detail page displaying the "Employee Insights" card with the overall score, star rating, and linear progress indicators for the 8 score categories.
  - *Acceptance*: Renders a polished card matching the Ratings Breakdown design.
  - *Verification*: View Job Detail screen and confirm the card renders correct ratings.
  - *Files*: `lib/presentation/job_market/screens/job_details_page.dart`
  - *Scope*: M

- [x] **Task 5: Refactor Actions and Floating Buttons in JobDetail**
  - *Description*: Move the cart bookmark button to the AppBar actions. Replace the bottom "Reserve" and "Save to Cart" buttons with a Floating Action Button for "Apply now 🚀". Put the "Write Review" button inline just above `JobReviewsSection`.
  - *Acceptance*: Scrolling details list has inline Write Review button, app bar has bookmark toggle, and floating button triggers application link.
  - *Verification*: Run app, verify button actions and positions.
  - *Files*:
    - `lib/presentation/job_market/screens/job_details_page.dart`
    - `lib/presentation/job_market/widgets/job_reviews_section.dart`
  - *Scope*: M

- [x] **Task 6: Redesign JobCard Widget**
  - *Description*: Convert `JobCard` to a horizontal row layout containing the business logo container on the left, details column (employer, role, location, rating row) in the middle, and salary badge (`+tips`) on the right.
  - *Acceptance*: JobCard matches the design in `Job Card 2.png`.
  - *Verification*: Verify layout in marketplace list view.
  - *Files*: `lib/presentation/job_market/widgets/job_card.dart`
  - *Scope*: S

### Phase 4: Verification
- [x] **Task 7: Run Code Verification**
  - *Description*: Run formatting, analysis, and test suite.
  - *Acceptance*: All build and quality checks are clean.
  - *Verification*: Run `dart format`, `flutter analyze`, and `flutter test`.
  - *Files*: None
  - *Scope*: XS

## Risks and Mitigations
| Risk | Impact | Mitigation |
|------|--------|------------|
| Build runner conflicts or compilation issues | Medium | Run build runner with `--delete-conflicting-outputs` flag. |
| UI overflow due to too many stars/fields on the review screen | Low | Wrap the review screen body inside a `SingleChildScrollView`. |
