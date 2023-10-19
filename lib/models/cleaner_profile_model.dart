class CleanerProfileModel1 {
  CleanerProfileModel1({
    required this.id,
    required this.email,
    required this.profile,
    required this.timezone,
  });
  late final int id;
  late final String email;
  late final Profile profile;
  late final String timezone;

  CleanerProfileModel1.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    profile = Profile.fromJson(json['profile']);
    timezone = json['timezone'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['profile'] = profile.toJson();
    data['timezone'] = timezone;
    return data;
  }
}

class Profile {
  Profile({
    required this.id,
    required this.hourlyRate,
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
    required this.color,
    required this.document,
    required this.user,
  });
  late final int id;
  late final String hourlyRate;
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
  late final String color;
  late final String document;
  late final int user;

  Profile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    hourlyRate = json['hourly_rate'];
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
    profilePicture = json['profile_picture'] ?? "";
    timeZone = json['time_zone'] ?? "";
    status = json['status'];
    color = json['color'];
    document = json['document'] ?? "";
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['hourly_rate'] = hourlyRate;
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
    data['color'] = color;
    data['document'] = document;
    data['user'] = user;
    return data;
  }
}
