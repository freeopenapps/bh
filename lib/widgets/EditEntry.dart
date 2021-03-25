import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../providers/entry_list.dart';

import '../models/Entry.dart';
import '../theme.dart';

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
          title: Text('Delete Entry'),
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
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Delete'),
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
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Text(
              'Update Entry',
              style: theme.textTheme.headline1,
            ),
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
              padding: EdgeInsets.all(10),
              width: 600,
              child: Column(
                children: [
                  SizedBox(
                    width: 600,
                    child: ElevatedButton(
                      child: Text(
                        'Save Changes',
                        style: theme.textTheme.button,
                      ),
                      onPressed: () => _updateEntry(),
                      autofocus: true,
                      clipBehavior: Clip.antiAlias,
                      style: theme.elevatedButtonTheme.style,
                    ),
                  ),
                  SizedBox(
                    width: 600,
                    child: ElevatedButton(
                      child: Text(
                        'Delete',
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
