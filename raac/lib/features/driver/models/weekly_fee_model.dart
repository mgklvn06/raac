class WeeklyFee {
  final String weekId;
  int amount;
  bool paid;

  WeeklyFee({
    required this.weekId,
    required this.amount,
    this.paid = false,
  });
}
