import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/list_view_component.dart';
import '../models/task_model.dart';
import '../repository/task_repository.dart';

class StudyTasksPage extends StatelessWidget {
   StudyTasksPage({super.key});

  List<TaskModel> tasks = [];

  @override
  Widget build(BuildContext context) {
    tasks = Provider.of<TaskRepository>(context).studyTasks;

    return Scaffold(
      backgroundColor: const Color(0xFFEEEDEC),
      body: ListViewComponent(
        tasks: tasks,
      ),
    );
  }
}
