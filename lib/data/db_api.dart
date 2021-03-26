import '../models/Entry.dart' as EntryModel;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBAPI {
  static const String DB_NAME = 'bloodhound.db';
  static const String DB_TABLE = 'entries';
  static const String DB_TABLE_COLS =
      'date TEXT, ketones TEXT, glucose TEXT, weight TEXT, pressure TEXT, note TEXT, picPath TEXT';

  static Database _db;
  static String _dbRoot;
  static String _dbPath;

  //============= Internal methods
  static Future<void> _init() async {
    DBAPI._dbRoot = await getDatabasesPath();
    DBAPI._dbPath = join(_dbRoot, DBAPI.DB_NAME);
    DBAPI._db = await openDatabase(
      _dbPath,
      version: 1,
      onCreate: (dbase, version) {
        return dbase.execute('CREATE TABLE ' +
            DBAPI.DB_TABLE +
            '(id TEXT PRIMARY KEY, ' +
            DBAPI.DB_TABLE_COLS +
            ')');
      },
    );
    // print('Database path: ${DBAPI._dbPath}');
  }

  //============= DB API
  static Future<void> insert(EntryModel.Entry entry) async {
    await DBAPI._init();
    await DBAPI._db.insert(
      DBAPI.DB_TABLE,
      entry.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> update(EntryModel.Entry entry) async {
    await DBAPI._init();
    await DBAPI._db.update(
      DBAPI.DB_TABLE,
      entry.toMap(),
      where: 'id = ?',
      whereArgs: [entry.id],
    );
  }

  static Future<List<EntryModel.Entry>> getAll() async {
    await DBAPI._init();
    List<Map<String, Object>> data = await DBAPI._db.query(DBAPI.DB_TABLE);
    return data.map((entryMap) {
      return EntryModel.entryFromMap(entryMap);
    }).toList();
  }

  static Future<void> delete(EntryModel.Entry entry) async {
    await DBAPI._init();
    await DBAPI._db.delete(
      DBAPI.DB_TABLE,
      where: 'id = ?',
      whereArgs: [entry.id],
    );
  }
}
