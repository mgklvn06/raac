import '../models/ride_model.dart';

class MockRideService {
  Ride? _activeRide;
  final List<Ride> _rideHistory = [];

  Ride? get activeRide => _activeRide;

  List<Ride> getRideHistory({bool completedOnly = true}) {
    if (completedOnly) {
      return _rideHistory.where((r) => r.status == RideStatus.completed).toList();
    }
    return _rideHistory;
  }

  void requestRide(Ride ride) {
    _activeRide = ride;
  }

  void acceptRide({required String driverName, required String driverPhone}) {
    if (_activeRide == null) return;
    _activeRide!
      ..status = RideStatus.accepted
      ..driverName = driverName
      ..driverPhone = driverPhone;
  }

  void completeRide() {
    if (_activeRide == null) return;
    _activeRide!.status = RideStatus.completed;
    _rideHistory.add(_activeRide!);
    _activeRide = null;
  }

  void cancelRide() {
    _activeRide = null;
  }
}
