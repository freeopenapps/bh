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

  Map<String, String> toMap() {
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
}

Entry entryFromMap(Map<String, dynamic> map) {
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

Future<String> getFileDir(
  PermissionManager perMan,
  PathManager pathMan, {
  fileSystem = const LocalFileSystem(),
}) async {
  if (await perMan.storage()) {
    logger.d('Getting permissions');
    try {
      // Directory tempDir = await getApplicationDocumentsDirectory();
      String tempDir = await pathMan.downloadsPath();
      Directory _tgt = fileSystem.directory(
        join(tempDir, 'BloodHoundApp'),
      );
      if (await _tgt.exists()) {
        logger.d('DIRECTORY FOUND: ${_tgt.path}');
        return _tgt.path;
      } else {
        final Directory _newTgt = await _tgt.create(
          recursive: true,
        );
        logger.d('DIRECTORY CREATED: ${_tgt.path}');
        return _newTgt.path;
      }
    } on Exception catch (e) {
      logger.e('Could not get directory', e);
    }
  }
  logger.e('No directory retrieved/created');
  return '';
}

Future<void> entryToFile(
  Entry entry,
  Function getFileDir,
  Function getFileName,
  PermissionManager perMan,
  PathManager pathMan, {
  fileSystem = const LocalFileSystem(),
}) async {
  // Write a json file: <date>_<time>.<uuid>.json for given Entry
  try {
    String path = await getFileDir(perMan, pathMan);
    if (path == '') {
      throw Exception('Failed to get path to file');
    }
    logger.d('Retrieved path: $path');

    String fullPath = join(path, getFileName(entry));
    logger.d('Attempting to create: $fullPath');
    File f = fileSystem.file(fullPath);
    await f.writeAsString(json.encode(entry.toMap()));
    bool a = await f.exists();
    logger.d('Created file: ${f.path} : $a');
  } on Exception catch (e) {
    logger.e('Failed to create file for Entry: ${entry.id}', e);
  }
}

Future<Entry> fromFile(
  String path,
  Function entryFromMap, {
  fsLocal: true,
}) async {
  /** Read a json file and return an Entry */
  FileSystem fs;
  if (fsLocal) {
    logger.d('Using local FS');
    fs = LocalFileSystem();
  } else {
    logger.d('Using memory FS');
    fs = MemoryFileSystem();
  }
  try {
    File f = fs.file(path);
    String data = await f.readAsString();
    Entry e = entryFromMap(json.decode(data));
    logger.d('Created Entry from: $path');
    return e;
  } on Exception catch (e) {
    logger.e('Failed to create Entry from: $path', e);
  }
}

String getFileName(Entry entry) {
  // Output:  2021-03-17_11-00-00_000.a82bfe9f-0b28-4f2c-a0d2-3f2c41305c10.json
  String a = entry.date.toString().split(' ')[0];
  String b = entry.date
      .toString()
      .split(' ')[1]
      .replaceAll('.', '_')
      .replaceAll(':', '-');
  return a + '_' + b + '.' + entry.id + '.json';
}
