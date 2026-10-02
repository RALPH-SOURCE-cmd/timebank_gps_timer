import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'exercise3_job_data.dart';

class Exercise3SaveOffline extends StatefulWidget {
  const Exercise3SaveOffline({super.key});

  @override
  State<Exercise3SaveOffline> createState() => _Exercise3SaveOfflineState();
}

class _Exercise3SaveOfflineState extends State<Exercise3SaveOffline> {
  late Box<JobData> _jobBox;
  String _statusText = "No data saved yet";

  @override
  void initState() {
    super.initState();
    _jobBox = Hive.box<JobData>('jobsBox');
    _loadSavedData();
  }

  void _loadSavedData() {
    if (_jobBox.isNotEmpty) {
      final lastJob = _jobBox.values.last;
      setState(() {
        _statusText = "Last saved: ${lastJob.toString()}";
      });
    }
  }

  Future<void> _saveJobData() async {
    // In the real app these values come from LocationService.
    // For this exercise, we use dummy/fixed values so it works standalone.
    final newJob = JobData(
      jobId: "job_${DateTime.now().millisecondsSinceEpoch}",
      startTime: DateTime.now().toIso8601String(),
      latitude: 37.4219999,
      longitude: -122.0840575,
    );

    await _jobBox.add(newJob);

    setState(() {
      _statusText = "Saved: ${newJob.toString()}";
    });

    // ignore: avoid_print
    print(newJob.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Exercise 3: Save Offline")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(_statusText, textAlign: TextAlign.center),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _saveJobData,
                child: const Text("Start (Save Job Data)"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}