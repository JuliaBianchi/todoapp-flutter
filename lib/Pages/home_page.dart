import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ionicons/ionicons.dart';
import 'package:lottie/lottie.dart';
import 'package:todoapp/Repository/task_repository.dart';
import 'package:todoapp/store/task_store.dart';

import '../Models/task_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const colorPrymary = 0xFFD0CAEB;
  static const colorSecondary = 0xFF7B6FC3;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final storeTasks = TaskStore(repository: TaskRepository());
  List<TaskModel> tasks = [];

  @override
  void initState() {
    super.initState();
    storeTasks.getTasks().then((_) {
      tasks = storeTasks.state.value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(HomePage.colorPrymary),
      appBar: AppBar(
        backgroundColor: const Color(HomePage.colorPrymary),
        elevation: 0,
        toolbarHeight: 70,

        title: const Padding(
          padding: EdgeInsets.all(15.0),
          child: Text(
            'To-Do',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: AnimatedBuilder(
        animation: Listenable.merge([
          storeTasks.isLoading,
          storeTasks.erro,
          storeTasks.state,
        ]),
        builder: (context, child) {
          if (storeTasks.isLoading.value) {
            return const Center(
              child: SpinKitThreeBounce(
                color: Colors.blueAccent,
                size: 15,
              ),
            );
          }

          if (storeTasks.erro.value.isNotEmpty) {
            return Center(
              child: Text(
                'Ocorreu um erro ao carregar as tarefas! ${storeTasks.erro.value}',
                style: const TextStyle(
                  color: Colors.black54,
                  fontFamily: 'RobotoMono',
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
            );
          }

          if (storeTasks.state.value.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 300,
                      width:200,
                      child: Lottie.network('https://lottie.host/997690ed-9d5b-4cdb-898d-2068b00ac71b/5tkcgt186u.json', )),
                  const Text(
                    'Ops, parece que você não tem nenhuma tarefa ainda!',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),

                ],
              ),
            );
          } else{
            return Container();
          }




        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: Color(0xFF5C0090),
        shape: const CircleBorder(),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Ionicons.add, size: 25, color: Colors.white,),
            ],
          ),
      ),
    );
  }
}
