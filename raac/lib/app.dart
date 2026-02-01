import 'package:flutter/material.dart';
import 'package:raac/core/routing/app_router.dart';
import 'package:raac/services/mock/mock_admin_service.dart';
import 'package:raac/services/mock/mock_driver_service.dart';
import 'package:raac/services/mock/mock_ride_service.dart';

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
      home: FutureBuilder<Object>(
        future: router.resolveHome("mockUid"),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const CircularProgressIndicator();
          final home = snapshot.data as Widget;

          // Pass mock services to home screens as needed
          return home;
        },
      ),
    );
  }
}
