import 'package:flutter/material.dart';

class Pending extends StatelessWidget {
  final int pendingCount;
  const Pending({super.key, required this.pendingCount, required String label});

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
              child: Text("Pending", style: TextStyle(fontSize: 30)),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Text("$pendingCount", style: const TextStyle(fontSize: 30)),
            ),
          ),
        ],
      ),
    );
  }
}
