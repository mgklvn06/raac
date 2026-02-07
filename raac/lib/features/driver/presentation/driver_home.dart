// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../../rides/ride_state.dart';
import '../driver_state.dart';
import '../../../shared/enums/ride_status.dart';

class DriverHome extends StatelessWidget {
  final RideState rideState;
  final DriverState driverState;

  const DriverHome({super.key, required this.rideState, required this.driverState});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([rideState, driverState]),
      builder: (context, _) {
        final ride = rideState.activeRide;
        final colors = Theme.of(context).colorScheme;
        return ListView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
          children: [
            Card(
              margin: EdgeInsets.zero,
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Row(
                  children: [
                    Container(
                      height: 54,
                      width: 54,
                      decoration: BoxDecoration(
                        color: colors.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Icon(Icons.person, color: colors.primary),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Driver Ali',
                              style: Theme.of(context).textTheme.titleMedium),
                          Text(
                            driverState.suspended
                                ? 'Account suspended'
                                : driverState.online
                                    ? 'Online and available'
                                    : 'Offline',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                    Switch(
                      value: driverState.online,
                      onChanged: driverState.suspended
                          ? null
                          : (_) => driverState.toggleOnline(),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 18),
            Row(
              children: [
                Expanded(
                  child: _DriverStatCard(
                    title: 'Today\'s Earnings',
                    value: 'KSh ${driverState.totalEarnings}',
                    icon: Icons.account_balance_wallet,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _DriverStatCard(
                    title: 'Weekly Fee',
                    value: 'KSh ${driverState.currentWeekFee}',
                    icon: Icons.request_quote,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            Card(
              margin: EdgeInsets.zero,
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Incoming request',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 12),
                    if (ride == null || ride.status != RideStatus.requested)
                      Text(
                        'No incoming rides yet. Stay online to receive requests.',
                        style: Theme.of(context).textTheme.bodyMedium,
                      )
                    else
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${ride.from} -> ${ride.to}',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Fare: KSh ${ride.price}',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    const SizedBox(height: 14),
                    FilledButton.icon(
                      onPressed: driverState.online
                          ? () {
                              rideState.acceptRide('driver-001');
                            }
                          : null,
                      icon: const Icon(Icons.check_circle_outline),
                      label: const Text('Accept next ride'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _DriverStatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const _DriverStatCard({
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: colors.primary),
            const SizedBox(height: 10),
            Text(title, style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 6),
            Text(value, style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
      ),
    );
  }
}
