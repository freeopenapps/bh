import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../providers/entry_list.dart';
import 'EntryRowItem.dart';
import '../theme.dart';
import '../constants.dart';
import '../strings.dart';

class EntryRows extends StatelessWidget {
  final Function _editEntryModal;
  EntryRows(
    this._editEntryModal,
  );

  @override
  Widget build(BuildContext context) {
    final theme = mobileTheme();
    final height =
        MediaQuery.of(context).size.height - EntryRowsConsts.displayHeightTrim;
    return Container(
      height: height,
      child: Consumer<EntryListProvider>(
        builder: (_, notifier, __) => ListView.builder(
          itemCount: notifier.entries.length,
          itemBuilder: (ctx, index) {
            return Container(
              padding: EdgeInsets.all(EntryRowsConsts.padding),
              margin: EdgeInsets.all(EntryRowsConsts.margin),
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
                                .withOpacity(EntryRowsConsts.dateBGOpacity),
                          ),
                          padding: EdgeInsets.all(EntryRowsConsts.datePadding),
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
                              title: EntryRowsStrings.ketonesTitle,
                              value: notifier.entries[index].ketones,
                              units: EntryRowsStrings.ketonesUnits,
                            ),
                            EntryRowItem(
                              title: EntryRowsStrings.glucoseTitle,
                              value: notifier.entries[index].glucose,
                              units: EntryRowsStrings.glucoseUnits,
                            ),
                            EntryRowItem(
                              title: EntryRowsStrings.weightTitle,
                              value: notifier.entries[index].weight,
                              units: EntryRowsStrings.weightUnits,
                            ),
                            EntryRowItem(
                              title: EntryRowsStrings.pressureTitle,
                              value: notifier.entries[index].pressure,
                              units: EntryRowsStrings.pressureUnits,
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.all(EntryRowsConsts.notePadding),
                          height: EntryRowsConsts.noteHeight,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  notifier.entries[index].note,
                                  maxLines: EntryRowsConsts.noteMaxLines,
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
                                .withOpacity(EntryRowsConsts.noteBGOpacity),
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
