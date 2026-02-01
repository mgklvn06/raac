abstract class AuthService {
  Future<String?> signInWithPhone(String phone);
  Future<void> signOut();
  String? get currentUserId;
}
