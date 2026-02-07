// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:raac/features/passenger/presentation/ride_summary_screen.dart';
import 'package:raac/features/passenger/models/ride_history_item.dart';
import 'package:raac/features/rides/models/ride_model.dart';
import 'package:raac/shared/enums/ride_status.dart';
import 'package:raac/services/mock/mock_ride_service.dart';

class PassengerHistoryView extends StatelessWidget {
  final MockRideService rideService;

  const PassengerHistoryView({super.key, required this.rideService});

  @override
  Widget build(BuildContext context) {
    final items = _mockHistory();
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
      itemCount: items.length,
      separatorBuilder: (_, _) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final item = items[index];
        return InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => RideSummaryScreen(item: item),
              ),
            );
          },
          child: Ink(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 14,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    height: 52,
                    width: 52,
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(
                      Icons.local_taxi_rounded,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${item.ride.from} -> ${item.ride.to}',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${item.prettyDate} • ${item.ride.status.name.toUpperCase()}',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'KSh ${item.ride.price}',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item.driverName,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  List<RideHistoryItem> _mockHistory() {
    final items = [
      RideHistoryItem(
        ride: Ride(
          id: 'ride_101',
          from: 'Hagadera Section B',
          to: 'Market Area',
          price: 150,
          status: RideStatus.completed,
          passengerName: 'Passenger One',
          passengerPhone: '+254700000000',
          fromSection: 'Hagadera Section B',
          toSection: 'Market Area',
          driverName: 'Ahmed Noor',
          driverPhone: '+254711444555',
        ),
        dateTime: DateTime.now().subtract(const Duration(hours: 3)),
        driverName: 'Ahmed Noor',
        plate: 'KDA 219Y',
      ),
      RideHistoryItem(
        ride: Ride(
          id: 'ride_102',
          from: 'Town Stage',
          to: 'Hostel C',
          price: 120,
          status: RideStatus.completed,
          passengerName: 'Passenger One',
          passengerPhone: '+254700000000',
          fromSection: 'Town Stage',
          toSection: 'Hostel C',
          driverName: 'Zainab Ali',
          driverPhone: '+254711000111',
        ),
        dateTime: DateTime.now().subtract(const Duration(days: 1, hours: 2)),
        driverName: 'Zainab Ali',
        plate: 'KCC 441Q',
      ),
      RideHistoryItem(
        ride: Ride(
          id: 'ride_103',
          from: 'Library',
          to: 'Faculty Gate',
          price: 90,
          status: RideStatus.completed,
          passengerName: 'Passenger One',
          passengerPhone: '+254700000000',
          fromSection: 'Library',
          toSection: 'Faculty Gate',
          driverName: 'Hussein Omar',
          driverPhone: '+254711222333',
        ),
        dateTime: DateTime.now().subtract(const Duration(days: 2, hours: 5)),
        driverName: 'Hussein Omar',
        plate: 'KDE 602M',
      ),
    ];

    final completed = rideService.getRideHistory(completedOnly: true);
    for (final ride in completed) {
      items.insert(
        0,
        RideHistoryItem(
          ride: ride,
          dateTime: DateTime.now().subtract(const Duration(hours: 1)),
          driverName: ride.driverName ?? 'Assigned driver',
          plate: 'KDE 602M',
        ),
      );
    }

    return items;
  }
}
