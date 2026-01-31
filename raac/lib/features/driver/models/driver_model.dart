class Driver {
  final String id;
  final String fullName;
  final String phoneNumber;

  bool approved;
  bool suspended;
  bool online;

  Driver({
    required this.id,
    required this.fullName,
    required this.phoneNumber,
    this.approved = false,
    this.suspended = false,
    this.online = false,
  });
}
