import 'dart:collection';
import 'package:flutter/material.dart';
import '../models/task_model.dart';

class TaskRepository extends ChangeNotifier {
  List<TaskModel> _list = [];

  UnmodifiableListView<TaskModel> get list => UnmodifiableListView(_list);

  addTask(TaskModel task) {
    _list.add(task);
    notifyListeners();
  }

  updateTask(TaskModel task) {
    int index = _list.indexWhere((p) => p.id == task.id);

    if (index >= 0) {
      _list[index] = task;
      notifyListeners();
    }
  }
}
