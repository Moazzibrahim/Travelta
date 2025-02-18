class BusBookingList {
  final int id;
  final String name;
  final String supplierName;
  final String supplierEmail;
  final String supplierPhone;
  final String totalPrice;
  final String toName;
  final String toRole;
  final String toEmail;
  final int toPhone;
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

  BusBookingList(
      {required this.id,
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
      required this.numOfChildren
      });

  factory BusBookingList.fromJson(Map<String, dynamic> json) => BusBookingList(
      id: json['id'],
      name: json['bus_name'],
      supplierName: json['supplier_from_name'],
      supplierEmail: json['supplier_from_email'],
      supplierPhone: json['supplier_from_phone'],
      totalPrice: json['total_price'],
      toName: json['to_name'],
      toRole: json['to_role'],
      toEmail: json['to_email'],
      toPhone: int.tryParse(json['to_phone'].toString()) ?? 0, // Convert safely
      country: json['country'] ?? 'No country',
      paymentStatus: json['payment_status'] ?? 'No payment status',
      code: json['code'],
      status: json['status'],
      specialRequest: json['special_request'] ?? 'No special request', // Handle null
      from: json['from'],
      to: json['to'],
      departure: json['depature'] ?? 'Unknown departure', // Fix JSON key typo
      arrival: json['arrival'] ?? 'No arrival', // Handle null
      busNum: json['bus_no'],
      driverPhone: json['driver_phone'],
      numOfAdults: json['no_adults'],
      numOfChildren: json['no_children'], 
    );

}