import 'package:flutter/material.dart';
import 'package:todoapp/Database/DbUtil.dart';
import 'package:todoapp/pages/home_page.dart';

void main() {
  runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  DbUtil.database();

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title:  'To-Do App',
      debugShowCheckedModeBanner: false,
      initialRoute: '/home',
      routes: {
        '/home': (context) => const HomePage(),
      },



    );
  }
}

