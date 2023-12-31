import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseConnection{
  setDatabase() async{
    var directory=await getApplicationDocumentsDirectory();
    var path=join(directory.path,'db_todoList_sqflite1');
    var database=await openDatabase(path, version: 2, onCreate: _onCreatingDatabase);
    return database;
  }

  _onCreatingDatabase(Database database,int version)async{
    await database.execute("CREATE TABLE categories(id INTEGER PRIMARY KEY,name TEXT,description TEXT)");

    await database.execute("CREATE TABLE todo(id INTEGER PRIMARY KEY,title TEXT,description TEXT,"
        "category TEXT,todoDate TEXT,isFinished INTEGER)");
  }

}