import '../../shared/enums/user_role.dart';
import '../../services/auth/role_service.dart';
import '../../services/mock/mock_ride_service.dart';

import '../../features/passenger/presentation/request_ride_screen.dart';
import '../../features/driver/presentation/driver_home.dart';
import '../../features/admin/presentation/admin_dashboard.dart';
class AppRouter {
  final RoleService roleService;
  final MockRideService rideService;

  AppRouter({required this.roleService, required this.rideService});
  
  // ignore: strict_top_level_inference
  get role => null;
  
  // ignore: strict_top_level_inference
  get adminService => null;

    Future<Object> resolveHome(String uid) async {
      switch (role) {
        case UserRole.passenger:
          return RequestRideScreen(rideService: rideService);
        case UserRole.driver:
          return DriverHome(rideState: rideService as dynamic);
        case UserRole.admin:
          return AdminDashboard(adminService: adminService as dynamic);
        default:
          return  AdminDashboard(adminService: adminService as dynamic);
      }
    }
  }
  
