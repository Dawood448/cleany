class BookingDetailsModel {
  BookingDetailsModel({
    this.success,
    this.statusCode,
    this.message,
    this.data,
  });
  bool? success;
  num? statusCode;
  String? message;
  List<BookingDetailsData>? data;

  BookingDetailsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['status_code'];
    message = json['message'];
    data = List.from(json['data'])
        .map((e) => BookingDetailsData.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['success'] = success;
    data['status_code'] = statusCode;
    data['message'] = message;
    data['data'] = this.data!.map((e) => e.toJson()).toList();
    return data;
  }
}

class BookingDetailsData {
  BookingDetailsData({
    this.id,
    this.packages,
    this.extras,
    this.service,
    this.dispatchId,
    this.serviceProvider,
    this.schedule,
    this.bod,
    this.outstanding,
    this.collection,
    this.dispatch,
    this.type,
    this.startTime,
    this.totalHours,
    this.totalAmount,
    this.latestReschedule,
    this.latestCancel,
    this.additionalInfo,
    this.status,
    this.customerNotes,
    this.cleanerNotes,
    this.threeDayReminder,
    this.oneDayReminder,
    this.threeHourReminder,
    this.isCancelled,
    this.latitude,
    this.longitude,
    this.appointmentDateTime,
    this.createdAt,
    this.updatedAt,
    this.serviceLocation,
  });
  num? id;
  List<Packages>? packages;
  List<Extras>? extras;
  DispatchId? dispatchId;
  Service? service;
  num? serviceProvider;
  Schedule? schedule;
  Bod? bod;
  Outstanding? outstanding;
  num? collection;
  Dispatch? dispatch;
  String? type;
  DateTime? startTime;
  num? totalHours;
  num? totalAmount;
  num? latestReschedule;
  num? latestCancel;
  String? additionalInfo;
  String? status;
  String? customerNotes;
  String? cleanerNotes;
  bool? threeDayReminder;
  bool? oneDayReminder;
  bool? threeHourReminder;
  bool? isCancelled;
  String? latitude;
  String? longitude;
  DateTime? appointmentDateTime;
  DateTime? createdAt;
  DateTime? updatedAt;
  num? serviceLocation;

  BookingDetailsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    packages =
        List.from(json['packages']).map((e) => Packages.fromJson(e)).toList();
    extras = List.from(json['extras']).map((e) => Extras.fromJson(e)).toList();
    dispatchId = DispatchId.fromJson(json['dispatch_id']);
    serviceProvider = json['service_provider'];
    service=  Service.fromJson(json['service']) ;
    schedule = Schedule.fromJson(json['schedule']);
    bod = Bod.fromJson(json['bod']);
    outstanding = Outstanding.fromJson(json['outstanding']);
    collection = null;
    dispatch =
        json['dispatch'] != null ? Dispatch.fromJson(json['dispatch']) : null;
    type = null;
    startTime = null;
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
    appointmentDateTime = DateTime.tryParse(json['appointment_date_time']);
    createdAt = DateTime.tryParse(json['created_at']);
    updatedAt = DateTime.tryParse(json['updated_at']);
    serviceLocation = json['service_location'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['packages'] = packages!.map((e) => e.toJson()).toList();
    data['extras'] = extras!.map((e) => e.toJson()).toList();
    data['dispatch_id'] = dispatchId!.toJson();
    data['service_provider'] = serviceProvider;
    data['schedule'] = schedule!.toJson();
    data['bod'] = bod!.toJson();
    data['outstanding'] = outstanding!.toJson();
    data['collection'] = collection;
    data['dispatch'] = dispatch!.toJson();
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

class Packages {
  Packages({
    this.id,
    this.item,
    this.quantity,
    this.price,
    this.createdAt,
    this.updatedAt,
    this.booking,
  });
  num? id;
  Item? item;
  num? quantity;
  String? price;
  DateTime? createdAt;
  DateTime? updatedAt;
  num? booking;

  Packages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    item = Item.fromJson(json['item']);
    quantity = json['quantity'];
    price = json['price'];
    createdAt = DateTime.tryParse(json['created_at']);
    updatedAt = DateTime.tryParse(json['updated_at']);
    booking = json['booking'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['item'] = item!.toJson();
    data['quantity'] = quantity;
    data['price'] = price;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['booking'] = booking;
    return data;
  }
}

class Item {
  Item({
    this.id,
    this.title,
    this.timeHrs,
    this.price,
    this.discountPercent,
    this.createdAt,
    this.updatedAt,
    this.package,
  });
  num? id;
  String? title;
  String? timeHrs;
  String? price;
  num? discountPercent;
  DateTime? createdAt;
  DateTime? updatedAt;
  num? package;

  Item.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    timeHrs = json['time_hrs'];
    price = json['price'];
    discountPercent = json['discount_percent'];
    createdAt = DateTime.tryParse(json['created_at']);
    updatedAt = DateTime.tryParse(json['updated_at']);
    package = json['package'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['time_hrs'] = timeHrs;
    data['price'] = price;
    data['discount_percent'] = discountPercent;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['package'] = package;
    return data;
  }
}

class Extras {
  Extras({
    this.id,
    this.extra,
    this.quantity,
    this.price,
    this.createdAt,
    this.updatedAt,
    this.booking,
  });
  num? id;
  Extra? extra;
  num? quantity;
  String? price;
  DateTime? createdAt;
  DateTime? updatedAt;
  num? booking;

  Extras.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    extra = Extra.fromJson(json['extra']);
    quantity = json['quantity'];
    price = json['price'];
    createdAt = DateTime.tryParse(json['created_at']);
    updatedAt = DateTime.tryParse(json['updated_at']);
    booking = json['booking'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['extra'] = extra!.toJson();
    data['quantity'] = quantity;
    data['price'] = price;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['booking'] = booking;
    return data;
  }
}

class Extra {
  Extra({
    this.id,
    this.title,
    this.timeHrs,
    this.toolTip,
    this.price,
    this.createdAt,
    this.updatedAt,
    this.service,
  });
  num? id;
  String? title;
  String? timeHrs;
  String? toolTip;
  String? price;
  DateTime? createdAt;
  DateTime? updatedAt;
  num? service;

  Extra.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    timeHrs = json['time_hrs'];
    toolTip = json['tool_tip'];
    price = json['price'];
    createdAt = DateTime.tryParse(json['created_at']);
    updatedAt = DateTime.tryParse(json['updated_at']);
    service = json['service'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['time_hrs'] = timeHrs;
    data['tool_tip'] = toolTip;
    data['price'] = price;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['service'] = service;
    return data;
  }
}

class DispatchId {
  DispatchId({
    this.id,
    this.serviceProvider,
    this.status,
    this.shiftStarted,
    this.shiftEnded,
    this.startTime,
    this.endTime,
    this.shiftStatus,
    this.createdAt,
    this.updatedAt,
    this.booking,
  });
  num? id;
  ServiceProvider? serviceProvider;
  String? status;
  bool? shiftStarted;
  bool? shiftEnded;
  DateTime? startTime;
  DateTime? endTime;
  String? shiftStatus;
  DateTime? createdAt;
  DateTime? updatedAt;
  num? booking;

  DispatchId.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serviceProvider = ServiceProvider.fromJson(json['service_provider']);
    status = json['status'];
    shiftStarted = json['shift_started'];
    shiftEnded = json['shift_ended'];
    startTime = DateTime.tryParse(json['start_time']);
    endTime = DateTime.tryParse(json['end_time']);
    shiftStatus = json['shift_status'];
    createdAt = DateTime.tryParse(json['created_at']);
    updatedAt = DateTime.tryParse(json['updated_at']);
    booking = json['booking'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['service_provider'] = serviceProvider!.toJson();
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
    this.id,
    this.email,
    this.userProfile,
  });
  num? id;
  String? email;
  UserProfile? userProfile;

  ServiceProvider.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    userProfile = UserProfile.fromJson(json['user_profile']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['user_profile'] = userProfile!.toJson();
    return data;
  }
}

class UserProfile {
  UserProfile({
    this.id,
    this.latitude,
    this.longitude,
    this.hourlyRate,
    this.color,
    this.role,
    this.firstName,
    this.lastName,
    this.gender,
    this.language,
    this.address,
    this.city,
    this.state,
    this.country,
    this.zipCode,
    this.phoneNumber,
    this.profilePicture,
    this.timeZone,
    this.status,
    this.document,
    this.bookingProfile,
    this.createdAt,
    this.updatedAt,
    this.user,
  });
  num? id;
  String? latitude;
  String? longitude;
  String? hourlyRate;
  String? color;
  String? role;
  String? firstName;
  String? lastName;
  String? gender;
  String? language;
  String? address;
  String? city;
  String? state;
  String? country;
  String? zipCode;
  String? phoneNumber;
  String? profilePicture;
  String? timeZone;
  String? status;
  String? document;
  bool? bookingProfile;
  DateTime? createdAt;
  DateTime? updatedAt;
  num? user;

  UserProfile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    latitude = json['latitude'];
    longitude = json['longitude'];
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
    bookingProfile = json['booking_profile'];
    createdAt = DateTime.tryParse(json['created_at']);
    updatedAt = DateTime.tryParse(json['updated_at']);
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
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
    data['booking_profile'] = bookingProfile;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['user'] = user;
    return data;
  }
}

class Schedule {
  Schedule({
    this.id,
    this.startTime,
    this.endTime,
    this.status,
    this.shiftStarted,
    this.colour,
    this.shiftEnded,
    this.tipAmount,
    this.shiftStatus,
    this.count,
    this.createdAt,
    this.updatedAt,
    this.user,
    this.booking,
  });
  num? id;
  DateTime? startTime;
  DateTime? endTime;
  String? status;
  bool? shiftStarted;
  String? colour;
  bool? shiftEnded;
  num? tipAmount;
  String? shiftStatus;
  num? count;
  DateTime? createdAt;
  DateTime? updatedAt;
  num? user;
  num? booking;

  Schedule.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    startTime = DateTime.tryParse(json['start_time']);
    endTime = DateTime.tryParse(json['end_time']);
    status = json['status'];
    shiftStarted = json['shift_started'];
    colour = json['colour'];
    shiftEnded = json['shift_ended'];
    tipAmount = json['tip_amount'];
    shiftStatus = json['shift_status'];
    count = json['count'];
    createdAt = DateTime.tryParse(json['created_at']);
    updatedAt = DateTime.tryParse(json['updated_at']);
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
    this.id,
    this.frequency,
    this.bodContactInfo,
    this.bodServiceLocation,
    this.type,
    this.startTime,
    this.totalHours,
    this.totalAmount,
    this.latestReschedule,
    this.latestCancel,
    this.additionalInfo,
    this.createdAt,
    this.updatedAt,
    this.status,
    this.colour,
    this.user,
  });
  num? id;
  Frequency? frequency;
  BodContactInfo? bodContactInfo;
  BodServiceLocation? bodServiceLocation;
  String? type;
  DateTime? startTime;
  num? totalHours;
  num? totalAmount;
  num? latestReschedule;
  num? latestCancel;
  String? additionalInfo;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? status;
  String? colour;
  num? user;

  Bod.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    frequency = Frequency.fromJson(json['frequency']);
    bodContactInfo = BodContactInfo.fromJson(json['bod_contact_info']);
    bodServiceLocation =
        BodServiceLocation.fromJson(json['bod_service_location']);
    type = null;
    startTime = null;

    totalHours = json['total_hours'];
    totalAmount = json['total_amount'];
    latestReschedule = json['latest_reschedule'];
    latestCancel = json['latest_cancel'];
    additionalInfo = json['additional_info'];
    createdAt = DateTime.tryParse(json['created_at']);
    updatedAt = DateTime.tryParse(json['updated_at']);
    status = json['status'];
    colour = json['colour'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['frequency'] = frequency!.toJson();
    data['bod_contact_info'] = bodContactInfo!.toJson();
    data['bod_service_location'] = bodServiceLocation!.toJson();
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
    this.id,
    this.service,
    this.type,
    this.title,
    this.discountPercent,
    this.discountAmount,
    this.startDate,
    this.recurEndDate,
    this.createdAt,
    this.updatedAt,
  });
  num? id;
  Service? service;
  String? type;
  String? title;
  num? discountPercent;
  num? discountAmount;
  DateTime? startDate;
  String? recurEndDate;
  DateTime? createdAt;
  DateTime? updatedAt;

  Frequency.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    service = json['service'] != null ? Service.fromJson(json['service']) : null;
    type = json['type'];
    title = json['title'];
    discountPercent = json['discount_percent'];
    discountAmount = json['discount_amount'];
    startDate = DateTime.tryParse(json['start_date']);
    recurEndDate = null;
    createdAt = DateTime.tryParse(json['created_at']);
    updatedAt = DateTime.tryParse(json['updated_at']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['service'] = service!.toJson();
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
    this.id,
    this.taxAmount,
    this.name,
    this.slug,
    this.title,
    this.description,
    this.status,
    this.image_1,
    this.image_2,
    this.type,
    this.colour,
    this.createdAt,
    this.updatedAt,
    this.company,
    this.tax,
  });
  num? id;
  num? taxAmount;
  String? name;
  String? slug;
  String? title;
  String? description;
  String? status;
  String? image_1;
  String? image_2;
  String? type;
  String? colour;
  DateTime? createdAt;
  DateTime? updatedAt;
  num? company;
  num? tax;

  Service.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    taxAmount = json['tax_amount'];
    name = json['name'];
    slug = json['slug'];
    title = json['title'];
    description = json['description'];
    status = json['status'];
    image_1 = json['image_1'];
    image_2 = json['image_2'];
    type = json['type'];
    colour = json['colour'];
    createdAt = DateTime.tryParse(json['created_at']);
    updatedAt = DateTime.tryParse(json['updated_at']);
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
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.howToEnterOnPremise,
    this.createdAt,
    this.updatedAt,
    this.parkingSpot,
    this.havePets,
    this.howHearAboutUs,
  });
  num? id;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? howToEnterOnPremise;
  DateTime? createdAt;
  DateTime? updatedAt;
  bool? parkingSpot;
  bool? havePets;
  String? howHearAboutUs;

  BodContactInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    phone = json['phone'];
    howToEnterOnPremise = json['how_to_enter_on_premise'];
    createdAt = DateTime.tryParse(json['created_at']);
    updatedAt = DateTime.tryParse(json['updated_at']);
    parkingSpot = json['do_parking_spot'];
    havePets = json['do_you_pets'];
    howHearAboutUs = json['how_do_you_hear_about_us'];
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
    data['do_parking_spot'] = parkingSpot;
    data['do_you_pets'] = havePets;
    data['how_do_you_hear_about_us'] = howHearAboutUs;
    return data;
  }
}

class BodServiceLocation {
  BodServiceLocation({
    this.id,
    this.streetAddress,
    this.aptSuite,
    this.city,
    this.state,
    this.zipCode,
    this.letLong,
    this.createdAt,
    this.updatedAt,
  });
  num? id;
  String? streetAddress;
  String? aptSuite;
  String? city;
  String? state;
  num? zipCode;
  String? letLong;
  DateTime? createdAt;
  DateTime? updatedAt;

  BodServiceLocation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    streetAddress = json['street_address'];
    aptSuite = json['apt_suite'];
    city = json['city'];
    state = json['state'];
    zipCode = json['zip_code'];
    letLong = json['let_long'];
    createdAt = DateTime.tryParse(json['created_at']);
    updatedAt = DateTime.tryParse(json['updated_at']);
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
    this.totalAmount,
    this.status,
    this.paidAmount,
    this.isFirst,
  });
  num? totalAmount;
  String? status;
  num? paidAmount;
  bool? isFirst;

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
    this.id,
    this.serviceProvider,
    this.status,
    this.shiftStarted,
    this.shiftEnded,
    this.startTime,
    this.endTime,
    this.shiftStatus,
    this.createdAt,
    this.updatedAt,
    this.booking,
  });
  num? id;
  ServiceProvider? serviceProvider;
  String? status;
  bool? shiftStarted;
  bool? shiftEnded;
  DateTime? startTime;
  DateTime? endTime;
  String? shiftStatus;
  DateTime? createdAt;
  DateTime? updatedAt;
  num? booking;

  Dispatch.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serviceProvider = ServiceProvider.fromJson(json['service_provider']);
    status = json['status'];
    shiftStarted = json['shift_started'];
    shiftEnded = json['shift_ended'];
    startTime = DateTime.tryParse(json['start_time']);
    endTime = DateTime.tryParse(json['end_time']);
    shiftStatus = json['shift_status'];
    createdAt = DateTime.tryParse(json['created_at']);
    updatedAt = DateTime.tryParse(json['updated_at']);
    booking = json['booking'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['service_provider'] = serviceProvider!.toJson();
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
