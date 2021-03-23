import '../strings.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../providers/entry_list.dart';

class BackupModal extends StatefulWidget {
  @override
  _BackupModalState createState() => _BackupModalState();
}

class _BackupModalState extends State<BackupModal> {
  DateTime _startDate = DateTime.now().subtract(Duration(days: 30));
  DateTime _endDate = DateTime.now();

  void _showDatePicker(choice) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) return;
      if (choice == 'start') {
        setState(() {
          _startDate = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            0,
            0,
          );
        });
      }
      if (choice == 'end') {
        setState(() {
          _endDate = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            23,
            59,
          );
        });
      }
      setState(() {
        _endDate = pickedDate;
      });
    });
  }

  Future<void> _messageDialog(ctx, title, message) async {
    return showDialog<void>(
      context: ctx,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _selectiveBackup(context) async {
    Navigator.of(context).pop();
    await Provider.of<EntryListProvider>(
      context,
      listen: false,
    ).setRange(_startDate, _endDate);

    await Provider.of<EntryListProvider>(
      context,
      listen: false,
    ).backUp().then((res) {
      _messageDialog(
        context,
        BackupModalStrings.selBackupDialogTitle,
        BackupModalStrings.selBackupDialogMsg,
      );
    }).catchError((onError) {
      print('_selectiveBackup(): Error\n');
      print(onError);
    });
  }

  void _fullBackup(context) {
    Navigator.of(context).pop();
    Provider.of<EntryListProvider>(
      context,
      listen: false,
    ).backUp().then((res) {
      _messageDialog(
        context,
        BackupModalStrings.fullBackupDialogTitle,
        BackupModalStrings.fullBackupDialogMsg,
      );
    }).catchError((onError) {
      print('_fullBackup(): Error\n');
      print(onError);
    });
  }

  void _restore(context) async {
    await Provider.of<EntryListProvider>(
      context,
      listen: false,
    ).restore().then((res) {
      Navigator.of(context).pop();

      _messageDialog(
        context,
        BackupModalStrings.restoreDialogTitle,
        BackupModalStrings.restoreDialogMsg,
      );
    }).catchError((onError) {
      print('_restore(): Error\n');
      print(onError);
    });
  }

  @override
  Widget build(BuildContext context) {
    const double padding = 18.0;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(padding),
        child: Column(
          // padding: EdgeInsets.all(30),
          children: <Widget>[
            Card(
              child: Column(
                children: [
                  Text(
                    BackupModalStrings.selBackupTitle,
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  Text(
                    BackupModalStrings.selBackupRange,
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(2),
                        child: ElevatedButton(
                          child: Text(
                            DateFormat.yMd().format(_startDate),
                          ),
                          onPressed: () => {_showDatePicker('start')},
                          // autofocus: true,
                          clipBehavior: Clip.antiAlias,
                          style: Theme.of(context).elevatedButtonTheme.style,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(2),
                        child: ElevatedButton(
                          child: Text(
                            DateFormat.yMd().format(_endDate),
                          ),
                          onPressed: () => {_showDatePicker('end')},
                          // autofocus: true,
                          clipBehavior: Clip.antiAlias,
                          style: Theme.of(context).elevatedButtonTheme.style,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    BackupModalStrings.selBackupMsg,
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(padding),
                    child: ElevatedButton(
                      child: Text(BackupModalStrings.selBackupBtn),
                      style: Theme.of(context).elevatedButtonTheme.style,
                      onPressed: () => {_selectiveBackup(context)},
                      autofocus: true,
                      clipBehavior: Clip.antiAlias,
                    ),
                  ),
                ],
              ),
            ),
            Card(
              child: Column(
                children: <Widget>[
                  Text(
                    BackupModalStrings.fullBackupTitle,
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  Text(
                    BackupModalStrings.fullBackupMsg,
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        child: Text(BackupModalStrings.fullBackupBtn),
                        style: Theme.of(context).elevatedButtonTheme.style,
                        onPressed: () => {_fullBackup(context)},
                        autofocus: true,
                        clipBehavior: Clip.antiAlias,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Card(
              child: Column(
                children: <Widget>[
                  Text(
                    BackupModalStrings.restoreTitle,
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  Text(
                    BackupModalStrings.restoreMsg,
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        child: Text(BackupModalStrings.restoreBtn),
                        style: Theme.of(context).elevatedButtonTheme.style,
                        onPressed: () => {_restore(context)},
                        autofocus: true,
                        clipBehavior: Clip.antiAlias,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
