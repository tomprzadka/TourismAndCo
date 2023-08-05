import 'package:test/test.dart';
import 'package:tourism_and_co/mocks/mock_location.dart';

void main() {
  test('test fetchAny', () async {
    final mockLocation = MockLocation.fetchAll().first;
    expect(mockLocation, isNotNull);
    expect(mockLocation.name, isNotEmpty);
  });

  test('test fetchAll', () {
    final mockLocations = MockLocation.fetchAll();
    expect(mockLocations.length, greaterThan(0));
    expect(mockLocations[0].name, isNotEmpty);
  });

  test('test fetch', () {
    final mockLocation = MockLocation.fetch(0);
    expect(mockLocation, isNotNull);
    expect(mockLocation.name, isNotEmpty);
  });
}
