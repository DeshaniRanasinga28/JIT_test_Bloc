import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/user_model.dart';

class UserDBHelper {
  late Database _database;

  Future<void> initDatabase() async {

      final path = await getDatabasesPath();
      final databasePath = join(path, 'user_database.db');

      _database = await openDatabase(databasePath, version: 1,
          onCreate: (Database db, int version) async {
            await db.execute('''
          CREATE TABLE users(
            id INTEGER PRIMARY KEY,
            username TEXT,
            password TEXT
          )
        ''');
          });
  }



  Future<void> insertUser(UserModel user) async {
    await _database.insert('users', user.toMap());
  }

  Future<List<UserModel>> getUsers() async {
    final List<Map<String, dynamic>> maps = await _database.query('users');

    return List.generate(maps.length, (i) {
      return UserModel(
        username: maps[i]['username'],
        password: maps[i]['password'],
      );
    });
  }

  Future close() async {
    final db = _database.database;

    db.close();
  }
}
