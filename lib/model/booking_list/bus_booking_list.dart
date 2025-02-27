class BusBookingList {
  final int id;
  final String name;
  final String supplierName;
  final String supplierEmail;
  final String supplierPhone; // Changed to String to match JSON
  final String totalPrice;
  final String toName;
  final String toRole;
  final String toEmail;
  final String toPhone;
  final String? country;
  final String? paymentStatus;
  final String code;
  final String status;
  final String? specialRequest;
  final String from;
  final String to;
  final String departure;
  final String? arrival;
  final String busNum;
  final String driverPhone;
  final int numOfAdults;
  final int numOfChildren;

  BusBookingList({
    required this.id,
    required this.name,
    required this.supplierName,
    required this.supplierEmail,
    required this.supplierPhone,
    required this.totalPrice,
    required this.toName,
    required this.toRole,
    required this.toEmail,
    required this.toPhone,
    this.country,
    this.paymentStatus,
    required this.code,
    required this.status,
    this.specialRequest,
    required this.from,
    required this.to,
    required this.departure,
    this.arrival,
    required this.busNum,
    required this.driverPhone,
    required this.numOfAdults,
    required this.numOfChildren,
  });

  factory BusBookingList.fromJson(Map<String, dynamic> json) => BusBookingList(
        id: json['id'] ?? 0,
        name: json['bus_name'] ?? 'Unknown',
        supplierName: json['supplier_from_name'] ?? 'Unknown',
        supplierEmail: json['supplier_from_email'] ?? 'Unknown',
        supplierPhone: json['supplier_from_phone'].toString(), // Convert to String
        totalPrice: json['total_price'] ?? '0.00',
        toName: json['to_name'] ?? 'Unknown',
        toRole: json['to_role'] ?? 'Unknown',
        toEmail: json['to_email'] ?? 'Unknown',
        toPhone: json['to_phone'].toString(), // Convert to String
        country: json['country'] ?? 'No country',
        paymentStatus: json['payment_status'] ?? 'No payment status',
        code: json['code'] ?? 'No Code',
        status: json['status'] ?? 'Unknown',
        specialRequest: json['special_request'] ?? 'No special request',
        from: json['from'] ?? 'Unknown',
        to: json['to'] ?? 'Unknown',
        departure: json['depature'] ?? 'Unknown departure', // Fixed typo
        arrival: json['arrival'] ?? 'No arrival',
        busNum: json['bus_no'] ?? 'Unknown',
        driverPhone: json['driver_phone'].toString(), // Convert to String
        numOfAdults: int.tryParse(json['no_adults'].toString()) ?? 0, // Convert to int
        numOfChildren: int.tryParse(json['no_children'].toString()) ?? 0, // Convert to int
      );
}
