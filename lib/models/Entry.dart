import 'dart:io';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uuid/uuid.dart';
import 'package:ext_storage/ext_storage.dart';

import 'package:file/file.dart';
import 'package:file/memory.dart';
import 'package:file/local.dart';

import '../logging.dart';

final logger = getLogger('Entry');

class PermissionManager {
  /// Wrapper class to facilitate mocking during testing
  Future<bool> storage() async {
    return await Permission.storage.request().isGranted;
  }
}

class PathManager {
  /// Wrapper class to facilitate mocking during testing
  Future<String> downloadsPath() async {
    return await ExtStorage.getExternalStoragePublicDirectory(
        ExtStorage.DIRECTORY_DOWNLOADS);
  }
}

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

  static Future<String> getFileDir(
    PermissionManager perMan,
    PathManager pathMan, {
    fsLocal = true,
  }) async {
    // Select FileSystem
    // Local works on device FS. For builds.
    // Memory creates FS in memory. For testing.
    FileSystem fs;
    if (fsLocal) {
      fs = LocalFileSystem();
    } else {
      fs = MemoryFileSystem();
    }

    logger.v('You don\'t always want to see all of these');
    logger.d('Logs a debug message');
    logger.i('Public Function called');
    logger.w('This might become a problem');
    logger.e('Something has happened');

    // print("Getting permissions!");
    if (await perMan.storage()) {
      try {
        // Directory tempDir = await getApplicationDocumentsDirectory();
        String tempDir = await pathMan.downloadsPath();
        Directory _tgt = fs.directory(
          join(tempDir, 'BloodHoundApp'),
        );
        if (await _tgt.exists()) {
          print('DIRECTORY FOUND: ${_tgt.path}');

          return _tgt.path;
        } else {
          final Directory _newTgt = await _tgt.create(
            recursive: true,
          );
          // print('DIRECTORY CREATED: ${_newTgt.path}');
          return _newTgt.path;
        }
      } on Exception catch (e) {
        print('getFileDir: ERROR:\n');
        print(e);
      }
    }
    return '';
  }

  static Future<void> toFile(
    Entry entry,
    PermissionManager perMan,
    PathManager pathMan, {
    fsLocal: true,
  }) async {
    // Select FileSystem
    // Local works on device FS. For builds.
    // Memory creates FS in memory. For testing.
    FileSystem fs;
    if (fsLocal) {
      fs = LocalFileSystem();
    } else {
      fs = MemoryFileSystem();
    }
    /** Write a json file <id>.json for given Entry*/
    try {
      String path = await Entry.getFileDir(perMan, pathMan);
      // print('\n\ntoFile: PATH:');
      // print(path);
      if (path != '') {
        var fullPath = join(path, Entry.getFileName(entry));
        // print('Writing file: ' + fullPath);
        File f = fs.file(fullPath);
        // print(f.path);
        await f.writeAsString(json.encode(entry.toMap()));
        // await File(fullPath).exists().then((value) => print(value));
      }
    } on Exception catch (e) {
      print('toFile: ERROR\n');
      print(e.toString());
    }
  }

  // static Future<Entry> fromFile(String path) async {
  //   /** Read a json file and return an Entry */
  //   File f = File(path);
  //   String data = await f.readAsString();
  //   return Entry.fromMap(json.decode(data));
  // }

  static String getFileName(Entry entry) {
    // Output:  2021-03-17_11-00-00_000.a82bfe9f-0b28-4f2c-a0d2-3f2c41305c10.json
    String a = entry.date.toString().split(' ')[0];
    String b = entry.date
        .toString()
        .split(' ')[1]
        .replaceAll('.', '_')
        .replaceAll(':', '-');
    return a + '_' + b + '.' + entry.id + '.json';
  }
}
