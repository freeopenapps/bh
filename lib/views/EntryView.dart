import 'package:flutter/material.dart';

import '../widgets/AppBarTitle.dart';
import '../models/Entry.dart';
import '../widgets/AddEntry.dart';
import '../widgets/EditEntry.dart';
import '../widgets/EntryRows.dart';

class EntryView extends StatefulWidget {
  final String title;
  final String version;

  EntryView({this.title, this.version});
  @override
  _EntryViewState createState() => _EntryViewState();
}

class _EntryViewState extends State<EntryView> {
  void _editEntryModal(BuildContext ctx, Entry entry) {
    showModalBottomSheet(
      context: ctx,
      isScrollControlled: true,
      builder: (_) {
        return GestureDetector(
          child: EditEntry(entry),
          onTap: () {},
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  void _newEntryModal(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      isScrollControlled: true,
      builder: (_) {
        return GestureDetector(
          child: AddEntry(),
          onTap: () {},
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarTitle(
          title: widget.title,
          version: widget.version,
        ),
      ),
      body: Column(
        children: [
          EntryRows(_editEntryModal, context),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _newEntryModal(context),
      ),
    );
  }
}
