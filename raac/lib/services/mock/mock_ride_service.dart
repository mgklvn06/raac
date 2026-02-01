import 'package:raac/features/rides/models/ride_model.dart';
import 'package:raac/shared/enums/ride_status.dart';


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
    // Ride.status is final and cannot be reassigned here; only update mutable fields.
    _activeRide!
      ..driverName = driverName
      ..driverPhone = driverPhone;
  }

  void completeRide() {
    if (_activeRide == null) return;
    final completed = _activeRide!.copyWith(status: RideStatus.completed);
    _rideHistory.add(completed);
    _activeRide = null;
  }

  void cancelRide() {
    _activeRide = null;
  }
}
