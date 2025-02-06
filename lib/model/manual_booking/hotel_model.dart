class HotelModel {
  String? hotelName;
  String? hotelAddress;
  int? totalNights;
  int? roomQuantity;
  List<String?> selectedRoomTypes;
  String? checkInDate;
  String? checkOutDate;
  int? adultsNumber;
  int? childrenNumber;
  List<Map<String, dynamic>> adultsDetails;
  List<Map<String, dynamic>> childrenDetails;

  HotelModel({
    this.hotelName,
    this.hotelAddress,
    this.totalNights,
    this.roomQuantity,
    this.selectedRoomTypes = const [],
    this.checkInDate,
    this.checkOutDate,
    this.adultsNumber,
    this.childrenNumber,
    this.adultsDetails = const [],
    this.childrenDetails = const [],
  });

  Map<String, dynamic> toJson() {
    return {
      'hotelName': hotelName,
      'hotelAddress': hotelAddress,
      'totalNights': totalNights,
      'roomQuantity': roomQuantity,
      'selectedRoomTypes': selectedRoomTypes,
      'checkInDate': checkInDate,
      'checkOutDate': checkOutDate,
      'adultsNumber': adultsNumber,
      'childrenNumber': childrenNumber,
      'adultsDetails': adultsDetails,
      'childrenDetails': childrenDetails,
    };
  }

  factory HotelModel.fromJson(Map<String, dynamic> json) {
    return HotelModel(
      hotelName: json['hotelName'],
      hotelAddress: json['hotelAddress'],
      totalNights: json['totalNights'],
      roomQuantity: json['roomQuantity'],
      selectedRoomTypes: List<String?>.from(json['selectedRoomTypes']),
      checkInDate: json['checkInDate'],
      checkOutDate: json['checkOutDate'],
      adultsNumber: json['adultsNumber'],
      childrenNumber: json['childrenNumber'],
      adultsDetails: List<Map<String, String>>.from(json['adultsDetails']),
      childrenDetails: List<Map<String, String>>.from(json['childrenDetails']),
    );
  }
}
