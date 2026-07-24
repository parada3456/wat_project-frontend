import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wat_project_frontend/di/inject.dart';
import 'package:wat_project_frontend/domain/models/mission_models.dart';
import 'package:wat_project_frontend/domain/ui_status/ui_status.dart';
import 'package:wat_project_frontend/presentation/missions_tasks/bloc/calendar_bloc/calendar_bloc.dart';
import 'package:wat_project_frontend/presentation/missions_tasks/bloc/mission_task_bloc.dart';
import 'package:wat_project_frontend/presentation/missions_tasks/screens/mission_calendar_page.dart';
import 'package:wat_project_frontend/presentation/missions_tasks/widgets/mission_calendar.dart';

class MockMissionTaskBloc extends MockBloc<MissionTaskEvent, MissionTaskState>
    implements MissionTaskBloc {}

void main() {
  late MockMissionTaskBloc mockMissionTaskBloc;

  setUpAll(() {
    registerFallbackValue(const MissionsTasksListRequested());
  });

  setUp(() {
    mockMissionTaskBloc = MockMissionTaskBloc();
    getIt.registerSingleton<MissionTaskBloc>(mockMissionTaskBloc);
  });

  tearDown(getIt.reset);

  group('CalendarBloc Unit Tests', () {
    test('initial state has focusedMonth set to initial date at day 1', () {
      final bloc = CalendarBloc(initialMonth: DateTime(2026, 6, 15));
      expect(bloc.state.focusedMonth, DateTime(2026, 6, 1));
      expect(bloc.state.selectedDate, isNull);
    });

    blocTest<CalendarBloc, CalendarState>(
      'PreviousMonthRequested shifts focusedMonth back by one month and clears selectedDate',
      build: () => CalendarBloc(initialMonth: DateTime(2026, 6, 1)),
      act: (bloc) => bloc.add(const PreviousMonthRequested()),
      expect: () => [
        CalendarState(focusedMonth: DateTime(2026, 5, 1), selectedDate: null),
      ],
    );

    blocTest<CalendarBloc, CalendarState>(
      'NextMonthRequested shifts focusedMonth forward by one month and clears selectedDate',
      build: () => CalendarBloc(initialMonth: DateTime(2026, 6, 1)),
      act: (bloc) => bloc.add(const NextMonthRequested()),
      expect: () => [
        CalendarState(focusedMonth: DateTime(2026, 7, 1), selectedDate: null),
      ],
    );

    blocTest<CalendarBloc, CalendarState>(
      'DateSelected updates selectedDate',
      build: () => CalendarBloc(initialMonth: DateTime(2026, 6, 1)),
      act: (bloc) => bloc.add(DateSelected(DateTime(2026, 6, 10))),
      expect: () => [
        CalendarState(
          focusedMonth: DateTime(2026, 6, 1),
          selectedDate: DateTime(2026, 6, 10),
        ),
      ],
    );
  });

  group('MissionCalendarPage Widget Tests', () {
    testWidgets(
      'renders CustomScrollView and SliverAppBar with MissionCalendar background',
      (WidgetTester tester) async {
        when(() => mockMissionTaskBloc.state).thenReturn(
          const MissionTaskState(status: UIStatus.initial(), missions: []),
        );

        await tester.pumpWidget(const MaterialApp(home: MissionCalendarPage()));

        // Verify page scaffold elements
        expect(find.byType(CustomScrollView), findsOneWidget);
        expect(find.byType(SliverAppBar), findsOneWidget);
        expect(find.byType(MissionCalendar), findsOneWidget);
        expect(find.text('Mission Calendar'), findsOneWidget);
        expect(find.text('Deadlines this month'), findsOneWidget);
      },
    );

    testWidgets('displays loaded mission deadlines correctly', (
      WidgetTester tester,
    ) async {
      final mockMission = MissionModel(
        missionId: 'm1',
        phaseId: 'p1',
        title: 'June Test Mission',
        tasks: const [],
        isActive: true,
        isLocked: false,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        userMission: UserMissionModel(
          userMissionId: 'um1',
          userId: 'u1',
          missionId: 'm1',
          calculatedDueDate: DateTime(2026, 6, 15),
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      );

      when(() => mockMissionTaskBloc.state).thenReturn(
        MissionTaskState(
          status: const UIStatus.loadSuccess(),
          missions: [mockMission],
        ),
      );

      await tester.pumpWidget(const MaterialApp(home: MissionCalendarPage()));

      await tester.pumpAndSettle();

      // The deadline card list should show the mission
      expect(find.text('June Test Mission'), findsOneWidget);
    });
  });
}
