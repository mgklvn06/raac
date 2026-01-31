import '../../shared/enums/user_role.dart';
import '../auth/role_service.dart';

class MockRoleService implements RoleService {
  @override
  Future<UserRole> getUserRole(String uid) async {
    // CHANGE HERE to test flows
    return UserRole.passenger;
    // return UserRole.driver;
    // return UserRole.admin;
  }
}
