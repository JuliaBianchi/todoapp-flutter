import 'package:flutter/cupertino.dart';
import 'package:todoapp/Models/task_model.dart';
import 'package:todoapp/Repository/task_repository.dart';

class TaskStore {
  final ITaskRepository repository;

  TaskStore({required this.repository});

  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  final ValueNotifier<List<TaskModel>>state =
  ValueNotifier<List<TaskModel>>([]);

  final ValueNotifier<String> erro = ValueNotifier<String>('');

  Future getTasks() async {
    isLoading.value = true;

    try {
      final result = await repository.getTasks();
      state.value = result;
    } catch (e) {
      erro.value = e.toString();
    }
    isLoading.value = false;
  }

}