class Tour {
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
  final String tourName;
  final String tourType;
  final int childrenNo;
  final int adultsNo;
  final List<TourHotel> tourHotels;
  final List<TourBus> tourBuses;
  final String createdAt;
  final String code;
  final String? paymentStatus;
  final String status;
  final String? specialRequest;

  Tour({
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
    required this.tourName,
    required this.tourType,
    required this.childrenNo,
    required this.adultsNo,
    required this.tourHotels,
    required this.tourBuses,
    required this.createdAt,
    required this.code,
    this.paymentStatus,
    required this.status,
    this.specialRequest,
  });

  factory Tour.fromJson(Map<String, dynamic> json) {
    return Tour(
      id: json['id'],
      supplierFromName: json['supplier_from_name'],
      supplierFromEmail: json['supplier_from_email'],
      supplierFromPhone: json['supplier_from_phone'],
      country: json['country'] ?? 'No country',
      totalPrice: json['total_price'],
      toName: json['to_name'],
      toRole: json['to_role'],
      toEmail: json['to_email'],
      toPhone: json['to_phone'],
      tourName: json['tour_name'],
      tourType: json['tour_type'],
      childrenNo: json['children_no'],
      adultsNo: json['adults_no'],
      tourHotels: List<TourHotel>.from(
          json['tour_hotels'].map((e) => TourHotel.fromJson(e))),
      tourBuses: List<TourBus>.from(
          json['tour_buses'].map((e) => TourBus.fromJson(e))),
      createdAt: json['created_at'],
      code: json['code'],
      paymentStatus: json['payment_status'] ?? 'No payment status',
      status: json['status'],
      specialRequest: json['special_request'] ?? 'No special request',
    );
  }
}

class TourHotel {
  final String destination;
  final String hotelName;
  final String roomType;
  final String checkIn;
  final String checkOut;
  final String nights;

  TourHotel({
    required this.destination,
    required this.hotelName,
    required this.roomType,
    required this.checkIn,
    required this.checkOut,
    required this.nights,
  });

  factory TourHotel.fromJson(Map<String, dynamic> json) {
    return TourHotel(
      destination: json['destination'],
      hotelName: json['hotel_name'],
      roomType: json['room_type'],
      checkIn: json['check_in'],
      checkOut: json['check_out'],
      nights: json['nights'],
    );
  }
}

class TourBus {
  final String transportation;
  final int seats;

  TourBus({required this.transportation, required this.seats});

  factory TourBus.fromJson(Map<String, dynamic> json) {
    return TourBus(
      transportation: json['transportation'],
      seats: json['seats'],
    );
  }
}
