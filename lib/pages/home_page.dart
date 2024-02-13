import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const colorPrymary = 0xFF46257E;
  static const colorSecondary = 0xFF7C56B5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(colorPrymary),
      appBar: AppBar(
        backgroundColor: const Color(colorSecondary),
        elevation: 0,
        toolbarHeight: 70,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        centerTitle: true,
        title: const Text(
          'TO-DO',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ),

      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: const Color(colorSecondary),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Ionicons.add, size: 15,),
              Icon(Ionicons.list_outline)
            ],
          )),
      bottomNavigationBar: const BottomAppBar(
        notchMargin: 10,
        shape: CircularNotchedRectangle(),
        height: 60,
        color: Color(0xFF7C56B5),
      ),
    );
  }
}
