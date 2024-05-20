import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/Database/db_util.dart';
import 'package:todoapp/pages/home_page.dart';
import 'package:todoapp/repository/task_repository.dart';

void main() {
  runApp(ChangeNotifierProvider(create: (context) => TaskRepository(), child: MyApp(),));
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
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
      initialRoute: '/home-page',
      routes: {
        '/home-page' : (context) => HomePage(),
      },
      theme: ThemeData(
        textTheme: GoogleFonts.nanumMyeongjoTextTheme(),
      ),
    );
  }
}

