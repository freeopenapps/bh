import 'dart:ffi';

import '../models/Entry.dart' as EntryModel;
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';

import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite/sqflite.dart' as sqf;

import '../strings.dart';
import '../logging.dart';

final logger = getLogger('DB API');

class DB {
  String? location;
  final sqf.DatabaseFactory dbf = databaseFactoryFfi;
  sqf.Database? _db;

  static final DB _singleton = DB._init();
  factory DB({@required String? location}) {
    /// Only 1 instance ever created
    /// Prefereable to static as it is a proper
    /// instance that can share information,
    /// versus static vars/methods that
    /// do not share instance information
    _singleton.location = location;
    return _singleton;
  }

  DB._init() {
    this._createDB();
  }

  Future<void> _createDB() async {
    final String name = DbApiStrings.name;
    final String table = DbApiStrings.table;
    final String columns = DbApiStrings.columns;

    logger.d('Created DB: $location/$name');
    logger.d('With TABLE: $table');
    logger.d('With COLUMNS: $columns');

    try {
      this._db = await dbf.openDatabase(join(this.location!, name));
      await this._db?.execute('CREATE TABLE ' + table + columns);
      logger.d('DB Created successfully');
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
