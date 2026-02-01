import 'package:flutter/material.dart';
import '../driver_state.dart';
import '../../../core/config/app_constants.dart';

class EarningsScreen extends StatelessWidget {
  final DriverState driverState;

  const EarningsScreen({super.key, required this.driverState});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Earnings')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Total Earnings: ${AppConstants.currency} ${driverState.totalEarnings}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 12),
            Text(
              'Platform Fee (This Week): ${AppConstants.currency} ${driverState.currentWeekFee}',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
