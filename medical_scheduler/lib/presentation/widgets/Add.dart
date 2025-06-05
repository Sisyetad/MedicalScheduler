import 'package:flutter/material.dart';

class AddWidget extends StatefulWidget {
  final String entity;
  const AddWidget({super.key, required this.entity});

  @override
  State<AddWidget> createState() => _AddState();
}

class _AddState extends State<AddWidget> {
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed:
          () => {
          },
      style: OutlinedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 39, 81, 195),
      ),
      child: Text(
        "Add ${widget.entity}",
        style: TextStyle(color: Colors.white, fontSize: 18),
      ),
    );
  }
}
