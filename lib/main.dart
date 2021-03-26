import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import './views/EntryView.dart';
import './providers/entry_list.dart';

void main() {
  Logger.level = Level.warning;
  runApp(AppRoot());
}

class AppRoot extends StatelessWidget {
  final String version = 'v1.0.1';
  final String title = 'Blood Hound ';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => EntryListProvider(),
      child: MaterialApp(
        title: title,
        home: EntryView(
          title: title,
          version: version,
        ),
      ),
    );
  }
}
