import 'dart:collection';
import 'package:flutter/foundation.dart';

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
    _init();
    notifyListeners();
  }

  void update(Entry entry) async {
    await DBAPI.update(entry);
    _init();
    notifyListeners();
  }

  void delete(Entry entry) async {
    await DBAPI.delete(entry);
    _init();
    notifyListeners();
  }
}
