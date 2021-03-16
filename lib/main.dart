import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './views/EntryView.dart';
import './providers/entry_list.dart';

void main() {
  final String version = 'v0.1.0';
  final String title = 'Blood Hound ';

  runApp(
    ChangeNotifierProvider(
      create: (ctx) => EntryListProvider(),
      child: MaterialApp(
        title: title,
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
          buttonColor: Colors.red,
        ),
        home: EntryView(
          title: title,
          version: version,
        ),
      ),
    ),
  );
}
