import 'package:flutter/material.dart';
import '../../rides/ride_state.dart';
import '../../../shared/enums/ride_status.dart';

class IncomingRequestScreen extends StatelessWidget {
  final RideState rideState;

  const IncomingRequestScreen({super.key, required this.rideState});

  @override
  Widget build(BuildContext context) {
    final ride = rideState.activeRide;

    if (ride == null || ride.status != RideStatus.requested) {
      return const Center(child: Text('No incoming rides'));
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Incoming Ride')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('${ride.from} → ${ride.to}'),
          Text('Price: KSh ${ride.price}'),
          const SizedBox(height: 20),
          ElevatedButton(
            child: const Text('Accept'),
            onPressed: () {
              rideState.acceptRide('driver-001');
            },
          ),
        ],
      ),
    );
  }
}
