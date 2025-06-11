import 'package:flutter/material.dart';

class Resolved extends StatelessWidget {
  final int resolvedCount;
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
          // THIS IS THE FINAL FIX: Using Expanded
          // An Expanded widget forces its child to fill the available space
          // in the main axis. Here, each Expanded will take up exactly 50px of height.
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Text(
                  "Resolved Pending",
                  style: const TextStyle(fontSize: 24),
                ),
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Text(
                  "$resolvedCount",
                  style: const TextStyle(fontSize: 24),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}