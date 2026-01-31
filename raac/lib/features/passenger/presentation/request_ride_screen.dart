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
                  status: RideStatus.requested,
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
