import 'package:flutter/material.dart';

class Resolved extends StatelessWidget {
  final int resolvedCount; // This should be replaced with the actual resolved count from the provide
  const Resolved({super.key, required this.resolvedCount});

  @override
  Widget build(BuildContext context) {

    return Container(
      height: 100,
      width: 308,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color.fromARGB(255, 43, 95, 145),
      ),
      child: Column(
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              child: Text("Resolved Pending", style: TextStyle(fontSize: 30)),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Text("$resolvedCount", style: const TextStyle(fontSize: 30)),
            ),
          ),
        ],
      ),
    );
  }
}
