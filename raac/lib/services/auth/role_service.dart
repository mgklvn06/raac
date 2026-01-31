import '../../shared/enums/user_role.dart';

abstract class RoleService {
  Future<UserRole> getUserRole(String uid);
}
