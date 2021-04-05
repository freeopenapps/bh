// import 'dart:ffi';

// import 'package:file/local.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

// import 'package:sqflite_common_ffi/sqflite_ffi.dart' as ffi;
import 'package:sqflite/sqflite.dart' as sqf;

// import 'package:file/file.dart';
// import 'package:file/memory.dart';

/// Resources:
/// https://github.com/tekartik/sqflite/issues/49

// The Model under test
import 'package:bloodhound/data/db_api.dart';

// import 'package:bloodhound/models/Entry.dart';
import '../lib/strings.dart';
import '../lib/logging.dart';
import 'DB_api_test.mocks.dart';

final logger = getLogger('DB Test');

/// Reminder: When generating mocks, don't forget to add:
///
// @override
// Future<void> execute(String cmd, [dynamic arguments]) async {
//   return super.noSuchMethod(Invocation.method(#execute, [cmd, arguments]))
//       as dynamic;
// }
//
// @override
// Future<int> insert(
//   String cmd,
//   Map<String, Object?> m, {
//   _i2.ConflictAlgorithm? conflictAlgorithm,
//   String? nullColumnHack,
// }) async {
//   return super.noSuchMethod(
//     Invocation.method(
//       #insert,
//       [
//         cmd,
//         m,
//         conflictAlgorithm,
//         nullColumnHack,
//       ],
//     ),
//   ) as dynamic;
// }
///
/// to MockDatabase() to fix null safety errors:
/// type 'Null' is not a subtype of type 'Future<void>' (execute)
/// type 'Null' is not a subtype of type 'Future<int>'  (insert)
///
@GenerateMocks([
  DatabaseFactoryManager,
  sqf.DatabaseFactory,
  sqf.Database,
])
void main() {
  DatabaseFactoryManager mockDbFactoryManager = MockDatabaseFactoryManager();
  MockDatabaseFactory mockDBFactory = MockDatabaseFactory();
  MockDatabase mockDB = MockDatabase();

  String tempDir = '/fake/path';
  // Entry entry = Entry(
  //   id: '333',
  //   date: '',
  //   ketones: '',
  //   glucose: '',
  //   weight: '',
  //   pressure: '',
  //   note: '',
  //   picPath: '',
  // );

  setUpAll(() {
    logger.d('setUpAll() called');

    /// Mock DB setup stubbing for all tests
    when(mockDbFactoryManager.getFactory()).thenReturn(mockDBFactory);
    when(mockDBFactory.openDatabase(
      join(
        tempDir,
        DbApiStrings.name,
      ),
    )).thenAnswer((_) async => mockDB);
    String cmd = 'CREATE TABLE ' + DbApiStrings.table + DbApiStrings.columns;
    when(mockDB.execute(cmd)).thenAnswer((_) async => Future.value(null));
  });

  tearDownAll(() {
    logger.d('tearDownAll() called');
  });

  group('createDB', () {
    test('create new db and only ever return same instance of DB class',
        () async {
      logger.d('1st call to DB()');
      DB db1 = DB(
        location: tempDir,
        dbFactoryManager: mockDbFactoryManager,
      );

      /// Wait for all async DB setup to be done
      await Future.delayed(const Duration(seconds: 1), () {});

      logger.d('Verifying DB setup');
      assert(db1.db == mockDB);
      verify(mockDbFactoryManager.getFactory());
      verify(mockDBFactory.openDatabase(
        join(
          tempDir,
          DbApiStrings.name,
        ),
      ));
      verify(mockDB.execute(
          'CREATE TABLE ' + DbApiStrings.table + DbApiStrings.columns));

      logger.d('2nd call to DB()');
      DB db2 = DB(
        location: tempDir,
        dbFactoryManager: mockDbFactoryManager,
      );

      /// Wait for all async DB setup to be done
      await Future.delayed(const Duration(seconds: 1), () {});

      logger.d('Verifying DB() not setup again, returns same instance');
      assert(db1 == db2);
      assert(db2.db == mockDB);
      verifyNever(mockDbFactoryManager.getFactory());
      verifyNever(mockDBFactory.openDatabase(join(
        tempDir,
        DbApiStrings.name,
      )));
      verifyNever(mockDB.execute(
          'CREATE TABLE ' + DbApiStrings.table + DbApiStrings.columns));
    });
  });

  ///
  /// Further testing of DB interactions not possible due to lack of
  /// understanding of how to update mockito generated mocks to satisfy null
  /// safety.
  ///
  /// ERROR: type 'Null' is not a subtype of type 'FutureOr<int>'
  ///

  // group('insert entry into db', () {
  //   setUp(() {
  //     entry.id = '333';
  //     entry.date = 'a';
  //     entry.note = 'b';
  //     entry.glucose = '1';
  //     entry.ketones = '2';
  //     entry.weight = '3';
  //     entry.pressure = '4';
  //     entry.picPath = '5';
  //   });

  //   test('Insert object into db', () async {
  //     /// Mock setup
  //     when(
  //       mockDB.insert(
  //         DbApiStrings.table,
  //         entry.toMap(),
  //         conflictAlgorithm: sqf.ConflictAlgorithm.replace,
  //       ),
  //     ).thenAnswer((_) => Future.value(1));

  //     logger.d('1st call to DB()');
  //     DB db = DB(
  //       location: tempDir,
  //       dbFactoryManager: mockDbFactoryManager,
  //     );

  //     /// Wait for all async DB setup to be done
  //     await Future.delayed(const Duration(seconds: 1), () {});

  //     db.insert(entry);

  //     logger.d('Verifying DB setup');
  //     assert(db.db == mockDB);
  //     verify(mockDbFactoryManager.getFactory());
  //     verify(mockDBFactory.openDatabase(join(tempDir, DbApiStrings.name)));
  //     verify(mockDB.execute(
  //         'CREATE TABLE ' + DbApiStrings.table + DbApiStrings.columns));

  //     logger.d('Verifying insert called as expected');
  //     verify(mockDB.insert(DbApiStrings.table, entry.toMap()));
  //   });
  // });

  // group('update', () {
  //   setUp(() {});
  //   tearDown(() {});
  //   test('', () {});
  // });

  // group('getAll', () {
  //   setUp(() {});
  //   tearDown(() {});
  //   test('', () {});
  // });

  // group('delete', () {
  //   setUp(() {});
  //   tearDown(() {});
  //   test('', () {});
  // });
}
