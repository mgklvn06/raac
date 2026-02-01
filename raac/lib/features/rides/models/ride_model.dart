import '../../../shared/enums/ride_status.dart';

class Ride {
  final String id;
  final String from;
  final String to;
  final int price;
  final RideStatus status;
  final String? driverId;

  Ride({
    required this.id,
    required this.from,
    required this.to,
    required this.price,
    required this.status,
    this.driverId, required String passengerName, required String passengerPhone, required String fromSection, required String toSection,
  });

  Null get driverName => null;

  Null get driverPhone => null;

  set driverPhone(String driverPhone) {}

  set driverName(String driverName) {}

  Ride copyWith({
    RideStatus? status,
    String? driverId,
  }) {
    return Ride(
      id: id,
      from: from,
      to: to,
      price: price,
      status: status ?? this.status,
      driverId: driverId ?? this.driverId, passengerName: '', passengerPhone: '', fromSection: '', toSection: '',
    );
  }
}
