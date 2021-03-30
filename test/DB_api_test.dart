import 'dart:ffi';

import 'package:file/local.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:sqflite_common_ffi/sqflite_ffi.dart' as ffi;
import 'package:sqflite/sqflite.dart' as sqf;

import 'package:file/file.dart';
import 'package:file/memory.dart';

/// Resources:
/// https://github.com/tekartik/sqflite/issues/49

// The Model under test
import 'package:bloodhound/data/db_api.dart';

import 'package:bloodhound/models/Entry.dart';
import '../lib/strings.dart';
import '../lib/logging.dart';
import 'DB_api_test.mocks.dart';

final logger = getLogger('DB Test');

@GenerateMocks([
  DatabaseFactoryManager,
  sqf.DatabaseFactory,
  sqf.Database,
])
void main() {
  String tempDir = '/fake/path';
  Entry? entry;
  DatabaseFactoryManager mockDbFactoryManager = MockDatabaseFactoryManager();
  MockDatabaseFactory mockDBFactory = MockDatabaseFactory();
  MockDatabase mockDB = MockDatabase();

  setUpAll(() {
    logger.d('setUpAll() called');
    entry = Entry(
      id: '333',
      date: '',
      ketones: '',
      glucose: '',
      weight: '',
      pressure: '',
      note: '',
      picPath: '',
    );
  });

  tearDownAll(() {
    logger.d('tearDownAll() called');
  });

  group('createDB', () {
    setUp(() {
      logger.d('createDB: setUp() called');

      /// Setup mock return behavior
      when(mockDbFactoryManager.getFactory()).thenReturn(mockDBFactory);
      when(mockDBFactory.openDatabase(join(tempDir, DbApiStrings.name)))
          .thenAnswer((_) async => mockDB);
      String cmd = 'CREATE TABLE ' + DbApiStrings.table + DbApiStrings.columns;
      when(mockDB.execute(cmd)).thenAnswer((_) async => Future.value(null));
    });

    tearDown(() {
      logger.d('createDB: tearDown() called');
    });

    test('create new db and only ever return same instance of DB class',
        () async {
      logger.d('1st call to DB()');
      DB db1 = DB(location: tempDir, dbFactoryManager: mockDbFactoryManager);

      /// Wait for all async DB stuff to be done
      await Future.delayed(const Duration(seconds: 1), () {});

      logger.d('Verifying DB setup');
      verify(mockDbFactoryManager.getFactory());
      verify(mockDBFactory.openDatabase(join(tempDir, DbApiStrings.name)));
      verify(mockDB.execute(
          'CREATE TABLE ' + DbApiStrings.table + DbApiStrings.columns));

      logger.d('2nd call to DB()');
      DB db2 = DB(location: tempDir, dbFactoryManager: mockDbFactoryManager);

      /// Wait for all async DB stuff to be done
      await Future.delayed(const Duration(seconds: 1), () {});

      logger.d('Verifying DB() not setup again, returns same instance');
      assert(db1 == db2);
      assert(db2.db == mockDB);
      verifyNever(mockDbFactoryManager.getFactory());
      verifyNever(mockDBFactory.openDatabase(join(tempDir, DbApiStrings.name)));
      verifyNever(mockDB.execute(
          'CREATE TABLE ' + DbApiStrings.table + DbApiStrings.columns));
    });
  });

  // group('insert', () {
  //   setUp(() {});
  //   tearDown(() {});
  //   test('Insert object into db', () async {
  //     DB db = DB(location: tempDir?.path);
  //     db.insert(entry!);

  //     File dbf = fs.file(join(tempDir!.path, DbApiStrings.name));
  //     bool exists = await dbf.exists();
  //     expect(exists, true);
  //   });
  // });

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
