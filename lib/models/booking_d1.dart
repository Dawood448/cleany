class AutoGenerate {
  AutoGenerate({
    required this.data,
  });
  late final List<Data> data;

  AutoGenerate.fromJson(Map<String, dynamic> json) {
    data = List.from(json['data']).map((e) => Data.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['data'] = this.data.map((e) => e.toJson()).toList();
    return data;
  }
}

class Data {
  Data({
    required this.id,
    required this.paymentStatus,
    this.dispatchId,
    this.serviceProvider,
    required this.schedule,
    required this.bod,
    required this.outstanding,
    this.collection,
    this.dispatch,
    this.type,
    required this.startTime,
    required this.totalHours,
    required this.totalAmount,
    required this.latestReschedule,
    required this.latestCancel,
    required this.additionalInfo,
    required this.status,
    required this.customerNotes,
    required this.cleanerNotes,
    required this.threeDayReminder,
    required this.oneDayReminder,
    required this.threeHourReminder,
    required this.isCancelled,
    required this.latitude,
    required this.longitude,
    required this.appointmentDateTime,
    required this.createdAt,
    required this.updatedAt,
    required this.serviceLocation,
  });
  late final int id;
  late final String paymentStatus;
  late final DispatchId? dispatchId;
  late final int? serviceProvider;
  late final Schedule schedule;
  late final Bod bod;
  late final Outstanding outstanding;
  late final int? collection;
  late final Dispatch? dispatch;
  late final Null type;
  late final String startTime;
  late final int totalHours;
  late final double? totalAmount;
  late final int latestReschedule;
  late final int latestCancel;
  late final String additionalInfo;
  late final String status;
  late final String customerNotes;
  late final String cleanerNotes;
  late final bool threeDayReminder;
  late final bool oneDayReminder;
  late final bool threeHourReminder;
  late final bool isCancelled;
  late final String latitude;
  late final String longitude;
  late final String appointmentDateTime;
  late final String createdAt;
  late final String updatedAt;
  late final int serviceLocation;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    paymentStatus = json['payment_status'];
    dispatchId = null;
    serviceProvider = null;
    schedule = Schedule.fromJson(json['schedule']);
    bod = Bod.fromJson(json['bod']);
    outstanding = Outstanding.fromJson(json['outstanding']);
    collection = null;
    dispatch = null;
    type = null;
    startTime = json['start_time'];
    totalHours = json['total_hours'];
    totalAmount = json['total_amount'];
    latestReschedule = json['latest_reschedule'];
    latestCancel = json['latest_cancel'];
    additionalInfo = json['additional_info'];
    status = json['status'];
    customerNotes = json['customer_notes'];
    cleanerNotes = json['cleaner_notes'];
    threeDayReminder = json['three_day_reminder'];
    oneDayReminder = json['one_day_reminder'];
    threeHourReminder = json['three_hour_reminder'];
    isCancelled = json['is_cancelled'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    appointmentDateTime = json['appointment_date_time'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    serviceLocation = json['service_location'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['payment_status'] = paymentStatus;
    data['dispatch_id'] = dispatchId;
    data['service_provider'] = serviceProvider;
    data['schedule'] = schedule.toJson();
    data['bod'] = bod.toJson();
    data['outstanding'] = outstanding.toJson();
    data['collection'] = collection;
    data['dispatch'] = dispatch;
    data['type'] = type;
    data['start_time'] = startTime;
    data['total_hours'] = totalHours;
    data['total_amount'] = totalAmount;
    data['latest_reschedule'] = latestReschedule;
    data['latest_cancel'] = latestCancel;
    data['additional_info'] = additionalInfo;
    data['status'] = status;
    data['customer_notes'] = customerNotes;
    data['cleaner_notes'] = cleanerNotes;
    data['three_day_reminder'] = threeDayReminder;
    data['one_day_reminder'] = oneDayReminder;
    data['three_hour_reminder'] = threeHourReminder;
    data['is_cancelled'] = isCancelled;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['appointment_date_time'] = appointmentDateTime;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['service_location'] = serviceLocation;
    return data;
  }
}

class DispatchId {
  DispatchId({
    required this.id,
    required this.serviceProvider,
    required this.status,
    required this.shiftStarted,
    required this.shiftEnded,
    required this.startTime,
    required this.endTime,
    required this.shiftStatus,
    required this.createdAt,
    required this.updatedAt,
    required this.booking,
  });
  late final int id;
  late final ServiceProvider serviceProvider;
  late final String status;
  late final bool shiftStarted;
  late final bool shiftEnded;
  late final String startTime;
  late final String endTime;
  late final String shiftStatus;
  late final String createdAt;
  late final String updatedAt;
  late final int booking;

  DispatchId.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serviceProvider = ServiceProvider.fromJson(json['service_provider']);
    status = json['status'];
    shiftStarted = json['shift_started'];
    shiftEnded = json['shift_ended'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    shiftStatus = json['shift_status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    booking = json['booking'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['service_provider'] = serviceProvider.toJson();
    data['status'] = status;
    data['shift_started'] = shiftStarted;
    data['shift_ended'] = shiftEnded;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    data['shift_status'] = shiftStatus;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['booking'] = booking;
    return data;
  }
}

class ServiceProvider {
  ServiceProvider({
    required this.id,
    required this.email,
    required this.userProfile,
  });
  late final int id;
  late final String email;
  late final UserProfile userProfile;

  ServiceProvider.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    userProfile = UserProfile.fromJson(json['user_profile']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['user_profile'] = userProfile.toJson();
    return data;
  }
}

class UserProfile {
  UserProfile({
    required this.id,
    required this.hourlyRate,
    required this.color,
    required this.role,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.language,
    required this.address,
    required this.city,
    required this.state,
    required this.country,
    required this.zipCode,
    required this.phoneNumber,
    required this.profilePicture,
    required this.timeZone,
    required this.status,
    required this.document,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
  });
  late final int id;
  late final String hourlyRate;
  late final String color;
  late final String role;
  late final String firstName;
  late final String lastName;
  late final String gender;
  late final String language;
  late final String address;
  late final String city;
  late final String state;
  late final String country;
  late final String zipCode;
  late final String phoneNumber;
  late final String profilePicture;
  late final String timeZone;
  late final String status;
  late final String document;
  late final String createdAt;
  late final String updatedAt;
  late final int user;

  UserProfile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    hourlyRate = json['hourly_rate'];
    color = json['color'];
    role = json['role'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    gender = json['gender'];
    language = json['language'];
    address = json['address'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    zipCode = json['zip_code'];
    phoneNumber = json['phone_number'];
    profilePicture = json['profile_picture'];
    timeZone = json['time_zone'];
    status = json['status'];
    document = json['document'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['hourly_rate'] = hourlyRate;
    data['color'] = color;
    data['role'] = role;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['gender'] = gender;
    data['language'] = language;
    data['address'] = address;
    data['city'] = city;
    data['state'] = state;
    data['country'] = country;
    data['zip_code'] = zipCode;
    data['phone_number'] = phoneNumber;
    data['profile_picture'] = profilePicture;
    data['time_zone'] = timeZone;
    data['status'] = status;
    data['document'] = document;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['user'] = user;
    return data;
  }
}

class Schedule {
  Schedule({
    required this.id,
    required this.startTime,
    required this.endTime,
    required this.status,
    required this.shiftStarted,
    required this.colour,
    required this.shiftEnded,
    required this.tipAmount,
    required this.shiftStatus,
    required this.count,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
    required this.booking,
  });
  late final int id;
  late final String startTime;
  late final String endTime;
  late final String status;
  late final bool shiftStarted;
  late final String colour;
  late final bool shiftEnded;
  late final int tipAmount;
  late final String shiftStatus;
  late final int count;
  late final String createdAt;
  late final String updatedAt;
  late final int user;
  late final int booking;

  Schedule.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    status = json['status'];
    shiftStarted = json['shift_started'];
    colour = json['colour'];
    shiftEnded = json['shift_ended'];
    tipAmount = json['tip_amount'];
    shiftStatus = json['shift_status'];
    count = json['count'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'];
    booking = json['booking'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    data['status'] = status;
    data['shift_started'] = shiftStarted;
    data['colour'] = colour;
    data['shift_ended'] = shiftEnded;
    data['tip_amount'] = tipAmount;
    data['shift_status'] = shiftStatus;
    data['count'] = count;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['user'] = user;
    data['booking'] = booking;
    return data;
  }
}

class Bod {
  Bod({
    required this.id,
    required this.frequency,
    required this.bodContactInfo,
    required this.bodServiceLocation,
    this.type,
    required this.startTime,
    required this.totalHours,
    required this.totalAmount,
    required this.latestReschedule,
    required this.latestCancel,
    required this.additionalInfo,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
    required this.colour,
    required this.user,
  });
  late final int id;
  late final Frequency frequency;
  late final BodContactInfo bodContactInfo;
  late final BodServiceLocation bodServiceLocation;
  late final Null type;
  late final String startTime;
  late final int totalHours;
  late final double? totalAmount;
  late final int latestReschedule;
  late final int latestCancel;
  late final String additionalInfo;
  late final String createdAt;
  late final String updatedAt;
  late final String status;
  late final String colour;
  late final int user;

  Bod.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    frequency = Frequency.fromJson(json['frequency']);
    bodContactInfo = BodContactInfo.fromJson(json['bod_contact_info']);
    bodServiceLocation = BodServiceLocation.fromJson(json['bod_service_location']);
    type = null;
    startTime = json['start_time'];
    totalHours = json['total_hours'];
    totalAmount = json['total_amount'];
    latestReschedule = json['latest_reschedule'];
    latestCancel = json['latest_cancel'];
    additionalInfo = json['additional_info'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    status = json['status'];
    colour = json['colour'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['frequency'] = frequency.toJson();
    data['bod_contact_info'] = bodContactInfo.toJson();
    data['bod_service_location'] = bodServiceLocation.toJson();
    data['type'] = type;
    data['start_time'] = startTime;
    data['total_hours'] = totalHours;
    data['total_amount'] = totalAmount;
    data['latest_reschedule'] = latestReschedule;
    data['latest_cancel'] = latestCancel;
    data['additional_info'] = additionalInfo;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['status'] = status;
    data['colour'] = colour;
    data['user'] = user;
    return data;
  }
}

class Frequency {
  Frequency({
    required this.id,
    required this.service,
    required this.type,
    required this.title,
    required this.discountPercent,
    required this.discountAmount,
    required this.startDate,
    this.recurEndDate,
    required this.createdAt,
    required this.updatedAt,
  });
  late final int id;
  late final Service service;
  late final String type;
  late final String title;
  late final int discountPercent;
  late final int discountAmount;
  late final String startDate;
  late final Null recurEndDate;
  late final String createdAt;
  late final String updatedAt;

  Frequency.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    service = Service.fromJson(json['service']);
    type = json['type'];
    title = json['title'];
    discountPercent = json['discount_percent'];
    discountAmount = json['discount_amount'];
    startDate = json['start_date'];
    recurEndDate = null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['service'] = service.toJson();
    data['type'] = type;
    data['title'] = title;
    data['discount_percent'] = discountPercent;
    data['discount_amount'] = discountAmount;
    data['start_date'] = startDate;
    data['recur_end_date'] = recurEndDate;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Service {
  Service({
    required this.id,
    required this.taxAmount,
    required this.name,
    required this.slug,
    required this.title,
    required this.description,
    required this.status,
    this.image_1,
    this.image_2,
    required this.type,
    required this.colour,
    required this.createdAt,
    required this.updatedAt,
    required this.company,
    required this.tax,
  });
  late final int id;
  late final int taxAmount;
  late final String name;
  late final String slug;
  late final String title;
  late final String description;
  late final String status;
  late final Null image_1;
  late final Null image_2;
  late final String type;
  late final String colour;
  late final String createdAt;
  late final String updatedAt;
  late final int company;
  late final int tax;

  Service.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    taxAmount = json['tax_amount'];
    name = json['name'];
    slug = json['slug'];
    title = json['title'];
    description = json['description'];
    status = json['status'];
    image_1 = null;
    image_2 = null;
    type = json['type'];
    colour = json['colour'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    company = json['company'];
    tax = json['tax'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['tax_amount'] = taxAmount;
    data['name'] = name;
    data['slug'] = slug;
    data['title'] = title;
    data['description'] = description;
    data['status'] = status;
    data['image_1'] = image_1;
    data['image_2'] = image_2;
    data['type'] = type;
    data['colour'] = colour;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['company'] = company;
    data['tax'] = tax;
    return data;
  }
}

class BodContactInfo {
  BodContactInfo({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.howToEnterOnPremise,
    required this.createdAt,
    required this.updatedAt,
  });
  late final int id;
  late final String firstName;
  late final String lastName;
  late final String email;
  late final String phone;
  late final String howToEnterOnPremise;
  late final String createdAt;
  late final String updatedAt;

  BodContactInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    phone = json['phone'];
    howToEnterOnPremise = json['how_to_enter_on_premise'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['phone'] = phone;
    data['how_to_enter_on_premise'] = howToEnterOnPremise;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class BodServiceLocation {
  BodServiceLocation({
    required this.id,
    required this.streetAddress,
    required this.aptSuite,
    required this.city,
    required this.state,
    required this.zipCode,
    required this.letLong,
    required this.createdAt,
    required this.updatedAt,
  });
  late final int id;
  late final String streetAddress;
  late final String aptSuite;
  late final String city;
  late final String state;
  late final int zipCode;
  late final String letLong;
  late final String createdAt;
  late final String updatedAt;

  BodServiceLocation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    streetAddress = json['street_address'];
    aptSuite = json['apt_suite'];
    city = json['city'];
    state = json['state'];
    zipCode = json['zip_code'];
    letLong = json['let_long'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['street_address'] = streetAddress;
    data['apt_suite'] = aptSuite;
    data['city'] = city;
    data['state'] = state;
    data['zip_code'] = zipCode;
    data['let_long'] = letLong;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Outstanding {
  Outstanding({
    required this.totalAmount,
    required this.status,
    required this.paidAmount,
    required this.isFirst,
  });
  late final double? totalAmount;
  late final String status;
  late final int paidAmount;
  late final bool isFirst;

  Outstanding.fromJson(Map<String, dynamic> json) {
    totalAmount = json['total_amount'];
    status = json['status'];
    paidAmount = json['paid_amount'];
    isFirst = json['is_first'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['total_amount'] = totalAmount;
    data['status'] = status;
    data['paid_amount'] = paidAmount;
    data['is_first'] = isFirst;
    return data;
  }
}

class Dispatch {
  Dispatch({
    required this.id,
    required this.serviceProvider,
    required this.status,
    required this.shiftStarted,
    required this.shiftEnded,
    required this.startTime,
    required this.endTime,
    required this.shiftStatus,
    required this.createdAt,
    required this.updatedAt,
    required this.booking,
  });
  late final int id;
  late final ServiceProvider serviceProvider;
  late final String status;
  late final bool shiftStarted;
  late final bool shiftEnded;
  late final String startTime;
  late final String endTime;
  late final String shiftStatus;
  late final String createdAt;
  late final String updatedAt;
  late final int booking;

  Dispatch.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serviceProvider = ServiceProvider.fromJson(json['service_provider']);
    status = json['status'];
    shiftStarted = json['shift_started'];
    shiftEnded = json['shift_ended'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    shiftStatus = json['shift_status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    booking = json['booking'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['service_provider'] = serviceProvider.toJson();
    data['status'] = status;
    data['shift_started'] = shiftStarted;
    data['shift_ended'] = shiftEnded;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    data['shift_status'] = shiftStatus;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['booking'] = booking;
    return data;
  }
}
