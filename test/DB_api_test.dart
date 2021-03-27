import 'package:file/local.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:file/file.dart';
import 'package:file/memory.dart';

// The Model under test
import 'package:bloodhound/data/db_api.dart';
import '../lib/strings.dart';
import '../lib/logging.dart';

final logger = getLogger('Entry Test');

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  /// Wanted to use MemoryFileSystem but go this error:
  /// bad parameter or other API misuse (code 21)
  FileSystem fs = LocalFileSystem();
  Directory? tempDir;

  setUpAll(() {
    tempDir = fs.directory(fs.systemTempDirectory.path + '/bh_temp');
    logger.i('Created directory: ${tempDir?.path}');
  });

  tearDownAll(() {
    tempDir?.delete(recursive: true);
    logger.i('Deleted directory: ${tempDir?.path}');
  });

  group('createDB', () {
    setUp(() {});
    tearDown(() {});

    test('create a new db when instantiated', () async {
      DB(location: tempDir?.path);

      File dbf = fs.file(join(tempDir!.path, DbApiStrings.name));
      bool exists = await dbf.exists();
      expect(exists, true);
    });

    test(
        'given the db has been made, when createDB is called, then return the existing db',
        () {});
  });

  group('insert', () {
    setUp(() {});
    tearDown(() {});
    test('', () {});
  });

  group('update', () {
    setUp(() {});
    tearDown(() {});
    test('', () {});
  });

  group('getAll', () {
    setUp(() {});
    tearDown(() {});
    test('', () {});
  });

  group('delete', () {
    setUp(() {});
    tearDown(() {});
    test('', () {});
  });
}
