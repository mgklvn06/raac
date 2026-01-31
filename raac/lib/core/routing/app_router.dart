import 'package:flutter/material.dart';
import '../../shared/enums/user_role.dart';
import '../../services/auth/role_service.dart';

import '../../features/passenger/presentation/request_ride_screen.dart';
import '../../features/driver/presentation/driver_home.dart';
import '../../features/admin/presentation/admin_dashboard.dart';

class AppRouter {
  final RoleService roleService;

  AppRouter({required this.roleService});

  Future<Widget> resolveHome(String uid) async {
    final role = await roleService.getUserRole(uid);

    switch (role) {
      case UserRole.passenger:
        return const RequestRideScreen();
      case UserRole.driver:
        return const DriverHome();
      case UserRole.admin:
        return const AdminDashboard();
    }
  }
}
