import 'dart:io';

import 'package:sqflite/sqlite_api.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DataBaseManager{
  DataBaseManager._private();

  static DataBaseManager instance = DataBaseManager._private();

  Database? _db;

  Future<Database> get db async{
    if (_db == null) {
      _db = await _initDB();
    }
    return _db!;
  }

  Future _initDB() async {
    Directory docDir = await getApplicationDocumentsDirectory();
    String path = join(docDir.path,"bookmark.db");

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        return await db.execute(
          '''
          CREATE TABLE bookmark (
          id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
          surah TEXT NOT NULL,
          number_surah INTEGER NOT NULL,
          ayat INTEGER NOT NULL,
          juz INTEGER NOT NULL,
          via TEXT NOT NULL,
          index_ayat INTEGER NOT NULL,
          last_read INTEGER DEFAULT 0
          )
          '''
        );
      },
    );
  }

  Future closeDB() async {
    _db = await instance.db;
    _db!.close();
  }
}