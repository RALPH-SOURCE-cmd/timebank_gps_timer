import 'dart:async';
import 'package:flutter/material.dart';

class Exercise2Stopwatch extends StatefulWidget {
  const Exercise2Stopwatch({super.key});

  @override
  State<Exercise2Stopwatch> createState() => _Exercise2StopwatchState();
}

class _Exercise2StopwatchState extends State<Exercise2Stopwatch> {
  Timer? _timer;
  int _secondsElapsed = 0;
  bool _isRunning = false;

  void _startTimer() {
    if (_isRunning) return; // prevent starting twice
    setState(() {
      _isRunning = true;
    });
    // Timer.periodic runs the code inside every 1 second, forever,
    // until we cancel it.
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _secondsElapsed++;
      });
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    setState(() {
      _isRunning = false;
    });
  }

  void _resetTimer() {
    _timer?.cancel();
    setState(() {
      _secondsElapsed = 0;
      _isRunning = false;
    });
  }

  String _formatTime(int totalSeconds) {
    final hours = (totalSeconds ~/ 3600).toString().padLeft(2, '0');
    final minutes = ((totalSeconds % 3600) ~/ 60).toString().padLeft(2, '0');
    final seconds = (totalSeconds % 60).toString().padLeft(2, '0');
    return "$hours:$minutes:$seconds";
  }

  @override
  void dispose() {
    // Always cancel timers when the screen is destroyed,
    // otherwise it keeps running in the background and wastes battery/memory.
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Exercise 2: Stopwatch")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _formatTime(_secondsElapsed),
              style: const TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _startTimer,
                  child: const Text("Start"),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: _stopTimer,
                  child: const Text("Stop"),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: _resetTimer,
                  child: const Text("Reset"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}