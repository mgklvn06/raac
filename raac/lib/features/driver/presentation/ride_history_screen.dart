import 'package:flutter/material.dart';
import '../../rides/data/mock_ride_service.dart';
import '../../rides/models/ride_model.dart';

class DriverRideHistoryScreen extends StatelessWidget {
  final MockRideService rideService;

  const DriverRideHistoryScreen({super.key, required this.rideService});

  @override
  Widget build(BuildContext context) {
    final rides = rideService.getRideHistory();

    final myRides = rides.where((r) => r.driverName == 'Driver Ali').toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Driver Ride History')),
      body: myRides.isEmpty
          ? const Center(child: Text('No completed rides yet'))
          : ListView.builder(
              itemCount: myRides.length,
              itemBuilder: (context, index) {
                final ride = myRides[index];
                return ListTile(
                  title: Text('${ride.fromSection} → ${ride.toSection}'),
                  subtitle: Text('Passenger: ${ride.passengerName}\nPrice: KSh ${ride.price}'),
                  trailing: Text(ride.status.name),
                );
              },
            ),
    );
  }
}
