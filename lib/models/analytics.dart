class AnalyticsModel {
  int? totalCompletedBookings;
  double? totalHoursInCompletedBookings;
  double? averageHoursPerBooking;
  int? bookingsCompletedLast15Days;
  int? assignedBookings;
  int? totalCustomersServed;

  AnalyticsModel(
      {this.totalCompletedBookings,
      this.totalHoursInCompletedBookings,
      this.averageHoursPerBooking,
      this.bookingsCompletedLast15Days,
      this.assignedBookings,
      this.totalCustomersServed});

  AnalyticsModel.fromJson(Map<String, dynamic> json) {
    totalCompletedBookings = json['total_completed_bookings'];
    totalHoursInCompletedBookings = json['total_hours_in_completed_bookings'];
    averageHoursPerBooking = json['average_hours_per_booking'];
    bookingsCompletedLast15Days = json['bookings_completed_last_15_days'];
    assignedBookings = json['assigned_bookings'];
    totalCustomersServed = json['total_customers_served'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_completed_bookings'] = totalCompletedBookings;
    data['total_hours_in_completed_bookings'] = totalHoursInCompletedBookings;
    data['average_hours_per_booking'] = averageHoursPerBooking;
    data['bookings_completed_last_15_days'] = bookingsCompletedLast15Days;
    data['assigned_bookings'] = assignedBookings;
    data['total_customers_served'] = totalCustomersServed;
    return data;
  }
}
