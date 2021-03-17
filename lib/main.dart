import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './views/EntryView.dart';
import './providers/entry_list.dart';

void main() {
  runApp(AppRoot());
}

class AppRoot extends StatelessWidget {
  final String version = 'v1.0.0';
  final String title = 'Blood Hound ';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
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
    );
  }
}
