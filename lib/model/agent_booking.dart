class AgentBooking {
  final String name;
  final int id;
  final String phone;
  final String ownerPhone;
  final String email;

  AgentBooking(
      {required this.name,
      required this.id,
      required this.phone,
      required this.ownerPhone,
      required this.email});

  factory AgentBooking.fromJson(Map<String, dynamic> json) {
    return AgentBooking(
      name: json['name'],
      id: json['id'],
      phone: json['phone'],
      ownerPhone: json['owner_phone'],
      email: json['email'],
    );
  }
}

class AgentBookingList {
  final List<dynamic> agentBookings;

  AgentBookingList({required this.agentBookings});

  factory AgentBookingList.fromJson(Map<String, dynamic> json) {
    return AgentBookingList(
      agentBookings: json['agents'],
    );
  }
}
