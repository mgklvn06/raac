import 'package:flutter/material.dart';

class DriverHome extends StatefulWidget {
  final MockDriverService driverService;

  const DriverHome({super.key, required this.driverService});

  @override
  State<DriverHome> createState() => _DriverHomeState();
}

class _DriverHomeState extends State<DriverHome> {
  @override
  void initState() {
    super.initState();
    widget.driverService.loadDriver();
  }

  @override
  Widget build(BuildContext context) {
    final driver = widget.driverService.currentDriver;

    if (driver == null) {
      return const Scaffold(
        body: Center(child: Text('Loading driver...')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Driver Dashboard')),
      body: Column(
        children: [
          Text('Name: ${driver.fullName}'),
          Text('Status: ${driver.online ? "Online" : "Offline"}'),
          const SizedBox(height: 16),

          if (!driver.approved)
            const Text('Waiting for approval', style: TextStyle(color: Colors.red)),

          if (driver.suspended)
            const Text('Account suspended', style: TextStyle(color: Colors.red)),

          ElevatedButton(
            onPressed: driver.online
                ? widget.driverService.goOffline
                : (widget.driverService.canGoOnline()
                    ? widget.driverService.goOnline
                    : null),
            child: Text(driver.online ? 'Go Offline' : 'Go Online'),
          ),
          ElevatedButton(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PassengerRideHistoryScreen(rideService: rideService),
      ),
    );
  },
  child: const Text('View Ride History'),
)

        ],
      ),
    );
  }
}
