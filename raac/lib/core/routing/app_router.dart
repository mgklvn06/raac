import 'package:flutter/material.dart';
import '../../shared/enums/user_role.dart';
import '../../services/auth/role_service.dart';
import '../../services/mock/mock_admin_service.dart';
import '../../services/mock/mock_ride_service.dart';

import '../../features/shell/passenger_shell.dart';
import '../../features/shell/driver_shell.dart';
import '../../features/admin/presentation/admin_home_screen.dart';
import '../../features/rides/ride_state.dart';
import '../../features/driver/driver_state.dart';

class AppRouter {
  final RoleService roleService;
  final MockRideService rideService;
  final MockAdminService adminService;
  final RideState rideState;
  final DriverState driverState;

  AppRouter({
    required this.roleService,
    required this.rideService,
    required this.adminService,
    required this.rideState,
    required this.driverState,
  });

  Future<Widget> resolveHome(String uid) async {
    final role = await roleService.getUserRole(uid);
    switch (role) {
      case UserRole.passenger:
        return PassengerShell(rideService: rideService);
      case UserRole.driver:
        return DriverShell(
          driverState: driverState,
          rideState: rideState,
        );
      case UserRole.admin:
        return AdminHomeScreen(adminService: adminService);
    }
  }
}
