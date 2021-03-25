import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../providers/entry_list.dart';
import 'EntryRowItem.dart';
import '../models/Entry.dart';
import '../theme.dart';

class EntryRows extends StatelessWidget {
  final Function _editEntryModal;
  EntryRows(
    this._editEntryModal,
  );

  @override
  Widget build(BuildContext context) {
    final theme = mobileTheme();
    final height = MediaQuery.of(context).size.height - 170;
    return Container(
      height: height,
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
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context)
                                .backgroundColor
                                .withOpacity(0.5),
                          ),
                          padding: EdgeInsets.all(4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                DateFormat.yMd().format(
                                  DateTime.parse(notifier.entries[index].date),
                                ),
                                style: theme.textTheme.headline2,
                              ),
                              Text(
                                DateFormat.jm().format(
                                  DateTime.parse(notifier.entries[index].date),
                                ),
                                style: theme.textTheme.headline2,
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
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
                          ],
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
                                  style: theme.textTheme.headline4,
                                ),
                              ),
                            ],
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(context)
                                .backgroundColor
                                .withOpacity(0.3),
                          ),
                        ),
                      ],
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
