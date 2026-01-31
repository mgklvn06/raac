import '../models/driver_model.dart';

class MockDriverService {
  Driver? _currentDriver;

  Driver? get currentDriver => _currentDriver;

  void loadDriver() {
    _currentDriver = Driver(
      id: 'driver_001',
      fullName: 'Driver Ali',
      phoneNumber: '+254711111111',
      approved: true,
      suspended: false,
      online: false,
    );
  }

  bool canGoOnline() {
    final d = _currentDriver;
    if (d == null) return false;
    return d.approved && !d.suspended;
  }

  void goOnline() {
    if (canGoOnline()) {
      _currentDriver!.online = true;
    }
  }

  void goOffline() {
    if (_currentDriver != null) {
      _currentDriver!.online = false;
    }
  }
}
