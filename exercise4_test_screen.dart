import 'package:flutter/material.dart';
import 'exercise4_distance.dart';

class Exercise4TestScreen extends StatelessWidget {
  const Exercise4TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Example: distance between two nearby points
    final result = calculateDistance(
      startLatitude: 37.4219999,
      startLongitude: -122.0840575,
      endLatitude: 37.4230000,
      endLongitude: -122.0850000,
    );

    return Scaffold(
      appBar: AppBar(title: const Text("Exercise 4: Distance")),
      body: Center(
        child: Text(
          "Distance: ${result.distanceInMeters.toStringAsFixed(1)} m\n"
          "Close enough (≤400m)? ${result.isCloseEnough}",
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}