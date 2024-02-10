class NotesModel {
  int? id;
  String? bookingNotes;
  String? recurrenceNotes;
  String? operationsNotes;
  String? recurrenceOperationsNotes;
  String? adminOnlyNotes;
  String? cleanerNotes;
  String? createdAt;
  String? updatedAt;
  String? booking;

  NotesModel({this.id, this.bookingNotes, this.recurrenceNotes, this.operationsNotes, this.recurrenceOperationsNotes, this.adminOnlyNotes, this.cleanerNotes, this.createdAt, this.updatedAt, this.booking});

  NotesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bookingNotes = json['booking_notes'];
    recurrenceNotes = json['recurrence_notes'];
    operationsNotes = json['operations_notes'];
    recurrenceOperationsNotes = json['recurrence_operations_notes'];
    adminOnlyNotes = json['admin_only_notes'];
    cleanerNotes = json['cleaner_notes'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    booking = json['booking'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['booking_notes'] = bookingNotes;
    data['recurrence_notes'] = recurrenceNotes;
    data['operations_notes'] = operationsNotes;
    data['recurrence_operations_notes'] = recurrenceOperationsNotes;
    data['admin_only_notes'] = adminOnlyNotes;
    data['cleaner_notes'] = cleanerNotes;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['booking'] = booking;
    return data;
  }
}
