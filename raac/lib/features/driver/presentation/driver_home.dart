import 'package:flutter/material.dart';
import '../../rides/ride_state.dart';
import '../../../shared/enums/ride_status.dart';

class DriverHome extends StatelessWidget {
  final RideState rideState;

  const DriverHome({super.key, required this.rideState});

  @override
  Widget build(BuildContext context) {
    final ride = rideState.activeRide;

    return Scaffold(
      appBar: AppBar(title: const Text('Driver')),
      body: Center(
        child: ride != null && ride.status == RideStatus.accepted
            ? ElevatedButton(
                onPressed: rideState.completeRide,
                child: const Text('Complete Ride'),
              )
            : const Text('Waiting for rides'),
      ),
    );
  }
}
