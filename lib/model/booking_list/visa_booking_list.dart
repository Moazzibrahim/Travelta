class Visa {
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
  final int noAdults;
  final int noChildren;
  final String countryName;
  final String travelDate;
  final String appointment;
  final String? notes;
  final String code;
  final String? paymentStatus;
  final String status;
  final String? specialRequest;

  Visa({
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
    required this.noAdults,
    required this.noChildren,
    required this.countryName,
    required this.travelDate,
    required this.appointment,
    this.notes,
    required this.code,
    this.paymentStatus,
    required this.status,
    this.specialRequest,
  });

 factory Visa.fromJson(Map<String, dynamic> json) {
  return Visa(
    id: json['id'], 
    supplierFromName: json['supplier_from_name'],
    supplierFromEmail: json['supplier_from_email'],
    supplierFromPhone: json['supplier_from_phone'].toString(),
    country: json['country']?.toString() ?? 'No country',
    totalPrice: json['total_price'].toString(), 
    toName: json['to_name'],
    toRole: json['to_role'],
    toEmail: json['to_email'],
    toPhone: json['to_phone'].toString(), 
    noAdults: json['no_adults'], 
    noChildren: json['no_children'], 
    countryName: json['country_name'],
    travelDate: json['travel_date'],
    appointment: json['appointment'],
    notes: json['notes']?.toString() ?? 'No notes',
    code: json['code'],
    paymentStatus: json['payment_status']?.toString() ?? 'no payment status',
    status: json['status'],
    specialRequest: json['special_request']?.toString() ?? 'No special request',
  );
}


}