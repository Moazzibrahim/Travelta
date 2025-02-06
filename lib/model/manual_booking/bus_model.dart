class BusDetails {
  String? from;
  String? to;
  String? checkInDate;
  String? checkOutDate;
  int adultsNumber; 
  int childrenNumber; 
  List<Map<String, dynamic>> adultsDetails;
  List<Map<String, dynamic>> childrenDetails;
  double? adultsPrice;
  double? childrenPrice;
  String? busName;
  String? busNumberPlate;
  String? driverPhone;

  BusDetails({
    this.from,
    this.to,
    this.checkInDate,
    this.checkOutDate,
    this.adultsNumber = 0, 
    this.childrenNumber = 0,
    this.adultsDetails = const [],
    this.childrenDetails = const [],
    this.adultsPrice,
    this.childrenPrice,
    this.busName,
    this.busNumberPlate,
    this.driverPhone,
  });

  Map<String, dynamic> toJson() {
    return {
      'from': from,
      'to': to,
      'checkInDate': checkInDate,
      'checkOutDate': checkOutDate,
      'adultsNumber': adultsNumber,
      'childrenNumber': childrenNumber,
      'adultsDetails': adultsDetails,
      'childrenDetails': childrenDetails,
      'adultsPrice': adultsPrice,
      'childrenPrice': childrenPrice,
      'busName': busName,
      'busNumberPlate': busNumberPlate,
      'driverPhone': driverPhone,
    };
  }

  factory BusDetails.fromJson(Map<String, dynamic> json) {
    return BusDetails(
      from: json['from'],
      to: json['to'],
      checkInDate: json['checkInDate'],
      checkOutDate: json['checkOutDate'],
      adultsNumber: json['adultsNumber'] ?? 0, 
      childrenNumber: json['childrenNumber'] ?? 0,
      adultsDetails: List<Map<String, dynamic>>.from(json['adultsDetails'] ?? []),
      childrenDetails: List<Map<String, dynamic>>.from(json['childrenDetails'] ?? []),
      adultsPrice: json['adultsPrice'],
      childrenPrice: json['childrenPrice'],
      busName: json['busName'],
      busNumberPlate: json['busNumberPlate'],
      driverPhone: json['driverPhone'],
    );
  }
}
