import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wat_project_frontend/core/widgets/app_popup.dart';

void main() {
  Widget buildTestableWidget(Widget child) {
    return MaterialApp(
      home: Scaffold(
        body: Builder(
          builder: (context) {
            return Center(
              child: ElevatedButton(
                onPressed: () {
                  if (child is AppPopup) {
                    showDialog<void>(
                      context: context,
                      builder: (context) => child,
                    );
                  }
                },
                child: const Text('Show Dialog'),
              ),
            );
          },
        ),
      ),
    );
  }

  group('AppPopup Widget Tests', () {
    testWidgets('renders title and message correctly', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        buildTestableWidget(
          AppPopup(
            title: 'Test Title',
            message: 'Test Message Detail',
            buttons: [
              AppPopupButton(
                label: 'Confirm',
                onPressed: () {},
                isPrimary: true,
              ),
            ],
          ),
        ),
      );

      // Open the dialog
      await tester.tap(find.text('Show Dialog'));
      await tester.pumpAndSettle();

      expect(find.text('Test Title'), findsOneWidget);
      expect(find.text('Test Message Detail'), findsOneWidget);
      expect(find.text('Confirm'), findsOneWidget);
    });

    testWidgets('executes button callback on tap', (WidgetTester tester) async {
      bool callbackExecuted = false;

      await tester.pumpWidget(
        buildTestableWidget(
          AppPopup(
            title: 'Callback Test',
            message: 'Verify callback triggers',
            buttons: [
              AppPopupButton(
                label: 'Click Me',
                onPressed: () {
                  callbackExecuted = true;
                },
                isPrimary: true,
              ),
            ],
          ),
        ),
      );

      // Open the dialog
      await tester.tap(find.text('Show Dialog'));
      await tester.pumpAndSettle();

      // Tap button and verify
      await tester.tap(find.text('Click Me'));
      await tester.pumpAndSettle();

      expect(callbackExecuted, isTrue);
    });

    testWidgets('renders 2 buttons in horizontal Row layout', (
      WidgetTester tester,
    ) async {
      int cancelTapped = 0;
      int confirmTapped = 0;

      await tester.pumpWidget(
        buildTestableWidget(
          AppPopup(
            title: 'Two Buttons',
            message: 'Row layout verify',
            buttons: [
              AppPopupButton(label: 'Cancel', onPressed: () => cancelTapped++),
              AppPopupButton(
                label: 'Confirm',
                onPressed: () => confirmTapped++,
                isPrimary: true,
              ),
            ],
          ),
        ),
      );

      // Open dialog
      await tester.tap(find.text('Show Dialog'));
      await tester.pumpAndSettle();

      expect(find.text('Cancel'), findsOneWidget);
      expect(find.text('Confirm'), findsOneWidget);

      // Verify the button layout type: they are children of Row
      final rowFinder = find.byType(Row);
      expect(rowFinder, findsOneWidget);

      // Tap buttons
      await tester.tap(find.text('Cancel'));
      await tester.tap(find.text('Confirm'));

      expect(cancelTapped, 1);
      expect(confirmTapped, 1);
    });

    testWidgets('renders 3 buttons in vertical Column layout', (
      WidgetTester tester,
    ) async {
      int action1Tapped = 0;
      int action2Tapped = 0;
      int action3Tapped = 0;

      await tester.pumpWidget(
        buildTestableWidget(
          AppPopup(
            title: 'Three Buttons',
            message: 'Column layout verify',
            buttons: [
              AppPopupButton(
                label: 'First',
                onPressed: () => action1Tapped++,
                isPrimary: true,
              ),
              AppPopupButton(label: 'Second', onPressed: () => action2Tapped++),
              AppPopupButton(label: 'Third', onPressed: () => action3Tapped++),
            ],
          ),
        ),
      );

      // Open dialog
      await tester.tap(find.text('Show Dialog'));
      await tester.pumpAndSettle();

      expect(find.text('First'), findsOneWidget);
      expect(find.text('Second'), findsOneWidget);
      expect(find.text('Third'), findsOneWidget);

      // When 3 buttons are used, they should render as a Column block layout inside the buttons container
      // Note: There will be multiple Columns (e.g. dialog base, buildButtons column),
      // we check that the number of Columns is at least two (main dialog Column + button Column)
      expect(find.byType(Column), findsAtLeastNWidgets(2));

      // Tap buttons
      await tester.tap(find.text('First'));
      await tester.tap(find.text('Second'));
      await tester.tap(find.text('Third'));

      expect(action1Tapped, 1);
      expect(action2Tapped, 1);
      expect(action3Tapped, 1);
    });

    testWidgets('renders icon when type is not none', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        buildTestableWidget(
          AppPopup(
            title: 'Success Type',
            message: 'Icon rendering verify',
            type: AppPopupType.success,
            buttons: [AppPopupButton(label: 'Dismiss', onPressed: () {})],
          ),
        ),
      );

      // Open dialog
      await tester.tap(find.text('Show Dialog'));
      await tester.pumpAndSettle();

      // Check success icon is displayed
      expect(find.byIcon(Icons.check_circle_outline_rounded), findsOneWidget);
    });
  });
}
