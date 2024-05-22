import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/list_view_component.dart';
import '../models/task_model.dart';
import '../repository/task_repository.dart';

class BirthdayPage extends StatelessWidget {
  BirthdayPage({super.key});

  List<TaskModel> tasks = [];

  @override
  Widget build(BuildContext context) {
    tasks = Provider.of<TaskRepository>(context).birthdays;

    return Scaffold(
      backgroundColor: const Color(0xFFEEEDEC),
      body: ListViewComponent(
        tasks: tasks,
      ),
    );
  }
}
