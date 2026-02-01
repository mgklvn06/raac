import 'package:flutter/material.dart';
import '../../driver/driver_state.dart';

class DriversScreen extends StatelessWidget {
  final DriverState driverState;

  const DriversScreen({super.key, required this.driverState});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Drivers & Fees')),
      body: ListView(
        children: driverState.weeklyFees.values.map((fee) {
          return ListTile(
            title: Text('Week ${fee.weekId}'),
            subtitle: Text('Amount: KSh ${fee.amount}'),
            trailing: fee.paid
                ? const Text('PAID', style: TextStyle(color: Colors.green))
                : ElevatedButton(
                    child: const Text('Mark Paid'),
                    onPressed: () {
                      driverState.markWeekAsPaid(fee.weekId);
                    },
                  ),
          );
        }).toList(),
      ),
    );
  }
}

extension on Object? {
  
  
}
