import 'package:flutter/material.dart';
import 'package:raac/features/driver/models/weekly_fee_model.dart';
import 'package:raac/features/rides/models/ride_model.dart';
import '../../../core/config/app_constants.dart';
import '../../../core/utils/date_utils.dart';

class DriverState extends ChangeNotifier {
  bool online = false;
  bool suspended = false;

  int totalEarnings = 0;

  /// weekId → WeeklyFee
  final Map<String, WeeklyFee> weeklyFees = {};

  Null get currentWeekFee => null;

  // -------------------
  // Ride Completion Hook
  // -------------------
  void onRideCompleted(Ride ride) {
    final weekId = DateUtilsHelper.currentWeekId();

    weeklyFees.putIfAbsent(
      weekId,
      () => WeeklyFee(weekId: weekId, amount: 0),
    );

    weeklyFees[weekId]!.amount += AppConstants.platformFee;

    totalEarnings += (ride.price - AppConstants.platformFee);

    notifyListeners();
  }

  // -------------------
  // Weekly Enforcement
  // -------------------
  void enforceWeeklyPayment() {
    for (final fee in weeklyFees.values) {
      if (!fee.paid && fee.amount > 0) {
        suspendDriver();
        break;
      }
    }
  }

  // -------------------
  // Admin Actions
  // -------------------
  void markWeekAsPaid(String weekId) {
    if (weeklyFees.containsKey(weekId)) {
      weeklyFees[weekId]!.paid = true;
      reactivateDriver();
      notifyListeners();
    }
  }

  // -------------------
  // Driver State Changes
  // -------------------
  void suspendDriver() {
    suspended = true;
    online = false;
    notifyListeners();
  }

  void reactivateDriver() {
    suspended = false;
    notifyListeners();
  }

  void toggleOnline() {
    if (!suspended) {
      online = !online;
      notifyListeners();
    }
  }

  void getCurrentWeekFee() {}
}
