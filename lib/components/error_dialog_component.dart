import 'package:flutter/material.dart';

class DisplayDialog extends StatefulWidget {

  final String title;
  final String msg;

  const DisplayDialog({super.key, required this.title, required this.msg});

  @override
  State<DisplayDialog> createState() => _DisplayDialogState();
}

class _DisplayDialogState extends State<DisplayDialog> {
  late String title;
  late String msg;

  @override
  void initState() {
    super.initState();

    title = widget.title;
    msg = widget.msg;
  }

  @override
  Widget build(BuildContext context) {

    return AlertDialog(
      title: Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
        textAlign: TextAlign.center,
      ),
      content: Text(msg, style: const TextStyle(fontSize: 14),
        textAlign: TextAlign.center,),
      actions: [
        Center(
          child: ElevatedButton(
            style:
            ElevatedButton.styleFrom(backgroundColor: Colors.grey.shade300),
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'Fechar',
              style: TextStyle(color: Colors.grey.shade800, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}
