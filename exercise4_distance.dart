import 'package:geolocator/geolocator.dart';

class DistanceResult {
  final double distanceInMeters;
  final bool isCloseEnough;

  DistanceResult({
    required this.distanceInMeters,
    required this.isCloseEnough,
  });
}

/// Calculates the distance in metres between two GPS points,
/// and whether that distance is within the allowed 400m range.
DistanceResult calculateDistance({
  required double startLatitude,
  required double startLongitude,
  required double endLatitude,
  required double endLongitude,
}) {
  // Geolocator has a built-in formula (Haversine formula) for this —
  // no need to write the math by hand.
  final double distance = Geolocator.distanceBetween(
    startLatitude,
    startLongitude,
    endLatitude,
    endLongitude,
  );

  const double maxAllowedDistance = 400.0;

  return DistanceResult(
    distanceInMeters: distance,
    isCloseEnough: distance <= maxAllowedDistance,
  );
}