import 'package:flutter/material.dart';

class Completed extends StatelessWidget {
  final int completedCount;
  const Completed({super.key, required this.completedCount});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 308,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color.fromARGB(255, 43, 95, 145),
      ),
      child: Wrap(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.heart_broken, size: 35),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Total completed", style: TextStyle(fontSize: 30)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60.0),
            child: Text(
              "$completedCount",
              style: const TextStyle(fontSize: 30),
            ),
          ),
        ],
      ),
    );
  }
}
