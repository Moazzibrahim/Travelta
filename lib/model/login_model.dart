class UserModel {
  final User user;
  final String token;

  UserModel({
    required this.user,
    required this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      user: User.fromJson(json['user']),
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user.toJson(),
      'token': token,
    };
  }
}

class User {
  final int id;
  final int planId;
  final String name;
  final String phone;
  final String email;
  final String address;
  final int totalBooking;
  final int totalCommission;
  final String startDate;
  final String endDate;
  final String priceCycle;
  final String role;
  final int countryId;
  final int cityId;
  final int? zoneId;
  final int sourceId;
  final String createdAt;
  final String updatedAt;
  final String ownerName;
  final String ownerPhone;
  final String ownerEmail;
  final String? services;
  final String status;
  final String token;

  User({
    required this.id,
    required this.planId,
    required this.name,
    required this.phone,
    required this.email,
    required this.address,
    required this.totalBooking,
    required this.totalCommission,
    required this.startDate,
    required this.endDate,
    required this.priceCycle,
    required this.role,
    required this.countryId,
    required this.cityId,
    this.zoneId,
    required this.sourceId,
    required this.createdAt,
    required this.updatedAt,
    required this.ownerName,
    required this.ownerPhone,
    required this.ownerEmail,
    this.services,
    required this.status,
    required this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      planId: json['plan_id'],
      name: json['name'],
      phone: json['phone'],
      email: json['email'],
      address: json['address'],
      totalBooking: json['total_booking'],
      totalCommission: json['total_commission'],
      startDate: json['start_date'],
      endDate: json['end_date'],
      priceCycle: json['price_cycle'],
      role: json['role'],
      countryId: json['country_id'],
      cityId: json['city_id'],
      zoneId: json['zone_id'],
      sourceId: json['source_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      ownerName: json['owner_name'],
      ownerPhone: json['owner_phone'],
      ownerEmail: json['owner_email'],
      services: json['services'],
      status: json['status'],
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'plan_id': planId,
      'name': name,
      'phone': phone,
      'email': email,
      'address': address,
      'total_booking': totalBooking,
      'total_commission': totalCommission,
      'start_date': startDate,
      'end_date': endDate,
      'price_cycle': priceCycle,
      'role': role,
      'country_id': countryId,
      'city_id': cityId,
      'zone_id': zoneId,
      'source_id': sourceId,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'owner_name': ownerName,
      'owner_phone': ownerPhone,
      'owner_email': ownerEmail,
      'services': services,
      'status': status,
      'token': token,
    };
  }
}
