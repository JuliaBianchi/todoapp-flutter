import 'dart:collection';
import 'package:flutter/material.dart';
import '../models/task_model.dart';

class TaskRepository extends ChangeNotifier {
  List<TaskModel> _list = [];

  UnmodifiableListView<TaskModel> get allTasks => UnmodifiableListView(_list.where((e) => e.category == 1).toList());

  UnmodifiableListView<TaskModel> get studyTasks => UnmodifiableListView(_list.where((e) => e.category == 2).toList());

  UnmodifiableListView<TaskModel> get workTasks => UnmodifiableListView(_list.where((e) => e.category == 3).toList());

  UnmodifiableListView<TaskModel> get birthdays => UnmodifiableListView(_list.where((e) => e.category == 4).toList());


  addTask(TaskModel task) {
    _list.add(task);
    notifyListeners();
  }

  removeTask(item) {
    _list.remove(item);
    notifyListeners();
  }
}
