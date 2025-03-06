class CustomerBooking {
  final int id;
  final String name;
  final String phone;
  final String? emergencyPhone;
  final String email;

  CustomerBooking(
      {required this.id,
      required this.name,
      required this.phone,
      required this.email,
      required this.emergencyPhone,
      });

  factory CustomerBooking.fromJson(Map<String, dynamic> json) {
    return CustomerBooking(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      email: json['email'],
      emergencyPhone: json['emergency_phone'] ?? 'No emergency phone',
    );
  }
}

class CustomerBookingList {
  final List<dynamic> customerBookings;

  CustomerBookingList({required this.customerBookings});

  factory CustomerBookingList.fromJson(Map<String,dynamic> json) => CustomerBookingList(
    customerBookings: json['customers'],
  );
}
