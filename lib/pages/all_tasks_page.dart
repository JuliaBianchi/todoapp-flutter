import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/repository/tasks_repository.dart';
import '../models/task_model.dart';

class AllTasksPage extends StatelessWidget {
  AllTasksPage({super.key});

  List<TaskModel> tasks = [];

  @override
  Widget build(BuildContext context) {
    tasks = Provider.of<TasksRepository>(context).allTasks;

    return Scaffold(
      backgroundColor: const Color(0xFFEEEDEC),
      body: tasks.isEmpty
          ? Container(
              color: Colors.blue.shade50,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Nenhuma tarefa ainda!',
                        style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Adicione algumas tarefas clicando no ícone abaixo.',
                        style: TextStyle(
                          color: Colors.grey.shade400,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            )
          : Container(
              color: Colors.blue.shade50,
              child: Column(
                children: [
                  Expanded(
                    child: Consumer<TasksRepository>(builder: (_, repository, Widget) {
                      return ListView.builder(
                        itemCount: repository.allTasks.length,
                        itemBuilder: (context, index) {
                          final task = repository.allTasks[index];
                          return Dismissible(
                            background: Container(
                              color: Colors.blue.shade200,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text('Concluir',
                                        style: TextStyle(
                                          color: Colors.blue.shade800,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        )),
                                  ),
                                ],
                              ),
                            ),
                            secondaryBackground: Container(
                              color: Colors.blue.shade200,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Text('Concluir',
                                        style: TextStyle(
                                          color: Colors.blue.shade800,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        )),
                                  ),
                                ],
                              ),
                            ),

                            key: ValueKey<TaskModel>(task),
                            onDismissed: (DismissDirection direction) {
                                Provider.of<TasksRepository>(context, listen: false).deleteTask(task);
                                Provider.of<TasksRepository>(context, listen: false).removeTask(task);

                            },
                            child: Container(
                              margin: const EdgeInsets.all(10),
                              decoration: const BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey,
                                      offset: Offset(0.0, 1.0), //(x,y)
                                      blurRadius: 1.0,
                                    ),
                                  ],
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(30.0),
                                      bottomRight: Radius.circular(30.0))),
                              child: GestureDetector(

                                child: Card(
                                  elevation: 0,
                                  color: Colors.transparent,
                                  child: SingleChildScrollView(
                                    child: Container(
                                      margin: const EdgeInsets.all(25.0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            children: [
                                              LimitedBox(
                                                child: Text(
                                                  '${task.description}',
                                                  maxLines: 6,
                                                  softWrap: true,
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 16),
                                                ),
                                              ),
                                            ],
                                          ),
                                          if (task.created_at != null)
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                Text(DateFormat.yMMMMEEEEd('pt-br').format(DateTime.parse(task.created_at!)),
                                                  style: TextStyle(
                                                      color: Colors.grey.shade600,
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 12),
                                                ),
                                              ],
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                            ),
                          );
                        },
                      );
                    }),
                  ),
                ],
              ),
            ),
    );
  }
}
