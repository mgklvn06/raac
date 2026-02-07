import 'package:flutter/material.dart';
import 'package:raac/features/driver/driver_state.dart';
import 'package:raac/features/rides/models/ride_model.dart';
import 'package:raac/shared/enums/ride_status.dart';


class RideState extends ChangeNotifier {
  Ride? activeRide;
  final List<Ride> history = [];

  final DriverState driverState;

  RideState({required this.driverState});

  // existing methods omitted for clarity

  void completeRide() {
    if (activeRide == null) return;

    final completed = activeRide!.copyWith(status: RideStatus.completed);
    history.add(completed);

    driverState.onRideCompleted(completed);

    activeRide = null;
    notifyListeners();
  }

  void acceptRide(String driverId) {
    if (activeRide == null) {
      requestRide(from: 'Hagadera Section B', to: 'Market Area', price: 150);
    }
    activeRide = activeRide!.copyWith(
      status: RideStatus.accepted,
      driverId: driverId,
      driverName: 'Driver Ali',
      driverPhone: '+254711111111',
    );
    notifyListeners();
  }

  void requestRide({
    required String from,
    required String to,
    required int price,
  }) {
    activeRide = Ride(
      id: 'ride_demo',
      from: from,
      to: to,
      price: price,
      status: RideStatus.requested,
      passengerName: 'Passenger One',
      passengerPhone: '+254700000000',
      fromSection: from,
      toSection: to,
    );
    notifyListeners();
  }
}
