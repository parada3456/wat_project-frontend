# Spec: Job Detail UI and Add Review UI Refactor

## Objective
We want to upgrade the J1 Job detail and review system to improve usability and offer richer rating feedback.
Specifically:
1. **Bookmark in App Bar**: Relocate the save to cart / bookmark functionality to the top right app bar actions.
2. **Apply now FAB**: Replace the bottom action buttons with a floating action button on the bottom right labelled "Apply now 🚀" linking to the job source URL.
3. **Inline Review Trigger**: Remove the floating Write Review button and place it as a fixed inline button above the reviews list.
4. **Ratings Breakdown**: Show overall rating and an "Employee Insights" card with progress bar breakdowns of individual categories (agency, job, coworkers, town, hours, housing, second job, overtime).
5. **Detailed Form**: Expand the review creation form to let J1 students rate all these dimensions individually, as well as leaving text reviews and tips.
6. **Polished Job Card**: Redesign the `JobCard` to use a clean horizontal layout with employer title, role, location, rating row, and teal salary badge (`+tips`) matching `Job Card 2.png`.

## Tech Stack
- Frontend: Flutter & Dart
- State Management: `flutter_bloc`

## Commands
- Run build runner: `flutter pub run build_runner build --delete-conflicting-outputs`
- Run all tests: `flutter test`
- Format code: `dart format lib/ test/`
- Analyze code: `flutter analyze`

## Project Structure
We will modify the following files:
```
lib/
  data/
    sources/
      api/
        api_model/
          job_review/
            create_review_request.dart # Modify: Add rating/score and tips fields
  presentation/
    job_market/
      screens/
        job_details_page.dart         # Modify: Refactor details buttons, add breakdown card
        write_review_page.dart        # Modify: Add dynamic star rows for new ratings and tips field
      widgets/
        job_reviews_section.dart      # Modify: Add inline review button callback
        job_card.dart                 # Modify: Redesign JobCard matching wireframe
```

## Code Style
Here is a snippet showing how `CreateReviewRequest` will be defined:
```dart
@JsonSerializable()
class CreateReviewRequest {
  @JsonKey(name: 'job_id')
  final String jobId;
  @JsonKey(name: 'rating_stars')
  final double ratingStars;
  @JsonKey(name: 'review_text')
  final String reviewText;
  @JsonKey(name: 'tips_for_next_generation')
  final String? tipsForNextGeneration;
  @JsonKey(name: 'score_agency')
  final double scoreAgency;
  @JsonKey(name: 'score_job')
  final double scoreJob;
  @JsonKey(name: 'score_coworkers')
  final double scoreCoworkers;
  @JsonKey(name: 'score_town')
  final double scoreTown;
  @JsonKey(name: 'score_hours')
  final double scoreHours;
  @JsonKey(name: 'score_housing')
  final double scoreHousing;
  @JsonKey(name: 'score_second_job_feasibility')
  final double scoreSecondJobFeasibility;
  @JsonKey(name: 'score_overtime_availability')
  final double scoreOvertimeAvailability;
  // ...
}
```

## Boundaries
- **Always**: Fallback gracefully to default ratings (e.g. `0.0` or empty progress) if a job does not have any ratings/reviews yet.
- **Never**: Hardcode specific UI margins or colors that bypass `AppColors` and `AppDimension`.

## Success Criteria
- [ ] `CreateReviewRequest` has all 12 properties and serializes correctly.
- [ ] Build runner successfully runs and compiles all files.
- [ ] `WriteReviewPage` has a ScrollView allowing users to input all 8 score sliders (interactive stars), review text, and tips text.
- [ ] "Save/Remove to Cart" acts as a Bookmark icon toggle on the top right app bar of `JobDetailsPage`.
- [ ] Bottom reserve button replaced by "Apply now 🚀" Floating Action Button.
- [ ] "Write Review" is a regular button positioned above the comments list in `JobDetailsPage`.
- [ ] An "Employee Insights" card displaying overall rate and breakdown progress bars is shown on `JobDetailsPage`.
