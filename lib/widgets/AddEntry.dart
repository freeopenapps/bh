import '../models/Entry.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../providers/entry_list.dart';
import '../theme.dart';
import '../strings.dart';
import '../constants.dart';

class AddEntry extends StatefulWidget {
  @override
  _AddEntryState createState() => _AddEntryState();
}

class _AddEntryState extends State<AddEntry> {
  // EntryList entryList;

  final _ketonesC = TextEditingController();
  final _glucoseC = TextEditingController();
  final _weightC = TextEditingController();
  final _pressureC = TextEditingController();
  final _noteC = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(AddEntryConsts.datePickerStartYear),
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

  void _submitEntry() {
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

    Provider.of<EntryListProvider>(
      context,
      listen: false,
    ).create(Entry(
      ketones: ketones,
      glucose: glucose,
      weight: weight,
      pressure: pressure,
      note: note,
      date: date,
      picPath: '',
    ));

    // Close the modal
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final theme = mobileTheme();
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(AddEntryConsts.scrollViewPadding),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: AddEntryStrings.entryKetonesFld,
              ),
              controller: _ketonesC,
              keyboardType: TextInputType.number,
            ),
            TextField(
              decoration: const InputDecoration(
                labelText: AddEntryStrings.entryGlucoseFld,
              ),
              controller: _glucoseC,
              keyboardType: TextInputType.number,
            ),
            TextField(
              decoration: const InputDecoration(
                labelText: AddEntryStrings.entryWeightFld,
              ),
              controller: _weightC,
              keyboardType: TextInputType.number,
            ),
            TextField(
              decoration: const InputDecoration(
                labelText: AddEntryStrings.entryPressureFld,
              ),
              controller: _pressureC,
              keyboardType: TextInputType.datetime,
            ),
            TextField(
              decoration: const InputDecoration(
                labelText: AddEntryStrings.entryNoteFld,
              ),
              controller: _noteC,
              keyboardType: TextInputType.multiline,
              maxLines: AddEntryConsts.noteMaxLines,
              minLines: AddEntryConsts.noteMinLines,
            ),
            Container(
              padding: EdgeInsets.all(AddEntryConsts.dateTimeBtnPadding),
              margin: EdgeInsets.all(AddEntryConsts.dateTimeBtnMargin),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    style: theme.elevatedButtonTheme.style,
                    child: Text(
                      DateFormat.yMd().format(_selectedDate),
                      style: theme.textTheme.button,
                    ),
                    onPressed: _showDatePicker,
                    clipBehavior: Clip.antiAlias,
                  ),
                  ElevatedButton(
                    style: theme.elevatedButtonTheme.style,
                    child: Text(
                      _selectedTime.format(context),
                      style: theme.textTheme.button,
                    ),
                    onPressed: _showTimePicker,
                    clipBehavior: Clip.antiAlias,
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(AddEntryConsts.btnPadding),
              width: AddEntryConsts.btnWidth,
              child: ElevatedButton(
                style: theme.elevatedButtonTheme.style,
                child: Text(
                  AddEntryStrings.createBtn,
                  style: theme.textTheme.button,
                ),
                onPressed: () => _submitEntry(),
                clipBehavior: Clip.antiAlias,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
