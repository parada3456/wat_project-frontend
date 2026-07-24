import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wat_project_frontend/di/inject.dart';
import 'package:wat_project_frontend/domain/models/job_models.dart';
import 'package:wat_project_frontend/domain/ui_status/ui_status.dart';
import 'package:wat_project_frontend/domain/services/auth_manager.dart';
import 'package:wat_project_frontend/presentation/job_market/bloc/job_market_bloc.dart';
import 'package:wat_project_frontend/presentation/job_market/widgets/job_card.dart';
import 'package:wat_project_frontend/presentation/job_market/screens/job_details_page.dart';
import 'package:wat_project_frontend/presentation/job_market/screens/write_review_page.dart';
import 'package:wat_project_frontend/data/entities/job_review/job/job_detail_response.dart';
import 'package:wat_project_frontend/data/entities/job_review/job/job_posting_entity.dart';
import 'package:wat_project_frontend/data/entities/job_review/job/job_overall_rating_entity.dart';

class MockJobMarketBloc extends MockBloc<JobMarketEvent, JobMarketState>
    implements JobMarketBloc {}

class MockAuthSessionManager extends Mock implements AuthSessionManager {}

void main() {
  late MockJobMarketBloc mockJobMarketBloc;
  late MockAuthSessionManager mockAuthSessionManager;

  setUpAll(() {
    registerFallbackValue(const JobMarketEvent.listCartItems());
  });

  setUp(() {
    mockJobMarketBloc = MockJobMarketBloc();
    mockAuthSessionManager = MockAuthSessionManager();

    getIt.registerSingleton<JobMarketBloc>(mockJobMarketBloc);
    getIt.registerSingleton<AuthSessionManager>(mockAuthSessionManager);

    when(() => mockAuthSessionManager.isAdmin).thenReturn(false);
  });

  tearDown(getIt.reset);

  final mockJob = JobPostingModel(
    jobId: 'job-123',
    employerTitle: 'Dunkins',
    position: 'Food Runner',
    locationCity: 'Yellowstone',
    locationState: 'WY',
    salaryRangeMin: 16.00,
    updatedAt: DateTime.now(),
  );

  group('JobCard Refactor Widget Tests', () {
    testWidgets(
      'renders horizontal layout with correct details and salary badge',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: JobCard(job: mockJob, rating: 4.8, reviewCount: 24),
            ),
          ),
        );

        // Verify Employer Title and emoji
        expect(find.text('Dunkins'), findsOneWidget);
        expect(find.text('🍔🥤'), findsOneWidget);

        // Verify Role/Position
        expect(find.text('Food Runner'), findsOneWidget);

        // Verify Location
        expect(find.text('Yellowstone, WY'), findsOneWidget);

        // Verify Rating and Reviews
        expect(find.text('4.8'), findsOneWidget);
        expect(find.text('24 reviews'), findsOneWidget);

        // Verify Salary badge with tips
        expect(find.text('\$16.00 +tips'), findsOneWidget);
      },
    );
  });

  group('JobDetailsPage Refactor Widget Tests', () {
    testWidgets(
      'renders Employee Insights card, bookmark AppBar icon, and Apply FAB',
      (WidgetTester tester) async {
        final mockRating = JobOverallRatingEntity(
          ratingSummaryId: 'r1',
          jobId: 'job-123',
          overallRate: 4.8,
          agencyRate: 4.9,
          jobRate: 4.2,
          coworkersRate: 4.7,
          townRate: 4.5,
          hoursRate: 4.3,
          housingRate: 4.1,
          secondJobFeasibilityRate: 4.0,
          overtimeAvailabilityRate: 4.6,
          reviewCount: 42,
          updatedAt: DateTime.now(),
        );

        final detailResponse = JobDetailResponse(
          job: JobPostingEntity(
            jobId: 'job-123',
            employerTitle: 'Dunkins',
            position: 'Food Runner',
            locationCity: 'Yellowstone',
            locationState: 'WY',
            salaryRangeMin: 16.00,
            salaryRangeMax: 18.00,
            usSponsor: true,
            availableSlots: 5,
            sourceUrl: 'https://example.com/apply',
            updatedAt: DateTime.now(),
          ),
          housing: null,
          rating: mockRating,
        );

        when(() => mockJobMarketBloc.state).thenReturn(
          JobMarketState(
            status: const UIStatus.loadSuccess(),
            jobDetail: detailResponse,
            reviews: const [],
            cartItems: const [],
          ),
        );

        await tester.pumpWidget(
          const MaterialApp(home: JobDetailsPage(jobId: 'job-123')),
        );

        await tester.pumpAndSettle();

        // Verify Employee Insights Card title and overall score
        expect(find.text('Employee Insights'), findsOneWidget);
        expect(find.text('Based on 42 verified reviews'), findsOneWidget);
        expect(find.text('4.8'), findsNWidgets(2));

        // Verify score breakdown headings
        expect(find.text('Agency / Sponsor'), findsOneWidget);
        expect(find.text('Job Position Tasks'), findsOneWidget);
        expect(find.text('Coworkers'), findsOneWidget);

        // Verify Bookmark action icon is present
        expect(find.byIcon(Icons.bookmark_border), findsOneWidget);

        // Verify Apply now FAB is present
        expect(find.text('Apply now 🚀'), findsOneWidget);

        // Verify fixed write review button is inline
        expect(find.text('Write a Review'), findsOneWidget);
      },
    );
  });

  group('WriteReviewPage Refactor Widget Tests', () {
    testWidgets(
      'renders detailed rating rows and tips field, and submits review',
      (WidgetTester tester) async {
        // Increase screen size for form fields so submit button is visible on-screen
        tester.view.physicalSize = const Size(800, 1200);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);

        when(() => mockJobMarketBloc.state).thenReturn(
          const JobMarketState(createReviewStatus: UIStatus.initial()),
        );

        await tester.pumpWidget(
          const MaterialApp(home: WriteReviewPage(jobId: 'job-123')),
        );

        // Verify screen title
        expect(find.text('Write a Review'), findsOneWidget);

        // Verify detailed rating rows headings
        expect(find.text('Detailed Ratings'), findsOneWidget);
        expect(find.text('Agency / Sponsor'), findsOneWidget);
        expect(find.text('Job Position Tasks'), findsOneWidget);
        expect(find.text('Coworkers'), findsOneWidget);
        expect(find.text('Town / Location'), findsOneWidget);
        expect(find.text('Hours Provided'), findsOneWidget);
        expect(find.text('Housing Conditions'), findsOneWidget);
        expect(find.text('Second Job Feasibility'), findsOneWidget);
        expect(find.text('Overtime Availability'), findsOneWidget);

        // Verify tips text field
        expect(find.text('Tips for Next Generation'), findsOneWidget);

        // Enter review text
        final textFields = find.byType(TextField);
        expect(textFields, findsNWidgets(2)); // Review content + Tips content

        await tester.enterText(textFields.first, 'Excellent experience!');
        await tester.enterText(textFields.last, 'Pack warm clothes.');

        // Tap submit button
        await tester.tap(find.text('Submit Review'));
        await tester.pump();

        // Verify CreateJobReview event is dispatched with exact ratings
        verify(
          () => mockJobMarketBloc.add(any(that: isA<CreateJobReviewEvent>())),
        ).called(1);
      },
    );
  });
}
