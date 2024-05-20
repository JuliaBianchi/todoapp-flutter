import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/repository/task_repository.dart';
import 'package:todoapp/models/task_model.dart';
import '../components/error_dialog_component.dart';
import 'package:flutter_svg/flutter_svg.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
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

  Future<dynamic> showTasksDialog(BuildContext context, int index, [TaskModel? task]) async {

    await showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            backgroundColor: const Color(0xFFEEEDEC),
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 15),
                        child: Text(
                          'Tarefa',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        width: 320,
                        height: 125,
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xFF9EA5AD)),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 280,
                              height: 120,
                              child: TextFormField(
                                controller: descriptionController,
                                decoration: InputDecoration(
                                  hintText: 'Descreva a tarefa...',
                                  hintStyle: TextStyle(color: Colors.grey.shade600),
                                  border: InputBorder.none,
                                  suffixIconConstraints: const BoxConstraints(maxWidth: 24, maxHeight: 24),
                                  contentPadding: const EdgeInsets.only(left: 8.0, right: 15.0, top: 15.0, bottom: 5.0),
                                ),
                                maxLines: 5,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: Color(0xFF454C52),
                                ),
                                cursorColor: const Color(0xFF454C52),
                                validator: (value) =>
                                value == ''
                                    ? 'Ops, a tarefa não pode ser vazia.'
                                    : null,
                              ),
                            ),
                            Padding(padding: const EdgeInsets.only(top: 15),
                                child: SvgPicture.asset('lib/assets/pencil-square.svg')),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
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
                                style: ButtonStyle(backgroundColor: MaterialStateProperty.all(const Color(0xFF5C0090)),),
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
                                  backgroundColor: MaterialStateProperty.all(const Color(0xFF5C0090)),
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
        category: _tabController.index+1,
        created_at: createdAt.toString(),
        updated_at: null,
        deleted_at: null,
        isCompleted: false
    );

    try {
      Provider.of<TaskRepository>(context, listen: false).addTask(task);
      log('Add');
      log('${task.id}');
      log('${task.category}');
      log('${task.description}');
      log('${task.created_at}');

    }catch(e){
      log('Erro $e');
    }

    Navigator.popAndPushNamed(context, '/home-page');

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
    tasks = Provider.of<TaskRepository>(context).list;

    return DefaultTabController(
      initialIndex: 1,
      length: 4,
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(210, 210, 255, 65.0),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 220,
              child: GridPaper(
                interval: 200,
                color: Colors.white12,
                child: SvgPicture.asset('lib/assets/arrow.svg', alignment: Alignment.center,),
              ),
            ),
            TabBar(
              controller: _tabController,
              isScrollable: true,
              tabAlignment: TabAlignment.start,
              padding: const EdgeInsets.all(10),
              labelPadding: const EdgeInsets.only(left: 25, right: 25, top: 10),
              dividerColor: Colors.transparent,
              indicatorSize: TabBarIndicatorSize.label,
              splashBorderRadius: BorderRadius.circular(50.0),
              labelColor: const Color.fromRGBO(120, 28, 171, 100),
              indicatorColor: Colors.purple,
              unselectedLabelColor: Colors.black54,
              tabs: const [
                Tab(text: 'Todas', icon: Icon(Icons.home),),
                Tab(text: 'Estudo', icon: Icon(Icons.library_books)),
                Tab(text: 'Trabalho', icon: Icon(Icons.laptop)),
                Tab(text: 'Aniversários', icon: Icon(Icons.cake)),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  Container(child: const Text('Geral')),
                  Container(child: const Text('Estudos')),
                  Container(child: const Text('Trabalho')),
                  Container(child: const Text('Aniversário')),

                ],),
            ),

          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xFF5C0090),
          tooltip: 'Adicionar nota',
          onPressed: () {
            final index = _tabController.index + 1;

            showTasksDialog(context, index);
          },
          shape: const CircleBorder(),
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }
}
