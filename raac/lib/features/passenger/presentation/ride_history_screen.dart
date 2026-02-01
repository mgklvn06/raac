import 'package:flutter/material.dart';
import '../../rides/ride_state.dart';

class RideHistoryScreen extends StatelessWidget {
  final RideState rideState;

  const RideHistoryScreen({super.key, required this.rideState});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ride History')),
      body: ListView.builder(
        itemCount: rideState.history.length,
        itemBuilder: (_, i) {
          final ride = rideState.history[i];
          return ListTile(
            title: Text('${ride.from} → ${ride.to}'),
            subtitle: Text('KSh ${ride.price}'),
          );
        },
      ),
    );
  }
}
