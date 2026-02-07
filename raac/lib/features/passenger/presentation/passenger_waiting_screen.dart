// ignore_for_file: deprecated_member_use

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:raac/features/passenger/presentation/ride_summary_screen.dart';
import 'package:raac/services/mock/mock_ride_service.dart';
import 'package:raac/shared/enums/ride_status.dart';
import 'package:raac/features/rides/models/ride_model.dart';
import 'package:raac/features/passenger/models/ride_history_item.dart';

class PassengerWaitingScreen extends StatefulWidget {
  final MockRideService rideService;

  const PassengerWaitingScreen({super.key, required this.rideService});

  @override
  State<PassengerWaitingScreen> createState() => _PassengerWaitingScreenState();
}

class _PassengerWaitingScreenState extends State<PassengerWaitingScreen> {
  Timer? _timer;
  bool _notified = false;

  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(milliseconds: 1400), _simulateAccept);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _simulateAccept() {
    final ride = widget.rideService.activeRide;
    if (ride == null || ride.status != RideStatus.requested) return;
    widget.rideService.acceptRide(
      driverName: 'Asha Mwangi',
      driverPhone: '+254711222334',
    );
    if (mounted) {
      setState(() {});
      _showSnack('Driver found! Asha is on the way.');
    }
  }

  void _showSnack(String message) {
    if (_notified) return;
    _notified = true;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  RideHistoryItem _buildSummary(Ride ride) {
    return RideHistoryItem(
      ride: ride,
      dateTime: DateTime.now(),
      driverName: ride.driverName ?? 'Driver assigned',
      plate: 'KDA 219Y',
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final ride = widget.rideService.activeRide;

    return Scaffold(
      appBar: AppBar(title: const Text('Finding a Driver')),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  colors.surface,
                  colors.surface.withOpacity(0.9),
                  colors.primary.withOpacity(0.05),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
              child: ride == null
                  ? _EmptyRideCard(onClose: () => Navigator.pop(context))
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Matching you with the best driver nearby',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Status: ${ride.status.name.toUpperCase()}',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 18),
                        Card(
                          margin: EdgeInsets.zero,
                          child: Padding(
                            padding: const EdgeInsets.all(18),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.route, color: colors.primary),
                                    const SizedBox(width: 10),
                                    Text(
                                      '${ride.from.isNotEmpty ? ride.from : ride.fromSection} -> ${ride.to.isNotEmpty ? ride.to : ride.toSection}',
                                      style:
                                          Theme.of(context).textTheme.titleMedium,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                Row(
                                  children: [
                                    _InfoPill(
                                      label: 'Price',
                                      value: 'KSh ${ride.price}',
                                    ),
                                    const SizedBox(width: 10),
                                    _InfoPill(
                                      label: 'ETA',
                                      value: '6-9 min',
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: LinearProgressIndicator(
                                    value: ride.status == RideStatus.accepted
                                        ? 1
                                        : 0.6,
                                    minHeight: 8,
                                    backgroundColor:
                                        colors.primary.withOpacity(0.1),
                                    color: colors.primary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 18),
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 350),
                          child: ride.status == RideStatus.accepted
                              ? _DriverCard(
                                  key: const ValueKey('driver'),
                                  name: ride.driverName ?? 'Driver assigned',
                                  phone: ride.driverPhone ?? 'Pending contact',
                                )
                              : _SearchingCard(
                                  key: const ValueKey('searching'),
                                ),
                        ),
                        const Spacer(),
                        if (ride.status == RideStatus.accepted)
                          FilledButton.icon(
                            onPressed: () {
                              final summary = _buildSummary(ride);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      RideSummaryScreen(item: summary),
                                ),
                              );
                            },
                            icon: const Icon(Icons.receipt_long_rounded),
                            label: const Text('View ride summary'),
                          )
                        else
                          OutlinedButton.icon(
                            onPressed: () {
                              widget.rideService.cancelRide();
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.close),
                            label: const Text('Cancel ride'),
                          ),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoPill extends StatelessWidget {
  final String label;
  final String value;

  const _InfoPill({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.12),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: Theme.of(context).textTheme.bodyMedium),
          Text(value, style: Theme.of(context).textTheme.titleMedium),
        ],
      ),
    );
  }
}

class _SearchingCard extends StatelessWidget {
  const _SearchingCard({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          children: [
            Container(
              height: 44,
              width: 44,
              decoration: BoxDecoration(
                color: colors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(Icons.radar, color: colors.primary),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'Searching for drivers in your area...',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DriverCard extends StatelessWidget {
  final String name;
  final String phone;

  const _DriverCard({super.key, required this.name, required this.phone});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          children: [
            Container(
              height: 52,
              width: 52,
              decoration: BoxDecoration(
                color: colors.primary.withOpacity(0.12),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(Icons.person, color: colors.primary),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: Theme.of(context).textTheme.titleMedium),
                  Text(phone, style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
            ),
            Icon(Icons.call, color: colors.primary),
          ],
        ),
      ),
    );
  }
}

class _EmptyRideCard extends StatelessWidget {
  final VoidCallback onClose;

  const _EmptyRideCard({required this.onClose});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 18),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'No active ride found',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Text(
                'Start a new request from the home screen.',
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: onClose,
                child: const Text('Back to home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
