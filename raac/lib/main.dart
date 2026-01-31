void main() {
  final roleService = MockRoleService();
  final rideService = MockRideService();
  final driverService = MockDriverService();
  driverService.loadDriver();
  final adminService = MockAdminService();

  final router = AppRouter(roleService: roleService);

  runApp(RAACApp(
    router: router,
    rideService: rideService,
    driverService: driverService,
    adminService: adminService,
  ));
}
