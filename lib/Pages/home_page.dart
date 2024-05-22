import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/pages/all_tasks_page.dart';
import 'package:todoapp/pages/birthday_page.dart';
import 'package:todoapp/pages/study_tasks_page.dart';
import 'package:todoapp/pages/work_tasks_pege.dart';
import 'package:todoapp/repository/task_repository.dart';
import 'package:todoapp/models/task_model.dart';
import '../components/error_dialog_component.dart';
import 'package:flutter_svg/flutter_svg.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();

  TextEditingController idController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  late TabController _tabController;

  List<TaskModel> tasks = [];

  bool isChecked = false;

  void clearFields() {
    titleController.clear();
    descriptionController.clear();
  }

  Future<dynamic> showTasksDialog(BuildContext context, [TaskModel? task]) async {

    await showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            backgroundColor: Colors.blue.shade50,
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                       Padding(
                        padding: EdgeInsets.only(top: 15, left: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Tarefa',
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue.shade800),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue.shade200),
                          borderRadius: BorderRadius.circular(8.0),
                          color: Colors.white
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 250,
                              height: 120,
                              child: TextFormField(
                                controller: descriptionController,
                                decoration: InputDecoration(
                                  hintText: 'Descreva a tarefa...',
                                  hintStyle: TextStyle(color: Colors.grey.shade500),
                                  border: InputBorder.none,
                                  suffixIconConstraints: const BoxConstraints(maxWidth: 24, maxHeight: 24),
                                  contentPadding: const EdgeInsets.only(left: 8.0, right: 15.0, top: 15.0, bottom: 5.0),
                                ),
                                maxLines: 5,
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: Colors.grey.shade900,
                                ),
                                cursorColor: const Color(0xFF454C52),
                                validator: (value) => value == ''
                                    ? 'Ops, a tarefa não pode ser vazia.'
                                    : null,
                              ),
                            ),
                            Padding(padding: const EdgeInsets.only(top: 15), child: SvgPicture.asset('lib/assets/pencil-square.svg', color: Colors.blue.shade500,)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 125,
                              child: ElevatedButton(
                                onPressed: () {
                                  submitForm();
                                },
                                style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blue.shade500),),
                                child: const Text(
                                  'Salvar',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 15),
                            SizedBox(
                              width: 125,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  clearFields();
                                },
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(Colors.blue.shade500),
                                ),
                                child: const Text(
                                  'Cancelar',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
    );
  }

  Future<void> submitForm() async {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }

    int? id = tasks.length;
    DateTime createdAt = DateTime.now();

    if(tasks.isEmpty){
      id = 1;
    }else{
      id = (id + 1);
    }

    TaskModel task = TaskModel(
        id: id,
        description: descriptionController.text,
        category: _tabController.index + 1,
        created_at: createdAt,
        updated_at: null,
        deleted_at: null,
        isCompleted: false
    );

    try {
      Provider.of<TaskRepository>(context, listen: false).addTask(task);

    }catch(e){
      log('Erro $e');
    }

    Navigator.pop(context);

    clearFields();
  }

  void _showScaffold(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: LimitedBox(
          maxWidth: 150,
          maxHeight: 50,
          child: Center(
            child: Text(
              msg,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              maxLines: 5,
            ),
          ),
        ),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.fixed,
      ),
    );
  }

  Future _showErrorDialog(String msg, String title) {
    return showDialog(context: context,
        builder: (ctx) => DisplayDialog(title: title, msg: msg));
  }

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    tasks = Provider.of<TaskRepository>(context).allTasks;

    return DefaultTabController(
      initialIndex: 1,
      length: 4,
      child: Scaffold(
        backgroundColor: Colors.blue.shade50,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Anotações', style: TextStyle(color: Colors.blue.shade800, fontWeight: FontWeight.bold, fontSize: 32)),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TabBar(
                  padding: const EdgeInsets.only(left: 25 ),
                  controller: _tabController,
                  isScrollable: true,
                  indicator: BoxDecoration(borderRadius: BorderRadius.circular(30.0), color: Colors.blue.shade500),
                  tabAlignment: TabAlignment.start,
                  dividerColor: Colors.transparent,
                  indicatorSize: TabBarIndicatorSize.tab,
                  splashBorderRadius: BorderRadius.circular(30.0),
                  labelColor: const Color(0xFFe9ebff),
                  unselectedLabelColor: Colors.blue.shade500,
                  indicatorPadding: EdgeInsets.all(5.0),
                  labelStyle: TextStyle(fontWeight: FontWeight.w600),
                  tabs:  const [
                    Tab(text: 'Todas'),
                    Tab(text: 'Estudo'),
                    Tab(text: 'Trabalho'),
                    Tab(text: 'Aniversários'),
                  ],
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  Container(child: AllTasksPage()),
                  Container(child: StudyTasksPage()),
                  Container(child: WorkTasksPage()),
                  Container(child: BirthdayPage()),

                ],),
            ),

          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue.shade500,
          tooltip: 'Adicionar',
          onPressed: () {
            showTasksDialog(context);
          },
          shape: const CircleBorder(),
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }
}
