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

  void acceptRide(String s) {}

  void requestRide({required String from, required String to, required int price}) {}
}
