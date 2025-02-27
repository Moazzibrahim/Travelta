class Customer {
  final int id;
  final String name;
  final String phone;
  final String email;
  final String gender;
  final String createdAt;
  final String? emergencyPhone;

  Customer({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.gender,
    required this.createdAt,
    this.emergencyPhone,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      email: json['email'],
      gender: json['gender'],
      createdAt: json['created_at'],
      emergencyPhone: json['emergency_phone'],
    );
  }
}

class Customers {
  final List<dynamic> customers;

  Customers({
    required this.customers,
  });

  factory Customers.fromJson(Map<String, dynamic> json) {
    return Customers(
      customers: json['customers'],
    );
  }
}
