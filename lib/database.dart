import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Db {
  final int id;
  final String name;
  final dynamic value;

  Db({this.id, this.name, this.value});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'value': value,
    };
  }

  // Implement toString to make it easier to see information
  @override
  String toString() {
    return 'Db{id: $id, name: $name, value: $value}';
  }

  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'test_database.db'),
      // When the database is first created, create a table to store dogs.
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE test_data(id INTEGER PRIMARY KEY, name TEXT, value TEXT)",
        );
      },
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 1,
    );
  }

  Future<void> insert(Db data) async {
    // Get a reference to the database.
    final Database db = await database;

    // Insert the Dog into the correct table. Also specify the
    // `conflictAlgorithm`. In this case, if the same dog is inserted
    // multiple times, it replaces the previous data.
    await db.insert(
      'test_data',
      data.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Db>> datas() async {
    // Get a reference to the database.
    final Database db = await database;

    // Query the table for all .
    final List<Map<String, dynamic>> maps = await db.query('test_data');

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return Db(
        id: maps[i]['id'],
        name: maps[i]['name'],
        value: maps[i]['value'],
      );
    });
  }

  Future<void> update(Db data) async {
    // Get a reference to the database.
    final db = await database;

    // Update the given Dog.
    await db.update(
      'test_data',
      data.toMap(),
      // Ensure that the Dog has a matching id.
      where: "id = ?",
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [data.id],
    );
  }

  Future<void> deleteById(id) async {
    // Get a reference to the database.
    final db = await database;

    // Remove the Dog from the database.
    await db.delete(
      'test_data',
      // Use a `where` clause to delete a specific dog.
      where: "id = ?",
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
  }

  // // Insert a dog into the database.
  // await insert(fido);

  // // Print the list of dogs (only Fido for now).
  // print(await dogs());

  // // Update Fido's age and save it to the database.

  // await updateDog(fido);

  // // Print Fido's updated information.
  // print(await dogs());

  // // Delete Fido from the database.
  // await deleteDog(fido.id);

  // // Print the list of dogs (empty).
  // print(await dogs());
}
