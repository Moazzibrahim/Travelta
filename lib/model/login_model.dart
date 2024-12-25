class UserModel {
  final User user;
  final String token;
  final List<Plan> plans;

  UserModel({
    required this.user,
    required this.token,
    required this.plans,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      user: User.fromJson(json['user']),
      token: json['token'],
      plans: (json['plans'] as List).map((plan) => Plan.fromJson(plan)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user.toJson(),
      'token': token,
      'plans': plans.map((plan) => plan.toJson()).toList(),
    };
  }
}

class User {
  final int id;
  final int? planId;
  final String name;
  final String phone;
  final String email;
  final String? address;
  final int totalBooking;
  final int totalCommission;
  final String? startDate;
  final String? endDate;
  final String? priceCycle;
  final String role;
  final int? countryId;
  final int? cityId;
  final int? zoneId;
  final int? sourceId;
  final String? createdAt;
  final String? updatedAt;
  final String ownerName;
  final String ownerPhone;
  final String ownerEmail;
  final String? services;
  final String status;
  final String token;

  User({
    required this.id,
    this.planId,
    required this.name,
    required this.phone,
    required this.email,
    this.address,
    required this.totalBooking,
    required this.totalCommission,
    this.startDate,
    this.endDate,
    this.priceCycle,
    required this.role,
    this.countryId,
    this.cityId,
    this.zoneId,
    this.sourceId,
    this.createdAt,
    this.updatedAt,
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

class Plan {
  final int id;
  final String name;
  final String description;
  final int userLimit;
  final int branchLimit;
  final int periodInDays;
  final String moduleType;
  final double price;
  final String discountType;
  final double discountValue;
  final double priceAfterDiscount;
  final double adminCost;
  final double branchCost;
  final String? createdAt;
  final String? updatedAt;
  final String type;

  Plan({
    required this.id,
    required this.name,
    required this.description,
    required this.userLimit,
    required this.branchLimit,
    required this.periodInDays,
    required this.moduleType,
    required this.price,
    required this.discountType,
    required this.discountValue,
    required this.priceAfterDiscount,
    required this.adminCost,
    required this.branchCost,
    this.createdAt,
    this.updatedAt,
    required this.type,
  });

  factory Plan.fromJson(Map<String, dynamic> json) {
    return Plan(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      userLimit: json['user_limit'],
      branchLimit: json['branch_limit'],
      periodInDays: json['period_in_days'],
      moduleType: json['module_type'],
      price: json['price'].toDouble(),
      discountType: json['discount_type'],
      discountValue: json['discount_value'].toDouble(),
      priceAfterDiscount: json['price_after_discount'].toDouble(),
      adminCost: json['admin_cost'].toDouble(),
      branchCost: json['branch_cost'].toDouble(),
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'user_limit': userLimit,
      'branch_limit': branchLimit,
      'period_in_days': periodInDays,
      'module_type': moduleType,
      'price': price,
      'discount_type': discountType,
      'discount_value': discountValue,
      'price_after_discount': priceAfterDiscount,
      'admin_cost': adminCost,
      'branch_cost': branchCost,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'type': type,
    };
  }
}
