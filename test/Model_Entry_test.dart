import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

// Mock
import 'Model_Entry_test.mocks.dart';

// The Model under test
import 'package:bloodhound/models/Entry.dart' as EntryModel;

// Ref: https://flutter.dev/docs/cookbook/testing

// Template:
// group('', () {
//   setUp(() {});
//   tearDown(() {});
//   test('', () {});
// });

// 92cdc363-576d-401f-8418-d575a9b100a2
final uuidRe =
    RegExp(r"[a-z0-9]{8}-[a-z0-9]{4}-[a-z0-9]{4}-[a-z0-9]{4}-[a-z0-9]{12}");

@GenerateMocks([
  EntryModel.PathManager,
  EntryModel.PermissionManager,
])
void main() {
  Map<String, String> eMap;

  setUpAll(() {
    eMap = {
      'id': '333',
      'date': '',
      'ketones': '',
      'glucose': '',
      'weight': '',
      'pressure': '',
      'note': '',
      'picPath': '',
    };
  });
  group('Constructor', () {
    setUp(() {});
    tearDown(() {});
    test('Without ID', () {
      EntryModel.Entry entry = EntryModel.Entry(
        ketones: eMap['ketones'],
        glucose: eMap['glucose'],
        weight: eMap['weight'],
        pressure: eMap['pressure'],
        note: eMap['note'],
        date: eMap['date'],
        picPath: eMap['picPath'],
      );

      expect(entry.ketones, eMap['ketones']);
      expect(entry.glucose, eMap['glucose']);
      expect(entry.weight, eMap['weight']);
      expect(entry.pressure, eMap['pressure']);
      expect(entry.note, eMap['note']);
      expect(entry.date, eMap['date']);
      expect(entry.picPath, eMap['picPath']);
      assert(uuidRe.hasMatch(entry.id));
    });

    test('With ID', () {
      EntryModel.Entry entry = EntryModel.Entry(
        ketones: eMap['ketones'],
        glucose: eMap['glucose'],
        weight: eMap['weight'],
        pressure: eMap['pressure'],
        note: eMap['note'],
        date: eMap['date'],
        picPath: eMap['picPath'],
        id: eMap['id'],
      );

      expect(entry.ketones, eMap['ketones']);
      expect(entry.glucose, eMap['glucose']);
      expect(entry.weight, eMap['weight']);
      expect(entry.pressure, eMap['pressure']);
      expect(entry.note, eMap['note']);
      expect(entry.date, eMap['date']);
      expect(entry.picPath, eMap['picPath']);
      expect(entry.id, '333');
    });
  });

  group('Map', () {
    setUp(() {});
    tearDown(() {});

    test('toMap', () {
      EntryModel.Entry entry = EntryModel.Entry(
        ketones: eMap['ketones'],
        glucose: eMap['glucose'],
        weight: eMap['weight'],
        pressure: eMap['pressure'],
        note: eMap['note'],
        date: eMap['date'],
        picPath: eMap['picPath'],
        id: eMap['id'],
      );

      expect(entry.toMap(), eMap);
    });

    test('fromMap', () {
      EntryModel.Entry entry = EntryModel.Entry.fromMap(eMap);

      expect(entry.toMap(), eMap);
    });
  });

  group('File', () {
    setUp(() {});
    tearDown(() {});

    test('getFileDir', () async {
      final pathMan = MockPathManager();
      final perMan = MockPermissionManager();

      when(pathMan.downloadsPath()).thenAnswer((_) async => '/test/path');
      when(perMan.storage()).thenAnswer((_) async => true);

      var dir = await EntryModel.Entry.getFileDir(
        perMan,
        pathMan,
        fsLocal: false,
      );

      expect(dir, '/test/path/BloodHoundApp');
    });

    test('toFile', () {});

    test('fromFile', () {});

    test('getFileName', () {});

    test('', () {});
  });
}
