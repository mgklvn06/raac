import '../../../shared/enums/ride_status.dart';

class Ride {
  final String id;
  final String from;
  final String to;
  final int price;
  final RideStatus status;
  final String? driverId;
  final String passengerName;
  final String passengerPhone;
  final String fromSection;
  final String toSection;
  String? driverName;
  String? driverPhone;

  Ride({
    required this.id,
    required this.from,
    required this.to,
    required this.price,
    required this.status,
    this.driverId,
    required this.passengerName,
    required this.passengerPhone,
    required this.fromSection,
    required this.toSection,
    this.driverName,
    this.driverPhone,
  });

  Ride copyWith({
    RideStatus? status,
    String? driverId,
    String? driverName,
    String? driverPhone,
  }) {
    return Ride(
      id: id,
      from: from,
      to: to,
      price: price,
      status: status ?? this.status,
      driverId: driverId ?? this.driverId,
      passengerName: passengerName,
      passengerPhone: passengerPhone,
      fromSection: fromSection,
      toSection: toSection,
      driverName: driverName ?? this.driverName,
      driverPhone: driverPhone ?? this.driverPhone,
    );
  }
}
