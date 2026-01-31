class IncomingRequestScreen extends StatelessWidget {
  final MockRideService rideService;

  const IncomingRequestScreen({super.key, required this.rideService});

  @override
  Widget build(BuildContext context) {
    final ride = rideService.activeRide;

    if (ride == null ||
    ride.status != RideStatus.requested ||
    !driverService.currentDriver!.online) {
  return const Scaffold(
    body: Center(child: Text('No ride requests')),
  );
}


    return Scaffold(
      appBar: AppBar(title: const Text('Incoming Ride')),
      body: Column(
        children: [
          Text('From: ${ride.fromSection}'),
          Text('To: ${ride.toSection}'),
          Text('Price: KSh ${ride.price}'),
          ElevatedButton(
            onPressed: () {
              rideService.acceptRide(
                driverName: 'Driver Ali',
                driverPhone: '+254711111111',
              );
            },
            child: const Text('Accept Ride'),
          ),
        ],
      ),
    );
  }
}
