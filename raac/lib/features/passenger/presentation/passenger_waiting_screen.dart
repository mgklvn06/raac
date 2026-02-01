import 'package:flutter/material.dart';
import 'package:raac/services/mock/mock_ride_service.dart';
import 'package:raac/shared/enums/ride_status.dart';

class PassengerWaitingScreen extends StatelessWidget {
  final MockRideService rideService;

  const PassengerWaitingScreen({super.key, required this.rideService});

  @override
  Widget build(BuildContext context) {
    final ride = rideService.activeRide;

    return Scaffold(
      appBar: AppBar(title: const Text('Finding Driver')),
      body: ride == null
          ? const Text('No active ride')
          : Column(
              children: [
                Text('Status: ${ride.status.name}'),
                if (ride.status == RideStatus.accepted)
                  Column(
                    children: [
                      Text('Driver: ${ride.driverName}'),
                      Text('Phone: ${ride.driverPhone}'),
                    ],
                  ),
              ],
            ),
    );
  }
}
