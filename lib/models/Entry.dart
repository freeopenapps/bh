import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

class Entry {
  String id;
  String date; // DateTime.toUtc()
  String ketones; //Entry title
  String glucose; //numeric entry value
  String weight; //int, double, String
  String pressure; //Entry units
  String note; //Entry note
  String picPath; //Path to pic

  Entry({
    @required this.ketones,
    @required this.glucose,
    @required this.weight,
    @required this.pressure,
    @required this.note,
    @required this.date,
    @required this.picPath,
    this.id = '',
  }) {
    if (this.id == '') this.id = Uuid().v4();
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date,
      'ketones': ketones,
      'glucose': glucose,
      'weight': weight,
      'pressure': pressure,
      'note': note,
      'picPath': picPath,
    };
  }

  static Entry fromMap(Map<String, dynamic> map) {
    return Entry(
      id: map['id'],
      date: map['date'],
      ketones: map['ketones'],
      glucose: map['glucose'],
      weight: map['weight'],
      pressure: map['pressure'],
      note: map['note'],
      picPath: map['picPath'],
    );
  }
}
