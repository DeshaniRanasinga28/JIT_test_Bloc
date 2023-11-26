import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/transaction_model.dart';

class TransactionsDBHelper {
  static final TransactionsDBHelper instance = TransactionsDBHelper._init();
  static Database? _database;

  TransactionsDBHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDatabase('transaction_database.db');
    return _database!;
  }

  Future<Database> initDatabase(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path,
        version: 1, onCreate: _onCreateTransactions);
  }

  Future _onCreateTransactions(Database db, int version) async {
    await db.execute('''
CREATE TABLE transactions ( 
  _id INTEGER PRIMARY KEY AUTOINCREMENT, 
  type TEXT,
  transactionNumber TEXT,
  amount REAL,
  date TEXT,
  commission REAL,
  total REAL,
  operationType TEXT,
  status TEXT
  )
''');
  }

  Future<TransDetails> insertTransactions(TransDetails transDetails) async {
    final db = await instance.database;
    final id = await db.insert('transactions', transDetails.toJson());
    return transDetails.copy(id: id);
  }

  Future<TransDetails> readTransactions({required int id}) async {
    final db = await instance.database;

    final maps = await db.query(
      'transactions',
      columns: TransDetailsFields.values,
      where: '${TransDetailsFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return TransDetails.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<TransDetails>> getActiveTransactions() async {
    final db = await instance.database;
    const orderBy = '${TransDetailsFields.id} DESC';
    final result = await db.query('transactions',
        where: 'status = ?', whereArgs: ['active'], orderBy: orderBy);

    return result.map((json) => TransDetails.fromJson(json)).toList();
  }

  Future<int> updateTransaction({required TransDetails todo}) async {
    final db = await instance.database;

    return db.update(
      'transactions',
      todo.toJson(),
      where: '${TransDetailsFields.id} = ?',
      whereArgs: [todo.id],
    );
  }

  Future<int> deleteTransaction({required int id}) async {
    final db = await instance.database;

    return await db.delete(
      'transactions',
      where: '${TransDetailsFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
