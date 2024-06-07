import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:todoapp/Database/db_util.dart';
import '../models/task_model.dart';

class TasksRepository extends ChangeNotifier {
  List<TaskModel> _list = [];

  final database = DbUtil.database();

  UnmodifiableListView<TaskModel> get allTasks => UnmodifiableListView(_list.where((e) => e.category == 1).toList());

  UnmodifiableListView<TaskModel> get studyTasks => UnmodifiableListView(_list.where((e) => e.category == 2).toList());

  UnmodifiableListView<TaskModel> get workTasks => UnmodifiableListView(_list.where((e) => e.category == 3).toList());

  UnmodifiableListView<TaskModel> get birthdays => UnmodifiableListView(_list.where((e) => e.category == 4).toList());


  Future<void> insertTask(TaskModel task)async {
    final db = await DbUtil.database();
    await db.insert('tasks', task.toMap());
    notifyListeners();
  }

  Future<void> deleteTask(TaskModel task)async {
    final db = await DbUtil.database();
    await db.delete('tasks', where: 'id = ?', whereArgs: [task.id]);
    notifyListeners();
  }

  Future<void> table(String task, String where, List<Object?> whereArgs )async {
    final db = await DbUtil.database();
    await db.query('tasks', where: where ,whereArgs: whereArgs);
    notifyListeners();
  }

  Future<void> updateTask(TaskModel task)async {
    final db = await DbUtil.database();
    await db.delete('tasks', where: 'id = ?', whereArgs: [task.id]);
    notifyListeners();
  }


  addTask(TaskModel task) {
    _list.add(task);
    notifyListeners();
  }

  removeTask(item) {
    _list.remove(item);
    notifyListeners();
  }
}