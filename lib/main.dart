import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'exercise3_job_data.dart';
import 'exercise3_save_offline.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(JobDataAdapter());
  await Hive.openBox<JobData>('jobsBox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Exercise3SaveOffline(),
    );
  }
}