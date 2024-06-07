import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/Database/db_util.dart';
import 'package:todoapp/pages/home_page.dart';
import 'package:todoapp/repository/tasks_repository.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(ChangeNotifierProvider(create: (context) => TasksRepository(), child: MyApp(),));
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
        '/home-page' : (context) => const HomePage(),
      },
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      localizationsDelegates:  const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('pt', 'BR')],


    );
  }
}

