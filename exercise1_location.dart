import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class Exercise1Location extends StatefulWidget {
  const Exercise1Location({super.key});

  @override
  State<Exercise1Location> createState() => _Exercise1LocationState();
}

class _Exercise1LocationState extends State<Exercise1Location> {
  String _resultText = "Press the button to get your location";
  bool _isLoading = false;

  Future<void> _getCurrentLocation() async {
    setState(() {
      _isLoading = true;
      _resultText = "Getting location...";
    });

    try {
      // Step 1: Check if location services (GPS) are turned on at all
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() {
          _resultText = "Location services are OFF. Please turn on GPS.";
          _isLoading = false;
        });
        return;
      }

      // Step 2: Check current permission status
      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        // Ask the user for permission
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          setState(() {
            _resultText = "Location permission was denied.";
            _isLoading = false;
          });
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        setState(() {
          _resultText =
              "Location permission is permanently denied. Enable it in phone Settings.";
          _isLoading = false;
        });
        return;
      }

      // Step 3: Permission granted — actually get the location
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        _resultText =
            "Latitude: ${position.latitude}\nLongitude: ${position.longitude}";
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _resultText = "Error getting location: $e";
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Exercise 1: GPS Location")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _resultText,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 24),
              _isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _getCurrentLocation,
                      child: const Text("Get My Location"),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}