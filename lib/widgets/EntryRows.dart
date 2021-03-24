import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../providers/entry_list.dart';
import 'EntryRowItem.dart';
import '../models/Entry.dart';

class EntryRows extends StatelessWidget {
  final Function _editEntryModal;
  final BuildContext parentContext;
  EntryRows(
    this._editEntryModal,
    this.parentContext,
  );

  Future<void> _deleteDialog(Entry entry) async {
    return showDialog<void>(
      context: parentContext,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Entry'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(DateFormat.yMd().format(DateTime.parse(entry.date))),
                Text(DateFormat.jm().format(DateTime.parse(entry.date))),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Delete'),
              onPressed: () {
                Provider.of<EntryListProvider>(
                  parentContext,
                  listen: false,
                ).delete(entry);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
      child: Consumer<EntryListProvider>(
        builder: (_, notifier, __) => ListView.builder(
          itemCount: notifier.entries.length,
          itemBuilder: (ctx, index) {
            return Container(
              padding: EdgeInsets.all(1),
              margin: EdgeInsets.all(1),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).primaryColorDark,
                  width: 1,
                ),
              ),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      _editEntryModal(
                        ctx,
                        notifier.entries[index],
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        EntryRowItem(
                          title: DateFormat.yMd().format(
                              DateTime.parse(notifier.entries[index].date)),
                          value: DateFormat.jm().format(
                              DateTime.parse(notifier.entries[index].date)),
                          units: '-' * 10,
                        ),
                        EntryRowItem(
                          title: 'Ketones',
                          value: notifier.entries[index].ketones,
                          units: 'mmol/L',
                        ),
                        EntryRowItem(
                          title: 'Glucose',
                          value: notifier.entries[index].glucose,
                          units: 'mg/L',
                        ),
                        EntryRowItem(
                          title: 'Weight',
                          value: notifier.entries[index].weight,
                          units: 'lb',
                        ),
                        EntryRowItem(
                          title: 'Pressure',
                          value: notifier.entries[index].pressure,
                          units: 'dia/sys/bpm',
                        ),
                        IconButton(
                          icon: const Icon(Icons.remove_circle_outline),
                          tooltip: 'Delete this Entry',
                          onPressed: () {
                            _deleteDialog(notifier.entries[index]);
                          },
                          color: Theme.of(context).buttonColor.withOpacity(0.7),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(5),
                    height: 70,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            notifier.entries[index].note,
                            maxLines: 4,
                            overflow: TextOverflow.clip,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).backgroundColor,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
