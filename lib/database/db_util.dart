import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

class DbUtil {
  static const int version = 1; //-> mudar pra PROXIMA

  static Future<Database> database() async {
    final dbPath = await getDatabasesPath();

    return openDatabase(
      path.join(dbPath, 'todo.db'),
      onCreate: (db, version) {
        // CRIAR TABELA DO BANCO
        db.execute('CREATE TABLE tasks ( id INTEGER,description TEXT, category INTEGER, created_at DATETIME)');
      },
      version: version,
    );
  }

  Future<void> insert(String table, Map<String, Object?> data) async {
    final db = await DbUtil.database();
    await db.insert(table, data);
  }

  Future<void> delete(String table, String where, List<Object?> whereArgs) async {
    final db = await DbUtil.database();
    await db.delete(table, where: where, whereArgs: whereArgs);
  }

  Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DbUtil.database();
    return db.query(table);
  }

  static Future<List<Map<String, Object?>>> query(String table) async {
    final db = await DbUtil.database();
    return await db.query(table);
  }


  Future<void> updateTask(String table,Map<String, Object?> values, String where, List<Object?> whereArgs) async {
    final db = await DbUtil.database();
    await db.update(table, values, where: where, whereArgs: whereArgs);
  }



 // MÉTODO GET PARA TRAZER OS DADOS
 // MÉTODO CREATE PARA CRIAR AS TASKS
 // MÉTODO UPDATE PARA ATUALIZAR
 // MÉTODO DELETE PARA EXCLUIR

 // TOAST DE ERRO CASO DER ALGUM

  //     Fluttertoast.showToast(
  //         msg: "Mensagem:$e",
  //         toastLength: Toast.LENGTH_LONG,
  //         gravity: ToastGravity.CENTER,
  //         timeInSecForIosWeb: 1,
  //         textColor: Colors.white,
  //         fontSize: 7.0);

}