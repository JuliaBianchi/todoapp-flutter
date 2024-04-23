import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';
import 'package:todoapp/Models/task_model.dart';
import 'package:sqflite/sqflite.dart' as sql;

class DbUtil {
  static const int version = 1; //-> mudar pra PROXIMA

  static Future<Database> database() async {
    final dbPath = await getDatabasesPath();

    return openDatabase(
      path.join(dbPath, 'todo.db'),
      onCreate: (db, version) {
        // CRIAR TABELA DO BANCO
        db.execute('CREATE TABLE tasks ( id INTEGER PRIMARY KEY AUTOINCREMENT, description TEXT, created_at DATE, updated_at DATE, deleted_at DATE, isCompleted BOOL)');
      },
      version: version,
    );
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DbUtil.database();
    await db.insert(
      table,
      data,
    );
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DbUtil.database();
    return db.query(table);
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