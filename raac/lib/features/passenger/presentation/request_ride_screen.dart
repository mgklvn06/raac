import 'package:flutter/material.dart';
import 'package:raac/features/passenger/presentation/passenger_waiting_screen.dart';
import 'package:raac/features/rides/models/ride_model.dart';
import 'package:raac/services/mock/mock_ride_service.dart';
import 'package:raac/shared/enums/ride_status.dart';

class RequestRideScreen extends StatelessWidget {
  final MockRideService rideService;

  const RequestRideScreen({super.key, required this.rideService});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Request Ride')),
      body: Column(
        children: [
          const Text('From: Section A'),
          const Text('To: Section D'),
          const Text('Price: KSh 250'),
          ElevatedButton(
            onPressed: () {
              rideService.requestRide(
                Ride(
                  id: 'ride_001',
                  passengerName: 'Passenger One',
                  passengerPhone: '+254700000000',
                  fromSection: 'Section A',
                  toSection: 'Section D',
                  price: 250,
                  status: RideStatus.requested, from: '', to: '',
                ),
              );
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      PassengerWaitingScreen(rideService: rideService),
                ),
              );
            },
            child: const Text('Request Ride'),
          )
        ],
      ),
    );
  }
}
