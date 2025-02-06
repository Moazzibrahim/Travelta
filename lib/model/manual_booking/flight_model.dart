class FlightDetails {
  String? flightType;
  String? flightDirection;
  String? flightClass;
  String? checkInDate;
  String? checkOutDate;

  int? adultsNumber;
  int? adultsPrice;
  int? childrenPrice;
  int? childrenNumber;
  List<Map<String, dynamic>> adultsDetails;
  List<Map<String, dynamic>> childrenDetails;
  int? infantNumber;
  String? airline;
  String? ticketNumber;
  String? refBNR;
  String? fromLocation;
  String? toLocation;
  DateTime? arrivalDate;
  List<Map<String, dynamic>> fromto;

  FlightDetails({
    this.flightType,
    this.flightDirection,
    this.flightClass,
    this.checkInDate,
    this.checkOutDate,
    this.adultsNumber,
    this.childrenNumber,
    this.adultsPrice,
    this.childrenPrice,
    this.adultsDetails = const [],
    this.childrenDetails = const [],
    this.infantNumber,
    this.airline,
    this.ticketNumber,
    this.refBNR,
    this.fromLocation,
    this.toLocation,
    this.arrivalDate,
    this.fromto = const [],
  });

  Map<String, dynamic> toJson() {
    return {
      'flightType': flightType,
      'flightDirection': flightDirection,
      'flightClass': flightClass,
      'checkInDate': checkInDate,
      'checkOutDate': checkOutDate,
      'adultsNumber': adultsNumber,
      'childrenNumber': childrenNumber,
      'adultsPrice': adultsPrice,
      'childrenPrice': childrenPrice,
      'adultsDetails': adultsDetails,
      'childrenDetails': childrenDetails,
      'infantNumber': infantNumber,
      'airline': airline,
      'ticketNumber': ticketNumber,
      'refBNR': refBNR,
      'fromLocation': fromLocation,
      'toLocation': toLocation,
      'arrivalDate':
          arrivalDate?.toIso8601String(), // Convert DateTime to ISO8601 string
      'fromto': fromto,
    };
  }

  factory FlightDetails.fromJson(Map<String, dynamic> json) {
    return FlightDetails(
      flightType: json['flightType'],
      flightDirection: json['flightDirection'],
      flightClass: json['flightClass'],
      checkInDate: json['checkInDate'],
      checkOutDate: json['checkOutDate'],
      adultsNumber: json['adultsNumber'],
      childrenNumber: json['childrenNumber'],
      adultsPrice: json['adultsPrice'],
      childrenPrice: json['childrenPrice'],
      adultsDetails: List<Map<String, dynamic>>.from(json['adultsDetails']),
      childrenDetails: List<Map<String, dynamic>>.from(json['childrenDetails']),
      infantNumber: json['infantNumber'],
      airline: json['airline'],
      ticketNumber: json['ticketNumber'],
      refBNR: json['refBNR'],
      fromLocation: json['fromLocation'],
      toLocation: json['toLocation'],
      arrivalDate: json['arrivalDate'],
      fromto: List<Map<String, dynamic>>.from(json['fromto']),
    );
  }
}
