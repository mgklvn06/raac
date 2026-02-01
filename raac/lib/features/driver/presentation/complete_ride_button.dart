import 'package:flutter/material.dart';

class CompleteRideButton extends StatelessWidget {
  final VoidCallback onComplete;

  const CompleteRideButton({super.key, required this.onComplete});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onComplete,
      child: const Text('Complete Ride'),
    );
  }
}
