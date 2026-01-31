import 'package:flutter/material.dart';
import '../../rides/data/mock_ride_service.dart';
import '../../rides/models/ride_model.dart';

class PassengerRideHistoryScreen extends StatelessWidget {
  final MockRideService rideService;

  const PassengerRideHistoryScreen({super.key, required this.rideService});

  @override
  Widget build(BuildContext context) {
    final rides = rideService.getRideHistory();

    return Scaffold(
      appBar: AppBar(title: const Text('My Ride History')),
      body: rides.isEmpty
          ? const Center(child: Text('No completed rides yet'))
          : ListView.builder(
              itemCount: rides.length,
              itemBuilder: (context, index) {
                final ride = rides[index];
                return ListTile(
                  title: Text('${ride.fromSection} → ${ride.toSection}'),
                  subtitle: Text(
                      'Driver: ${ride.driverName ?? "-"}\nPrice: KSh ${ride.price}'),
                  trailing: Text(ride.status.name),
                );
              },
            ),
    );
  }
}
