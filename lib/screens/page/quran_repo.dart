import 'package:al_quran/models/ayah/ayah.dart';
import 'package:al_quran/models/chapter/sura_name.dart';
import 'package:al_quran/models/juz/juz.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

dp({msg, arg}) {
  debugPrint(" \n $msg    $arg ");
}

class QuranRepo {
  Database? database;

  Future openDb() async {
    try {
      var databasesPath = await getDatabasesPath();

      var path = join(databasesPath, "quranGB.db");

      dp(msg: "path", arg: path);

      // Check if the database exists
      var exists = await databaseExists(path);

      dp(msg: "exits", arg: exists);

      if (!exists) {
        // Should happen only the first time you launch your application
        dp(msg: "Creating new copy from asset");

        // Make sure the parent directory exists
        try {
          await Directory(dirname(path)).create(recursive: true);
        } catch (_) {}

        // Copy from asset
        ByteData data = await rootBundle.load(join("assets", "db/quranGB.db"));

        List<int> bytes =
            data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

        // Write and flush the bytes written
        await File(path).writeAsBytes(bytes, flush: true);
        database = await openDatabase(path, readOnly: true);
      } else {
        dp(msg: "Opening existing database");

        database = await openDatabase(path, readOnly: true);
        dp(msg: "database is open", arg: database?.isOpen);
      }
    } catch (e) {
      dp(msg: "Error in open db", arg: e);
    }
  }

  Future<List<Ayah>> getQuranBySuraId(suraId) async {
    //

    print("ID is ${suraId.runtimeType}");

    try {
      if (database == null) {
        await openDb();
      }
      List<Ayah> ayatList = [];

      List<Map> suraMapList = await database!
          .rawQuery('SELECT * FROM quran where surah_id=$suraId');

      suraMapList.forEach((element) {
        ayatList.add(Ayah.fromMap(element as Map<String, dynamic>));
      });

      ayatList.sort((a, b) => a.verse_id!.compareTo(b.verse_id!));
      return ayatList;
    } catch (e) {
      print("Eror in aya get $e");
      return [];
    }
  }

  Future<List<Juz>> getParasJuz() async {
    try {
      if (database == null) {
        await openDb();
      }
      List<Juz> ayatList = [];

      List<Map> suraMapList =
          await database!.rawQuery('SELECT * FROM quran_juz');

      suraMapList.forEach((element) {
        //
        ayatList.add(Juz.fromMap(element as Map<String, dynamic>));

        //
      });

      ayatList.sort((a, b) => a.number!.compareTo(b.number!));

      return ayatList;
    } catch (e) {
      print("Erro in para get ${e}");
      return [];
    }
  }

  Future<List<SuraName>> getSuras() async {
    //

    try {
      List<SuraName> ayatList = [];

      dp(msg: "is opne ", arg: database?.isOpen);

      if (database == null) {
        await openDb();
      }

      List<Map> suraMapList =
          await database!.rawQuery('SELECT * FROM surah_name');

      print(suraMapList.length);

      suraMapList.forEach((element) {
        ayatList.add(SuraName.fromMap(element as Map<String, dynamic>));
      });

      ayatList;

      return ayatList;
    } catch (e) {
      CastError e1 = e as CastError;

      print(e.runtimeType);

      dp(msg: "Error 1", arg: e1.stackTrace);

      return [];
    }
  }
}
