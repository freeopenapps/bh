import 'package:flutter/material.dart';

import '../constants.dart';
import '../theme.dart';
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
    final screenWidth = MediaQuery.of(context).size.width;
    /**
     * Note: Nested MaterialApp here to be able to use 
     * MediaQuery for theme selection
     */
    return MaterialApp(
      theme: screenWidth > ScreenWidth.small ? mediumTheme : smallTheme,
      home: Scaffold(
        appBar: AppBar(
          toolbarHeight: screenWidth >= ScreenWidth.small ? 100 : 60,
          title: AppBarTitle(
            screenWidth: screenWidth,
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
      ),
    );
  }
}
