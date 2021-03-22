import '../strings.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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

  void _createBackup(context) {
    Navigator.of(context).pop();
    _messageDialog(
      context,
      BackupModalStrings.backupCreatedDialogTitle,
      BackupModalStrings.backupCreatedDialogMsg,
    );
  }

  void _createFullBackup(context) {
    Navigator.of(context).pop();
    _messageDialog(
      context,
      BackupModalStrings.backupFullCreatedDialogTitle,
      BackupModalStrings.backupFullCreatedDialogMsg,
    );
  }

  void _loadBackup(context) {
    Navigator.of(context).pop();
    _messageDialog(
      context,
      BackupModalStrings.backupLoadedDialogTitle,
      BackupModalStrings.backupLoadedDialogMsg,
    );
  }

  @override
  Widget build(BuildContext context) {
    const double padding = 12.0;
    return SingleChildScrollView(
      child: Column(
        // padding: EdgeInsets.all(30),
        children: <Widget>[
          Card(
            child: Column(
              children: [
                Text(
                  BackupModalStrings.backupTitle,
                  style: Theme.of(context).textTheme.headline1,
                ),
                Text(
                  BackupModalStrings.dateRange,
                  style: Theme.of(context).textTheme.headline2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(padding),
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
                      padding: const EdgeInsets.all(padding),
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
                  BackupModalStrings.createBackup,
                  style: Theme.of(context).textTheme.headline2,
                ),
                Padding(
                  padding: const EdgeInsets.all(padding),
                  child: ElevatedButton(
                    child: Text(BackupModalStrings.createBtn),
                    style: Theme.of(context).elevatedButtonTheme.style,
                    onPressed: () => {_createBackup(context)},
                    autofocus: true,
                    clipBehavior: Clip.antiAlias,
                  ),
                ),
                Text(
                  BackupModalStrings.fullBackup,
                  style: Theme.of(context).textTheme.headline2,
                ),
                Padding(
                  padding: const EdgeInsets.all(padding),
                  child: ElevatedButton(
                    child: Text(BackupModalStrings.createAllBtn),
                    style: Theme.of(context).elevatedButtonTheme.style,
                    onPressed: () => {_createFullBackup(context)},
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
                  BackupModalStrings.restoreTitle,
                  style: Theme.of(context).textTheme.headline1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      BackupModalStrings.loadBackup,
                      style: Theme.of(context).textTheme.headline2,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(padding),
                  child: ElevatedButton(
                    child: Text(BackupModalStrings.loadBtn),
                    style: Theme.of(context).elevatedButtonTheme.style,
                    onPressed: () => {_loadBackup(context)},
                    autofocus: true,
                    clipBehavior: Clip.antiAlias,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
