import 'dart:convert';

import 'package:todoapp/Database/db_util.dart';

import '../Models/task_model.dart';

abstract class ITaskRepository {
  Future<List<TaskModel>> getTasks();
}

class TaskRepository implements ITaskRepository {
  List<TaskModel> tasks = [];

  @override
  Future<List<TaskModel>> getTasks() async {
    final dataList = await DbUtil.getData('tasks');

    tasks = dataList.map((data) => TaskModel.fromJson(data)).toList();

    return tasks;
  }



}