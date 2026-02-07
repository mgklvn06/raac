import 'package:flutter/material.dart';
import '../driver/driver_state.dart';
import '../rides/ride_state.dart';
import '../driver/presentation/driver_home.dart';
import '../driver/presentation/incoming_request_screen.dart';
import '../driver/presentation/earnings_screen.dart';

class DriverShell extends StatefulWidget {
  final DriverState? driverState;
  final RideState? rideState;

  const DriverShell({super.key, this.driverState, this.rideState});

  @override
  State<DriverShell> createState() => _DriverShellState();
}

class _DriverShellState extends State<DriverShell> {
  late final DriverState _driverState =
      widget.driverState ?? DriverState();
  late final RideState _rideState =
      widget.rideState ?? RideState(driverState: _driverState);
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final titles = ['Driver Home', 'Incoming', 'Earnings'];
    final subtitles = [
      'Status + availability',
      'New ride requests',
      'Weekly totals',
    ];

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 72,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(titles[_index], style: Theme.of(context).textTheme.titleLarge),
            Text(
              subtitles[_index],
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
      body: IndexedStack(
        index: _index,
        children: [
          DriverHome(rideState: _rideState, driverState: _driverState),
          IncomingRequestScreen(rideState: _rideState),
          EarningsScreen(driverState: _driverState),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (value) => setState(() => _index = value),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.dashboard_rounded),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.notifications_active_rounded),
            label: 'Requests',
          ),
          NavigationDestination(
            icon: Icon(Icons.account_balance_wallet_rounded),
            label: 'Earnings',
          ),
        ],
      ),
    );
  }
}
