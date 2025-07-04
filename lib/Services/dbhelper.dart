import 'dart:convert';
import 'dart:io';

import 'package:notes_new_app/Services/notesmodel.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class Dbhelper {
  
  //fields of tbale to be used
  static String idColumn = 'id';
  static String titleColumn = 'title';
  static String descriptionColumn = 'description';
  static String timeColumn = 'time';
  static String tableName = 'noteTable';

  Database? db;

  Dbhelper._();
  static Dbhelper instance = Dbhelper._();

  Future<Database> getDB() async{
    return db ?? initDB();
  }

  Future<Database> initDB() async{
    Directory directory = await getApplicationDocumentsDirectory();
    final path = join(directory.path,'notes.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute('''
            CREATE TABLE $tableName (
            $idColumn INTEGER PRIMARY KEY AUTOINCREMENT,
            $titleColumn TEXT,
            $descriptionColumn TEXT,
            $timeColumn TEXT
            )
        ''');
      },
    );
  }

  //inserting the data
  Future<int> insertData(NotesModel model) async{
    final _db = await getDB();
    return _db.insert(tableName, model.toJson());
  }

  //update the data
  Future<int> updateData(NotesModel model) async{
    final _db = await getDB();
    return _db.update(tableName, model.toJson(),where: 'id = ?',whereArgs: [model.id]);
  }

  //delete data
  Future<int> deleteData(NotesModel model) async{
    final _db = await getDB();
    return _db.delete(tableName,where: 'id = ?',whereArgs: [model.id]);
  }

  //get all data
  Future<List<NotesModel>> getData() async{
    final _db = await getDB();
    List<Map<String, Object?>> data =await _db.query(tableName);
    return data.map((c) => NotesModel.fromJson(c)).toList();
  }
}