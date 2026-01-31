import 'package:flutter/material.dart';
import '../data/mock_admin_service.dart';
import '../../driver/models/driver_model.dart';

class AdminDashboard extends StatefulWidget {
  final MockAdminService adminService;

  const AdminDashboard({super.key, required this.adminService});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  @override
  Widget build(BuildContext context) {
    final drivers = widget.adminService.drivers;

    return Scaffold(
      appBar: AppBar(title: const Text('Admin Dashboard')),
      body: ListView.builder(
        itemCount: drivers.length,
        itemBuilder: (context, index) {
          final driver = drivers[index];

          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              title: Text(driver.fullName),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Phone: ${driver.phoneNumber}'),
                  Text('Approved: ${driver.approved}'),
                  Text('Suspended: ${driver.suspended}'),
                  Text('Online: ${driver.online}'),
                ],
              ),
              trailing: Wrap(
                spacing: 8,
                children: [
                  if (!driver.approved)
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          widget.adminService.approveDriver(driver.id);
                        });
                      },
                      child: const Text('Approve'),
                    ),
                  if (!driver.suspended)
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          widget.adminService.suspendDriver(driver.id);
                        });
                      },
                      child: const Text('Suspend'),
                    ),
                  if (driver.suspended)
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          widget.adminService.unsuspendDriver(driver.id);
                        });
                      },
                      child: const Text('Unsuspend'),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
