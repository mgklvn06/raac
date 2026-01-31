enum RideStatus { requested, accepted, completed, cancelled }

class Ride {
  final String id;
  final String passengerName;
  final String passengerPhone;

  final String fromSection;
  final String toSection;
  final int price;

  RideStatus status;
  String? driverName;
  String? driverPhone;

  Ride({
    required this.id,
    required this.passengerName,
    required this.passengerPhone,
    required this.fromSection,
    required this.toSection,
    required this.price,
    required this.status,
    this.driverName,
    this.driverPhone,
  });
}
