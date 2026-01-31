class RAACApp extends StatelessWidget {
  final AppRouter router;
  final MockRideService rideService;
  final MockDriverService driverService;
  final MockAdminService adminService;

  const RAACApp({
    super.key,
    required this.router,
    required this.rideService,
    required this.driverService,
    required this.adminService,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FutureBuilder<Widget>(
        future: router.resolveHome("mockUid"),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const CircularProgressIndicator();
          final home = snapshot.data!;

          // Pass mock services to home screens as needed
          return home;
        },
      ),
    );
  }
}
