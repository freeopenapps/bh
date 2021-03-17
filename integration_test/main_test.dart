import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets("failing test example", (WidgetTester tester) async {
    expect(2 + 2, equals(5));
  });

  testWidgets("passing test example 1", (WidgetTester tester) async {
    expect(2 + 2, equals(4));
  });

  testWidgets("passing test example 2", (WidgetTester tester) async {
    expect(2 + 2, equals(4));
  });

  testWidgets("passing test example 3", (WidgetTester tester) async {
    expect(2 + 2, equals(4));
  });
}
