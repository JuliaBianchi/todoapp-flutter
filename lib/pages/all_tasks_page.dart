import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/components/list_view_component.dart';

import '../models/task_model.dart';
import '../repository/task_repository.dart';

class AllTasksPage extends StatefulWidget {
  const AllTasksPage({super.key});

  @override
  State<AllTasksPage> createState() => _AllTasksPageState();
}

class _AllTasksPageState extends State<AllTasksPage> {
  List<TaskModel> tasks = [];

  @override
  Widget build(BuildContext context) {
    tasks = Provider.of<TaskRepository>(context).allTasks;

    return Scaffold(
      backgroundColor: const Color(0xFFEEEDEC),
      body: ListViewComponent(
        tasks: tasks,
      ),
    );
  }
}
