import 'dart:async' as prefix0;

import 'package:expense_app/models/transaction.dart' as prefix1;
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:expense_app/models/transaction.dart';

class DatabaseHelper{

  static DatabaseHelper _databaseHelper;
  static Database _database;

  String TABLE = 'transaction_table';
  String ID = 'id';
  String TITLE = 'title';
  String AMOUNT = 'amount';
  String DATE = 'date';

  DatabaseHelper._createInstance();

  factory DatabaseHelper(){
    if(_databaseHelper==null)
      _databaseHelper = DatabaseHelper._createInstance();

    return _databaseHelper;
  }

  Future<Database> get database async{
    if(database == null){
      _database = await initializeDatabase();
    }
      return _database;
  }

  Future<Database>initializeDatabase() async{

    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'transaction.db';

    var transactionDatabase = await openDatabase(path,version: 1, onCreate: _createDb);
    return transactionDatabase;

  }
  
  void _createDb(Database db, int newVersion) async{
    await db.execute('CREATE TABLE $TABLE($ID INTEGER PRIMARY KEY AUTOINCREMENT,$TITLE TEXT,'
        '$AMOUNT REAL, $DATE TEXT)');
  }


 Future<List<Map<String, dynamic>>> getTransactionMapList() async{
    Database db = await this.database;
    var result = await db.rawQuery('SELECT * FROM $TABLE');
    return result;
  }

  Future<int> insertTransaction(prefix1.Transaction transaction) async{

    Database db = await this.database;
    var result = await db.insert(TABLE, transaction.toMap());
    return result;

  }

  Future<int> updateTransaction(prefix1.Transaction transaction) async{

    var db = await this.database;
    var result = await db.update(TABLE, transaction.toMap(), where: 'ID = ?',whereArgs: [transaction.Id]);
    return result;

  }

  Future<int> deleteTransaction(int id) async{

    var db = await this.database;
    var result = await db.rawDelete('DELETE FROM $TABLE WHERE $ID = $id');
    return result;

  }

  Future<int> getCount() async{

    Database db = await this.database;
    List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) from $TABLE');
    int result = Sqflite.firstIntValue(x);
    return result;

  }

}