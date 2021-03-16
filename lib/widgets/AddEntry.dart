import 'package:bh/models/Entry.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../providers/entry_list.dart';

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
      firstDate: DateTime(2021),
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
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(30),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Ketones'),
              controller: _ketonesC,
              keyboardType: TextInputType.number,
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Glucose'),
              controller: _glucoseC,
              keyboardType: TextInputType.number,
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Weight'),
              controller: _weightC,
              keyboardType: TextInputType.number,
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Pressure'),
              controller: _pressureC,
              keyboardType: TextInputType.datetime,
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Note'),
              controller: _noteC,
              keyboardType: TextInputType.multiline,
              maxLines: 4,
              minLines: 1,
            ),
            Container(
              padding: EdgeInsets.all(5),
              margin: EdgeInsets.all(1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    child: Text(
                      DateFormat.yMd().format(_selectedDate),
                    ),
                    onPressed: _showDatePicker,
                    // autofocus: true,
                    clipBehavior: Clip.antiAlias,
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).buttonColor,
                    ),
                  ),
                  ElevatedButton(
                    child: Text(
                      _selectedTime.format(context),
                    ),
                    onPressed: _showTimePicker,
                    // autofocus: true,
                    clipBehavior: Clip.antiAlias,
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).buttonColor,
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              width: 600,
              child: ElevatedButton(
                child: Text('Create Entry'),
                style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).buttonColor,
                ),
                onPressed: () => _submitEntry(),
                autofocus: true,
                clipBehavior: Clip.antiAlias,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
