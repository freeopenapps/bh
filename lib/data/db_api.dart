// import 'dart:ffi';

import '../models/Entry.dart' as EntryModel;
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as path;

import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite/sqflite.dart' as sqf;

import '../strings.dart';
import '../logging.dart';

final logger = getLogger('DB API');

class DatabaseFactoryManager {
  /// Wrapper to be able to inject method
  /// to facilitate testing.
  sqf.DatabaseFactory getFactory() {
    logger.d('DatabaseFactoryManager: getFactory() called');
    return databaseFactoryFfi;
  }
}

class DB {
  sqf.Database? _db;
  sqf.Database? get db {
    return _db;
  }

  static DB? _singleton;

  factory DB({
    @required location,
    @required dbFactoryManager,
  }) =>
      _singleton ??
      DB._internal(
        location: location,
        dbFactoryManager: dbFactoryManager,
      );

  DB._internal({
    @required location,
    @required dbFactoryManager,
  }) {
    logger.d('_internal() called');
    // Instance method
    this._createDB(location, dbFactoryManager);
    // Static variable
    _singleton = this;
    // ... this named constructor can
    // use static variables and instance
    // methods... interesting...
  }

  Future<void> _createDB(
    String location,
    DatabaseFactoryManager dbFactoryManager,
  ) async {
    try {
      logger.d('Creating DB at location: $location');

      sqf.DatabaseFactory factory = dbFactoryManager.getFactory();
      this._db = await factory.openDatabase(
        path.join(
          location,
          DbApiStrings.name,
        ),
      );
      String cmd = 'CREATE TABLE ' + DbApiStrings.table + DbApiStrings.columns;
      await this._db?.execute(cmd);

      logger.d('Created DB: $location/${DbApiStrings.name}');
      logger.d('With TABLE: ${DbApiStrings.table}');
      logger.d('With COLUMNS: ${DbApiStrings.columns}');
    } on Exception catch (e) {
      logger.e(e);
      throw Exception(e);
    }
  }

  Future<void> insert(EntryModel.Entry entry) async {
    try {
      if (this._db != null) {
        int? id = await this._db?.insert(
              DbApiStrings.table,
              entry.toMap(),
              conflictAlgorithm: sqf.ConflictAlgorithm.replace,
            );
        logger.d('Inserted: ${entry.id}');
        logger.d('Returned id: $id');
      } else {
        throw Exception('Invalid _db value: ${this._db}');
      }
    } on Exception catch (e) {
      logger.e(e);
    }
  }
}

// class DBAPI {
//   static const String DB_NAME = DbApiStrings.dbName;
//   static const String DB_TABLE = DbApiStrings.tableName;
//   static const String DB_TABLE_COLS = DbApiStrings.columns;

//   static Database _db;
//   static String _dbRoot;
//   static String _dbPath;

//   //============= Internal methods
//   static Future<void> _init() async {
//     DBAPI._dbRoot = await getDatabasesPath();
//     DBAPI._dbPath = join(_dbRoot, DBAPI.DB_NAME);
//     DBAPI._db = await openDatabase(
//       _dbPath,
//       version: 1,
//       onCreate: (dbase, version) {
//         return dbase.execute('CREATE TABLE ' +
//             DBAPI.DB_TABLE +
//             '(id TEXT PRIMARY KEY, ' +
//             DBAPI.DB_TABLE_COLS +
//             ')');
//       },
//     );
//     // print('Database path: ${DBAPI._dbPath}');
//   }

//   //============= DB API
//   static Future<void> insert(EntryModel.Entry entry) async {
//     await DBAPI._init();
//     await DBAPI._db.insert(
//       DBAPI.DB_TABLE,
//       entry.toMap(),
//       conflictAlgorithm: ConflictAlgorithm.replace,
//     );
//   }

//   static Future<void> update(EntryModel.Entry entry) async {
//     await DBAPI._init();
//     await DBAPI._db.update(
//       DBAPI.DB_TABLE,
//       entry.toMap(),
//       where: 'id = ?',
//       whereArgs: [entry.id],
//     );
//   }

//   static Future<List<EntryModel.Entry>> getAll() async {
//     await DBAPI._init();
//     List<Map<String, Object>> data = await DBAPI._db.query(DBAPI.DB_TABLE);
//     return data.map((entryMap) {
//       return EntryModel.entryFromMap(entryMap);
//     }).toList();
//   }

//   static Future<void> delete(EntryModel.Entry entry) async {
//     await DBAPI._init();
//     await DBAPI._db.delete(
//       DBAPI.DB_TABLE,
//       where: 'id = ?',
//       whereArgs: [entry.id],
//     );
//   }
// }
