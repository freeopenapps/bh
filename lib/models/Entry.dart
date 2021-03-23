import 'dart:io';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
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

  static Future<String> getFileDir() async {
    // print("Getting permissions!");
    if (await Permission.storage.request().isGranted) {
      try {
        Directory tempDir = await getApplicationDocumentsDirectory();
        return tempDir.path;
      } on Exception catch (e) {
        print('getFileDir: ERROR:\n');
        print(e);
      }
    }
    return '';
  }

  static Future<void> toFile(Entry entry) async {
    /** Write a json file <id>.json for given Entry*/
    try {
      String path = await getFileDir();
      // print('\n\ntoFile: PATH:');
      // print(path);
      if (path != '') {
        var fullPath = join(path, Entry.getFileName(entry));
        // print('Writing file: ' + fullPath);
        File f = File(fullPath);
        // print(f.path);
        await f.writeAsString(json.encode(entry.toMap()));
        // await File(fullPath).exists().then((value) => print(value));
      }
    } on Exception catch (e) {
      print('toFile: ERROR\n');
      print(e.toString());
    }
  }

  static Future<Entry> fromFile(String path) async {
    /** Read a json file and return an Entry */
    File f = File(path);
    String data = await f.readAsString();
    return Entry.fromMap(json.decode(data));
  }

  static String getFileName(Entry entry) {
    String a = entry.date.toString().split(' ')[0];
    String b = entry.date.toString().split(' ')[1];
    return a + '.' + b + '.' + entry.id + '.json';
  }
}
