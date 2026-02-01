import 'package:raac/features/driver/models/driver_model.dart';

class MockAdminService {
  final List<Driver> _drivers = [
    Driver(id: 'driver_001', fullName: 'Driver Ali', phoneNumber: '+254711111111'),
    Driver(id: 'driver_002', fullName: 'Driver Omar', phoneNumber: '+254722222222'),
  ];

  List<Driver> get drivers => _drivers;

  void approveDriver(String driverId) {
    final driver = _drivers.firstWhere((d) => d.id == driverId);
    driver.approved = true;
  }

  void suspendDriver(String driverId) {
    final driver = _drivers.firstWhere((d) => d.id == driverId);
    driver.suspended = true;
    driver.online = false;
  }

  void unsuspendDriver(String driverId) {
    final driver = _drivers.firstWhere((d) => d.id == driverId);
    driver.suspended = false;
  }
}
