class TimeHelper {
  static bool checkDate() {
    DateTime now = DateTime.now();
    DateTime startDate = DateTime(2026, 2, 15);
    DateTime endDate = DateTime(2026, 3, 20);

    return now.isAfter(startDate) && now.isBefore(endDate);
  }
}
