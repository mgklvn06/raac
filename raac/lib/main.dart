import 'package:flutter/material.dart';
import 'package:raac/app.dart';
import 'package:raac/core/routing/app_router.dart';
import 'package:raac/features/driver/driver_state.dart';
import 'package:raac/features/rides/ride_state.dart';
import 'package:raac/services/mock/mock_admin_service.dart';
import 'package:raac/services/mock/mock_ride_service.dart';
import 'package:raac/services/mock/mock_role_service.dart';

void main() {
  final roleService = MockRoleService();
  final rideService = MockRideService();
  final adminService = MockAdminService();
  final driverState = DriverState();
  final rideState = RideState(driverState: driverState);

  final router = AppRouter(
    roleService: roleService,
    rideService: rideService,
    adminService: adminService,
    rideState: rideState,
    driverState: driverState,
  );

  runApp(RAACApp(
    router: router,
  ));
}
