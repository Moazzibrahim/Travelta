class Supplier {
  final String name;
  final int id;
  final String adminName;
  final String adminPhone;
  final String adminEmail;
  final List<dynamic> email;
  final List<dynamic> phone;
  final String? emergencyPhone;
  final List<Service> services;

  Supplier({
    required this.name,
    required this.id,
    required this.adminName,
    required this.adminPhone,
    required this.adminEmail,
    required this.email,
    required this.phone,
    required this.emergencyPhone,
    required this.services,
  });

  factory Supplier.fromJson(Map<String, dynamic> json) {
    return Supplier(
      name: json['name']?.toString() ?? '',
      id: json['id'] is int
          ? json['id']
          : int.tryParse(json['id'].toString()) ?? 0,
      adminName: json['admin_name']?.toString() ?? '',
      adminPhone: json['admin_phone']?.toString() ?? '',
      adminEmail: json['admin_email']?.toString() ?? '',
      email: json['emails'] is List
          ? List<String>.from(json['emails'].map((e) => e.toString()))
          : [json['emails'].toString()],
      phone: json['phones'] is List
          ? List<String>.from(json['phones'].map((p) => p.toString()))
          : [json['phones'].toString()],
      emergencyPhone: json['emergency_phone']?.toString() ?? 'N/A',
      services: (json['services'] as List<dynamic>?)
              ?.map((service) => Service.fromJson(service))
              .toList() ??
          [],
    );
  }
}

class Service {
  final int id;
  final String name;

  Service({required this.id, required this.name});

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      id: json['id'],
      name: json['service_name'],
    );
  }
}

class Services {
  final List<dynamic> services;

  Services({required this.services});

  factory Services.fromJson(Map<String, dynamic> json) {
    return Services(
      services: json['services'],
    );
  }
}

class Suppliers {
  final List<dynamic> suppliers;

  Suppliers({required this.suppliers});

  factory Suppliers.fromJson(Map<String, dynamic> json) {
    return Suppliers(
      suppliers: json['supplier_agent'],
    );
  }
}
