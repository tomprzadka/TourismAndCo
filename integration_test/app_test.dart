import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:tourism_and_co/app.dart';
import 'package:tourism_and_co/mocks/mock_location.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets("test app startup", (WidgetTester tester) async {
    runApp(const App());

    // wait until we are completely done loading our screen
    await tester.pumpAndSettle();

    final mockLocation = MockLocation.fetchAny();

    // NOTE: 'skipOffstage' below is used just in case any of the items we are findings
    // are off screen, since the first screen is a ListView
    // WARNING: `find.text()` is case sensitive, so since we are rendering upper
    // case items in our list view, we must find it via `toUpperCase()` here.
    // An alternative would be to find a widget by its 'key' but since this is a
    // simple app, there isn't as much of a need.
    expect(find.text(mockLocation.name, skipOffstage: false),
        findsOneWidget);
    // expect(find.text(mockLocation.name, skipOffstage: false),
    //     findsNothing);
  });

  testWidgets("test should fail", (WidgetTester tester) async {
    runApp(const App());

    // wait until we are completely done loading our screen
    await tester.pumpAndSettle();

    final mockLocation = MockLocation.fetchAny();

    // NOTE: 'skipOffstage' below is used just in case any of the items we are findings
    // are off screen, since the first screen is a ListView
    // WARNING: `find.text()` is case sensitive, so since we are rendering upper
    // case items in our list view, we must find it via `toUpperCase()` here.
    // An alternative would be to find a widget by its 'key' but since this is a
    // simple app, there isn't as much of a need.
    expect(
        find.text(mockLocation.name.toUpperCase(),
            skipOffstage: false),
        findsOneWidget);
    expect(find.text(mockLocation.name, skipOffstage: false),
        findsNothing);
  });
}
