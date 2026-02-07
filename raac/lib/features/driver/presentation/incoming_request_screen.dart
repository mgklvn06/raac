// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../../rides/ride_state.dart';
import '../../../shared/enums/ride_status.dart';

class IncomingRequestScreen extends StatelessWidget {
  final RideState rideState;

  const IncomingRequestScreen({super.key, required this.rideState});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final ride = rideState.activeRide;
    final isDemo = ride == null || ride.status != RideStatus.requested;

    if (isDemo) {
      rideState.requestRide(from: 'Town Stage', to: 'Hostel C', price: 120);
    }

    final activeRide = rideState.activeRide;

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
      children: [
        Card(
          margin: EdgeInsets.zero,
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Incoming request',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 12),
                Text(
                  '${activeRide?.from ?? 'Town Stage'} -> ${activeRide?.to ?? 'Hostel C'}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 6),
                Text(
                  'Fare: KSh ${activeRide?.price ?? 120}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: colors.primary.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.timer, color: colors.primary),
                      const SizedBox(width: 10),
                      Text(
                        'Pickup in 4-6 min',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {},
                        child: const Text('Decline'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: FilledButton(
                        onPressed: () {
                          rideState.acceptRide('driver-001');
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Ride accepted')),
                          );
                        },
                        child: const Text('Accept'),
                      ),
                    ),
                  ],
                ),
                if (isDemo)
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Text(
                      'Showing demo request data.',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
