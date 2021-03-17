import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:bloodhound/widgets/EntryRowItem.dart';

void main() {
  testWidgets('EntryRowItem displays text as expected',
      (WidgetTester tester) async {
    String title = 'Title';
    String value = 'Value';
    String units = 'Units';

    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        home: Row(
          children: [
            EntryRowItem(
              title: title,
              value: value,
              units: units,
            ),
          ],
        ),
      ),
    );

    // Verify that attributes are displayed.
    expect(find.text(title), findsOneWidget);
    expect(find.text(value), findsOneWidget);
    expect(find.text(units), findsOneWidget);
  });
}
