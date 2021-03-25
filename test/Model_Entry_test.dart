import 'package:flutter_test/flutter_test.dart';
import 'package:bloodhound/models/Entry.dart';

// Ref: https://flutter.dev/docs/cookbook/testing

// Template:
// group('', () {
//   setUp(() {});
//   tearDown(() {});
//   test('', () {});
// });

void main() {
  group('Constructor', () {
    Map e;
    setUp(() {
      Map<String, String> e = {
        'id': '',
        'date': '',
        'ketones': '',
        'glucose': '',
        'weight': '',
        'pressure': '',
        'note': '',
        'picPath': '',
      };
    });

    tearDown(() {});
    test('Without ID', () {
      Entry entry = Entry(
        ketones: e['ketones'],
        glucose: e['glucose'],
        weight: e['weight'],
        pressure: e['pressure'],
        note: e['note'],
        date: e['date'],
        picPath: '',
      );

      expect(entry.ketones, e['ketones']);
      expect(entry.glucose, e['glucose']);
      expect(entry.weight, e['weight']);
      expect(entry.pressure, e['pressure']);
      expect(entry.note, e['note']);
      expect(entry.date, e['date']);
      expect(entry.picPath, e['picPath']);
    });

    test('With ID', () {});
  });

  group('Map', () {
    setUp(() {});
    tearDown(() {});
    test('toMap', () {});

    test('fromMap', () {});
  });

  group('File', () {
    setUp(() {});
    tearDown(() {});
    test('getFileDir', () {});

    test('toFile', () {});

    test('fromFile', () {});

    test('getFileName', () {});

    test('', () {});
  });
}
