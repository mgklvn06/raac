import 'package:flutter/material.dart';
import '../../rides/ride_state.dart';

class PassengerHome extends StatelessWidget {
  final RideState rideState;

  const PassengerHome({super.key, required this.rideState});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Passenger')),
      body: Center(
        child: ElevatedButton(
          child: const Text('Request Ride'),
          onPressed: () {
            rideState.requestRide(
              from: 'Section A',
              to: 'Section B',
              price: 100,
            );
          },
        ),
      ),
    );
  }
}
