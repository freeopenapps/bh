import 'dart:io';
import 'dart:collection';
import 'package:validators/validators.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';

import '../models/Entry.dart';
import '../data/db_api.dart';

class EntryListProvider extends ChangeNotifier {
  List<Entry> _entries = [];

  EntryListProvider() {
    _init();
  }

  UnmodifiableListView<Entry> get entries => UnmodifiableListView(_entries);

  //============= Internal methods
  Future<void> _init() async {
    _entries = await DBAPI.getAll();
    // Sort dates so latest at top of list
    _entries.sort((a, b) => b.date.compareTo(a.date));
    notifyListeners();
  }

  //============= API
  void setRange(DateTime start, DateTime end) async {
    await _init();
    _entries = _entries
        .where((e) =>
            (DateTime.parse(e.date).compareTo(start) >= 0) &&
            (DateTime.parse(e.date).compareTo(end) <= 0))
        .toList();
    notifyListeners();
  }

  void create(Entry entry) async {
    await DBAPI.insert(entry);
    await _init();
  }

  void update(Entry entry) async {
    await DBAPI.update(entry);
    await _init();
  }

  void delete(Entry entry) async {
    await DBAPI.delete(entry);
    await _init();
  }

  //============= Backup / Restore API
  Future<void> backUp() async {
    await _init();
    _entries.map((e) => Entry.toFile(e));
  }

  void restore() async {
    await _init();
    Directory path = Directory(await Entry.getFileDir());

    // Get files with uuid names
    List<FileSystemEntity> files = await path
        .list()
        .where((obj) => isUUID(basename(obj.path.split('.')[0])))
        .toList();

    // Create entries from the files
    files.map((e) async => DBAPI.insert(await Entry.fromFile(e.path)));
  }
}
