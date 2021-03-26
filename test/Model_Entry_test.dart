import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:file/file.dart';
import 'package:file/memory.dart';

// Mocks
import 'Model_Entry_test.mocks.dart';

// The Model under test
import 'package:bloodhound/models/Entry.dart' as EntryModel;

import '../lib/logging.dart';

final logger = getLogger('Entry Test');

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
  EntryModel.Entry,
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
      EntryModel.Entry entry = EntryModel.entryFromMap(eMap);
      expect(entry.toMap(), eMap);
    });
  });

  group('File', () {
    setUp(() {});
    tearDown(() {});

    test('getFileDir', () async {
      final pathManMock = MockPathManager();
      final perManMock = MockPermissionManager();

      when(pathManMock.downloadsPath()).thenAnswer((_) async => '/test/path');
      when(perManMock.storage()).thenAnswer((_) async => true);

      var dir = await EntryModel.getFileDir(
        perManMock,
        pathManMock,
        fileSystem: MemoryFileSystem(),
      );

      expect(dir, '/test/path/BloodHoundApp');
    });

    test('entryToFile', () async {
      FileSystem fs = MemoryFileSystem();
      Directory tempDir = fs.currentDirectory;

      final entry = MockEntry();
      final pathManMock = MockPathManager();
      final perManMock = MockPermissionManager();

      when(entry.toMap()).thenReturn(eMap);
      when(entry.id).thenReturn('333');

      String getFileDirStub(
        EntryModel.PermissionManager pMan,
        EntryModel.PathManager ptMan,
      ) {
        return tempDir.path;
      }

      String getFileNameStub(EntryModel.Entry e) {
        return 'file.json';
      }

      await EntryModel.entryToFile(
        entry,
        getFileDirStub,
        getFileNameStub,
        perManMock,
        pathManMock,
        fileSystem: fs,
      );

      bool a = await tempDir.list().isEmpty;
      expect(a, false);
      File f = await tempDir.list().first;
      expect(f.basename, 'file.json');
    });

    test('fromFile', () {});

    test('getFileName', () {});

    test('', () {});
  });
}
