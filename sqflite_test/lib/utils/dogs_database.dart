import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/dog.dart';

class DogsDataBase {
  /// Open the dogs database and store the reference.
  Future<Database> openDB() async {
    var database =
        await openDatabase(join(await getDatabasesPath(), 'doggie_database.db'),
            onCreate: (db, version) {
      print("Creating dogs1 TABLE!! at doggie_database.db'");
      return db.execute(
          'CREATE TABLE dogs1(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, age INTEGER)');
    }, version: 1);
    print('Dogs Database opened');
    return database;
  }

  /// CREATE new Table of name X
  Future<void> createNewTable(String newTableName) async {
    final Database db = await openDB();
    await db.execute(
        'CREATE TABLE $newTableName(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, age INTEGER)');
    print("Table created: $newTableName");
  }

  /// DROP Table of name X
  Future<void> dropTable(String existingTableName) async {
    final Database db = await openDB();
    await db.execute(
        'DROP TABLE IF EXISTS $existingTableName');
    print("Table dropped: $existingTableName");
  }


  /// Insert a Dog into 'dogs' database
  Future<void> insertDog(Dog dog, String existingTableName) async {
    final Database db = await openDB();
    await db.insert(existingTableName, dog.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    print('dog named ${dog.name} inserted into TABLE: $existingTableName');
  }

  /// Get ALL dogs from the database
  Future<List<Dog>> getDogs(String existingTableName) async {
    final Database db = await openDB();
    final List<Map<String, dynamic>> dogMaps =
        await db.rawQuery('SELECT * FROM $existingTableName');

    print(dogMaps.length);
    return List.generate(dogMaps.length, (i) {
      return Dog(
        id: dogMaps[i]['id'],
        name: dogMaps[i]['name'],
        age: dogMaps[i]['age'],
      );
    });
  }

  /// Print ALL Dogs From Table Named X...
  Future<void> printDogs(String existingTableName) async {
    print('printing dogs');
    final dogs = await getDogs(existingTableName);
    for (int i = 0; i < dogs.length; i++) {
      print("id: ${dogs[i].id}, name: ${dogs[i].name}, age: ${dogs[i].age}");
    }
  }

  /// Print list of TABLES in 'doggie_database.db'
  Future<void> printTablesList() async {
    final Database db = await openDB();
    print(db);
    var tablesList = await db.rawQuery(
        "SELECT name FROM sqlite_master WHERE type='table'");
    print(tablesList);
  }
}
