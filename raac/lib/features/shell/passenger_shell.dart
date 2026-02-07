import 'package:flutter/material.dart';
import '../../services/mock/mock_ride_service.dart';
import '../passenger/presentation/request_ride_screen.dart';
import '../passenger/presentation/passenger_history_screen.dart';
import '../settings/presentation/settings_view.dart';

class PassengerShell extends StatefulWidget {
  final MockRideService rideService;

  const PassengerShell({super.key, required this.rideService});

  @override
  State<PassengerShell> createState() => _PassengerShellState();
}

class _PassengerShellState extends State<PassengerShell> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final titles = ['Home', 'Ride History', 'Settings'];
    final subtitles = [
      'Where are you headed today?',
      'Your recent trips',
      'Manage your account',
    ];

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 72,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              titles[_index],
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(
              subtitles[_index],
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
            ),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notifications_none_rounded),
            ),
          ),
        ],
      ),
      body: IndexedStack(
        index: _index,
        children: [
          RequestRideView(rideService: widget.rideService),
          PassengerHistoryView(rideService: widget.rideService),
          const SettingsView(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (value) => setState(() => _index = value),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.receipt_long_rounded),
            label: 'History',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_rounded),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
