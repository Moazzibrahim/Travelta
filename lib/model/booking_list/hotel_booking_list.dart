class HotelBookingList {
  final int id;
  final String name;
  final String supplierName;
  final String supplierEmail;
  final String supplierPhone;
  final String? country;
  final String totalPrice;
  final String toName;
  final String toRole;
  final String toEmail;
  final String toPhone;
  final String checkOut;
  final String checkIn;
  final int numOfNights; // Changed to int
  final List<String> roomType;
  final int numOfAdults;
  final int numOfChildren;
  final String? paymentStatus;
  final String code;
  final String status;
  final String? specialRequest;

  HotelBookingList({
    required this.id,
    required this.name,
    required this.supplierName,
    required this.supplierEmail,
    required this.supplierPhone,
    this.country,
    required this.totalPrice,
    required this.toName,
    required this.toRole,
    required this.toEmail,
    required this.toPhone,
    required this.checkOut,
    required this.checkIn,
    required this.numOfNights, // Changed to int
    required this.roomType,
    required this.numOfAdults,
    required this.numOfChildren,
    this.paymentStatus,
    required this.code,
    required this.status,
    this.specialRequest,
  });

  factory HotelBookingList.fromJson(Map<String, dynamic> json) => HotelBookingList(
        id: json['id'],
        name: json['hotel_name'],
        supplierName: json['supplier_from_name'],
        supplierEmail: json['supplier_from_email'],
        supplierPhone: json['supplier_from_phone'],
        country: json['country'] ?? 'No country',
        totalPrice: json['total_price'],
        toName: json['to_name'],
        toRole: json['to_role'],
        toEmail: json['to_email'],
        toPhone: json['to_phone'],
        checkOut: json['check_out'],
        checkIn: json['check_in'],
        numOfNights: int.tryParse(json['no_nights'].toString()) ?? 0,
        roomType: (json['room_type'] as List<dynamic>).map((e) => e.toString()).toList(),
        numOfAdults: json['no_adults'] is int ? json['no_adults'] : int.tryParse(json['no_adults'].toString()) ?? 0,
        numOfChildren: json['no_children'] is int ? json['no_children'] : int.tryParse(json['no_children'].toString()) ?? 0,
        paymentStatus: json['payment_status'] ?? 'no payment status',
        code: json['code'],
        status: json['status'],
        specialRequest: json['special_request'] ?? 'no Special requests',
      );
}
