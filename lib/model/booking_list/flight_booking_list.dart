class Flight {
  final int id;
  final String supplierFromName;
  final String supplierFromEmail;
  final String supplierFromPhone;
  final String? country;
  final String totalPrice;
  final String toName;
  final String toRole;
  final String toEmail;
  final String toPhone;
  final String flightType;
  final String flightDirection;
  final String departure;
  final String? arrival;
  final List<Map<String, String>> fromTo;
  final int childrenNo;
  final int adultsNo;
  final int infantsNo;
  final String flightClass;
  final String airline;
  final String ticketNo;
  final String refPnr;
  final String code;
  final String? paymentStatus;
  final String status;
  final String? specialRequest;

  Flight({
    required this.id,
    required this.supplierFromName,
    required this.supplierFromEmail,
    required this.supplierFromPhone,
    this.country,
    required this.totalPrice,
    required this.toName,
    required this.toRole,
    required this.toEmail,
    required this.toPhone,
    required this.flightType,
    required this.flightDirection,
    required this.departure,
    this.arrival,
    required this.fromTo,
    required this.childrenNo,
    required this.adultsNo,
    required this.infantsNo,
    required this.flightClass,
    required this.airline,
    required this.ticketNo,
    required this.refPnr,
    required this.code,
    this.paymentStatus,
    required this.status,
    this.specialRequest,
  });

  factory Flight.fromJson(Map<String, dynamic> json) {
    return Flight(
      id: json['id'] ?? 0, // Ensuring ID is never null
      supplierFromName: json['supplier_from_name'] ?? '',
      supplierFromEmail: json['supplier_from_email'] ?? '',
      supplierFromPhone: json['supplier_from_phone'] ?? '',
      country: json['country'] ?? 'no country',
      totalPrice: json['total_price'] ?? '0.00',
      toName: json['to_name'] ?? '',
      toRole: json['to_role'] ?? '',
      toEmail: json['to_email'] ?? '',
      toPhone: json['to_phone']?.toString() ?? '',
      flightType: json['flight_type'] ?? '',
      flightDirection: json['flight_direction'] ?? '',
      departure: json['departure'] ?? '',
      arrival: json['arrival'] ?? '',
      fromTo: (json['from_to']
              is List) // Ensuring `from_to` is a list before casting
          ? (json['from_to'] as List)
              .map((e) => {
                    'from': e['from']?.toString() ?? '',
                    'to': e['to']?.toString() ?? ''
                  })
              .toList()
          : [], // Default to empty list if `from_to` is not a list
      childrenNo: json['children_no'] != null
          ? int.tryParse(json['children_no'].toString()) ?? 0
          : 0,
      adultsNo: json['adults_no'] != null
          ? int.tryParse(json['adults_no'].toString()) ?? 0
          : 0,
      infantsNo: json['infants_no'] != null
          ? int.tryParse(json['infants_no'].toString()) ?? 0
          : 0,
      flightClass: json['flight_class'] ?? '',
      airline: json['airline'] ?? '',
      ticketNo: json['ticket_no'] ?? '',
      refPnr: json['ref_pnr'] ?? '',
      code: json['code'] ?? '',
      paymentStatus: json['payment_status'] ?? '',
      status: json['status'] ?? '',
      specialRequest: json['special_request'] ?? 'No special request',
    );
  }
}
