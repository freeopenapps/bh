import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../providers/entry_list.dart';

class BHAppBar extends StatefulWidget {
  final String title;
  final String version;

  BHAppBar({this.title, this.version});
  @override
  _BHAppBarState createState() => _BHAppBarState();
}

class _BHAppBarState extends State<BHAppBar> {
  DateTime _startDate = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
    00,
    00,
  );
  DateTime _endDate = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
    23,
    59,
  );

  void _showDatePicker(choice) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
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
      // Reduce entries list to range specified
      Provider.of<EntryListProvider>(
        context,
        listen: false,
      ).setRange(_startDate, _endDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: <Widget>[
              Text(widget.title),
              Text(
                widget.version,
                textScaleFactor: 0.7,
              ),
            ],
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    child: Text(
                      DateFormat.yMd().format(_startDate),
                    ),
                    onPressed: () {
                      _showDatePicker('start');
                    },
                    autofocus: true,
                    clipBehavior: Clip.antiAlias,
                    style: ElevatedButton.styleFrom(
                      side: BorderSide(
                        width: 0.5,
                        color: Colors.black,
                      ),
                      primary: Theme.of(context).buttonColor.withOpacity(0.6),
                    ),
                  ),
                  ElevatedButton(
                    child: Text(
                      DateFormat.yMd().format(_endDate),
                    ),
                    onPressed: () {
                      _showDatePicker('end');
                    },
                    autofocus: true,
                    clipBehavior: Clip.antiAlias,
                    style: ElevatedButton.styleFrom(
                      side: BorderSide(
                        width: 0.5,
                        color: Colors.black,
                      ),
                      primary: Theme.of(context).buttonColor.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
