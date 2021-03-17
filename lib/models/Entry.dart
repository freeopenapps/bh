import 'dart:io';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:downloads_path_provider/downloads_path_provider.dart';
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
    if (await Permission.storage.request().isGranted) {
      Directory tempDir = await DownloadsPathProvider.downloadsDirectory;
      String tempPath = tempDir.path;
      return join(tempPath, 'bloodhound');
    }
    return '';
  }

  static Future<void> toFile(Entry entry) async {
    /** Write a json file <id>.json for given Entry*/
    String path = await getFileDir();
    if (path != '') {
      var fullPath = join(await getFileDir(), entry.id + '.json');
      File f = File(fullPath);
      f.writeAsString(json.encode(entry.toMap()));
    }
  }

  static Future<Entry> fromFile(String path) async {
    /** Read a json file and return an Entry */
    File f = File(path);
    String data = await f.readAsString();
    return Entry.fromMap(json.decode(data));
  }
}
