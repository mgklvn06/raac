import 'package:flutter/material.dart';
import 'package:raac/app.dart';
import 'package:raac/core/routing/app_router.dart';
import 'package:raac/services/mock/mock_admin_service.dart';
import 'package:raac/services/mock/mock_driver_service.dart';
import 'package:raac/services/mock/mock_ride_service.dart';
import 'package:raac/services/mock/mock_role_service.dart';

void main() {
  final roleService = MockRoleService();
  final rideService = MockRideService();
  final driverService = MockDriverService();
  driverService.loadDriver();
  final adminService = MockAdminService();

  final router = AppRouter(roleService: roleService, rideService: rideService);

  runApp(RAACApp(
    router: router,
    rideService: rideService,
    driverService: driverService,
    adminService: adminService,
  ) as Widget);
}
