import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../providers/entry_list.dart';

import '../models/Entry.dart';
import '../theme.dart';
import '../strings.dart';
import '../constants.dart';

class EditEntry extends StatefulWidget {
  final Entry entry;
  EditEntry(this.entry);

  @override
  _EditEntryState createState() => _EditEntryState();
}

class _EditEntryState extends State<EditEntry> {
  final _ketonesC = TextEditingController();
  final _glucoseC = TextEditingController();
  final _weightC = TextEditingController();
  final _pressureC = TextEditingController();
  final _noteC = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  @override
  void initState() {
    super.initState();
    _ketonesC.text = widget.entry.ketones;
    _glucoseC.text = widget.entry.glucose;
    _weightC.text = widget.entry.weight;
    _pressureC.text = widget.entry.pressure;
    _noteC.text = widget.entry.note;
    _selectedDate = DateTime.parse(widget.entry.date);
    _selectedTime = TimeOfDay.fromDateTime(_selectedDate);
  }

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(EditEntryConsts.datePickerStartYear),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) return;
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  void _showTimePicker() {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((pickedTime) {
      if (pickedTime == null) return;
      setState(() {
        _selectedTime = pickedTime;
      });
    });
  }

  void _updateEntry() {
    final ketones = _ketonesC.text;
    final glucose = _glucoseC.text;
    final weight = _weightC.text;
    final pressure = _pressureC.text;
    final note = _noteC.text;
    final date = DateTime(
      _selectedDate.year,
      _selectedDate.month,
      _selectedDate.day,
      _selectedTime.hour,
      _selectedTime.minute,
    ).toString();

    // Do some validation here

    Entry e = Entry(
      ketones: ketones,
      glucose: glucose,
      weight: weight,
      pressure: pressure,
      note: note,
      date: date,
      picPath: '',
    );

    // Preserve id
    e.id = widget.entry.id;

    Provider.of<EntryListProvider>(
      context,
      listen: false,
    ).update(e);

    // Close the modal
    Navigator.of(context).pop();
  }

  Future<void> _deleteDialog(BuildContext ctx) async {
    return showDialog<void>(
      context: ctx,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(EditEntryStrings.deleteDialogTitle),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  DateFormat.yMd().format(
                    DateTime.parse(widget.entry.date),
                  ),
                ),
                Text(
                  DateFormat.jm().format(
                    DateTime.parse(widget.entry.date),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(EditEntryStrings.deleteDialogCancelBtn),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(EditEntryStrings.deleteDialogDeleteBtn),
              onPressed: () {
                Provider.of<EntryListProvider>(
                  ctx,
                  listen: false,
                ).delete(widget.entry);
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
    final theme = mobileTheme();
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(EditEntryConsts.scrollViewPadding),
        child: Column(
          children: [
            Text(
              EditEntryStrings.entryTitle,
              style: theme.textTheme.headline1,
            ),
            TextField(
              decoration: const InputDecoration(
                  labelText: EditEntryStrings.entryKetonesFld),
              controller: _ketonesC,
              keyboardType: TextInputType.number,
            ),
            TextField(
              decoration: const InputDecoration(
                  labelText: EditEntryStrings.entryGlucoseFld),
              controller: _glucoseC,
              keyboardType: TextInputType.number,
            ),
            TextField(
              decoration: const InputDecoration(
                  labelText: EditEntryStrings.entryWeightFld),
              controller: _weightC,
              keyboardType: TextInputType.number,
            ),
            TextField(
              decoration: const InputDecoration(
                  labelText: EditEntryStrings.entryPressureFld),
              controller: _pressureC,
              keyboardType: TextInputType.datetime,
            ),
            TextField(
              decoration: const InputDecoration(
                  labelText: EditEntryStrings.entryNoteFld),
              controller: _noteC,
              keyboardType: TextInputType.multiline,
              maxLines: EditEntryConsts.noteMaxLines,
              minLines: EditEntryConsts.noteMinLines,
            ),
            Container(
              padding: EdgeInsets.all(EditEntryConsts.dateTimeBtnPadding),
              margin: EdgeInsets.all(EditEntryConsts.dateTimeBtnMargin),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                    child: Text(
                      DateFormat.yMd().format(_selectedDate),
                      style: theme.textTheme.button,
                    ),
                    onPressed: _showDatePicker,
                    autofocus: true,
                    clipBehavior: Clip.antiAlias,
                    style: theme.elevatedButtonTheme.style,
                  ),
                  ElevatedButton(
                    child: Text(
                      _selectedTime.format(context),
                      style: theme.textTheme.button,
                    ),
                    onPressed: _showTimePicker,
                    autofocus: true,
                    clipBehavior: Clip.antiAlias,
                    style: theme.elevatedButtonTheme.style,
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(EditEntryConsts.btnPadding),
              child: Column(
                children: [
                  SizedBox(
                    width: EditEntryConsts.btnWidth,
                    child: ElevatedButton(
                      child: Text(
                        EditEntryStrings.saveBtn,
                        style: theme.textTheme.button,
                      ),
                      onPressed: () => _updateEntry(),
                      autofocus: true,
                      clipBehavior: Clip.antiAlias,
                      style: theme.elevatedButtonTheme.style,
                    ),
                  ),
                  SizedBox(
                    width: EditEntryConsts.btnWidth,
                    child: ElevatedButton(
                      child: Text(
                        EditEntryStrings.deleteBtn,
                        style: theme.textTheme.button,
                      ),
                      onPressed: () => _deleteDialog(context),
                      autofocus: true,
                      clipBehavior: Clip.antiAlias,
                      style: theme.elevatedButtonTheme.style.copyWith(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.red),
                      ),
                    ),
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
