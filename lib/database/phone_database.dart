import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'dart:async';
import 'dart:io';

import 'package:mobware/data/models/phone_model.dart';

class PhoneDatabase {
  static final PhoneDatabase _instance = PhoneDatabase._internal();

  factory PhoneDatabase() => _instance;

  static Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await initDatabase();
    return _database;
  }

  PhoneDatabase._internal();

  Future<Database> initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'phones.db');
    var theDatabase = await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDatabase;
  }

  void _onCreate(Database database, int version) async {
    await database.execute("CREATE TABLE Phones(id INTEGER PRIMARY KEY)");
    print('Database created sucessfully');
  }

  Future<int> updatePhone(PhoneModel phoneModel) async {
    var databaseClient = await database;
    int res = await databaseClient.update('Phones', phoneModel.toMap(),
        where: 'id = ?', whereArgs: [phoneModel.id]);
    print('Phone updated $res');
    return res;
  }

  Future closeDatabase() async {
    var databaseClient = await database;
    databaseClient.close();
  }
}
