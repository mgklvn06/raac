// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:raac/features/passenger/presentation/passenger_waiting_screen.dart';
import 'package:raac/features/rides/models/ride_model.dart';
import 'package:raac/services/mock/mock_ride_service.dart';
import 'package:raac/shared/enums/ride_status.dart';

class RequestRideScreen extends StatelessWidget {
  final MockRideService rideService;

  const RequestRideScreen({super.key, required this.rideService});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Request Ride')),
      body: RequestRideView(rideService: rideService),
    );
  }
}

class RequestRideView extends StatefulWidget {
  final MockRideService rideService;

  const RequestRideView({super.key, required this.rideService});

  @override
  State<RequestRideView> createState() => _RequestRideViewState();
}

class _RequestRideViewState extends State<RequestRideView> {
  bool _isRequesting = false;

  Future<void> _handleRequest() async {
    if (_isRequesting) return;
    setState(() => _isRequesting = true);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Ride request sent')),
    );
    await Future.delayed(const Duration(milliseconds: 600));
    if (!mounted) return;
    widget.rideService.requestRide(
      Ride(
        id: 'ride_001',
        passengerName: 'Passenger One',
        passengerPhone: '+254700000000',
        fromSection: 'Section A',
        toSection: 'Section D',
        from: 'Section A',
        to: 'Section D',
        price: 250,
        status: RideStatus.requested,
      ),
    );
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            PassengerWaitingScreen(rideService: widget.rideService),
      ),
    );
    if (mounted) {
      setState(() => _isRequesting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Stack(
      children: [
        const _PassengerBackground(),
        SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 6),
                Card(
                  margin: EdgeInsets.zero,
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Where to?',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 14),
                        _LocationRow(
                          icon: Icons.my_location,
                          label: 'Section A',
                          caption: 'Pickup',
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          child: Divider(height: 1),
                        ),
                        _LocationRow(
                          icon: Icons.place,
                          label: 'Section D',
                          caption: 'Drop-off',
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
                                'ETA: 6-9 min',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
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
                          'Trip summary',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: _SummaryTile(
                                label: 'Distance',
                                value: '3.2 km',
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _SummaryTile(
                                label: 'Price',
                                value: 'KSh 250',
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Prices are fixed by admin and include platform fees.',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                Text(
                  'Quick destinations',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: const [
                    _QuickChip(label: 'Main Gate'),
                    _QuickChip(label: 'Hostel B'),
                    _QuickChip(label: 'Library'),
                    _QuickChip(label: 'Cafeteria'),
                  ],
                ),
                const SizedBox(height: 26),
                FilledButton.icon(
                  onPressed: _isRequesting ? null : _handleRequest,
                  icon: _isRequesting
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Icon(Icons.rocket_launch_rounded),
                  label: Text(_isRequesting ? 'Requesting...' : 'Request Ride'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _PassengerBackground extends StatelessWidget {
  const _PassengerBackground();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            colors.surface,
            colors.surface.withOpacity(0.8),
            colors.primary.withOpacity(0.06),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
    );
  }
}

class _LocationRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String caption;

  const _LocationRow({
    required this.icon,
    required this.label,
    required this.caption,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Row(
      children: [
        Container(
          height: 38,
          width: 38,
          decoration: BoxDecoration(
            color: colors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: colors.primary, size: 20),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: Theme.of(context).textTheme.titleMedium),
            Text(caption, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ],
    );
  }
}

class _SummaryTile extends StatelessWidget {
  final String label;
  final String value;

  const _SummaryTile({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: 6),
          Text(value, style: Theme.of(context).textTheme.titleMedium),
        ],
      ),
    );
  }
}

class _QuickChip extends StatelessWidget {
  final String label;

  const _QuickChip({required this.label});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: colors.primary.withOpacity(0.15)),
      ),
      child: Text(label, style: Theme.of(context).textTheme.bodyMedium),
    );
  }
}
