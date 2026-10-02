import 'package:hive/hive.dart';

part 'exercise3_job_data.g.dart';

@HiveType(typeId: 0)
class JobData extends HiveObject {
  @HiveField(0)
  String jobId;

  @HiveField(1)
  String startTime;

  @HiveField(2)
  double latitude;

  @HiveField(3)
  double longitude;

  JobData({
    required this.jobId,
    required this.startTime,
    required this.latitude,
    required this.longitude,
  });

  @override
  String toString() {
    return "JobData(jobId: $jobId, startTime: $startTime, lat: $latitude, lng: $longitude)";
  }
}